<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>采购订单</h2>
    <div class="content-wrapper">
        <p>管理药品采购订单</p>
        <br>
        <a href="../../../../servlet/hospital/finance/DrugPurchaseServlet" class="btn submit-btn">查看订单</a>
    </div>
</div>

