/**
 * 智慧医疗云 - 护士端日常护理逻辑
 * 对应页面：nurse/index.html
 */

// 全局变量存储任务数据
let tasksData = [];

document.addEventListener('DOMContentLoaded', function() {
    // 1. 安全检查：只在存在“日常护理”模块的页面执行，防止报错
    if (!document.getElementById('daily-nursing')) return;

    // 2. 初始化：从数据库加载数据
    fetchTasksFromDB();
    
    // 3. 设置日期
    const now = new Date();
    const dateEl = document.getElementById('current-date');
    if(dateEl) dateEl.textContent = now.toLocaleDateString('zh-CN');

    // 4. 绑定搜索监听
    const searchInput = document.getElementById('task-search');
    if (searchInput) {
        searchInput.addEventListener('input', renderTasks);
    }

    // 5. 绑定筛选监听
    const filterSelect = document.getElementById('task-filter');
    if (filterSelect) {
        filterSelect.addEventListener('change', renderTasks);
    }
});

// --- 核心：从后端 Servlet 获取数据 ---
function fetchTasksFromDB() {
    // 注意：URL 路径要与 Servlet 注解 @WebServlet 一致
    const apiUrl = '../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=list';
    
    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            tasksData = data; // 将数据库数据存入全局变量
            renderTasks();    // 渲染界面
            updateStats();    // 更新统计
        })
        .catch(err => {
            console.error("获取数据失败:", err);
            const container = document.getElementById('task-list-body');
            if(container) container.innerHTML = '<div style="padding:20px;color:red;text-align:center">无法连接服务器获取数据</div>';
        });
}

// --- 渲染列表 (根据 tasksData 和筛选条件) ---
function renderTasks() {
    const container = document.getElementById('task-list-body');
    if (!container) return;

    container.innerHTML = ''; 

    // 获取筛选条件
    const searchEl = document.getElementById('task-search');
    const filterEl = document.getElementById('task-filter');
    const keyword = searchEl ? searchEl.value.trim() : ''; 
    const filterType = filterEl ? filterEl.value : 'all'; 

    // 过滤数据
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
            // 已完成
            statusHtml = `<span class="badge badge-done">已完成</span>`;
            // 撤销按钮：调用 networkUpdateTask 传入 0
            btnHtml = `<button class="btn-sm btn-undo" onclick="networkUpdateTask(${task.id}, 0)">↩ 撤销</button>`;
        } else {
            // 待办
            statusHtml = `<span class="badge badge-pending">待办</span>`;
            // 完成按钮：调用 networkUpdateTask 传入 1
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

// --- 核心：网络请求更新状态 ---
// id: 任务ID, newStatus: 1(完成) 或 0(撤销)
function networkUpdateTask(id, newStatus) {
    const actionText = newStatus === 1 ? "完成" : "撤销";
    
    if (!confirm(`确认要标记为【${actionText}】吗？`)) {
        return;
    }

    // 发送请求给 Servlet
    const apiUrl = `../../servlet/hospital/nurse/MedicalServiceServlet_Nurse?action=update&id=${id}&status=${newStatus}`;

    fetch(apiUrl, { method: 'POST' })
        .then(res => res.text())
        .then(result => {
            if (result.trim() === 'success') {
                // 成功后，重新从数据库拉取最新数据
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

// 兼容旧代码的入口 (如果 HTML onclick 还没改)
function completeTask(id) { networkUpdateTask(id, 1); }
function revokeTask(id) { networkUpdateTask(id, 0); }

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
    if(searchEl) searchEl.value = ''; // 清空搜索
}