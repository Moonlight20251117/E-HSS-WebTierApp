<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>病历帮助</h2>
    <div class="help-content">
        <h3>如何查看病历�?/h3>
        <p>�?查看病历"页面，您可以查看您的所有电子病历记录�?/p>
        
        <h3>如何下载病历�?/h3>
        <p>�?下载病历"页面，您可以选择需要下载的病历并保存为PDF格式�?/p>
        
        <h3>如何分享病历�?/h3>
        <p>�?分享病历"页面，您可以生成分享链接，将病历分享给其他医生或医疗机构�?/p>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/medical-record.css">
