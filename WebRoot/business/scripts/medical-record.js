/**
 * 电子病历业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initMedicalRecord();
});

function initMedicalRecord() {
    // 加载病历列表
    loadMedicalRecords();
    
    // 初始化搜索功能
    const searchInput = document.getElementById('record-search');
    if (searchInput) {
        searchInput.addEventListener('input', handleSearch);
    }
}

function loadMedicalRecords() {
    const userRole = getUserRole();
    let apiUrl = '';
    
    if (userRole === 'doctor') {
        apiUrl = '../../../../servlet/hospital/doctor/ElectronicRecordManageServlet?action=list';
    } else if (userRole === 'nurse') {
        apiUrl = '../../../../servlet/hospital/nurse/ElectronicRecordServlet_Auxiliary?action=list';
    } else if (userRole === 'patient') {
        apiUrl = '../../../../servlet/patient/ElectronicRecordServlet?action=list';
    }
    
    if (apiUrl) {
        fetch(apiUrl)
            .then(response => response.json())
            .then(records => {
                renderRecords(records);
            })
            .catch(error => {
                console.error('加载病历列表失败:', error);
            });
    }
}

function getUserRole() {
    const path = window.location.pathname;
    if (path.includes('doctor')) return 'doctor';
    if (path.includes('nurse')) return 'nurse';
    if (path.includes('patient')) return 'patient';
    return 'patient';
}

function renderRecords(records) {
    const container = document.getElementById('records-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    if (records.length === 0) {
        container.innerHTML = '<div style="text-align:center;padding:40px;color:#6c757d;">暂无病历记录</div>';
        return;
    }
    
    records.forEach(record => {
        const recordCard = document.createElement('div');
        recordCard.className = 'record-card';
        recordCard.onclick = () => viewRecord(record.id);
        recordCard.innerHTML = `
            <div class="record-header">
                <div class="record-title">${record.title || '病历记录'}</div>
                <div class="record-date">${formatDate(record.createTime)}</div>
            </div>
            <div class="record-summary">${record.summary || '暂无摘要'}</div>
            <div class="record-actions">
                <button class="record-view-btn" onclick="event.stopPropagation();viewRecord(${record.id})">查看</button>
                ${getRecordActions(record)}
            </div>
        `;
        container.appendChild(recordCard);
    });
}

function getRecordActions(record) {
    const userRole = getUserRole();
    let actions = '';
    
    if (userRole === 'doctor') {
        actions = `
            <button class="record-edit-btn" onclick="event.stopPropagation();editRecord(${record.id})">编辑</button>
        `;
    } else if (userRole === 'patient') {
        actions = `
            <button class="record-download-btn" onclick="event.stopPropagation();downloadRecord(${record.id})">下载</button>
            <button class="record-share-btn" onclick="event.stopPropagation();shareRecord(${record.id})">分享</button>
        `;
    }
    
    return actions;
}

function viewRecord(recordId) {
    const userRole = getUserRole();
    let apiUrl = '';
    
    if (userRole === 'doctor') {
        apiUrl = `../../../../servlet/hospital/doctor/ElectronicRecordManageServlet?action=view&id=${recordId}`;
    } else if (userRole === 'nurse') {
        apiUrl = `../../../../servlet/hospital/nurse/ElectronicRecordServlet_Auxiliary?action=view&id=${recordId}`;
    } else if (userRole === 'patient') {
        apiUrl = `../../../../servlet/patient/ElectronicRecordServlet?action=view&id=${recordId}`;
    }
    
    fetch(apiUrl)
        .then(response => response.json())
        .then(record => {
            showRecordDetail(record);
        })
        .catch(error => {
            console.error('加载病历详情失败:', error);
        });
}

function showRecordDetail(record) {
    // 显示病历详情模态框或跳转到详情页
    const detailHtml = `
        <div class="record-detail">
            <div class="detail-section">
                <div class="detail-section-title">基本信息</div>
                <div class="detail-item">
                    <span class="detail-label">患者姓名：</span>
                    <span class="detail-value">${record.patientName}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">就诊时间：</span>
                    <span class="detail-value">${formatDateTime(record.visitTime)}</span>
                </div>
            </div>
            <div class="detail-section">
                <div class="detail-section-title">诊断信息</div>
                <div class="detail-item">
                    <span class="detail-label">主诉：</span>
                    <span class="detail-value">${record.complaint || '无'}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">诊断：</span>
                    <span class="detail-value">${record.diagnosis || '无'}</span>
                </div>
            </div>
        </div>
    `;
    
    // 这里可以创建一个模态框显示详情，或者替换当前内容
    document.querySelector('.business-content').innerHTML = detailHtml;
}

function handleSearch(e) {
    const keyword = e.target.value.trim();
    // 实现搜索逻辑
    console.log('搜索关键词:', keyword);
}

function formatDate(date) {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('zh-CN');
}

function formatDateTime(date) {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleString('zh-CN');
}
