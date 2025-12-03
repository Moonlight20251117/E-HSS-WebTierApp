<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>我的帖子</h2>
    <div class="my-posts-list">
        <p>您发布的帖子将显示在这里</p>
    </div>
</div>

