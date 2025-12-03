<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>诊断历史</h2>
    <div class="content-wrapper">
        <p>查看您的远程诊断历史记录</p>
        <br>
        <a href="#" class="btn submit-btn">查看历史</a>
    </div>
</div>

