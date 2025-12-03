/**
 * 横向导航栏切换功能
 * 处理横向导航栏的点击事件，切换对应的侧边栏显示
 */
(function() {
    'use strict';
    
    // 防止重复初始化
    if (window.portfolioChangeInitialized) {
        return;
    }
    window.portfolioChangeInitialized = true;
    
    /**
     * 初始化横向导航栏切换功能
     */
    function initPortfolioChange() {
        const horizontalNav = document.querySelector('.horizontal-nav');
        if (!horizontalNav) {
            console.warn('未找到横向导航栏 .horizontal-nav');
            return;
        }
        
        // 为所有横向导航链接绑定点击事件
        const navLinks = horizontalNav.querySelectorAll('a[data-group]');
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                
                const group = this.getAttribute('data-group');
                if (!group) {
                    console.warn('导航链接缺少 data-group 属性');
                    return;
                }
                
                // 切换横向导航栏的激活状态
                navLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
                
                // 切换对应的侧边栏显示
                switchSidebar(group);
            });
        });
    }
    
    /**
     * 切换侧边栏显示
     * @param {string} group - 业务组名称
     */
    function switchSidebar(group) {
        // 隐藏所有侧边栏
        const allSidebars = document.querySelectorAll('.business-sidebar');
        allSidebars.forEach(sidebar => {
            sidebar.style.display = 'none';
        });
        
        // 显示对应的侧边栏
        const targetSidebar = document.getElementById(group + '-sidebar');
        if (targetSidebar) {
            targetSidebar.style.display = 'block';
            
            // 触发侧边栏切换事件，通知 contentNav-change.js
            const event = new CustomEvent('sidebarChanged', {
                detail: { group: group }
            });
            document.dispatchEvent(event);
        } else {
            console.warn('未找到对应的侧边栏: #' + group + '-sidebar');
        }
    }
    
    // 页面加载完成后初始化
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initPortfolioChange);
    } else {
        initPortfolioChange();
    }
    
    // 暴露全局函数（如果需要）
    window.initPortfolioChange = initPortfolioChange;
    window.switchSidebar = switchSidebar;
})();

