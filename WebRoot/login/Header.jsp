<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 变量已在主文件中声明，这里只获取header相关属性
String headerTitle = request.getAttribute("headerTitle") != null ? (String) request.getAttribute("headerTitle") : 
                     (request.getParameter("headerTitle") != null ? request.getParameter("headerTitle") : "智慧医疗云系统 - 用户登录");
String headerSubtitle = request.getAttribute("headerSubtitle") != null ? (String) request.getAttribute("headerSubtitle") : 
                        (request.getParameter("headerSubtitle") != null ? request.getParameter("headerSubtitle") : "");
%>
<!-- 登录页面头部 -->
<div class="login-header">
    <h1><%=headerTitle%></h1>
    <% if (headerSubtitle != null && !headerSubtitle.isEmpty()) { %>
        <p><%=headerSubtitle%></p>
    <% } %>
</div>

