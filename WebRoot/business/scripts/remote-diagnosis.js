/**
 * 远程医疗诊断业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initRemoteDiagnosis();
});

function initRemoteDiagnosis() {
    // 加载诊断申请列表
    loadDiagnosisApplications();
    
    // 初始化申请表单
    const applicationForm = document.getElementById('diagnosis-application-form');
    if (applicationForm) {
        applicationForm.addEventListener('submit', handleApplicationSubmit);
    }
}

function loadDiagnosisApplications() {
    // 根据角色加载不同的数据
    const userRole = getUserRole();
    let apiUrl = '';
    
    if (userRole === 'doctor') {
        apiUrl = '../../../../servlet/hospital/doctor/RemoteDiagnosisServlet?action=list';
    } else if (userRole === 'patient') {
        apiUrl = '../../../../servlet/patient/RemoteDiagnosisClientServlet?action=list';
    }
    
    if (apiUrl) {
        fetch(apiUrl)
            .then(response => response.json())
            .then(applications => {
                renderApplications(applications);
            })
            .catch(error => {
                console.error('加载申请列表失败:', error);
            });
    }
}

function getUserRole() {
    const path = window.location.pathname;
    if (path.includes('doctor')) return 'doctor';
    if (path.includes('patient')) return 'patient';
    return 'patient';
}

function renderApplications(applications) {
    const container = document.getElementById('applications-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    applications.forEach(app => {
        const appCard = document.createElement('div');
        appCard.className = 'application-card';
        appCard.innerHTML = `
            <div class="app-header">
                <span class="app-patient">患者：${app.patientName}</span>
                <span class="app-time">${app.createTime}</span>
            </div>
            <div class="app-symptoms">${app.symptoms}</div>
            <div class="app-status">状态：${getStatusText(app.status)}</div>
            <div class="app-actions">
                ${getActionButtons(app)}
            </div>
        `;
        container.appendChild(appCard);
    });
}

function getStatusText(status) {
    const statusMap = {
        'pending': '待处理',
        'processing': '处理中',
        'completed': '已完成',
        'cancelled': '已取消'
    };
    return statusMap[status] || status;
}

function getActionButtons(app) {
    const userRole = getUserRole();
    let buttons = '';
    
    if (userRole === 'doctor') {
        if (app.status === 'pending') {
            buttons = `<button onclick="acceptApplication(${app.id})">接受</button>
                       <button onclick="rejectApplication(${app.id})">拒绝</button>`;
        } else if (app.status === 'processing') {
            buttons = `<button onclick="submitDiagnosis(${app.id})">提交诊断</button>`;
        }
    } else if (userRole === 'patient') {
        if (app.status === 'pending' || app.status === 'processing') {
            buttons = `<button onclick="cancelApplication(${app.id})">取消申请</button>`;
        }
        if (app.status === 'completed') {
            buttons = `<button onclick="viewDiagnosis(${app.id})">查看诊断</button>`;
        }
    }
    
    return buttons;
}

function handleApplicationSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const data = {
        symptoms: formData.get('symptoms'),
        description: formData.get('description'),
        doctorId: formData.get('doctorId')
    };
    
    fetch('../../../../servlet/patient/RemoteDiagnosisClientServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('申请提交成功！');
            e.target.reset();
            loadDiagnosisApplications();
        } else {
            alert('申请提交失败：' + (result.message || '未知错误'));
        }
    })
    .catch(error => {
        console.error('提交申请失败:', error);
        alert('提交失败，请稍后重试');
    });
}

function acceptApplication(appId) {
    fetch(`../../../../servlet/hospital/doctor/RemoteDiagnosisServlet?action=accept&id=${appId}`, {
        method: 'POST'
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('已接受申请');
            loadDiagnosisApplications();
        }
    });
}

function submitDiagnosis(appId) {
    const diagnosis = prompt('请输入诊断结果：');
    if (!diagnosis) return;
    
    fetch('../../../../servlet/hospital/doctor/RemoteDiagnosisServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            action: 'submit',
            id: appId,
            diagnosis: diagnosis
        })
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('诊断结果已提交');
            loadDiagnosisApplications();
        }
    });
}
