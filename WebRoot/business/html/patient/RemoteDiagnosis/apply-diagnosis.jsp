<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>申请远程诊断</h2>
    <form id="diagnosis-application-form">
        <div class="form-group">
            <label>选择医生�?/label>
            <select name="doctorId" class="form-control" required>
                <option value="">请选择医生</option>
                <option value="1">张医�?- 内科</option>
                <option value="2">李医�?- 外科</option>
                <option value="3">王医�?- 儿科</option>
            </select>
        </div>
        <div class="form-group">
            <label>症状描述�?/label>
            <textarea name="symptoms" class="form-control" rows="5" placeholder="请详细描述您的症�?.." required></textarea>
        </div>
        <div class="form-group">
            <label>详细描述�?/label>
            <textarea name="description" class="form-control" rows="5" placeholder="请补充其他相关信�?.."></textarea>
        </div>
        <div class="action-buttons">
            <button type="submit" class="btn btn-primary">提交申请</button>
            <button type="reset" class="btn btn-secondary">重置</button>
        </div>
    </form>
</div>
<script src="<%=basePath%>business/scripts/remote-diagnosis.js"></script>

