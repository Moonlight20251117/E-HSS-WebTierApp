var f_1 = $('#f_1');
var f_2 = $('#f_2');
var f_3 = $('#f_3');
var f_4 = $('#f_4');
var selectCloud = $('#selectCloud');
var regist = $('#regist');
var login = $("#login");
var other = $("#other");

f_1.on('click', function() {
    selectCloud.removeAttr('hidden');
    regist.attr('hidden', 'hidden');
    login.attr('hidden', 'hidden');
    other.attr('hidden', 'hidden');
    f_1.attr('class', 'active');
    f_2.removeAttr('class');
    f_3.removeAttr('class');
    f_4.removeAttr('class');
})


f_2.on('click', function() {
    selectCloud.attr('hidden', 'hidden');
    regist.removeAttr('hidden');
    login.attr('hidden', 'hidden');
    other.attr('hidden', 'hidden');
    f_2.attr('class', 'active');
    f_1.removeAttr('class');
    f_3.removeAttr('class');
    f_4.removeAttr('class');
})


f_3.on('click', function() {
    selectCloud.attr('hidden', 'hidden');
    regist.attr('hidden', 'hidden');
    login.removeAttr('hidden');
    other.attr('hidden', 'hidden');
    f_3.attr('class', 'active');
    f_1.removeAttr('class');
    f_2.removeAttr('class');
    f_4.removeAttr('class');
})


f_4.on('click', function() {
    selectCloud.attr('hidden', 'hidden');
    regist.attr('hidden', 'hidden');
    login.attr('hidden', 'hidden');
    other.removeAttr('hidden');
    f_4.attr('class', 'active');
    f_1.removeAttr('class');
    f_2.removeAttr('class');
    f_3.removeAttr('class');
})