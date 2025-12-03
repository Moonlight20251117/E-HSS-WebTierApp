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
    <title>智慧医疗云系统 - 患者端</title>
    
    <!-- 引入基础样式 -->
    <link rel="stylesheet" href="<%=basePath%>business/css/layout.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/appointment.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
</head>
<body>
    <!-- 顶部标题栏 -->
    <%
    request.setAttribute("pageTitle", "智慧医疗云系统 - 患者端");
    request.setAttribute("userWelcome", "欢迎，患者用户");
    request.setAttribute("logoutLink", basePath + "login/patient-login.jsp");
    %>
    <jsp:include page="../../business/basic/header.jsp" />
    
    <!-- 横向导航栏 -->
    <%
    String navItemsHtml = "<li><a href=\"#appointment\" class=\"active\" data-group=\"appointment\">预约与挂号</a></li>"
                        + "<li><a href=\"#medical-record\" data-group=\"medical-record\">电子病历档案</a></li>"
                        + "<li><a href=\"#remote-diagnosis\" data-group=\"remote-diagnosis\">远程医疗诊断</a></li>"
                        + "<li><a href=\"#medical-info\" data-group=\"medical-info\">医疗资讯</a></li>";
    request.setAttribute("navItemsHtml", navItemsHtml);
    %>
    <jsp:include page="../../business/basic/portfolio.jsp" />
    
    <!-- 主容器 -->
    <div class="business-container">
        
        <!-- 侧边栏 -->
        <%
        String sidebarItemsHtml = "<div class=\"business-sidebar\" id=\"appointment-sidebar\">"
                                + "<div class=\"nav-category\">"
                                + "<div class=\"nav-category-title\"><span>预约服务</span><span class=\"category-toggle expanded\">▲</span></div>"
                                + "<ul class=\"nav-sub-list\" style=\"display: block;\">"
                                + "<li class=\"nav-sub-item\"><a href=\"#new-appointment\" class=\"active\" data-content=\"new-appointment\">新建预约</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#history-appointment\" data-content=\"history-appointment\">查看历史预约</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#cancel-appointment\" data-content=\"cancel-appointment\">取消预约</a></li>"
                                + "</ul></div>"
                                + "<div class=\"nav-category\">"
                                + "<div class=\"nav-category-title\"><span>挂号服务</span><span class=\"category-toggle\">▼</span></div>"
                                + "<ul class=\"nav-sub-list\" style=\"display: none;\">"
                                + "<li class=\"nav-sub-item\"><a href=\"#new-registration\" data-content=\"new-registration\">新建挂号</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#history-registration\" data-content=\"history-registration\">查看历史挂号</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#cancel-registration\" data-content=\"cancel-registration\">取消挂号</a></li>"
                                + "</ul></div></div>"
                                + "<div class=\"business-sidebar\" id=\"medical-record-sidebar\" style=\"display: none;\">"
                                + "<div class=\"nav-category\">"
                                + "<div class=\"nav-category-title\"><span>病历服务</span><span class=\"category-toggle expanded\">▲</span></div>"
                                + "<ul class=\"nav-sub-list\" style=\"display: block;\">"
                                + "<li class=\"nav-sub-item\"><a href=\"#view-record\" class=\"active\" data-content=\"view-record\">查看病历</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#download-record\" data-content=\"download-record\">下载病历</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#share-record\" data-content=\"share-record\">共享病历</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#record-help\" data-content=\"record-help\">使用帮助</a></li>"
                                + "</ul></div></div>"
                                + "<div class=\"business-sidebar\" id=\"remote-diagnosis-sidebar\" style=\"display: none;\">"
                                + "<div class=\"nav-category\">"
                                + "<div class=\"nav-category-title\"><span>远程诊断</span><span class=\"category-toggle expanded\">▲</span></div>"
                                + "<ul class=\"nav-sub-list\" style=\"display: block;\">"
                                + "<li class=\"nav-sub-item\"><a href=\"#apply-diagnosis\" class=\"active\" data-content=\"apply-diagnosis\">申请远程诊断</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#diagnosis-history\" data-content=\"diagnosis-history\">诊断历史</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#doctor-select\" data-content=\"doctor-select\">选择医生</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#diagnosis-guide\" data-content=\"diagnosis-guide\">诊断指南</a></li>"
                                + "</ul></div></div>"
                                + "<div class=\"business-sidebar\" id=\"medical-info-sidebar\" style=\"display: none;\">"
                                + "<div class=\"nav-category\">"
                                + "<div class=\"nav-category-title\"><span>医疗资讯</span><span class=\"category-toggle expanded\">▲</span></div>"
                                + "<ul class=\"nav-sub-list\" style=\"display: block;\">"
                                + "<li class=\"nav-sub-item\"><a href=\"#health-news\" class=\"active\" data-content=\"health-news\">健康新闻</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#disease-prevent\" data-content=\"disease-prevent\">疾病预防</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#medical-knowledge\" data-content=\"medical-knowledge\">医疗知识</a></li>"
                                + "<li class=\"nav-sub-item\"><a href=\"#hospital-info\" data-content=\"hospital-info\">医院信息</a></li>"
                                + "</ul></div></div>";
        request.setAttribute("sidebarItemsHtml", sidebarItemsHtml);
        %>
        <jsp:include page="../../business/basic/contentNav.jsp" />
        
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
    <script src="<%=basePath%>business/scripts/patient-home.js"></script>
    <script src="<%=basePath%>business/scripts/business-common.js"></script>
    <script src="<%=basePath%>business/scripts/portfolio-change.js"></script>
    <script src="<%=basePath%>business/scripts/contentNav-change.js"></script>
    <script>
        // 设置当前角色并初始化页面
        document.addEventListener('DOMContentLoaded', function() {
            // 设置当前角色
            if (typeof setCurrentRole === 'function') {
                setCurrentRole('patient');
            }
            
            // 等待所有脚本加载完成后，初始化并加载默认内容
            setTimeout(function() {
                // 确保横向导航栏已初始化
                if (typeof initPortfolioChange === 'function') {
                    initPortfolioChange();
                }
                
                // 确保侧边栏切换已初始化
                if (typeof initContentNavChange === 'function') {
                    initContentNavChange();
                }
                
                // 手动触发默认内容加载
                const firstSidebar = document.querySelector('.business-sidebar:not([style*="display: none"])');
                if (firstSidebar) {
                    const group = firstSidebar.id.replace('-sidebar', '');
                    const defaultLink = firstSidebar.querySelector('.nav-sub-item a.active') || 
                                       firstSidebar.querySelector('.nav-sub-item a');
                    if (defaultLink && typeof loadBusinessContent === 'function') {
                        const contentId = defaultLink.getAttribute('data-content');
                        if (contentId) {
                            loadBusinessContent('patient', group, contentId);
                        }
                    }
                }
            }, 100);
        });
    </script>

</body>
</html>
