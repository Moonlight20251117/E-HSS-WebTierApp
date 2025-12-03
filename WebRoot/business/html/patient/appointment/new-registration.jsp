<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>新建挂号</h2>
    <form id="registration-form">
        <div class="form-group">
            <label>选择科室�?/label>
            <select name="department" class="form-control" required>
                <option value="">请选择科室</option>
                <option value="internal">内科</option>
                <option value="surgery">外科</option>
                <option value="pediatrics">儿科</option>
            </select>
        </div>
        <div class="form-group">
            <label>患者姓名：</label>
            <input type="text" name="patientName" class="form-control" required>
        </div>
        <div class="form-group">
            <label>联系电话�?/label>
            <input type="tel" name="phone" class="form-control" required>
        </div>
        <div class="form-group">
            <label>症状描述�?/label>
            <textarea name="symptoms" class="form-control" rows="3"></textarea>
        </div>
        <div class="action-buttons">
            <button type="submit" class="btn btn-primary">提交挂号</button>
            <button type="reset" class="btn btn-secondary">重置</button>
        </div>
    </form>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/appointment.css">
<script src="<%=basePath%>business/scripts/appointment.js"></script>
