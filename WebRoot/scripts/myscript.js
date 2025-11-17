// 登录表单验证
document.querySelector('form').addEventListener('submit', function(e) {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const role = document.getElementById('role').value;
    
    if (!username || !password || !role) {
        alert('请填写完整的登录信息并选择用户角色');
        e.preventDefault();
        return false;
    }
    
    // 根据角色设置表单提交地址
    this.action = 'LoginServlet?role=' + role;
    return true;
});

// 演示用函数
function display_Code() {
    document.getElementById('output').innerHTML = '系统功能演示中...';
}