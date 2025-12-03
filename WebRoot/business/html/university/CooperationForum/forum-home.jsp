<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>论坛首页</h2>
    <div class="filter-bar">
        <select class="post-filter">
            <option value="all">全部内容</option>
            <option value="enterprise">企业发布</option>
            <option value="university">高校发布</option>
            <option value="executive">医院发布</option>
        </select>
        <input type="text" class="search-box" placeholder="搜索帖子...">
        <button class="search-btn" onclick="searchPosts()">搜索</button>
    </div>

    <div class="posts-container" id="posts-container">
        <!-- 帖子列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/forum.css">
<script src="<%=basePath%>business/scripts/forum.js"></script>
<script>
// 页面加载时加载帖�?
document.addEventListener('DOMContentLoaded', function() {
    loadForumPosts();
});
</script>
