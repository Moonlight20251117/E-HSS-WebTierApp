<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>下载病历</h2>
    <div class="content-wrapper">
        <p>下载您的电子病历档案</p>
        <br>
        <a href="#" class="btn submit-btn">下载病历</a>
    </div>
</div>

