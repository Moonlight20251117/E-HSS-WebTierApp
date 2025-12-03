<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>用户管理</h2>
        <button class="btn btn-primary" onclick="addUser()">新增用户</button>
    </div>
    
    <div class="toolbar">
        <input type="text" placeholder="搜索用户�?.." class="search-input">
        <select class="filter-select">
            <option value="all">全部角色</option>
            <option value="patient">患�?/option>
            <option value="doctor">医生</option>
            <option value="nurse">护士</option>
            <option value="finance">财务</option>
        </select>
        <button class="btn btn-primary" onclick="loadUserList()">刷新</button>
    </div>
    
    <div id="user-list-container">
        <!-- 用户列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script>
function loadUserList() {
    fetch('../../../../servlet/admin/UserManageServlet?action=list')
        .then(response => response.json())
        .then(users => {
            renderUserList(users);
        })
        .catch(error => {
            console.error('加载用户列表失败:', error);
        });
}

function renderUserList(users) {
    const container = document.getElementById('user-list-container');
    if (!container) return;
    
    let html = '<table class="data-table"><thead><tr><th>用户ID</th><th>用户�?/th><th>角色</th><th>状�?/th><th>操作</th></tr></thead><tbody>';
    
    users.forEach(user => {
        html += `
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td>
                    <button onclick="editUser(${user.id})">编辑</button>
                    <button onclick="deleteUser(${user.id})">删除</button>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}
</script>

