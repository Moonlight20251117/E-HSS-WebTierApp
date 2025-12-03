<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 优先从 attribute 获取，如果没有则从 parameter 获取
String sidebarItemsHtml = (String)request.getAttribute("sidebarItemsHtml");
if (sidebarItemsHtml == null) {
    sidebarItemsHtml = request.getParameter("sidebarItemsHtml");
}
if (sidebarItemsHtml == null) {
    sidebarItemsHtml = "";
}
%>
<!-- 侧边栏容器 -->
<div id="contentNav-container">
    <%=sidebarItemsHtml%>
</div>

