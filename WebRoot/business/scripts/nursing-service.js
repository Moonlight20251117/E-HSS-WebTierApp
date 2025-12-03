/**
 * 护务管理业务脚本
 * 版本: 2025-01-20 - 使用下拉选择框更新状态
 */

// 防止重复加载：检查是否已经初始化
if (window.nursingServiceInitialized) {
    console.warn('nursing-service.js 已经加载过，跳过重复初始化');
} else {
    window.nursingServiceInitialized = true;
    
    // 全局变量存储任务数据（使用window对象避免重复声明）
    if (!window.tasksData) {
        window.tasksData = [];
    }
    // 使用局部变量引用，但通过window.tasksData来存储和更新
    let tasksData = window.tasksData;

    // 版本标识，用于验证代码是否更新
    console.log('nursing-service.js 已加载 - 版本 2025-01-20 (下拉选择框版本)');

// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    // 检查是否存在日常护理模块
    if (document.getElementById('daily-nursing') || document.getElementById('task-list-body')) {
        initNursingService();
    }
});

// 由于JSP是动态加载的，也需要监听动态内容加载
// 使用MutationObserver监听task-list-body的创建
const observer = new MutationObserver(function(mutations) {
    const taskListBody = document.getElementById('task-list-body');
    if (taskListBody && !taskListBody.hasAttribute('data-initialized')) {
        taskListBody.setAttribute('data-initialized', 'true');
        // 延迟初始化，确保DOM完全加载
        setTimeout(() => {
            if (typeof initNursingService === 'function') {
                initNursingService();
            }
        }, 100);
    }
});

// 开始观察
observer.observe(document.body, {
    childList: true,
    subtree: true
});

function initNursingService() {
    // 从数据库加载数据
    fetchTasksFromDB();
    
    // 设置日期
    const now = new Date();
    const dateEl = document.getElementById('current-date');
    if(dateEl) dateEl.textContent = now.toLocaleDateString('zh-CN');

    // 绑定搜索监听
    const searchInput = document.getElementById('task-search');
    if (searchInput) {
        searchInput.addEventListener('input', renderTasks);
    }

    // 绑定筛选监听
    const filterSelect = document.getElementById('task-filter');
    if (filterSelect) {
        filterSelect.addEventListener('change', renderTasks);
    }
}

// 从后端Servlet获取数据
function fetchTasksFromDB() {
    // nurse-home.jsp在 home/hospital/ 目录下，所以使用相对路径 ../../servlet/...
    // 如果动态路径计算失败，尝试使用相对路径
    let apiUrl;
    try {
        // 尝试从当前页面路径计算项目根路径
        const path = window.location.pathname;
        const homeIndex = path.indexOf('/home/');
        if (homeIndex > 0) {
            const basePath = path.substring(0, homeIndex);
            apiUrl = basePath + '/servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=list';
        } else {
            // 使用相对路径（从nurse-home.jsp的位置：home/hospital/ -> ../../servlet/）
            apiUrl = '../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=list';
        }
    } catch (e) {
        // 如果计算失败，使用相对路径
        apiUrl = '../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=list';
    }
    
    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            // 确保数据是数组
            if (Array.isArray(data)) {
                window.tasksData = data;
                tasksData = window.tasksData; // 更新局部引用
                renderTasks();
                updateStats();
            } else {
                console.error('返回的数据不是数组:', data);
                window.tasksData = [];
                tasksData = window.tasksData; // 更新局部引用
                renderTasks();
            }
        })
        .catch(err => {
            console.error("获取数据失败:", err);
            console.error("请求URL:", apiUrl);
            const container = document.getElementById('task-list-body');
            if(container) {
                container.innerHTML = `<div style="padding:20px;color:red;text-align:center">
                    <p>无法连接服务器获取数据</p>
                    <p style="font-size:12px;color:#999;">错误: ${err.message}</p>
                    <p style="font-size:12px;color:#999;">URL: ${apiUrl}</p>
                    <p style="font-size:12px;color:#999;">请检查：1. Servlet是否已部署 2. 数据库是否连接 3. 控制台错误信息</p>
                </div>`;
            }
        });
}

// 渲染任务列表
function renderTasks() {
    const container = document.getElementById('task-list-body');
    if (!container) {
        console.warn('task-list-body 容器不存在');
        return;
    }

    // 确保使用最新的数据
    const tasksData = window.tasksData || [];
    
    const searchEl = document.getElementById('task-search');
    const filterEl = document.getElementById('task-filter');
    const keyword = searchEl ? searchEl.value.trim() : ''; 
    const filterType = filterEl ? filterEl.value : 'all'; 

    const filteredTasks = tasksData.filter(task => {
        // 处理可能为null或undefined的字段
        const bed = (task.bed || '').toString();
        const name = (task.name || '').toString();
        const matchSearch = bed.includes(keyword) || name.includes(keyword);
        let matchFilter = true;
        const status = task.status || '待执行';
        if (filterType === 'pending') matchFilter = (status === '待执行' || status === '执行中');
        if (filterType === 'completed') matchFilter = (status === '已完成');
        return matchSearch && matchFilter;
    });

    // 清空容器内容
    container.innerHTML = '';

    console.log('过滤前任务数:', tasksData.length, '过滤后任务数:', filteredTasks.length);
    
    if (filteredTasks.length === 0) {
        console.warn('没有匹配的任务，tasksData:', tasksData);
        container.innerHTML = '<div style="padding:20px; text-align:center; color:#999;">暂无匹配的任务</div>';
        return;
    }

    filteredTasks.forEach((task, index) => {
        // 确保task.id是字符串类型（新数据库使用VARCHAR类型的task_id）
        const taskId = String(task.id || '');
        
        // 处理status字段：可能是数字（0/1）或字符串（待执行/执行中/已完成/已取消）
        let status = task.status;
        if (status === null || status === undefined) {
            status = '待执行';
        } else if (typeof status === 'number') {
            // 如果是数字，转换为文本
            switch (status) {
                case 0: status = '待执行'; break;
                case 1: status = '已完成'; break;
                default: status = '待执行';
            }
        } else if (typeof status === 'string') {
            // 如果是字符串但值是数字，也转换
            if (status === '0') {
                status = '待执行';
            } else if (status === '1') {
                status = '已完成';
            }
            // 否则保持原值（待执行/执行中/已完成/已取消）
        } else {
            status = String(status);
        }
        
        
        // 根据状态显示不同的徽章样式
        let statusHtml;
        if (status === '已完成') {
            statusHtml = `<span class="badge badge-done">已完成</span>`;
        } else if (status === '执行中') {
            statusHtml = `<span class="badge badge-processing">执行中</span>`;
        } else if (status === '已取消') {
            statusHtml = `<span class="badge badge-cancelled">已取消</span>`;
        } else {
            // 兼容旧数据：如果status是"待办"，也显示为"待执行"
            const displayStatus = (status === '待办' || status === '待执行') ? '待执行' : status;
            statusHtml = `<span class="badge badge-pending">${displayStatus}</span>`;
        }
        
        // 创建下拉选择框（使用事件委托，不依赖onchange属性）
        // 确保状态值正确（兼容"待办"）
        const normalizedStatus = (status === '待办') ? '待执行' : status;
        const selectHtml = `
            <select class="status-select" data-task-id="${taskId}" data-original-status="${normalizedStatus}" aria-label="任务状态选择" title="选择任务状态" style="padding: 5px 8px; font-size: 12px; border: 1px solid #ddd; border-radius: 4px; cursor: pointer; min-width: 100px;">
                <option value="待执行" ${normalizedStatus === '待执行' ? 'selected' : ''}>待执行</option>
                <option value="执行中" ${normalizedStatus === '执行中' ? 'selected' : ''}>执行中</option>
                <option value="已完成" ${normalizedStatus === '已完成' ? 'selected' : ''}>已完成</option>
                <option value="已取消" ${normalizedStatus === '已取消' ? 'selected' : ''}>已取消</option>
            </select>
        `;

        // 安全处理可能为null或undefined的字段
        const time = task.time || '';
        const bed = task.bed || '0000';
        const name = task.name || '未知患者';
        const content = task.content || '';
        
        // 根据状态添加completed类
        const rowClass = status === '已完成' ? 'completed' : '';
        
        const row = `
            <div class="task-row ${rowClass}">
                <span class="col-time">${time}</span>
                <span class="col-bed">${bed}床</span>
                <span class="col-patient">${name}</span>
                <span class="col-content">${content}</span>
                <span class="col-status">${statusHtml}</span>
                <span class="col-action">${selectHtml}</span>
            </div>
        `;
        container.innerHTML += row;
    });
    
    // 验证下拉框是否已创建
    const selects = container.querySelectorAll('.status-select');
    if (selects.length === 0) {
        console.error('错误：下拉框没有被创建！');
    }
    
    // 使用全局事件委托，这样更可靠，不需要每次重新绑定
    if (!window.statusSelectHandlerBound) {
        document.addEventListener('change', function(e) {
            if (e.target && e.target.classList.contains('status-select')) {
                const select = e.target;
                const taskId = select.getAttribute('data-task-id');
                const newStatus = select.value;
                const originalStatus = select.getAttribute('data-original-status');
                
                if (typeof updateTaskStatus === 'function') {
                    updateTaskStatus(taskId, newStatus, originalStatus, select);
                } else {
                    console.error('updateTaskStatus 函数不存在');
                }
            }
        });
        window.statusSelectHandlerBound = true;
    }
}

// 更新任务状态（通过下拉选择框）
function updateTaskStatus(taskId, newStatus, originalStatus, selectElement) {
    // 如果状态没有改变，直接返回
    if (newStatus === originalStatus) {
        if (selectElement) {
            selectElement.value = originalStatus;
        }
        return;
    }
    
    if (!confirm(`确认要将任务状态从【${originalStatus}】修改为【${newStatus}】吗？`)) {
        // 如果取消，需要恢复原来的值
        if (selectElement) {
            selectElement.value = originalStatus;
        }
        return;
    }

    // 获取API URL（与fetchTasksFromDB使用相同的逻辑）
    let apiUrl;
    try {
        const path = window.location.pathname;
        const homeIndex = path.indexOf('/home/');
        if (homeIndex > 0) {
            const basePath = path.substring(0, homeIndex);
            apiUrl = `${basePath}/servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=update&id=${taskId}&status=${encodeURIComponent(newStatus)}`;
        } else {
            apiUrl = `../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=update&id=${taskId}&status=${encodeURIComponent(newStatus)}`;
        }
    } catch (e) {
        apiUrl = `../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=update&id=${taskId}&status=${encodeURIComponent(newStatus)}`;
    }

    fetch(apiUrl, { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        .then(res => res.text())
        .then(result => {
            if (result.trim() === 'success') {
                
                // 更新全局数据中的状态
                const tasksData = window.tasksData || [];
                const taskIndex = tasksData.findIndex(t => t.id === taskId);
                if (taskIndex !== -1) {
                    tasksData[taskIndex].status = newStatus;
                    window.tasksData = tasksData; // 更新window对象
                }
                
                // 立即更新当前行的状态显示
                const row = selectElement.closest('.task-row');
                if (row) {
                    const statusSpan = row.querySelector('.col-status');
                    if (statusSpan) {
                        // 更新状态徽章
                        let statusHtml;
                        if (newStatus === '已完成') {
                            statusHtml = `<span class="badge badge-done">已完成</span>`;
                            row.classList.add('completed');
                        } else if (newStatus === '执行中') {
                            statusHtml = `<span class="badge badge-processing">执行中</span>`;
                            row.classList.remove('completed');
                        } else if (newStatus === '已取消') {
                            statusHtml = `<span class="badge badge-cancelled">已取消</span>`;
                            row.classList.remove('completed');
                        } else {
                            statusHtml = `<span class="badge badge-pending">待执行</span>`;
                            row.classList.remove('completed');
                        }
                        statusSpan.innerHTML = statusHtml;
                    }
                    
                    // 更新下拉框的原始状态
                    selectElement.setAttribute('data-original-status', newStatus);
                }
                
                // 更新统计信息
                updateStats();
                
                // 延迟刷新完整列表以确保数据同步
                setTimeout(() => {
                    fetchTasksFromDB();
                }, 1000); 
            } else if (result.trim() === 'invalid_status') {
                alert("无效的状态值，请重新选择");
                // 恢复原值
                if (selectElement) {
                    selectElement.value = originalStatus || '待执行';
                }
            } else {
                alert("操作失败，请检查网络或后台日志");
                // 恢复原值
                if (selectElement) {
                    selectElement.value = originalStatus || '待执行';
                }
            }
        })
        .catch(err => {
            console.error("请求错误:", err);
            alert("网络连接错误");
            // 恢复原值
            if (selectElement) {
                selectElement.value = originalStatus || '待执行';
            }
        });
}

// 确保函数在全局作用域（用于兼容性）
window.updateTaskStatus = updateTaskStatus;

// 更新统计
function updateStats() {
    const tasksData = window.tasksData || [];
    const total = tasksData.length;
    const done = tasksData.filter(t => t.status === '已完成').length;
    const pending = tasksData.filter(t => t.status === '待执行' || t.status === '执行中').length;
    const cancelled = tasksData.filter(t => t.status === '已取消').length;
    const delayed = tasksData.filter(t => {
        // 检查是否有延误的任务（待执行或执行中，且计划时间已过）
        if (t.status === '待执行' || t.status === '执行中') {
            // 这里可以根据plan_time判断是否延误，暂时简单处理
            return false;
        }
        return false;
    }).length;

    const todoEl = document.getElementById('todo-count');
    const doneEl = document.getElementById('done-count');
    const alertEl = document.getElementById('alert-count');
    
    if(todoEl) todoEl.textContent = pending;
    if(doneEl) doneEl.textContent = done;
    if(alertEl) alertEl.textContent = delayed;
}

// 刷新按钮
function refreshTasks() {
    fetchTasksFromDB();
    const searchEl = document.getElementById('task-search');
    if(searchEl) searchEl.value = '';
}

} // 结束防止重复加载的检查块

