/**
 * 侧边栏切换功能
 * 处理侧边栏内容的点击事件，加载对应的业务内容
 */
(function() {
    'use strict';
    
    // 防止重复初始化
    if (window.contentNavChangeInitialized) {
        return;
    }
    window.contentNavChangeInitialized = true;
    
    // 存储当前角色信息（由页面设置）
    let currentRole = null;
    
    /**
     * 设置当前角色
     * @param {string} role - 角色名称（patient, doctor, nurse, etc.）
     */
    function setCurrentRole(role) {
        currentRole = role;
    }
    
    /**
     * 初始化侧边栏切换功能
     */
    function initContentNavChange() {
        // 监听侧边栏切换事件（由 portfolio-change.js 触发）
        document.addEventListener('sidebarChanged', function(e) {
            const group = e.detail.group;
            // 侧边栏切换后，加载默认内容
            loadDefaultContent(group);
        });
        
        // 为所有侧边栏链接绑定点击事件
        initSidebarLinks();
        
        // 初始化分类折叠/展开功能
        initCategoryToggle();
        
        // 页面加载时加载默认内容 - 延迟执行确保所有脚本已加载
        setTimeout(function() {
            const firstSidebar = document.querySelector('.business-sidebar:not([style*="display: none"])');
            if (firstSidebar) {
                const group = firstSidebar.id.replace('-sidebar', '');
                loadDefaultContent(group);
            }
        }, 200);
    }
    
    /**
     * 初始化侧边栏链接点击事件
     */
    function initSidebarLinks() {
        document.querySelectorAll('.nav-sub-item a[data-content]').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                
                const contentId = this.getAttribute('data-content');
                const sidebar = this.closest('.business-sidebar');
                if (!sidebar) {
                    console.warn('未找到侧边栏容器');
                    return;
                }
                
                const group = sidebar.id.replace('-sidebar', '');
                
                // 如果存在 loadBusinessContent 函数，使用它加载内容
                if (typeof loadBusinessContent === 'function' && currentRole) {
                    loadBusinessContent(currentRole, group, contentId);
                } else {
                    console.warn('loadBusinessContent 函数不存在或角色未设置');
                }
                
                // 更新激活状态
                const currentSidebar = sidebar;
                currentSidebar.querySelectorAll('.nav-sub-item a').forEach(a => a.classList.remove('active'));
                this.classList.add('active');
            });
        });
    }
    
    /**
     * 初始化分类折叠/展开功能
     */
    function initCategoryToggle() {
        document.querySelectorAll('.nav-category-title').forEach(title => {
            title.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                const subList = this.nextElementSibling;
                const toggle = this.querySelector('.category-toggle');
                
                if (subList && subList.classList.contains('nav-sub-list')) {
                    if (subList.style.display === 'block' || subList.style.display === '') {
                        subList.style.display = 'none';
                        if (toggle) {
                            toggle.textContent = '▼';
                            toggle.classList.remove('expanded');
                        }
                    } else {
                        subList.style.display = 'block';
                        if (toggle) {
                            toggle.textContent = '▲';
                            toggle.classList.add('expanded');
                        }
                    }
                }
            });
        });
    }
    
    /**
     * 加载默认内容
     * @param {string} group - 业务组名称
     */
    function loadDefaultContent(group) {
        const sidebar = document.getElementById(group + '-sidebar');
        if (!sidebar) {
            console.warn('未找到侧边栏: ' + group + '-sidebar');
            return;
        }
        
        // 确保侧边栏是显示的
        sidebar.style.display = 'block';
        
        // 查找第一个激活的链接或第一个链接
        const defaultLink = sidebar.querySelector('.nav-sub-item a.active') || 
                           sidebar.querySelector('.nav-sub-item a');
        
        if (defaultLink) {
            // 确保第一个分类是展开的
            const firstCategory = sidebar.querySelector('.nav-category');
            if (firstCategory) {
                const firstSubList = firstCategory.querySelector('.nav-sub-list');
                if (firstSubList) {
                    firstSubList.style.display = 'block';
                    const toggle = firstCategory.querySelector('.category-toggle');
                    if (toggle) {
                        toggle.textContent = '▲';
                        toggle.classList.add('expanded');
                    }
                }
            }
            
            // 获取内容ID和角色
            const contentId = defaultLink.getAttribute('data-content');
            if (contentId && currentRole && typeof loadBusinessContent === 'function') {
                // 直接调用 loadBusinessContent 加载内容
                loadBusinessContent(currentRole, group, contentId);
                // 更新激活状态
                sidebar.querySelectorAll('.nav-sub-item a').forEach(a => a.classList.remove('active'));
                defaultLink.classList.add('active');
            } else {
                // 如果 loadBusinessContent 不存在，触发点击事件
                defaultLink.click();
            }
        } else {
            console.warn('未找到默认链接');
        }
    }
    
    // 页面加载完成后初始化
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initContentNavChange);
    } else {
        initContentNavChange();
    }
    
    // 暴露全局函数
    window.setCurrentRole = setCurrentRole;
    window.initContentNavChange = initContentNavChange;
})();

