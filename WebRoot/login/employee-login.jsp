<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
// 设置页面属性
request.setAttribute("pageTitle", "智慧医疗云系统 - 员工登录");
request.setAttribute("headerTitle", "智慧医疗云系统 - 员工端登录");
request.setAttribute("loginType", "employee");
request.setAttribute("registerReturnUrl", path + "/login/employee-login.jsp");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include file="Head.jsp" %>
<body>
    <div class="login-container">
        <%@ include file="Header.jsp" %>
        <%@ include file="WorkPlace.jsp" %>
        <%@ include file="Footer.jsp" %>
    </div>
    <script type="text/javascript" src="<%=path%>/js/login.js"></script>
</body>
</html>

