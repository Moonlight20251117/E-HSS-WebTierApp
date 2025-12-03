<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>医疗咨询</h2>
    <div class="content-wrapper">
        <p>提供医疗咨询服务</p>
        <br>
        <a href="../../../../servlet/hospital/doctor/MedicalAdviceServlet" class="btn submit-btn">医疗咨询</a>
    </div>
</div>

