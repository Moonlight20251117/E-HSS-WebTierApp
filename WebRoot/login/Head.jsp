<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
// 变量已在主文件中声明，这里只获取pageTitle
// path 变量在主文件中声明，这里直接使用
String pageTitle = request.getAttribute("pageTitle") != null ? (String) request.getAttribute("pageTitle") : 
                   (request.getParameter("pageTitle") != null ? request.getParameter("pageTitle") : "智慧医疗云系统 - 用户登录");
%>
<head>
    <base href="<%=path%>/">
    <title><%=pageTitle%></title>
    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="智慧医疗云,登录,用户登录">
    <meta http-equiv="description" content="智慧医疗云系统用户登录页面">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/login.css">
</head>

