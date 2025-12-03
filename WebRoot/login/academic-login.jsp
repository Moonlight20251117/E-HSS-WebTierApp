<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
// 设置页面属性
request.setAttribute("pageTitle", "智慧医疗云系统 - 学术版登录");
request.setAttribute("headerTitle", "智慧医疗云系统 - 学术版登录");
request.setAttribute("headerSubtitle", "请登录您的账号");
request.setAttribute("loginType", "academic");
request.setAttribute("registerReturnUrl", path + "/login/academic-login.jsp");
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

