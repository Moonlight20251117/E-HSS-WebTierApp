/**
 * 医疗资讯业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initMedicalInfo();
});

function initMedicalInfo() {
    // 加载医疗资讯
    loadMedicalInfo();
    
    // 初始化分类筛选
    const categoryFilter = document.getElementById('info-category-filter');
    if (categoryFilter) {
        categoryFilter.addEventListener('change', handleCategoryFilter);
    }
}

function loadMedicalInfo() {
    // 根据当前页面确定资讯类型
    const infoType = getInfoType();
    
    // 这里可以从服务器加载资讯数据
    // 目前使用模拟数据
    const mockData = [
        {
            id: 1,
            title: '春季流感预防指南',
            category: 'disease-prevent',
            content: '春季是流感高发季节，请注意个人卫生...',
            publishTime: '2025-03-15',
            author: '医疗资讯部'
        },
        {
            id: 2,
            title: '最新医疗技术突破',
            category: 'health-news',
            content: '我院成功完成首例微创手术...',
            publishTime: '2025-03-14',
            author: '医疗资讯部'
        }
    ];
    
    renderMedicalInfo(mockData);
}

function getInfoType() {
    // 根据URL或页面标识确定资讯类型
    const path = window.location.pathname;
    if (path.includes('health-news')) return 'health-news';
    if (path.includes('disease-prevent')) return 'disease-prevent';
    if (path.includes('medical-knowledge')) return 'medical-knowledge';
    if (path.includes('hospital-info')) return 'hospital-info';
    return 'all';
}

function renderMedicalInfo(infoList) {
    const container = document.getElementById('info-list-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    if (infoList.length === 0) {
        container.innerHTML = '<div style="text-align:center;padding:40px;color:#6c757d;">暂无资讯</div>';
        return;
    }
    
    infoList.forEach(info => {
        const infoCard = document.createElement('div');
        infoCard.className = 'info-card';
        infoCard.innerHTML = `
            <div class="info-header">
                <h3 class="info-title">${info.title}</h3>
                <span class="info-time">${info.publishTime}</span>
            </div>
            <div class="info-content">${info.content}</div>
            <div class="info-footer">
                <span class="info-author">${info.author}</span>
                <button class="info-read-more" onclick="readMore(${info.id})">阅读更多</button>
            </div>
        `;
        container.appendChild(infoCard);
    });
}

function handleCategoryFilter(e) {
    const category = e.target.value;
    // 根据分类筛选资讯
    loadMedicalInfo();
}

function readMore(infoId) {
    // 跳转到详情页或显示详情
    console.log('阅读更多:', infoId);
}

