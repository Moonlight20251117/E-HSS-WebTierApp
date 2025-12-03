<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>病历设置</h2>
    <div class="content-wrapper">
        <p>配置病历管理相关设置</p>
        <br>
        <a href="#" class="btn submit-btn">设置</a>
    </div>
</div>

