<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>远程干预</h2>
    <div class="content-wrapper">
        <p>提供远程医疗干预服务</p>
        <br>
        <a href="../../../../servlet/hospital/doctor/RemoteConsultationDocServlet" class="btn submit-btn">远程干预</a>
    </div>
</div>

