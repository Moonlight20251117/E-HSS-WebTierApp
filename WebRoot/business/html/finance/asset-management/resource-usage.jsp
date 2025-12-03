<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>资源使用</h2>
    <div class="content-wrapper">
        <p>查看资源使用情况</p>
        <br>
        <a href="#" class="btn submit-btn">查看使用</a>
    </div>
</div>

