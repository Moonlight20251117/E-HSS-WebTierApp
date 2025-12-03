<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>取消挂号</h2>
    <div id="cancel-registration-container">
        <!-- 可取消的挂号列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/appointment.css">
<script src="<%=basePath%>business/scripts/appointment.js"></script>
