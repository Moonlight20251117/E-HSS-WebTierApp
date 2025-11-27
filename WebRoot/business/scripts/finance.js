/**
 * 财务业务脚本
 */

document.addEventListener('DOMContentLoaded', function() {
    initFinance();
});

function initFinance() {
    // 根据当前页面加载对应的财务数据
    const path = window.location.pathname;
    if (path.includes('asset')) {
        loadAssetData();
    } else if (path.includes('drug')) {
        loadDrugData();
    } else if (path.includes('financial')) {
        loadFinancialStatistics();
    }
}

// 资产与资源管理
function loadAssetData() {
    fetch('../../../../servlet/hospital/finance/AssetManagementServlet?action=list')
        .then(response => response.json())
        .then(data => {
            renderAssetList(data);
        })
        .catch(error => {
            console.error('加载资产数据失败:', error);
        });
}

function renderAssetList(assets) {
    const container = document.getElementById('asset-list-container');
    if (!container) return;
    
    let html = '<table class="data-table"><thead><tr><th>资产编号</th><th>资产名称</th><th>类别</th><th>状态</th><th>操作</th></tr></thead><tbody>';
    
    assets.forEach(asset => {
        html += `
            <tr>
                <td>${asset.code}</td>
                <td>${asset.name}</td>
                <td>${asset.category}</td>
                <td>${asset.status}</td>
                <td>
                    <button onclick="editAsset(${asset.id})">编辑</button>
                    <button onclick="deleteAsset(${asset.id})">删除</button>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

// 购药管理
function loadDrugData() {
    fetch('../../../../servlet/hospital/finance/DrugPurchaseServlet?action=list')
        .then(response => response.json())
        .then(data => {
            renderDrugList(data);
        })
        .catch(error => {
            console.error('加载药品数据失败:', error);
        });
}

function renderDrugList(drugs) {
    const container = document.getElementById('drug-list-container');
    if (!container) return;
    
    let html = '<table class="data-table"><thead><tr><th>药品名称</th><th>规格</th><th>库存</th><th>单价</th><th>操作</th></tr></thead><tbody>';
    
    drugs.forEach(drug => {
        html += `
            <tr>
                <td>${drug.name}</td>
                <td>${drug.specification}</td>
                <td>${drug.stock}</td>
                <td>¥${drug.price}</td>
                <td>
                    <button onclick="purchaseDrug(${drug.id})">采购</button>
                </td>
            </tr>
        `;
    });
    
    html += '</tbody></table>';
    container.innerHTML = html;
}

// 财务统计分析
function loadFinancialStatistics() {
    fetch('../../../../servlet/hospital/finance/FinancialStatisticsServlet?action=getStatistics')
        .then(response => response.json())
        .then(data => {
            renderStatistics(data);
        })
        .catch(error => {
            console.error('加载统计数据失败:', error);
        });
}

function renderStatistics(stats) {
    // 渲染统计图表
    // TODO: 使用图表库（如Chart.js）渲染数据
    console.log('统计数据:', stats);
}
