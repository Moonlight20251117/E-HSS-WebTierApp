<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>疫情监控</h2>
        <button class="btn btn-primary" onclick="showReportForm()">上报疫情</button>
    </div>
    
    <div class="stats-row">
        <div class="stat-card red">
            <h3>疑似病例</h3>
            <p class="stat-num" id="suspected-count">0</p>
        </div>
        <div class="stat-card orange">
            <h3>确诊病例</h3>
            <p class="stat-num" id="confirmed-count">0</p>
        </div>
        <div class="stat-card green">
            <h3>已处�?/h3>
            <p class="stat-num" id="processed-count">0</p>
        </div>
    </div>
    
    <div class="toolbar">
        <input type="text" placeholder="搜索疾病名称..." class="search-input">
        <select class="filter-select">
            <option value="all">全部</option>
            <option value="today">今日</option>
            <option value="week">本周</option>
        </select>
        <button class="btn btn-primary" onclick="loadDiseaseData()">刷新</button>
    </div>
    
    <div id="disease-data-container">
        <!-- 疾病数据将通过JS动态加�?-->
    </div>
    
    <!-- 上报表单（隐藏） -->
    <div id="report-form-container" style="display:none;">
        <form id="disease-report-form" class="publish-form">
            <div class="form-group">
                <label>疾病名称�?/label>
                <input type="text" name="diseaseName" class="form-control" required>
            </div>
            <div class="form-group">
                <label>患者数量：</label>
                <input type="number" name="patientCount" class="form-control" required>
            </div>
            <div class="form-group">
                <label>详细描述�?/label>
                <textarea name="description" class="form-control" rows="5" required></textarea>
            </div>
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">提交上报</button>
                <button type="button" class="btn btn-secondary" onclick="hideReportForm()">取消</button>
            </div>
        </form>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script src="<%=basePath%>business/scripts/disease-management.js"></script>
<script>
function showReportForm() {
    document.getElementById('report-form-container').style.display = 'block';
}
function hideReportForm() {
    document.getElementById('report-form-container').style.display = 'none';
}
</script>

