<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>资产分配</h2>
    <div class="content-wrapper">
        <p>管理资产分配情况</p>
        <br>
        <a href="#" class="btn submit-btn">分配资产</a>
    </div>
</div>

