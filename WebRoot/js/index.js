/**
 * index.jsp 的交互脚本
 */
function handleCloudSelection() {
    var selected = document.getElementById('cloudSelect').value;
    if (selected === 'Healthcare') {
        // 选择医疗云后，跳转到 SaaSportal/index.html
        window.location.href = 'SaaSportal/index.html';
    } else {
        // 其他云类型可以跳转到对应的处理servlet
        window.location.href = './CloudServiceEngineering?select=' + selected;
    }
}

