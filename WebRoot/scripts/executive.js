// 横向导航切换
document.querySelectorAll('.horizontal-nav .nav-item').forEach(item => {
    item.addEventListener('click', function() {
        // 移除横向导航所有激活状态
        document.querySelectorAll('.horizontal-nav .nav-item').forEach(nav => {
            nav.classList.remove('active');
        });
        // 添加当前激活状态
        this.classList.add('active');
        
        // 隐藏所有导航组
        document.querySelectorAll('.left-sidebar .nav-group').forEach(group => {
            group.classList.add('hidden');
            group.classList.remove('active');
        });
        
        // 显示对应导航组
        const group = this.getAttribute('data-group');
        document.getElementById(`${group}-nav`).classList.remove('hidden');
        document.getElementById(`${group}-nav`).classList.add('active');
        
        // 激活对应导航组的第一个项
        const firstItem = document.querySelector(`#${group}-nav .nav-item`);
        if (firstItem) {
            firstItem.click();
        }
    });
});

// 左侧竖向导航切换
document.querySelectorAll('.left-sidebar .nav-item').forEach(item => {
    item.addEventListener('click', function() {
        // 移除同组所有激活状态
        const parentGroup = this.closest('.nav-group');
        parentGroup.querySelectorAll('.nav-item').forEach(nav => {
            nav.classList.remove('active');
        });
        // 添加当前激活状态
        this.classList.add('active');
        
        // 隐藏所有内容面板
        document.querySelectorAll('.content-panel').forEach(panel => {
            panel.classList.add('hidden');
            panel.classList.remove('active');
        });
        
        // 显示对应内容面板
        const target = this.getAttribute('data-target');
        const targetPanel = document.getElementById(target);
        if (targetPanel) {
            targetPanel.classList.remove('hidden');
            targetPanel.classList.add('active');
            // 更新标题
            document.getElementById('content-title').textContent = this.textContent;
        }
    });
});
//横向导航切换逻辑
document.querySelectorAll('.horizontal-nav a').forEach(item => {
 item.addEventListener('click', function(e) {
     e.preventDefault();
     // 移除横向导航激活状态
     document.querySelectorAll('.horizontal-nav a').forEach(nav => {
         nav.classList.remove('active');
     });
     this.classList.add('active');
     
     // 获取目标分组
     const group = this.getAttribute('data-group');
     
     // 隐藏所有左侧导航
     document.querySelectorAll('.business-sidebar').forEach(sidebar => {
         sidebar.style.display = 'none';
     });
     
     // 显示对应左侧导航
     document.getElementById(`${group}-sidebar`).style.display = 'block';
     
     // 激活对应导航的第一个子项
     const firstSubItem = document.querySelector(`#${group}-sidebar .nav-sub-item a`);
     if (firstSubItem) {
         firstSubItem.click();
     }
 });
});

//左侧子导航切换逻辑
document.querySelectorAll('.nav-sub-item a').forEach(item => {
 item.addEventListener('click', function(e) {
     e.preventDefault();
     // 移除同组子导航激活状态
     const parentSidebar = this.closest('.business-sidebar');
     parentSidebar.querySelectorAll('.nav-sub-item a').forEach(sub => {
         sub.classList.remove('active');
     });
     this.classList.add('active');
     
     // 隐藏所有内容项
     document.querySelectorAll('.business-content-item').forEach(item => {
         item.style.display = 'none';
     });
     
     // 显示对应内容项
     const target = this.getAttribute('data-content');
     document.getElementById(target).style.display = 'block';
     
     // 控制步骤指示器显示（仅发布内容显示）
     const stepIndicator = document.getElementById('step-indicator');
     if (target === 'publish-content') {
         stepIndicator.style.display = 'flex';
     } else {
         stepIndicator.style.display = 'none';
     }
 });
});

//分类折叠/展开逻辑
document.querySelectorAll('.nav-category-title').forEach(title => {
 title.addEventListener('click', function() {
     const subList = this.nextElementSibling;
     const toggle = this.querySelector('.category-toggle');
     
     if (subList.style.display === 'block') {
         subList.style.display = 'none';
         toggle.classList.remove('expanded');
     } else {
         subList.style.display = 'block';
         toggle.classList.add('expanded');
     }
 });
});

//初始化页面
document.addEventListener('DOMContentLoaded', function() {
 // 默认隐藏步骤指示器
 document.getElementById('step-indicator').style.display = 'none';
});

document.addEventListener('DOMContentLoaded', function() {
    // 导航切换逻辑
    const navItems = document.querySelectorAll('.nav-item');
    const contentPanels = document.querySelectorAll('.content-panel');
    const contentTitle = document.getElementById('content-title');
    const stepIndicator = document.getElementById('step-indicator');

    navItems.forEach(item => {
        item.addEventListener('click', function() {
            // 切换导航激活状态
            navItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');

            // 切换内容面板
            const targetId = this.getAttribute('data-target');
            contentPanels.forEach(panel => {
                panel.classList.add('hidden');
            });
            document.getElementById(targetId).classList.remove('hidden');

            // 更新内容标题
            contentTitle.textContent = this.textContent;

            // 控制步骤指示器显示（仅发布内容页面显示）
            if (targetId === 'publish-content') {
                stepIndicator.style.display = 'flex';
            } else {
                stepIndicator.style.display = 'none';
            }
        });
    });

    // 发布表单提交
    const publishForm = document.querySelector('.publish-form');
    if (publishForm) {
        publishForm.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('内容提交成功，等待管理员审核！');
            // 切换到我的帖子页面
            document.querySelector('.nav-item[data-target="my-posts"]').click();
        });
    }

    // 取消按钮事件
    const cancelBtn = document.querySelector('.cancel-btn');
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function() {
            if (confirm('确定要取消发布吗？已输入内容将不保存')) {
                document.querySelector('.nav-item[data-target="forum-home"]').click();
            }
        });
    }

    // 退出登录
    const logoutBtn = document.querySelector('.logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function() {
            if (confirm('确定要退出登录吗？')) {
                window.location.href = '../../login.html';
            }
        });
    }

    // 初始化隐藏步骤指示器（首页不显示）
    stepIndicator.style.display = 'none';
});