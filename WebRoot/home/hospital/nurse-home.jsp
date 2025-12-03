<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智慧医疗云系统 - 护士端</title>
    
    <!-- 引入基础样式 -->
    <link rel="stylesheet" href="<%=basePath%>business/css/layout.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/nursing-service.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
</head>
<body>
    <!-- 顶部标题栏 -->
    <%
    request.setAttribute("pageTitle", "智慧医疗云系统 - 护士端");
    request.setAttribute("userWelcome", "欢迎，护士用户");
    request.setAttribute("logoutLink", basePath + "login/employee-login.jsp");
    %>
    <jsp:include page="../../business/basic/header.jsp" />
    
    <!-- 横向导航栏 -->
    <div class="horizontal-nav">
        <ul>
            <li><a href="#nursing-service" class="active" data-group="nursing-service">护务管理</a></li>
            <li><a href="#electronic-record" data-group="electronic-record">电子病历</a></li>
            <li><a href="#disease-management" data-group="disease-management">疾病管理</a></li>
        </ul>
    </div>
    
    <!-- 主容器 -->
    <div class="business-container">
        
        <!-- 1. 护务管理侧边栏 -->
        <div class="business-sidebar" id="nursing-service-sidebar">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>护务服务</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#daily-nursing" class="active" data-content="daily-nursing">日常护理工作</a></li>
                    <li class="nav-sub-item"><a href="#patient-arrangement" data-content="patient-arrangement">患者护理安排</a></li>
                    <li class="nav-sub-item"><a href="#nursing-schedule" data-content="nursing-schedule">排班表</a></li>
                    <li class="nav-sub-item"><a href="#nursing-stats" data-content="nursing-stats">工作统计</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 2. 电子病历侧边栏 -->
        <div class="business-sidebar" id="electronic-record-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>病历辅助管理</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#view-records" class="active" data-content="view-records">查看病历</a></li>
                    <li class="nav-sub-item"><a href="#record-assist" data-content="record-assist">协助记录</a></li>
                    <li class="nav-sub-item"><a href="#record-query" data-content="record-query">病历查询</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 3. 疾病管理侧边栏 -->
        <div class="business-sidebar" id="disease-management-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>疾病疫情管理</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#epidemic-info" class="active" data-content="epidemic-info">疫情信息</a></li>
                    <li class="nav-sub-item"><a href="#data-collection" data-content="data-collection">数据收集</a></li>
                    <li class="nav-sub-item"><a href="#reporting" data-content="reporting">信息上报</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 右侧内容区 -->
        <div class="business-content" id="business-content">
            <!-- 内容将通过JavaScript从business/html目录动态加载 -->
            <div id="business-content-placeholder">
                <h2>请选择左侧菜单项</h2>
            </div>
        </div>
    </div>
    
    <!-- 页脚 -->
    <jsp:include page="../../business/basic/footer.jsp" />

    <!-- 脚本区域 -->
    <script src="<%=basePath%>business/scripts/nurse-common.js"></script>
    <script src="<%=basePath%>business/scripts/business-common.js"></script>
    <script>
        // 初始化横向导航栏切换功能
        document.addEventListener('DOMContentLoaded', function() {
            // 使用统一的初始化函数
            if (typeof initHorizontalNav === 'function') {
                initHorizontalNav();
            }
            
            // 动态加载业务内容
            document.querySelectorAll('.nav-sub-item a').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const contentId = this.getAttribute('data-content');
                    const group = this.closest('.business-sidebar').id.replace('-sidebar', '');
                    
                    // 使用通用加载函数
                    loadBusinessContent('nurse', group, contentId);
                    
                    // 更新激活状态
                    document.querySelectorAll('.nav-sub-item a').forEach(a => a.classList.remove('active'));
                    this.classList.add('active');
                });
            });
            
            // 初始化分类折叠/展开功能
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
            
            // 页面加载时加载默认内容（默认显示第一分类的第一项）
            const firstSidebar = document.querySelector('.business-sidebar:not([style*="display: none"])');
            if (firstSidebar) {
                const firstCategory = firstSidebar.querySelector('.nav-category');
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
                const defaultLink = firstSidebar.querySelector('.nav-sub-item a.active') || firstSidebar.querySelector('.nav-sub-item a');
                if (defaultLink) {
                    defaultLink.click();
                }
            }
        });
    </script>

</body>
</html>
