<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>诊断历史</h2>
    <div id="diagnosis-history-container">
        <!-- 诊断历史列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script src="<%=basePath%>business/scripts/remote-diagnosis.js"></script>
