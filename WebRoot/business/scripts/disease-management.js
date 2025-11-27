/**
 * 疾病管理业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initDiseaseManagement();
});

function initDiseaseManagement() {
    // 加载疾病数据
    loadDiseaseData();
    
    // 初始化上报表单
    const reportForm = document.getElementById('disease-report-form');
    if (reportForm) {
        reportForm.addEventListener('submit', handleReportSubmit);
    }
}

function loadDiseaseData() {
    const userRole = getUserRole();
    let apiUrl = '';
    
    if (userRole === 'doctor') {
        apiUrl = '../../../../servlet/hospital/doctor/DiseaseManagementDocServlet?action=list';
    } else if (userRole === 'nurse') {
        apiUrl = '../../../../servlet/hospital/nurse/DiseaseManagementServlet_Nurse?action=list';
    }
    
    if (apiUrl) {
        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                renderDiseaseData(data);
            })
            .catch(error => {
                console.error('加载疾病数据失败:', error);
            });
    }
}

function getUserRole() {
    const path = window.location.pathname;
    if (path.includes('doctor')) return 'doctor';
    if (path.includes('nurse')) return 'nurse';
    return 'doctor';
}

function renderDiseaseData(data) {
    const container = document.getElementById('disease-data-container');
    if (!container) return;
    
    // 渲染疾病数据表格或图表
    // TODO: 根据实际数据结构实现渲染逻辑
    console.log('疾病数据:', data);
}

function handleReportSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const data = {
        diseaseName: formData.get('diseaseName'),
        patientCount: formData.get('patientCount'),
        description: formData.get('description'),
        reportTime: new Date().toISOString()
    };
    
    const userRole = getUserRole();
    let apiUrl = '';
    
    if (userRole === 'doctor') {
        apiUrl = '../../../../servlet/hospital/doctor/DiseaseManagementDocServlet';
    } else if (userRole === 'nurse') {
        apiUrl = '../../../../servlet/hospital/nurse/DiseaseManagementServlet_Nurse';
    }
    
    if (apiUrl) {
        fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert('上报成功！');
                e.target.reset();
                loadDiseaseData();
            } else {
                alert('上报失败：' + (result.message || '未知错误'));
            }
        })
        .catch(error => {
            console.error('上报失败:', error);
            alert('上报失败，请稍后重试');
        });
    }
}

