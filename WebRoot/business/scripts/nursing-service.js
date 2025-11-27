/**
 * 护务管理业务脚本
 */

// 全局变量存储任务数据
let tasksData = [];

// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    // 检查是否存在日常护理模块
    if (document.getElementById('daily-nursing') || document.getElementById('task-list-body')) {
        initNursingService();
    }
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
    const apiUrl = '../../../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=list';
    
    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            tasksData = data;
            renderTasks();
            updateStats();
        })
        .catch(err => {
            console.error("获取数据失败:", err);
            const container = document.getElementById('task-list-body');
            if(container) container.innerHTML = '<div style="padding:20px;color:red;text-align:center">无法连接服务器获取数据</div>';
        });
}

// 渲染任务列表
function renderTasks() {
    const container = document.getElementById('task-list-body');
    if (!container) return;

    container.innerHTML = '';

    const searchEl = document.getElementById('task-search');
    const filterEl = document.getElementById('task-filter');
    const keyword = searchEl ? searchEl.value.trim() : ''; 
    const filterType = filterEl ? filterEl.value : 'all'; 

    const filteredTasks = tasksData.filter(task => {
        const matchSearch = task.bed.includes(keyword) || task.name.includes(keyword);
        let matchFilter = true;
        if (filterType === 'pending') matchFilter = (task.status === 0);
        if (filterType === 'completed') matchFilter = (task.status === 1);
        return matchSearch && matchFilter;
    });

    if (filteredTasks.length === 0) {
        container.innerHTML = '<div style="padding:20px; text-align:center; color:#999;">暂无匹配的任务</div>';
        return;
    }

    filteredTasks.forEach(task => {
        let statusHtml, btnHtml;

        if (task.status === 1) {
            statusHtml = `<span class="badge badge-done">已完成</span>`;
            btnHtml = `<button class="btn-sm btn-undo" onclick="networkUpdateTask(${task.id}, 0)">↩ 撤销</button>`;
        } else {
            statusHtml = `<span class="badge badge-pending">待办</span>`;
            btnHtml = `<button class="btn-sm btn-done" onclick="networkUpdateTask(${task.id}, 1)">✅ 完成</button>`;
        }

        const row = `
            <div class="task-row ${task.status === 1 ? 'completed' : ''}">
                <span class="col-time">${task.time}</span>
                <span class="col-bed">${task.bed}床</span>
                <span class="col-patient">${task.name}</span>
                <span class="col-content">${task.content}</span>
                <span class="col-status">${statusHtml}</span>
                <span class="col-action">${btnHtml}</span>
            </div>
        `;
        container.innerHTML += row;
    });
}

// 网络请求更新状态
function networkUpdateTask(id, newStatus) {
    const actionText = newStatus === 1 ? "完成" : "撤销";
    
    if (!confirm(`确认要标记为【${actionText}】吗？`)) {
        return;
    }

    const apiUrl = `../../../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=update&id=${id}&status=${newStatus}`;

    fetch(apiUrl, { method: 'POST' })
        .then(res => res.text())
        .then(result => {
            if (result.trim() === 'success') {
                fetchTasksFromDB(); 
            } else {
                alert("操作失败，请检查网络或后台日志");
            }
        })
        .catch(err => {
            console.error("请求错误:", err);
            alert("网络连接错误");
        });
}

// 更新统计
function updateStats() {
    const total = tasksData.length;
    const done = tasksData.filter(t => t.status === 1).length;
    const pending = total - done;

    const todoEl = document.getElementById('todo-count');
    const doneEl = document.getElementById('done-count');
    
    if(todoEl) todoEl.textContent = pending;
    if(doneEl) doneEl.textContent = done;
}

// 刷新按钮
function refreshTasks() {
    fetchTasksFromDB();
    const searchEl = document.getElementById('task-search');
    if(searchEl) searchEl.value = '';
}

