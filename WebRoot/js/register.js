/**
 * register.jsp 的表单验证脚本
 */
document.addEventListener('DOMContentLoaded', function() {
    const registrationForm = document.getElementById('registrationForm');
    
    if (registrationForm) {
        registrationForm.addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!username) {
                alert('请输入用户名');
                e.preventDefault();
                return false;
            }
            
            if (!password) {
                alert('请输入密码');
                e.preventDefault();
                return false;
            }
            
            // 验证手机号格式（如果填写了）
            const phone = document.getElementById('phone').value.trim();
            if (phone) {
                const phonePattern = /^1[3-9]\d{9}$/;
                if (!phonePattern.test(phone)) {
                    alert('请输入正确的11位手机号码');
                    e.preventDefault();
                    return false;
                }
            }
            
            return true;
        });
    }
});

