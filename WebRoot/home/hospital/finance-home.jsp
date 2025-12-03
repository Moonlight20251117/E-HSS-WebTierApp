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
    <title>智慧医疗云系统 - 财务端</title>
    
    <!-- 引入基础样式 -->
    <link rel="stylesheet" href="<%=basePath%>business/css/layout.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/finance.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/business-common.css">
</head>
<body>
    <!-- 顶部标题栏 -->
    <%
    request.setAttribute("pageTitle", "智慧医疗云系统 - 财务端");
    request.setAttribute("userWelcome", "欢迎，财务用户");
    request.setAttribute("logoutLink", basePath + "login/employee-login.jsp");
    %>
    <jsp:include page="../../business/basic/header.jsp" />
    
    <!-- 横向导航栏 -->
    <div class="horizontal-nav">
        <ul>
            <li><a href="#asset-management" class="active" data-group="asset-management">资产管理</a></li>
            <li><a href="#drug-purchase" data-group="drug-purchase">药品采购</a></li>
            <li><a href="#financial-statistics" data-group="financial-statistics">财务统计</a></li>
        </ul>
    </div>
    
    <!-- 主容器 -->
    <div class="business-container">
        
        <!-- 1. 资产管理侧边栏 -->
        <div class="business-sidebar" id="asset-management-sidebar">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>资产管理</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#asset-list" class="active" data-content="asset-list">资产列表</a></li>
                    <li class="nav-sub-item"><a href="#asset-allocation" data-content="asset-allocation">资产分配</a></li>
                    <li class="nav-sub-item"><a href="#asset-maintenance" data-content="asset-maintenance">资产维护</a></li>
                    <li class="nav-sub-item"><a href="#resource-usage" data-content="resource-usage">资源使用</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 2. 药品采购侧边栏 -->
        <div class="business-sidebar" id="drug-purchase-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>药品采购</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#purchase-request" class="active" data-content="purchase-request">采购申请</a></li>
                    <li class="nav-sub-item"><a href="#purchase-order" data-content="purchase-order">采购订单</a></li>
                    <li class="nav-sub-item"><a href="#purchase-history" data-content="purchase-history">采购历史</a></li>
                    <li class="nav-sub-item"><a href="#drug-inventory" data-content="drug-inventory">药品库存</a></li>
                </ul>
            </div>
        </div>
        
        <!-- 3. 财务统计侧边栏 -->
        <div class="business-sidebar" id="financial-statistics-sidebar" style="display: none;">
            <div class="nav-category">
                <div class="nav-category-title">
                    <span>财务统计</span>
                    <span class="category-toggle expanded">▲</span>
                </div>
                <ul class="nav-sub-list" style="display: block;">
                    <li class="nav-sub-item"><a href="#revenue-statistics" class="active" data-content="revenue-statistics">收入统计</a></li>
                    <li class="nav-sub-item"><a href="#expense-statistics" data-content="expense-statistics">支出统计</a></li>
                    <li class="nav-sub-item"><a href="#budget-analysis" data-content="budget-analysis">预算分析</a></li>
                    <li class="nav-sub-item"><a href="#financial-report" data-content="financial-report">财务报表</a></li>
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
    <script src="<%=basePath%>business/scripts/finance.js"></script>
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
                    loadBusinessContent('finance', group, contentId);
                    
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
