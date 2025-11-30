/**
 * 业务模块通用JavaScript函数
 */

// 通用AJAX请求函数
function ajaxRequest(url, method, data, callback) {
    const options = {
        method: method || 'GET',
        headers: {
            'Content-Type': 'application/json;charset=UTF-8'
        }
    };
    
    if (data && method !== 'GET') {
        options.body = JSON.stringify(data);
    }
    
    fetch(url, options)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('网络响应错误');
        })
        .then(data => {
            if (callback) callback(data);
        })
        .catch(error => {
            console.error('请求失败:', error);
            alert('操作失败，请稍后重试');
        });
}

// 格式化日期
function formatDate(date) {
    if (!date) return '';
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// 格式化日期时间
function formatDateTime(date) {
    if (!date) return '';
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    const hours = String(d.getHours()).padStart(2, '0');
    const minutes = String(d.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}

// 显示加载状态
function showLoading(element) {
    if (element) {
        element.innerHTML = '<div style="text-align:center;padding:40px;"><div class="spinner"></div><p>加载中...</p></div>';
    }
}

// 显示错误信息
function showError(element, message) {
    if (element) {
        element.innerHTML = `<div style="text-align:center;padding:40px;color:#e74c3c;"><p>${message || '加载失败，请稍后重试'}</p></div>`;
    }
}

// 显示成功提示
function showSuccess(message) {
    const toast = document.createElement('div');
    toast.className = 'toast-success';
    toast.textContent = message;
    toast.style.cssText = 'position:fixed;top:20px;right:20px;background:#2ecc71;color:white;padding:15px 20px;border-radius:6px;box-shadow:0 4px 8px rgba(0,0,0,0.2);z-index:9999;';
    document.body.appendChild(toast);
    setTimeout(() => {
        toast.remove();
    }, 3000);
}

// 确认对话框
function confirmAction(message, callback) {
    if (confirm(message)) {
        if (callback) callback();
    }
}

// 分页函数
function createPagination(currentPage, totalPages, callback) {
    const pagination = document.createElement('div');
    pagination.className = 'pagination';
    pagination.style.cssText = 'display:flex;justify-content:center;gap:10px;margin-top:20px;';
    
    // 上一页
    const prevBtn = document.createElement('button');
    prevBtn.textContent = '上一页';
    prevBtn.disabled = currentPage === 1;
    prevBtn.onclick = () => callback(currentPage - 1);
    pagination.appendChild(prevBtn);
    
    // 页码
    for (let i = 1; i <= totalPages; i++) {
        const pageBtn = document.createElement('button');
        pageBtn.textContent = i;
        pageBtn.className = i === currentPage ? 'active' : '';
        pageBtn.onclick = () => callback(i);
        pagination.appendChild(pageBtn);
    }
    
    // 下一页
    const nextBtn = document.createElement('button');
    nextBtn.textContent = '下一页';
    nextBtn.disabled = currentPage === totalPages;
    nextBtn.onclick = () => callback(currentPage + 1);
    pagination.appendChild(nextBtn);
    
    return pagination;
}

/**
 * 根据角色、业务组和内容ID加载业务HTML片段
 * @param {string} role - 角色：admin, enterprise, hospital/doctor, hospital/nurse, hospital/executive, hospital/finance, patient, university
 * @param {string} group - 业务组名称（侧边栏ID去掉-sidebar后的名称）
 * @param {string} contentId - 内容ID（data-content属性的值）
 */
function loadBusinessContent(role, group, contentId) {
    // 先尝试查找 business-content，如果不存在则查找 business-content-placeholder
    let contentContainer = document.getElementById('business-content');
    if (!contentContainer) {
        contentContainer = document.querySelector('.business-content');
    }
    if (!contentContainer) {
        console.error('找不到业务内容容器 #business-content 或 .business-content');
        return;
    }
    
    // 显示加载状态
    showLoading(contentContainer);
    
    // 业务组名称到servlet业务名称的映射（注意：这里映射到实际的文件夹名称，保持大小写一致）
    const groupMapping = {
        'business-manage': 'BusinessManage',
        'user-manage': 'UserManage',
        'cooperation-forum': 'CooperationForum',
        'forum-overview': 'CooperationForum', // 论坛管理（高管端）
        'medical-service': 'MedicalService',
        'electronic-record': 'electronic-record', // 护士的电子病历使用小写
        'remote-diagnosis': 'RemoteDiagnosis',
        'remote-consultation': 'RemoteConsultation',
        'medical-advice': 'MedicalAdvice',
        'disease-management': 'disease-management', // 护士的疾病管理使用小写
        'asset-management': 'AssetManagement',
        'drug-purchase': 'DrugPurchase',
        'financial-statistics': 'FinancialStatistics',
        'nursing-service': 'nursing-service', // 护士的护理服务
        'appointment': 'appointment', // 患者预约使用小写appointment文件夹
        'medical-record': 'electronic-record', // 患者的医疗记录使用小写electronic-record文件夹
        'remote-diagnosis': 'remote-diagnosis', // 患者的远程诊断使用小写remote-diagnosis文件夹
        'remote-services': 'RemoteDiagnosis', // 医生的远程服务对应RemoteDiagnosis
        'medical-info': 'medical-info' // 医疗资讯使用小写medical-info文件夹
    };
    
    // 内容ID到HTML文件名的映射
    const contentMapping = {
        // 管理员
        'business-manage': 'business-manage.html',
        'user-manage': 'user-manage.html',
        // 合作论坛
        'forum-home': 'forum-home.html',
        'publish-content': 'publish-content.html',
        'my-posts': 'my-posts.html',
        'feedback': 'feedback.html',
        'replies': 'replies.html',
        'activity-stats': 'activity-stats.html',
        'interaction-stats': 'interaction-stats.html',
        // 医疗服务/护理服务
        'daily-work': 'daily-work.html',
        'daily-nursing': 'daily-nursing.html',
        'patient-care': 'patient-care.html',
        'schedule': 'schedule.html',
        'nursing-schedule': 'nursing-schedule.html',
        'statistics': 'statistics.html',
        'nursing-stats': 'nursing-stats.html',
        'patient-arrangement': 'patient-arrangement.html',
        // 电子病历
        'view-records': 'view-records.html',
        'add-record': 'add-record.html',
        'edit-record': 'edit-record.html',
        'record-settings': 'record-settings.html',
        'record-assist': 'record-assist.html',
        'record-query': 'record-query.html',
        'view-record': 'view-record.html',
        'download-record': 'download-record.html',
        'share-record': 'share-record.html',
        'record-help': 'record-help.html',
        // 远程医疗
        'remote-diagnosis': 'remote-diagnosis.html',
        'remote-consultation': 'remote-consultation.html',
        'medical-advice': 'medical-advice.html',
        'remote-history': 'remote-history.html',
        'apply-diagnosis': 'apply-diagnosis.html',
        'diagnosis-guide': 'diagnosis-guide.html',
        'diagnosis-history': 'diagnosis-history.html',
        'doctor-select': 'doctor-select.html',
        // 疾病管理
        'epidemic-monitor': 'epidemic-monitor.html',
        'epidemic-info': 'epidemic-info.html',
        'disease-report': 'disease-report.html',
        'reporting': 'reporting.html',
        'statistics-analysis': 'statistics-analysis.html',
        'prevention-guide': 'prevention-guide.html',
        'data-collection': 'data-collection.html',
        // 资产与资源管理
        'asset-list': 'asset-list.html',
        'asset-allocation': 'asset-allocation.html',
        'asset-maintenance': 'asset-maintenance.html',
        'resource-usage': 'resource-usage.html',
        // 购药管理
        'purchase-request': 'purchase-request.html',
        'purchase-order': 'purchase-order.html',
        'purchase-history': 'purchase-history.html',
        'drug-inventory': 'drug-inventory.html',
        // 财务统计分析
        'revenue-statistics': 'revenue-statistics.html',
        'expense-statistics': 'expense-statistics.html',
        'financial-report': 'financial-report.html',
        'budget-analysis': 'budget-analysis.html',
        // 预约与挂号
        'new-appointment': 'new-appointment.html',
        'new-registration': 'new-registration.html',
        'history-appointment': 'history-appointment.html',
        'history-registration': 'history-registration.html',
        'cancel-appointment': 'cancel-appointment.html',
        'cancel-registration': 'cancel-registration.html',
        // 医疗资讯
        'health-news': 'health-news.html',
        'hospital-info': 'hospital-info.html',
        'medical-knowledge': 'medical-knowledge.html',
        'disease-prevent': 'disease-prevent.html'
    };
    
    // 获取业务名称
    const businessName = groupMapping[group] || group;
    const fileName = contentMapping[contentId] || contentId + '.html';
    
    // 构建路径
    let basePath = '../../business/html/';
    if (role === 'admin') {
        basePath += 'admin/';
    } else if (role === 'enterprise') {
        basePath += 'enterprise/';
    } else if (role === 'university') {
        basePath += 'university/';
    } else if (role === 'patient') {
        basePath += 'patient/';
    } else if (role === 'doctor') {
        basePath += 'hospital/doctor/';
    } else if (role === 'nurse') {
        basePath += 'nurse/';
    } else if (role === 'executive') {
        basePath += 'executive/';
    } else if (role === 'finance') {
        basePath += 'hospital/finance/';
    }
    
    const htmlPath = basePath + businessName + '/' + fileName;
    
    // 加载HTML片段
    fetch(htmlPath)
        .then(response => {
            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }
            return response.text();
        })
        .then(html => {
            // 先提取link和script标签
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            
            // 辅助函数：将相对路径转换为绝对路径（从项目根目录开始）
            function resolvePath(relativePath) {
                // 如果已经是绝对路径或完整URL，直接返回
                if (relativePath.startsWith('http://') || relativePath.startsWith('https://')) {
                    return relativePath;
                }
                
                // 如果以 / 开头，已经是绝对路径，直接返回
                if (relativePath.startsWith('/')) {
                    return relativePath;
                }
                
                // 获取当前页面的基础URL和路径
                const currentPath = window.location.pathname;
                
                // 提取项目上下文路径（例如: /E-HSS/）
                // 当前页面路径可能是: /E-HSS/home/hospital/nurse-home.html
                const pathParts = currentPath.split('/').filter(p => p);
                let contextPath = '/';
                if (pathParts.length > 0) {
                    // 假设第一个部分是项目名（如 E-HSS）
                    contextPath = '/' + pathParts[0] + '/';
                }
                
                // 手动解析相对路径，避免URL API的路径重复问题
                // HTML文件在: business/html/nurse/nursing-service/daily-nursing.html
                // 相对路径 ../../../business/scripts/nursing-service.js
                // 从 business/html/nurse/nursing-service/ 向上3级到项目根，然后加上 business/scripts/nursing-service.js
                // 结果: /E-HSS/business/scripts/nursing-service.js
                
                let pathAfterUp = relativePath;
                let upLevels = 0;
                
                // 计算向上级数
                while (pathAfterUp.startsWith('../')) {
                    upLevels++;
                    pathAfterUp = pathAfterUp.substring(3);
                }
                
                // 移除开头的 /（如果有）
                if (pathAfterUp.startsWith('/')) {
                    pathAfterUp = pathAfterUp.substring(1);
                }
                
                // 构建最终路径：项目根 + 剩余路径
                const finalPath = contextPath + pathAfterUp;
                console.log('解析路径 - 相对路径:', relativePath, '向上级数:', upLevels, '剩余路径:', pathAfterUp, '解析结果:', finalPath);
                return finalPath;
            }
            
            // 处理CSS link标签
            const links = tempDiv.querySelectorAll('link[rel="stylesheet"]');
            links.forEach(link => {
                const href = link.getAttribute('href');
                const absoluteHref = resolvePath(href);
                
                console.log('加载CSS:', href, '->', absoluteHref);
                
                // 检查是否已经加载过这个CSS
                const existingLink = document.querySelector(`link[href="${absoluteHref}"]`);
                if (!existingLink) {
                    const newLink = document.createElement('link');
                    newLink.rel = 'stylesheet';
                    newLink.href = absoluteHref;
                    document.head.appendChild(newLink);
                }
                // 从HTML中移除link标签
                link.remove();
            });
            
            // 设置内容（已移除link标签）
            contentContainer.innerHTML = tempDiv.innerHTML;
            
            // 执行HTML中的script标签
            const scripts = contentContainer.querySelectorAll('script');
            scripts.forEach(script => {
                const newScript = document.createElement('script');
                if (script.src) {
                    // 获取script标签的src属性值（可能是相对路径）
                    const scriptSrc = script.getAttribute('src');
                    const absoluteSrc = resolvePath(scriptSrc);
                    
                    // 检查脚本是否已经加载过（避免重复加载）
                    const scriptId = 'loaded-script-' + absoluteSrc.replace(/[^a-zA-Z0-9]/g, '-');
                    if (document.getElementById(scriptId)) {
                        console.log('脚本已加载，跳过:', absoluteSrc);
                        script.remove();
                        return;
                    }
                    
                    console.log('加载JS - 原始路径:', scriptSrc, '解析后路径:', absoluteSrc);
                    newScript.src = absoluteSrc;
                    newScript.id = scriptId;
                } else {
                    newScript.textContent = script.textContent;
                }
                document.body.appendChild(newScript);
                script.remove();
            });
        })
        .catch(error => {
            console.error('加载业务内容失败:', error);
            showError(contentContainer, '加载失败：' + htmlPath);
        });
}

/**
 * 初始化横向导航栏切换功能
 * 确保侧边栏始终显示
 */
function initHorizontalNav() {
    // 先移除所有可能存在的旧事件监听器
    const existingLinks = document.querySelectorAll('.horizontal-nav a');
    existingLinks.forEach(link => {
        // 克隆节点以移除所有事件监听器
        const newLink = link.cloneNode(true);
        link.parentNode.replaceChild(newLink, link);
    });
    
    // 重新获取所有导航链接（此时已经是新的节点）
    const horizontalNavLinks = document.querySelectorAll('.horizontal-nav a');
    
    // 初始化时移除所有active状态，确保默认不显示高亮
    horizontalNavLinks.forEach(a => {
        a.classList.remove('active');
    });
    
    // 为每个导航链接添加点击事件
    horizontalNavLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation(); // 阻止事件冒泡
            
            const group = this.getAttribute('data-group');
            
            // 更新横向导航栏激活状态 - 先移除所有active，再添加当前点击的active
            // 重新查询所有导航链接，确保获取到最新的DOM节点
            const allNavLinks = document.querySelectorAll('.horizontal-nav a');
            allNavLinks.forEach(a => {
                // 强制移除active类
                a.classList.remove('active');
                // 移除active后恢复默认样式 - 清除所有可能的内联样式
                a.removeAttribute('style');
            });
            
            // 给当前点击的导航单元添加active类
            this.classList.add('active');
            
            // 隐藏所有侧边栏
            document.querySelectorAll('.business-sidebar').forEach(sidebar => {
                sidebar.style.display = 'none';
            });
            
            // 显示对应的侧边栏
            const targetSidebar = document.getElementById(group + '-sidebar');
            if (targetSidebar) {
                targetSidebar.style.display = 'block';
                
                // 加载该侧边栏的第一个激活项
                const firstActive = targetSidebar.querySelector('.nav-sub-item a.active');
                if (firstActive) {
                    // 使用setTimeout确保侧边栏显示后再触发点击
                    setTimeout(() => {
                        firstActive.click();
                    }, 10);
                } else {
                    // 如果没有激活项，激活第一个项
                    const firstItem = targetSidebar.querySelector('.nav-sub-item a');
                    if (firstItem) {
                        firstItem.classList.add('active');
                        setTimeout(() => {
                            firstItem.click();
                        }, 10);
                    }
                }
            } else {
                // 如果找不到对应的侧边栏，显示第一个可用的侧边栏
                const firstSidebar = document.querySelector('.business-sidebar');
                if (firstSidebar) {
                    firstSidebar.style.display = 'block';
                    const firstItem = firstSidebar.querySelector('.nav-sub-item a');
                    if (firstItem) {
                        firstItem.classList.add('active');
                        setTimeout(() => {
                            firstItem.click();
                        }, 10);
                    }
                }
            }
        });
    });
}
