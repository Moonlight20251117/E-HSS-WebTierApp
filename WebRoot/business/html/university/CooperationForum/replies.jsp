<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>我的回复</h2>
    <div id="replies-container">
        <!-- 回复列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/forum.css">
<script src="<%=basePath%>business/scripts/forum.js"></script>
