$(window).load(function(){
    $("ol.progress-tracker").each(function(){
        $(this).attr("data-progress-tracker-steps",
                     $(this).children("li").length);
    });
});