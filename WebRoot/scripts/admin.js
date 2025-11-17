document.addEventListener('DOMContentLoaded', function() {
    // 导航切换
    const navItems = document.querySelectorAll('.nav-item');
    const sections = document.querySelectorAll('.content-section');
    
    navItems.forEach(item => {
        item.addEventListener('click', function() {
            const target = this.getAttribute('data-target');
            
            navItems.forEach(i => i.classList.remove('active'));
            sections.forEach(s => s.classList.remove('active'));
            
            this.classList.add('active');
            document.getElementById(target).classList.add('active');
        });
    });

    // 加载待审核内容
    loadPendingReviews();
    // 加载审核日志
    loadReviewLogs();

    // 退出登录
    document.querySelector('.nav-item.logout').addEventListener('click', function() {
        if(confirm('确定要退出登录吗？')) {
            window.location.href = '../login.html';
        }
    });
});

// 加载待审核内容
function loadPendingReviews() {
    const pendingList = document.getElementById('pending-list');
    pendingList.innerHTML = '';

    // 模拟待审核数据
    const pendingPosts = [
        { id: 301, title: '医疗设备捐赠计划', author: '某慈善基金会', content: '计划向基层医院捐赠一批基础医疗设备...', time: '2025-11-17 08:10' },
        { id: 302, title: '医学人才联合培养', author: '某医科大学', content: '希望与各大医院合作开展规培医师联合培养项目...', time: '2025-11-17 09:25' }
    ];

    pendingPosts.forEach(post => {
        const postCard = document.createElement('div');
        postCard.className = 'post-card';
        postCard.innerHTML = `
            <div class="post-meta">
                <span>发布者：${post.author}</span>
                <span>${post.time}</span>
            </div>
            <h3 class="post-title">${post.title}</h3>
            <p class="post-excerpt">${post.content}</p>
            <div class="review-actions">
                <button class="btn approve-btn" onclick="approvePost(${post.id})">通过</button>
                <button class="btn reject-btn" onclick="rejectPost(${post.id})">驳回</button>
            </div>
        `;
        pendingList.appendChild(postCard);
    });
}

// 加载审核日志
function loadReviewLogs() {
    const logBody = document.getElementById('review-log-body');
    logBody.innerHTML = '';

    // 模拟日志数据
    const logs = [
        { id: 401, title: '智慧医院建设经验分享', author: '某三甲医院', result: '通过', time: '2025-11-15 15:30', operator: 'admin' },
        { id: 402, title: '虚假医疗广告', author: '某机构', result: '驳回', time: '2025-11-14 11:20', operator: 'admin' }
    ];

    logs.forEach(log => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${log.id}</td>
            <td>${log.title}</td>
            <td>${log.author}</td>
            <td>${log.result === '通过' ? '<span style="color: green;">通过</span>' : '<span style="color: red;">驳回</span>'}</td>
            <td>${log.time}</td>
            <td>${log.operator}</td>
        `;
        logBody.appendChild(row);
    });
}

// 审核通过
function approvePost(postId) {
    if(confirm(`确定通过帖子 #${postId} 吗？`)) {
        alert(`帖子 #${postId} 已通过审核`);
        loadPendingReviews(); // 刷新待审核列表
        loadReviewLogs(); // 刷新日志
    }
}

// 审核驳回
function rejectPost(postId) {
    const reason = prompt('请输入驳回原因：');
    if(reason) {
        alert(`帖子 #${postId} 已驳回，原因：${reason}`);
        loadPendingReviews();
        loadReviewLogs();
    }
}