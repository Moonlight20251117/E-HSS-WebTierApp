<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>我的帖子</h2>
    <div class="toolbar">
        <select class="filter-select">
            <option value="all">全部</option>
            <option value="pending">待审�?/option>
            <option value="approved">已通过</option>
            <option value="rejected">已拒�?/option>
        </select>
        <button class="btn btn-primary" onclick="loadMyPosts()">刷新</button>
    </div>
    
    <div class="posts-container" id="my-posts-container">
        <!-- 我的帖子列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/forum.css">
<script src="<%=basePath%>business/scripts/forum.js"></script>
<script>
function loadMyPosts() {
    fetch('../../../../servlet/enterprise/CooperationForumServlet_enterprise?action=myPosts')
        .then(response => response.json())
        .then(posts => {
            renderMyPosts(posts);
        })
        .catch(error => {
            console.error('加载我的帖子失败:', error);
        });
}

function renderMyPosts(posts) {
    const container = document.getElementById('my-posts-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    posts.forEach(post => {
        const postCard = document.createElement('div');
        postCard.className = 'post-card';
        postCard.innerHTML = `
            <div class="post-header">
                <span class="post-author">�?/span>
                <span class="post-time">${post.createTime}</span>
            </div>
            <div class="post-title">${post.title}</div>
            <div class="post-content">${post.content}</div>
            <div class="post-actions">
                <button class="edit-btn" onclick="editPost(${post.id})">编辑</button>
                <button class="delete-btn" onclick="deletePost(${post.id})">删除</button>
            </div>
        `;
        container.appendChild(postCard);
    });
}
</script>
