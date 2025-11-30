/**
 * 论坛管理业务脚本
 */

// 防止重复加载
if (window.forumInitialized) {
    console.warn('forum.js 已经加载过，跳过重复初始化');
} else {
    window.forumInitialized = true;
    
    // 全局变量存储帖子数据
    if (!window.forumPostsData) {
        window.forumPostsData = [];
    }
    const forumPostsData = window.forumPostsData;
    
    // 全局变量存储板块数据
    if (!window.forumSectionsData) {
        window.forumSectionsData = [];
    }
    const forumSectionsData = window.forumSectionsData;

    // 页面加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        if (document.getElementById('posts-list-body')) {
            initForum();
        }
    });

    // 由于HTML是动态加载的，也需要监听动态内容加载
    const observer = new MutationObserver(function(mutations) {
        const postsListBody = document.getElementById('posts-list-body');
        if (postsListBody && !postsListBody.hasAttribute('data-initialized')) {
            postsListBody.setAttribute('data-initialized', 'true');
            setTimeout(() => {
                if (typeof initForum === 'function') {
                    initForum();
                }
            }, 100);
        }
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    function initForum() {
        // 先加载板块列表
        fetchSections();
        // 然后加载帖子列表
        fetchPostsFromDB();
        
        // 绑定搜索监听
        const searchInput = document.getElementById('post-search');
        if (searchInput) {
            searchInput.addEventListener('input', renderPosts);
        }

        // 绑定筛选监听
        const statusFilter = document.getElementById('status-filter');
        if (statusFilter) {
            statusFilter.addEventListener('change', renderPosts);
        }
        
        const sectionFilter = document.getElementById('section-filter');
        if (sectionFilter) {
            sectionFilter.addEventListener('change', renderPosts);
        }
    }

    // 从后端获取板块列表
    function fetchSections() {
        let apiUrl;
        try {
            const path = window.location.pathname;
            const homeIndex = path.indexOf('/home/');
            if (homeIndex > 0) {
                const basePath = path.substring(0, homeIndex);
                apiUrl = basePath + '/servlet/hospital/executive/ForumServlet?action=sections';
            } else {
                apiUrl = '../../servlet/hospital/executive/ForumServlet?action=sections';
            }
        } catch (e) {
            apiUrl = '../../servlet/hospital/executive/ForumServlet?action=sections';
        }
        
        fetch(apiUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                if (Array.isArray(data)) {
                    window.forumSectionsData = data;
                    // 更新板块下拉框
                    const sectionFilter = document.getElementById('section-filter');
                    if (sectionFilter) {
                        // 保留"全部板块"选项
                        const allOption = sectionFilter.querySelector('option[value="all"]');
                        sectionFilter.innerHTML = '';
                        if (allOption) {
                            sectionFilter.appendChild(allOption);
                        }
                        // 添加板块选项
                        data.forEach(section => {
                            const option = document.createElement('option');
                            option.value = section.id;
                            option.textContent = section.name;
                            sectionFilter.appendChild(option);
                        });
                    }
                }
            })
            .catch(err => {
                console.error("获取板块列表失败:", err);
            });
    }

    // 从后端Servlet获取帖子数据
    function fetchPostsFromDB() {
        let apiUrl;
        try {
            const path = window.location.pathname;
            const homeIndex = path.indexOf('/home/');
            if (homeIndex > 0) {
                const basePath = path.substring(0, homeIndex);
                apiUrl = basePath + '/servlet/hospital/executive/ForumServlet?action=list';
            } else {
                apiUrl = '../../servlet/hospital/executive/ForumServlet?action=list';
            }
        } catch (e) {
            apiUrl = '../../servlet/hospital/executive/ForumServlet?action=list';
        }
        
        fetch(apiUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                if (Array.isArray(data)) {
                    window.forumPostsData = data;
                    renderPosts();
                } else {
                    console.error('返回的数据不是数组:', data);
                    window.forumPostsData = [];
                    renderPosts();
                }
            })
            .catch(err => {
                console.error("获取数据失败:", err);
                const container = document.getElementById('posts-list-body');
                if(container) {
                    container.innerHTML = `<div style="padding:20px;color:red;text-align:center">
                        <p>无法连接服务器获取数据</p>
                        <p style="font-size:12px;color:#999;">错误: ${err.message}</p>
                    </div>`;
                }
            });
    }

    // 渲染帖子列表
    function renderPosts() {
        const container = document.getElementById('posts-list-body');
        if (!container) {
            return;
        }

        const forumPostsData = window.forumPostsData || [];
        const searchEl = document.getElementById('post-search');
        const statusFilter = document.getElementById('status-filter');
        const sectionFilter = document.getElementById('section-filter');
        
        const keyword = searchEl ? searchEl.value.trim() : ''; 
        const statusFilterValue = statusFilter ? statusFilter.value : 'all';
        const sectionFilterValue = sectionFilter ? sectionFilter.value : 'all';

        const filteredPosts = forumPostsData.filter(post => {
            // 搜索匹配
            const matchSearch = keyword === '' || 
                (post.title && post.title.includes(keyword)) ||
                (post.content && post.content.includes(keyword));
            
            // 状态筛选
            const matchStatus = statusFilterValue === 'all' || post.status === statusFilterValue;
            
            // 板块筛选
            const matchSection = sectionFilterValue === 'all' || post.sectionId === sectionFilterValue;
            
            return matchSearch && matchStatus && matchSection;
        });

        container.innerHTML = '';

        if (filteredPosts.length === 0) {
            container.innerHTML = '<div style="padding:20px; text-align:center; color:#999;">暂无匹配的帖子</div>';
            return;
        }

        filteredPosts.forEach(post => {
            const postId = String(post.id || '');
            const status = post.status || '待审核';
            
            // 根据状态显示不同的徽章样式
            let statusHtml;
            if (status === '已发布') {
                statusHtml = `<span class="badge badge-published">已发布</span>`;
            } else if (status === '已驳回') {
                statusHtml = `<span class="badge badge-rejected">已驳回</span>`;
            } else if (status === '已删除') {
                statusHtml = `<span class="badge badge-deleted">已删除</span>`;
            } else {
                statusHtml = `<span class="badge badge-pending">待审核</span>`;
            }
            
            // 操作按钮
            let actionHtml = '';
            if (status === '待审核') {
                actionHtml = `
                    <button class="btn-sm btn-approve" onclick="approvePost('${postId}')" aria-label="审核通过" title="审核通过">通过</button>
                    <button class="btn-sm btn-reject" onclick="rejectPost('${postId}')" aria-label="驳回" title="驳回">驳回</button>
                `;
            } else {
                actionHtml = `
                    <button class="btn-sm btn-view" onclick="viewPost('${postId}')" aria-label="查看详情" title="查看详情">查看</button>
                `;
            }

            const row = `
                <div class="post-row">
                    <span class="col-title" title="${escapeHtml(post.title || '')}">${escapeHtml(post.title || '')}</span>
                    <span class="col-author">${escapeHtml(post.author || '未知')}</span>
                    <span class="col-section">${escapeHtml(post.section || '未知')}</span>
                    <span class="col-views">${post.viewCount || 0}</span>
                    <span class="col-replies">${post.replyCount || 0}</span>
                    <span class="col-time">${post.createTime || ''}</span>
                    <span class="col-status">${statusHtml}</span>
                    <span class="col-action">${actionHtml}</span>
                </div>
            `;
            container.innerHTML += row;
        });
    }

    // 审核通过
    function approvePost(postId) {
        if (!confirm('确认审核通过此帖子吗？')) {
            return;
        }
        updatePostStatus(postId, '已发布');
    }

    // 驳回
    function rejectPost(postId) {
        const opinion = prompt('请输入驳回原因：');
        if (opinion === null) return;
        updatePostStatus(postId, '已驳回', opinion);
    }

    // 查看帖子详情
    function viewPost(postId) {
        // 可以打开详情页面或弹窗
        alert('查看帖子详情功能待实现，帖子ID: ' + postId);
    }

    // 更新帖子状态
    function updatePostStatus(postId, newStatus, opinion) {
        let apiUrl;
        try {
            const path = window.location.pathname;
            const homeIndex = path.indexOf('/home/');
            if (homeIndex > 0) {
                const basePath = path.substring(0, homeIndex);
                apiUrl = `${basePath}/servlet/hospital/executive/ForumServlet?action=updateStatus&postId=${postId}&status=${encodeURIComponent(newStatus)}`;
            } else {
                apiUrl = `../../servlet/hospital/executive/ForumServlet?action=updateStatus&postId=${postId}&status=${encodeURIComponent(newStatus)}`;
            }
            if (opinion) {
                apiUrl += `&opinion=${encodeURIComponent(opinion)}`;
            }
            // 这里应该传入实际的审核人ID，暂时使用固定值
            apiUrl += `&auditorId=USER001`;
        } catch (e) {
            apiUrl = `../../servlet/hospital/executive/ForumServlet?action=updateStatus&postId=${postId}&status=${encodeURIComponent(newStatus)}`;
            if (opinion) {
                apiUrl += `&opinion=${encodeURIComponent(opinion)}`;
            }
            apiUrl += `&auditorId=USER001`;
        }

        fetch(apiUrl, { method: 'POST' })
            .then(res => res.text())
            .then(result => {
                if (result.trim() === 'success') {
                    // 刷新列表
                    setTimeout(() => {
                        fetchPostsFromDB();
                    }, 500);
                } else {
                    alert("操作失败，请检查网络或后台日志");
                }
            })
            .catch(err => {
                console.error("请求错误:", err);
                alert("网络连接错误");
            });
    }

    // 刷新列表
    function refreshPosts() {
        fetchPostsFromDB();
    }

    // HTML转义
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // 暴露全局函数
    window.fetchPostsFromDB = fetchPostsFromDB;
    window.renderPosts = renderPosts;
    window.approvePost = approvePost;
    window.rejectPost = rejectPost;
    window.viewPost = viewPost;
    window.refreshPosts = refreshPosts;
}
