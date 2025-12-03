<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>收入统计</h2>
        <select class="filter-select">
            <option value="today">今日</option>
            <option value="week">本周</option>
            <option value="month" selected>本月</option>
            <option value="year">本年</option>
        </select>
    </div>
    
    <div class="stats-row">
        <div class="stat-card blue">
            <h3>总收�?/h3>
            <p class="stat-num" id="total-revenue">¥0</p>
        </div>
        <div class="stat-card green">
            <h3>门诊收入</h3>
            <p class="stat-num" id="outpatient-revenue">¥0</p>
        </div>
        <div class="stat-card orange">
            <h3>住院收入</h3>
            <p class="stat-num" id="inpatient-revenue">¥0</p>
        </div>
    </div>
    
    <div class="statistics-chart">
        <h3>收入趋势�?/h3>
        <div class="chart-container" id="revenue-chart">
            <!-- 图表将通过JS动态生�?-->
        </div>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/finance.css">
<script src="<%=basePath%>business/scripts/finance.js"></script>
<script>
// 加载收入统计数据
fetch('../../../../servlet/hospital/finance/FinancialStatisticsServlet?action=getRevenue')
    .then(response => response.json())
    .then(data => {
        document.getElementById('total-revenue').textContent = '¥' + data.total;
        document.getElementById('outpatient-revenue').textContent = '¥' + data.outpatient;
        document.getElementById('inpatient-revenue').textContent = '¥' + data.inpatient;
        // TODO: 渲染图表
    })
    .catch(error => {
        console.error('加载统计数据失败:', error);
    });
</script>

