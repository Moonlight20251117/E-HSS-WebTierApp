<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <title>智慧医疗云系统 - 用户注册</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/login.css">
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>智慧医疗云系统 - 用户注册</h1>
        </div>
        
        <div class="login-form">
            <form method="post" action="<%=basePath%>servlet/login/UserManageService_Tool" id="registrationForm">
                <input type="hidden" name="action" value="regist">
                
                <div class="form-group">
                    <label for="username">用户名 <span style="color: red;">*</span></label>
                    <input type="text" id="username" name="username" required placeholder="请输入用户名（必填）">
                </div>
                
                <div class="form-group">
                    <label for="password">密码 <span style="color: red;">*</span></label>
                    <input type="password" id="password" name="password" required placeholder="请输入密码（必填）" minlength="6">
                </div>
                
                <div class="form-group">
                    <label for="realName">真实姓名 <span style="color: red;">*</span></label>
                    <input type="text" id="realName" name="realName" required placeholder="请输入真实姓名（必填）">
                </div>
                
                <div class="form-group">
                    <label for="idCard">身份证号 <span style="color: red;">*</span></label>
                    <input type="text" id="idCard" name="idCard" required placeholder="请输入18位身份证号（必填）" pattern="[0-9Xx]{18}" title="请输入18位身份证号">
                </div>
                
                <div class="form-group">
                    <label for="gender">性别</label>
                    <select id="gender" name="gender">
                        <option value="">请选择性别</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                        <option value="未知">未知</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="phone">手机号码 <span style="color: red;">*</span></label>
                    <input type="tel" id="phone" name="phone" required placeholder="请输入11位手机号码（必填）" pattern="[0-9]{11}" title="请输入11位手机号码">
                </div>
                
                <div class="form-group">
                    <label for="role">身份 <span style="color: red;">*</span></label>
                    <select id="role" name="role" required>
                        <option value="">请选择身份（必填）</option>
                        <option value="ROLE_PATIENT">患者</option>
                        <option value="ROLE_DOCTOR">医生</option>
                        <option value="ROLE_NURSE">护士</option>
                        <option value="ROLE_FINANCE">财务人员</option>
                        <option value="ROLE_EXECUTIVE">医院高管</option>
                        <option value="ROLE_ADMIN">管理员</option>
                        <option value="ROLE_ENTERPRISE">医疗相关企业</option>
                        <option value="ROLE_UNIVERSITY">医疗相关高校</option>
                    </select>
                </div>
                
                <div style="text-align: right; padding: 10px 0px;">
                    <a href="<%=basePath%>login/patient-login.jsp" style="color: #42A2FF; text-decoration: none;">已有账号，去登录</a>
                </div>
        
                <div class="form-actions">
                    <input type="submit" name="registerbutton" value="注册">
                    <input type="reset" value="重置">
                </div>
            </form>
        </div>
        
        <div class="login-footer">
            <p>智慧医疗云系统 &copy; 2025</p>
        </div>
    </div>

    <script type="text/javascript" src="<%=basePath%>js/register.js"></script>
</body>
</html>

