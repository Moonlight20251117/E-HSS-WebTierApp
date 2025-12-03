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
    <title>智慧医疗云系统 - 医院高管</title>
    
    <!-- 引入基础样式 -->
    <link rel="stylesheet" href="<%=basePath%>business/css/layout.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/forum.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
</head>
<body>
    <!-- 顶部标题栏 -->
    <%
    request.setAttribute("pageTitle", "智慧医疗云系统 - 医院高管");
    request.setAttribute("userWelcome", "欢迎，医院高管用户");
    request.setAttribute("logoutLink", basePath + "login/employee-login.jsp");
    %>
    <jsp:include page="../../business/basic/header.jsp" />
    
    <!-- 横向导航栏 -->
    <div class="horizontal-nav">
        <ul>
            <li><a href="#forum-overview" class="active" data-group="forum-overview">论坛一览</a></li>
            <li><a href="#interaction-center" data-group="interaction-center">互动中心</a></li>
            <li><a href="#data-center" data-group="data-center">数据中心</a></li>
        </ul>
    </div>
    
    <!-- 主容器 -->
    <div class="business-container">
        
        <!-- 1. 论坛一览侧边栏 -->
        <div class="business-sidebar" id="forum-overview-sidebar">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>论坛管理</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#forum-home" class="active" data-content="forum-home">论坛首页</a></li>
                    <li class="nav-sub-item"><a href="#publish-content" data-content="publish-content">发布内容</a></li>
                    <li class="nav-sub-item"><a href="#my-posts" data-content="my-posts">我的帖子</a></li>
                    <li class="nav-sub-item"><a href="#replies" data-content="replies">回复管理</a></li>
                    <li class="nav-sub-item"><a href="#feedback" data-content="feedback">反馈处理</a></li>
                    <li class="nav-sub-item"><a href="#activity-stats" data-content="activity-stats">活动统计</a></li>
                    <li class="nav-sub-item"><a href="#interaction-stats" data-content="interaction-stats">互动统计</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 2. 互动中心侧边栏 -->
        <div class="business-sidebar" id="interaction-center-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>互动功能</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#forum-home" class="active" data-content="forum-home">论坛首页</a></li>
                    <li class="nav-sub-item"><a href="#publish-content" data-content="publish-content">发布内容</a></li>
                    <li class="nav-sub-item"><a href="#my-posts" data-content="my-posts">我的帖子</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 3. 数据中心侧边栏 -->
        <div class="business-sidebar" id="data-center-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>数据统计</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#activity-stats" class="active" data-content="activity-stats">活动统计</a></li>
                    <li class="nav-sub-item"><a href="#interaction-stats" data-content="interaction-stats">互动统计</a></li>
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
    <script src="<%=basePath%>business/scripts/executive-home.js"></script>
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
                    loadBusinessContent('executive', group, contentId);
                    
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
            
            // 页面加载时加载默认内容
            const firstSidebar = document.querySelector('.business-sidebar:not([style*="display: none"])');
            if (firstSidebar) {
                const defaultLink = firstSidebar.querySelector('.nav-sub-item a.active') || firstSidebar.querySelector('.nav-sub-item a');
                if (defaultLink) {
                    defaultLink.click();
                }
            }
        });
    </script>

</body>
</html>
