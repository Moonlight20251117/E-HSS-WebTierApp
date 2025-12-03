<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <base href="<%=basePath%>">
        <title>云计算服务门户入口</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css" rel="stylesheet">
        <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/main.css">
    </head>

    <body>
        <div class="header">
            <h1><a href="#">云计算服务门户入口</a></h1>
        </div>
        
        <div class="container">
            <div class="col-md-offset-4 col-lg-offset-4 col-xl-offset-4">
                <form action="SaaSportal/index.html" method="get" class="">
                    <div id="selectCloud" class="form-group form-inline">
                        <label class="control-label">选择云</label>
                            <select class="form-control" name="select" id="cloudSelect">
                                <option value="Education">教育云</option>
                                <option value="Enterprise">企业云</option>
                                <option value="Healthcare">医疗云</option>
                                <option value="Epidemic">抗疫云</option>
                            </select>
                        <button type="button" class="btn btn-primary form-control" onclick="handleCloudSelection()">进入云</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="footer text-center">
        	版权所有 © 北京工业大学 ICP备:XXXXXXXX号 COPYRIGHT © BEIJING UNIVERSITY OF TECHNOLOGY
        </div>
    </body>

        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/index.js"></script>
</html>