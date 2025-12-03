<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <h2>发布内容</h2>
    <form id="publish-form" class="publish-form">
        <div class="form-group">
            <label>内容标题</label>
            <input type="text" name="title" class="form-control" placeholder="请输入标题（不超�?0字）" required>
        </div>
        <div class="form-group">
            <label>内容详情</label>
            <textarea name="content" class="form-control" rows="6" placeholder="请输入内容详�? required></textarea>
        </div>
        <div class="form-actions">
            <button type="button" class="btn btn-secondary" onclick="cancelPublish()">取消</button>
            <button type="submit" class="btn submit-btn">提交审核</button>
        </div>
    </form>
</div>
<link rel="stylesheet" href="../../../../css/forum.css">
<script src="../../../../scripts/forum.js"></script>
<script>
document.getElementById('publish-form').addEventListener('submit', function(e) {
    e.preventDefault();
    handlePublishSubmit(e);
});
</script>
