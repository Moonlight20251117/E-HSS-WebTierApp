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
        <button class="search-btn">搜索</button>
    </div>

    <div class="posts-container">
        <div class="post-card">
            <div class="post-header">
                <span class="post-author">某医疗科技公司（企业）</span>
                <span class="post-time">2025-11-18 09:25</span>
            </div>
            <div class="post-title">智慧医院建设经验分享</div>
            <div class="post-content">
                我院�?024年完成智慧化改造，重点优化了门诊流程与病房管理系统，患者平均等待时间缩�?0%，设备利用率提升25%...
            </div>
            <div class="post-actions">
                <button class="edit-btn">编辑</button>
                <button class="delete-btn">删除</button>
                <button class="view-reply-btn">查看回复(5)</button>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/forum.css">
<script src="<%=basePath%>business/scripts/forum.js"></script>

