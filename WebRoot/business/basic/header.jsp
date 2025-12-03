<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
// 获取传入的参数，优先使用request.getAttribute()，如果没有则使用request.getParameter()
String pageTitle = (String) request.getAttribute("pageTitle");
if (pageTitle == null) {
    pageTitle = request.getParameter("pageTitle");
}
if (pageTitle == null) {
    pageTitle = "智慧医疗云系统";
}

String userWelcome = (String) request.getAttribute("userWelcome");
if (userWelcome == null) {
    userWelcome = request.getParameter("userWelcome");
}
if (userWelcome == null) {
    userWelcome = "欢迎，用户";
}

String logoutLink = (String) request.getAttribute("logoutLink");
if (logoutLink == null) {
    logoutLink = request.getParameter("logoutLink");
}
if (logoutLink == null) {
    logoutLink = basePath + "login/patient-login.jsp";
} else if (!logoutLink.startsWith("http://") && !logoutLink.startsWith("https://") && !logoutLink.startsWith("/")) {
    // 如果是相对路径，添加basePath
    logoutLink = basePath + logoutLink;
}
%>
<div class="header">
    <div class="portal-logo">
        <img id="header-logo" src="<%=basePath%>images/logo.jpg" alt="智慧医疗云">
        <span id="header-title"><%=pageTitle%></span>
    </div>
    <div class="user-info">
        <span id="user-welcome"><%=userWelcome%></span>
        <a href="<%=logoutLink%>" id="logout-link">退出登录</a>
    </div>
</div>

