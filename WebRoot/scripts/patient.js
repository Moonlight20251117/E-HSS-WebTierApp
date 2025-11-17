// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    // 横向导航切换
    const navLinks = document.querySelectorAll('.horizontal-nav a');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // 移除所有导航的active类
            navLinks.forEach(l => l.classList.remove('active'));
            // 给当前点击的导航添加active类
            this.classList.add('active');
            
            // 隐藏所有侧边栏
            document.querySelectorAll('.business-sidebar').forEach(sidebar => {
                sidebar.style.display = 'none';
            });
            
            // 显示对应的侧边栏
            const nav = this.getAttribute('data-nav');
            document.getElementById(`${nav}-sidebar`).style.display = 'block';
            
            // 重置内容区域
            document.querySelectorAll('.business-content-item').forEach(item => {
                item.style.display = 'none';
            });
            
            // 显示默认内容
            const defaultContent = document.querySelector(`#${nav}-sidebar .nav-sub-item a.active, #${nav}-sidebar .nav-item a.active`).getAttribute('data-content');
            document.getElementById(defaultContent).style.display = 'block';
        });
    });
    
    // 侧边栏一级分类展开/折叠
    const categoryTitles = document.querySelectorAll('.nav-category-title');
    categoryTitles.forEach(title => {
        title.addEventListener('click', function() {
            const subList = this.nextElementSibling;
            const toggle = this.querySelector('.category-toggle');
            
            if (subList.style.display === 'none' || !subList.style.display) {
                subList.style.display = 'block';
                toggle.textContent = '▲';
                toggle.classList.add('expanded');
            } else {
                subList.style.display = 'none';
                toggle.textContent = '▼';
                toggle.classList.remove('expanded');
            }
        });
    });

    
    // 侧边栏二级导航切换
    const sidebarLinks = document.querySelectorAll('.nav-sub-item a, .nav-item a');
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // 移除同一侧边栏中所有导航的active类
            const parentSidebar = this.closest('.business-sidebar');
            parentSidebar.querySelectorAll('.nav-sub-item a, .nav-item a').forEach(l => l.classList.remove('active'));
            // 给当前点击的导航添加active类
            this.classList.add('active');
            
            // 隐藏所有内容区域
            document.querySelectorAll('.business-content-item').forEach(item => {
                item.style.display = 'none';
            });
            
            // 显示对应的内容区域
            const contentId = this.getAttribute('data-content');
            document.getElementById(contentId).style.display = 'block';
        });
    });
    
    // 步骤导航
    function goToStep(stepNumber) {
        // 更新步骤指示器
        document.querySelectorAll('.step').forEach((step, index) => {
            if (index + 1 < stepNumber) {
                step.classList.add('completed');
                step.classList.remove('active');
            } else if (index + 1 === stepNumber) {
                step.classList.add('active');
                step.classList.remove('completed');
            } else {
                step.classList.remove('active', 'completed');
            }
        });
        
        // 更新步骤内容
        document.querySelectorAll('.step-content').forEach((content, index) => {
            if (index + 1 === stepNumber) {
                content.classList.add('active');
            } else {
                content.classList.remove('active');
            }
        });
    }
    
    // 时间选择
    document.querySelectorAll('.time-slot').forEach(slot => {
        slot.addEventListener('click', function() {
            // 移除同医生下其他时间的选中状态
            this.closest('.doctor-item').querySelectorAll('.time-slot').forEach(item => {
                item.classList.remove('selected');
            });
            
            // 添加当前时间的选中状态
            this.classList.add('selected');
            
            // 更新确认信息
            const doctorName = this.closest('.doctor-item').querySelector('div').textContent;
            const departmentName = this.closest('.department-card').querySelector('.department-name').textContent;
            const time = this.textContent;
            
            document.getElementById('confirm-department').textContent = departmentName;
            document.getElementById('confirm-doctor').textContent = doctorName;
            document.getElementById('confirm-time').textContent = time;
        });
    });
    
    // 表单输入更新确认信息
    const nameInput = document.querySelector('input[type="text"]');
    if (nameInput) {
        nameInput.addEventListener('input', function() {
            document.getElementById('confirm-name').textContent = this.value || '-';
        });
    }
    
    const phoneInput = document.querySelector('input[type="tel"]');
    if (phoneInput) {
        phoneInput.addEventListener('input', function() {
            document.getElementById('confirm-phone').textContent = this.value || '-';
        });
    }
    
    // 步骤按钮事件监听
    const step1Next = document.getElementById('step1-next');
    if (step1Next) {
        step1Next.addEventListener('click', () => {
            // 检查是否选择了时间
            const selectedTime = document.querySelector('.time-slot.selected');
            if (selectedTime) {
                goToStep(2);
            } else {
                alert('请选择预约时间');
            }
        });
    }

    const step2Prev = document.getElementById('step2-prev');
    if (step2Prev) {
        step2Prev.addEventListener('click', () => goToStep(1));
    }

    const step2Next = document.getElementById('step2-next');
    if (step2Next) {
        step2Next.addEventListener('click', () => {
            // 检查是否填写了必要信息
            if (nameInput && nameInput.value && phoneInput && phoneInput.value) {
                goToStep(3);
            } else {
                alert('请填写患者姓名和联系电话');
            }
        });
    }

    const step3Prev = document.getElementById('step3-prev');
    if (step3Prev) {
        step3Prev.addEventListener('click', () => goToStep(2));
    }
    
    const step3Submit = document.getElementById('step3-submit');
    if (step3Submit) {
        step3Submit.addEventListener('click', () => {
            alert('预约成功！');
            goToStep(1);
            // 重置表单
            if (nameInput) nameInput.value = '';
            if (phoneInput) phoneInput.value = '';
            document.querySelectorAll('.time-slot.selected').forEach(slot => {
                slot.classList.remove('selected');
            });
            document.getElementById('confirm-name').textContent = '-';
            document.getElementById('confirm-phone').textContent = '-';
        });
    }
});