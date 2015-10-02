function infiniteScroll(){
    $('#resource_list').on('scroll', function(){
        var more_item_url = $('.pagination .next a').attr('href');
        if (more_item_url && $('#resource_list').scrollTop() > $('.currentpage').height() - $('#resource_list ').height() - 60){
            $('#pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
            $.getScript(more_item_url)
                .done(function(script, textStatus){
                    console.log(textStatus);
                })
                .fail(function(jqxhr, settings, exception) {
                    console.log(jqxhr);
                });
        } 
    });
}
