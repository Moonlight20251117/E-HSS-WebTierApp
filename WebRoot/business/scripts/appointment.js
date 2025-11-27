/**
 * 预约与挂号业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initAppointment();
});

function initAppointment() {
    // 初始化预约表单
    const appointmentForm = document.getElementById('appointment-form');
    if (appointmentForm) {
        appointmentForm.addEventListener('submit', handleAppointmentSubmit);
    }
    
    // 初始化步骤切换
    initStepNavigation();
}

function initStepNavigation() {
    const stepButtons = document.querySelectorAll('[data-step]');
    stepButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const targetStep = this.getAttribute('data-step');
            switchStep(targetStep);
        });
    });
}

function switchStep(step) {
    // 隐藏所有步骤内容
    document.querySelectorAll('.step-content').forEach(content => {
        content.classList.remove('active');
    });
    
    // 显示目标步骤
    const targetContent = document.getElementById(`step${step}-content`);
    if (targetContent) {
        targetContent.classList.add('active');
    }
    
    // 更新步骤指示器
    document.querySelectorAll('.step').forEach((stepEl, index) => {
        if (index + 1 <= parseInt(step)) {
            stepEl.classList.add('active');
        } else {
            stepEl.classList.remove('active');
        }
    });
}

function handleAppointmentSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const data = {
        department: formData.get('department'),
        doctor: formData.get('doctor'),
        time: formData.get('time'),
        patientName: formData.get('patientName'),
        phone: formData.get('phone'),
        symptoms: formData.get('symptoms')
    };
    
    // 发送预约请求
    fetch('../../../../servlet/patient/AppointmentServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('预约成功！');
            e.target.reset();
        } else {
            alert('预约失败：' + (result.message || '未知错误'));
        }
    })
    .catch(error => {
        console.error('预约请求失败:', error);
        alert('预约失败，请稍后重试');
    });
}

// 加载可用时间段
function loadAvailableTimeSlots(departmentId, doctorId, date) {
    fetch(`../../../../servlet/patient/AppointmentServlet?action=getTimeSlots&department=${departmentId}&doctor=${doctorId}&date=${date}`)
        .then(response => response.json())
        .then(slots => {
            const timeSlotContainer = document.getElementById('time-slots');
            if (timeSlotContainer) {
                timeSlotContainer.innerHTML = '';
                slots.forEach(slot => {
                    const slotBtn = document.createElement('button');
                    slotBtn.textContent = slot.time;
                    slotBtn.className = 'time-slot-btn';
                    slotBtn.onclick = () => selectTimeSlot(slot.time);
                    timeSlotContainer.appendChild(slotBtn);
                });
            }
        })
        .catch(error => {
            console.error('加载时间段失败:', error);
        });
}

function selectTimeSlot(time) {
    document.querySelectorAll('.time-slot-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');
    document.getElementById('selected-time').value = time;
}
