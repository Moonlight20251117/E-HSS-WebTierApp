<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 变量已在主文件中声明，这里只获取登录相关属性
// path 变量在主文件中声明，这里直接使用
// 获取登录类型：patient, employee, academic
String loginType = request.getAttribute("loginType") != null ? (String) request.getAttribute("loginType") : 
                   (request.getParameter("loginType") != null ? request.getParameter("loginType") : "patient");
// 获取注册链接的返回URL
String registerReturnUrl = request.getAttribute("registerReturnUrl") != null ? (String) request.getAttribute("registerReturnUrl") : 
                           (request.getParameter("registerReturnUrl") != null ? request.getParameter("registerReturnUrl") : "");
%>
<!-- 登录表单工作区域 -->
<div class="login-form">
    <% if ("patient".equals(loginType)) { %>
        <!-- 患者登录表单 -->
        <form method="post" action="<%=path%>/servlet/login/LoginServlet">
            <input type="hidden" name="role" value="patient">
            
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div style="text-align: right; padding: 0 0px;">
                <a href="<%=path%>/registration/register.jsp?return=<%=registerReturnUrl != null && !registerReturnUrl.isEmpty() ? registerReturnUrl : path + "/login/patient-login.jsp"%>" style="color: #42A2FF; text-decoration: none;">没有账号，去注册</a>
            </div>
    
            <div class="form-actions">
                <input type="submit" name="loginbutton" value="登录">
                <input type="reset" value="重置">
            </div>
        </form>
    <% } else if ("employee".equals(loginType)) { %>
        <!-- 员工登录表单 -->
        <form method="post" action="<%=path%>/servlet/login/LoginServlet">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="role">用户角色</label>
                <select id="role" name="role" required>
                    <option value="">请选择角色</option>
                    <option value="doctor">医生</option>
                    <option value="nurse">护士</option>
                    <option value="finance">财务</option>
                    <option value="executive">医院高管</option>
                    <option value="admin">管理员</option>
                </select>
            </div>
            
            <div style="text-align: right; padding: 0 0px;">
                <a href="<%=path%>/registration/register.jsp?return=<%=registerReturnUrl != null && !registerReturnUrl.isEmpty() ? registerReturnUrl : path + "/login/employee-login.jsp"%>" style="color: #42A2FF; text-decoration: none;">没有账号，去注册</a>
            </div>
            
            <div class="form-actions">
                <input type="submit" name="loginbutton" value="登录">
                <input type="reset" value="重置">
            </div>
        </form>
    <% } else if ("academic".equals(loginType)) { %>
        <!-- 学术版登录表单 -->
        <form method="post" action="<%=path%>/servlet/login/LoginServlet">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="role">用户角色</label>
                <select id="role" name="role" required>
                    <option value="">请选择角色</option>
                    <option value="enterprise">医疗相关企业</option>
                    <option value="university">医疗相关高校</option>
                </select>
            </div>
            
            <div style="text-align: right; padding: 0 20px;">
                <a href="<%=path%>/registration/register.jsp?return=<%=registerReturnUrl != null && !registerReturnUrl.isEmpty() ? registerReturnUrl : path + "/login/academic-login.jsp"%>" style="color: #165DFF; text-decoration: none;">没有账号，去注册</a>
            </div>
            
            <div class="form-actions">
                <input type="submit" name="loginbutton" value="登录">
                <input type="reset" value="重置">
            </div>
        </form>
    <% } %>
</div>

