<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>信息上报</h2>
    <div class="content-wrapper">
        <p>上报疾病疫情信息</p>
        <br>
        <a href="#" class="btn submit-btn">上报信息</a>
    </div>
</div>

