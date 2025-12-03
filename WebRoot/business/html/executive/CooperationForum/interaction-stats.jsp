<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>互动统计</h2>
    <div class="statistics-chart">
        <div class="chart-container" id="interaction-chart">
            <!-- 图表将通过JS动态生�?-->
        </div>
    </div>
</div>
<link rel="stylesheet" href="../../../../css/forum.css">
<script src="../../../../scripts/forum.js"></script>
