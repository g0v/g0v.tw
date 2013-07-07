function get_archives_all () {
    var content_id = $("#archives_content");
    var tab_id = $("#archives_all");
    var tabs = $(".archives_nav_tab");
    $.get("./archives/archives_all.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    tabs.removeClass('archives_active');
    tab_id.addClass("archives_active");

}

function get_archives_component () {
    var content_id = $("#archives_content");
    var tab_id = $("#archives_component");
    var tabs = $(".archives_nav_tab");
    $.get("./archives/archives_component.html",function(data){
        content_id.html('');
        content_id.append(data);
    });

    tabs.removeClass('archives_active');
    tab_id.addClass("archives_active");

}

$(document).ready(function () {
    get_archives_all();

    $("#archives_all").click(function() {
        get_archives_all();
    });
    $("#archives_component").click(function() {
        get_archives_component();
    });
});