var content_id = $("#join_content");
var tabs = $(".join_nav_tab")

function swich_class (tabs, tabId) {
    tabs.removeClass('join_active');
    tabId.addClass("join_active");
}

function get_join_how () {
    var _tab_id = $("#join_how");
    $.get("./archives/archives_all.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    switch_class (tabs, _tab_id)

}

function get_join_project () {
    var _tab_id = $("#join_project");
    $.get("./archives/archives_component.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    switch_class (tabs, _tab_id)
}

function get_join_member () {
    var _tab_id = $("#join_member");
    $.get("./archives/archives_component.html",function(data){
        content_id.html('');
        content_id.append(data);
    });
    
    switch_class (tabs, _tab_id)

}

function get_join_act () {
    var _tab_id = $("#join_act");
    $.get("./archives/archives_component.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    switch_class (tabs, _tab_id)

}

function get_join_vote () {
    var _tab_id = $("#join_vote");
    $.get("./archives/archives_component.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    switch_class (tabs, _tab_id)

}

$(document).ready(function () {
    console.log('ready to join page');
    get_join_how();

    $("#join_how").click(function() {
        get_join_how();
        console.log('click how');
    });
    $("#join_project").click(function() {
        get_join_project();
        console.log('click project');
    });

    $("#join_member").click(function() {
        get_join_member();
    });

    $("#join_act").click(function() {
        get_join_act();
    });

    $("#join_vote").click(function() {
        get_join_vote();
    });
});