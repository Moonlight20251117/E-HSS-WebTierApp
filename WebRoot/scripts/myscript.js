// 登录表单验证
document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.querySelector('form');
    if (loginForm && loginForm.action.includes('LoginServlet')) {
        loginForm.addEventListener('submit', function(e) {
            const username = document.getElementById('username');
            const password = document.getElementById('password');
            const role = document.getElementById('role');
            
            // 检查必填字段
            if (!username || !username.value) {
                alert('请输入用户名');
                e.preventDefault();
                return false;
            }
            
            if (!password || !password.value) {
                alert('请输入密码');
                e.preventDefault();
                return false;
            }
            
            // 如果有角色选择框（select元素），检查是否已选择
            // 对于隐藏的role字段（如patient-login.html中的hidden input），不需要检查
            if (role && role.tagName === 'SELECT' && !role.value) {
                alert('请选择用户角色');
                e.preventDefault();
                return false;
            }
            
            // 不修改action，使用表单中已设置的action
            return true;
        });
    }
});

// 演示用函数
function display_Code() {
    document.getElementById('output').innerHTML = '系统功能演示中...';
}