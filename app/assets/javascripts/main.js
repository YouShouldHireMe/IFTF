function adjustCSS($el, att, val){
    if ($el.length > 0){
        $el.css(att, val)
    }
}

function adjustNewTagWidth(tagid){
        var $taglist = $('#tag_lists'),
            $newtag = $('#new_tag');
        if (tagid == ''){
            $newtag.width($taglist.width());
        } else {
            $lasttag = $('[id="'+ tagid + '"]');
            var newWidth = $taglist.offset().left + $taglist.width() + 16 - $lasttag.offset().left - $lasttag.width() - 10 - 20;
            if (newWidth < 100) { newWidth = $taglist.width(); }
            $newtag.width(newWidth);
        }
    }

function adjust_on_window_change(){
        adjustCSS($('#grayout'), 'height', window.screen.height);
        adjustCSS($('#item_edit_bar'), 'left', $('#resource_preview').offset().left + 2.5);
        adjustCSS($('#item_edit_bar'), 'top', $('#resource_preview').offset().top + 2.125);
        adjustCSS($('#item_edit_bar'), 'width', $('#resource_preview').width() + 4); 
        adjustCSS($('#view_select_options'), 'left', getOffset($('#view_select'), 'left'));
        adjustCSS($('#resource_center'), 'height', 750 - 85 + $('#search_filter').height());
    }

function getOffset($el, att){
        if ($el.length > 0){
            return $el.offset()[att];
        } 
        return 0;
}
function updateCurrentParams(newParamString){
    var params = decodeURIComponent(window.location.search.substring(1)).split('&'),
        newParams = newParamString.split('&');
    var p = {};
    if (!(params.length == 1 && params[0] == "")){
        params.map(function(x) {var a = x.split('='); p[a[0]] = a[1]; });
    }
    newParams.map(function(x) {var a = x.split('='); p[a[0]] = a[1]; }); 
    var search_string = '';
    $.each(p, function(i, v){
        search_string = search_string + '&' + i + '=' + v;
    });
    return window.location.pathname + '?' + search_string.substring(1);
}

function popupHide(){
    $('#popup').hide();
    $('#grayout').hide();
    $('#popup').attr('class', '');
}
