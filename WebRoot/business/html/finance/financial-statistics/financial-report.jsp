<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>财务报表</h2>
    <div class="content-wrapper">
        <p>生成和查看财务报�?/p>
        <br>
        <a href="../../../../servlet/hospital/finance/FinancialStatisticsServlet" class="btn submit-btn">查看报表</a>
    </div>
</div>

