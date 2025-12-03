<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 优先从 attribute 获取，如果没有则从 parameter 获取
String navItemsHtml = (String)request.getAttribute("navItemsHtml");
if (navItemsHtml == null) {
    navItemsHtml = request.getParameter("navItemsHtml");
}
if (navItemsHtml == null) {
    navItemsHtml = "";
}
%>
<!-- 横向导航栏 -->
<div class="horizontal-nav">
    <ul>
        <%=navItemsHtml%>
    </ul>
</div>

