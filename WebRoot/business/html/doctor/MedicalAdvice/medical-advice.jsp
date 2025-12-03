<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="business-content-item">
    <div class="content-header-row">
        <h2>医疗咨询</h2>
    </div>
    
    <div class="toolbar">
        <select class="filter-select">
            <option value="all">全部</option>
            <option value="pending">待回�?/option>
            <option value="replied">已回�?/option>
        </select>
        <button class="btn btn-primary" onclick="loadAdviceRequests()">刷新</button>
    </div>
    
    <div id="advice-container">
        <!-- 咨询请求列表将通过JS动态加�?-->
    </div>
</div>
<link rel="stylesheet" href="../../../../css/business-common.css">
<script>
function loadAdviceRequests() {
    fetch('../../../../servlet/hospital/doctor/MedicalAdviceServlet?action=list')
        .then(response => response.json())
        .then(requests => {
            renderAdviceRequests(requests);
        })
        .catch(error => {
            console.error('加载咨询请求失败:', error);
        });
}

function renderAdviceRequests(requests) {
    const container = document.getElementById('advice-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    requests.forEach(req => {
        const reqCard = document.createElement('div');
        reqCard.className = 'card-item';
        reqCard.innerHTML = `
            <div class="card-title">${req.patientName} - ${req.createTime}</div>
            <div class="card-content">${req.question}</div>
            <div class="card-actions">
                <button onclick="replyAdvice(${req.id})">回复</button>
            </div>
        `;
        container.appendChild(reqCard);
    });
}
</script>

