<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>业务管理</h2>
        <button class="btn btn-primary" onclick="addBusiness()">新增业务</button>
    </div>
    
    <div class="toolbar">
        <input type="text" placeholder="搜索业务..." class="search-input">
        <button class="btn btn-primary" onclick="loadBusinessList()">刷新</button>
    </div>
    
    <div id="business-list-container">
        <!-- 业务列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet"  
        $url = $matches[1]
        if (-not ($url -match '^(https?://|/|#|javascript:)')) {
            if ($url.StartsWith('../')) {
                "href=`"$url`""
            } elseif ($url.StartsWith('./')) {
                "href=`"$url`""
            } else {
                "href=`"<%=basePath%>$url`""
            }
        } else {
            "href=`"$url`""
        }
    >
<script>
function loadBusinessList() {
    fetch('../../../../servlet/admin/BusinessManageServlet?action=list')
        .then(response => response.json())
        .then(businesses => {
            renderBusinessList(businesses);
        })
        .catch(error => {
            console.error('加载业务列表失败:', error);
        });
}

function renderBusinessList(businesses) {
    const container = document.getElementById('business-list-container');
    if (!container) return;
    
    let html = '<table class="data-table"><thead><tr><th>业务ID</th><th>业务名称</th><th>状�?/th><th>操作</th></tr></thead><tbody>';
    
    businesses.forEach(business => {
        html += `
            <tr>
                <td>${business.id}</td>
                <td>${business.name}</td>
                <td>${business.status}</td>
                <td>
                    <button onclick="editBusiness(${business.id})">编辑</button>
                    <button onclick="deleteBusiness(${business.id})">删除</button>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}
</script>

