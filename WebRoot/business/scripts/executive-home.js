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
     const targetSidebar = document.getElementById(`${group}-sidebar`);
     if (targetSidebar) {
         targetSidebar.style.display = 'block';
         
         // 激活对应导航的第一个子项
         const firstSubItem = targetSidebar.querySelector('.nav-sub-item a.active');
         if (firstSubItem) {
             firstSubItem.click();
         } else {
             const firstItem = targetSidebar.querySelector('.nav-sub-item a');
             if (firstItem) {
                 firstItem.click();
             }
         }
     }
 });
});

//左侧子导航切换逻辑
document.querySelectorAll('.nav-sub-item a').forEach(item => {
 item.addEventListener('click', function(e) {
     e.preventDefault();
     // 移除同组子导航激活状态
     const parentSidebar = this.closest('.business-sidebar');
     if (parentSidebar) {
         parentSidebar.querySelectorAll('.nav-sub-item a').forEach(sub => {
             sub.classList.remove('active');
         });
     }
     this.classList.add('active');
     
     // 获取内容ID和分组
     const contentId = this.getAttribute('data-content');
     const group = parentSidebar ? parentSidebar.id.replace('-sidebar', '') : '';
     
     // 如果有loadBusinessContent函数，使用动态加载
     if (typeof loadBusinessContent === 'function') {
         // 从当前页面路径推断角色
         const path = window.location.pathname;
         let role = 'executive';
         if (path.includes('doctor')) role = 'doctor';
         else if (path.includes('nurse')) role = 'nurse';
         else if (path.includes('finance')) role = 'finance';
         else if (path.includes('patient')) role = 'patient';
         else if (path.includes('enterprise')) role = 'enterprise';
         else if (path.includes('university')) role = 'university';
         else if (path.includes('admin')) role = 'admin';
         
         loadBusinessContent(role, group, contentId);
     } else {
         // 传统方式：隐藏所有内容项，显示对应内容项
         document.querySelectorAll('.business-content-item').forEach(item => {
             item.style.display = 'none';
         });
         
         const targetElement = document.getElementById(contentId);
         if (targetElement) {
             targetElement.style.display = 'block';
         }
     }
     
     // 控制步骤指示器显示（仅发布内容显示）
     const stepIndicator = document.getElementById('step-indicator');
     if (stepIndicator) {
         if (contentId === 'publish-content') {
             stepIndicator.style.display = 'flex';
         } else {
             stepIndicator.style.display = 'none';
         }
     }
 });
});

//分类折叠/展开逻辑
document.querySelectorAll('.nav-category-title').forEach(title => {
 title.addEventListener('click', function() {
     const subList = this.nextElementSibling;
     const toggle = this.querySelector('.category-toggle');
     
     if (subList && subList.classList.contains('nav-sub-list')) {
         if (subList.style.display === 'block' || subList.style.display === '') {
             subList.style.display = 'none';
             if (toggle) toggle.classList.remove('expanded');
         } else {
             subList.style.display = 'block';
             if (toggle) toggle.classList.add('expanded');
         }
     }
 });
});

//初始化页面
document.addEventListener('DOMContentLoaded', function() {
 // 默认隐藏步骤指示器
 const stepIndicator = document.getElementById('step-indicator');
 if (stepIndicator) {
     stepIndicator.style.display = 'none';
 }
 
 // 发布表单提交
 const publishForm = document.querySelector('.publish-form');
 if (publishForm) {
     publishForm.addEventListener('submit', function(e) {
         e.preventDefault();
         alert('内容提交成功，等待管理员审核！');
         // 切换到我的帖子页面
         const myPostsLink = document.querySelector('.nav-sub-item a[data-content="my-posts"]');
         if (myPostsLink) {
             myPostsLink.click();
         }
     });
 }

 // 取消按钮事件
 const cancelBtn = document.querySelector('.cancel-btn');
 if (cancelBtn) {
     cancelBtn.addEventListener('click', function() {
         if (confirm('确定要取消发布吗？已输入内容将不保存')) {
             const forumHomeLink = document.querySelector('.nav-sub-item a[data-content="forum-home"]');
             if (forumHomeLink) {
                 forumHomeLink.click();
             }
         }
     });
 }
});
