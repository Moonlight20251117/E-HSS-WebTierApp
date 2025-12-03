<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>远程诊断</h2>
    </div>
    
    <div class="toolbar">
        <select class="filter-select">
            <option value="all">全部</option>
            <option value="pending">待处�?/option>
            <option value="processing">处理�?/option>
            <option value="completed">已完�?/option>
        </select>
        <button class="btn btn-primary" onclick="loadDiagnosisApplications()">刷新</button>
    </div>
    
    <div id="applications-container">
        <!-- 诊断申请列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script src="<%=basePath%>business/scripts/remote-diagnosis.js"></script>

