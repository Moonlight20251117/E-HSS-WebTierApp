<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>查看病历</h2>
    <div id="record-view-container">
        <!-- 病历内容将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/medical-record.css">
<script src="<%=basePath%>business/scripts/medical-record.js"></script>
