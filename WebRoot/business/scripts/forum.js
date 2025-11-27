/**
 * 论坛管理业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initForum();
});

function initForum() {
    // 加载论坛帖子列表
    loadForumPosts();
    
    // 初始化发布表单
    const publishForm = document.getElementById('publish-form');
    if (publishForm) {
        publishForm.addEventListener('submit', handlePublishSubmit);
    }
}

function loadForumPosts() {
    const forumType = getForumType(); // 根据当前页面确定论坛类型
    const apiUrl = `../../../../servlet/${forumType}/CooperationForumServlet_${forumType}?action=list`;
    
    fetch(apiUrl)
        .then(response => response.json())
        .then(posts => {
            renderPosts(posts);
        })
        .catch(error => {
            console.error('加载帖子失败:', error);
        });
}

function getForumType() {
    // 根据当前URL或页面标识确定论坛类型
    const path = window.location.pathname;
    if (path.includes('enterprise')) return 'enterprise';
    if (path.includes('university')) return 'university';
    if (path.includes('executive')) return 'hospital/executive';
    return 'enterprise';
}

function renderPosts(posts) {
    const container = document.getElementById('posts-container');
    if (!container) return;
    
    container.innerHTML = '';
    
    posts.forEach(post => {
        const postCard = document.createElement('div');
        postCard.className = 'post-card';
        postCard.innerHTML = `
            <div class="post-header">
                <span class="post-author">${post.author}</span>
                <span class="post-time">${post.createTime}</span>
            </div>
            <div class="post-title">${post.title}</div>
            <div class="post-content">${post.content}</div>
            <div class="post-actions">
                <button class="reply-btn" onclick="replyPost(${post.id})">回复</button>
                <button class="collect-btn" onclick="collectPost(${post.id})">收藏</button>
            </div>
        `;
        container.appendChild(postCard);
    });
}

function handlePublishSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const data = {
        title: formData.get('title'),
        content: formData.get('content')
    };
    
    const forumType = getForumType();
    fetch(`../../../../servlet/${forumType}/CooperationForumServlet_${forumType}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('发布成功！');
            e.target.reset();
            loadForumPosts();
        } else {
            alert('发布失败：' + (result.message || '未知错误'));
        }
    })
    .catch(error => {
        console.error('发布失败:', error);
        alert('发布失败，请稍后重试');
    });
}

function replyPost(postId) {
    const replyContent = prompt('请输入回复内容：');
    if (!replyContent) return;
    
    // 发送回复请求
    // TODO: 实现回复功能
    console.log('回复帖子:', postId, replyContent);
}

function collectPost(postId) {
    // TODO: 实现收藏功能
    console.log('收藏帖子:', postId);
}
