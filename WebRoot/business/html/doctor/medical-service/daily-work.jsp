<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>日常工作安排</h2>
        <div class="date-display">当前日期�?span id="current-date"></span></div>
    </div>
    
    <div class="stats-row">
        <div class="stat-card blue">
            <h3>今日患�?/h3>
            <p class="stat-num" id="today-patients">0</p>
        </div>
        <div class="stat-card green">
            <h3>已完�?/h3>
            <p class="stat-num" id="completed-tasks">0</p>
        </div>
        <div class="stat-card orange">
            <h3>待处�?/h3>
            <p class="stat-num" id="pending-tasks">0</p>
        </div>
    </div>
    
    <div class="toolbar">
        <input type="text" placeholder="搜索患者姓�?.." class="search-input">
        <select class="filter-select">
            <option value="all">全部</option>
            <option value="today">今日</option>
            <option value="week">本周</option>
        </select>
        <button class="btn btn-primary">刷新</button>
    </div>
    
    <div class="content-wrapper">
        <table class="data-table">
            <thead>
                <tr>
                    <th>时间</th>
                    <th>患者姓�?/th>
                    <th>科室</th>
                    <th>状�?/th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="work-list-body">
                <tr>
                    <td colspan="5" style="text-align:center;padding:20px;color:#6c757d;">暂无数据</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
<script src="<%=basePath%>business/scripts/business-common.js"></script>

