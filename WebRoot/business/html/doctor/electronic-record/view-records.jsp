<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>电子病历管理</h2>
        <button class="btn btn-primary" onclick="addRecord()">添加病历</button>
    </div>
    
    <div class="toolbar">
        <input type="text" id="record-search" placeholder="搜索患者姓�?.." class="search-input">
        <button class="btn btn-primary" onclick="loadMedicalRecords()">刷新</button>
    </div>
    
    <div class="record-list" id="records-container">
        <!-- 病历列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/medical-record.css">
<script src="<%=basePath%>business/scripts/medical-record.js"></script>

