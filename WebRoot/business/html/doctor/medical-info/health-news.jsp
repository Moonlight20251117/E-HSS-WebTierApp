<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>健康新闻</h2>
        <select id="info-category-filter" class="filter-select">
            <option value="all">全部</option>
            <option value="health-news">健康新闻</option>
            <option value="disease-prevent">疾病预防</option>
            <option value="medical-knowledge">医疗知识</option>
        </select>
    </div>
    
    <div id="info-list-container">
        <!-- 资讯列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script src="<%=basePath%>business/scripts/medical-info.js"></script>

