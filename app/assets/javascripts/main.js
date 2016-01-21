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

function filter_sort_url(){
    var type    = $('#typeFilter').val() ? $('#typeFilter').val() : 'no_selection',
        tag     = $('#moreTags').val() ? $('#moreTags').val() : 'no_selection',
        order   = $('#customOrder').val(),
        related = '';

    if ($('.tag.selected').length == 1){
        tag = $('.tag.selected').data('tagid');
    }

    related = $('.currentpage').data('item_id') || '';
    if ($('#item_id').length == 1 && related == ''){
         //related = $('#item_id').data('itemid');
    }
    return '/filter/' + type + '/' + tag + '/' + order + '/' + related;
}

function save_filter_to_page($page){
    var type    = $('#typeFilter').val() ? $('#typeFilter').val() : 'no_selection',
        tag     = $('#moreTags').val() ? $('#moreTags').val() : 'no_selection',
        order   = $('#customOrder').val();

    if ($('.tag.selected').length == 1){
        tag = $('.tag.selected').data('tagid');
    }

    $page.data('type', type);
    $page.data('tag', tag);
    $page.data('order', order);
}

function reset_filter_display(type, tag, order){
    console.log('reset ' + tag);
    var reset_type  = (type == 'no_selection') ? '' : type,
        reset_tag   = (tag  == 'no_selection') ? '' : tag,
        reset_order = order ? order : 'date_desc';
    $('#typeFilter').val(reset_type);
    $('#customOrder').val(reset_order);
    $('#moreTags').val('');
    $('li.tag').removeClass('selected');
    if ($('.tag[data-tagid="' + reset_tag + '"').length == 1){
        $('.tag[data-tagid="' + reset_tag + '"').addClass('selected');
    }
    else {
        $('#moreTags').val(reset_tag);
    }
    $('#typeFilter').change();
    $('#customOrder').change();
    $('#moreTags').change();
    $('.currentpage').removeClass('newpage');
}

function reset_page_filter_display($page){
    var type    = $page.data('type'),
        tag     = $page.data('tag'),
        order   = $page.data('order');
    $page.addClass('newpage');
    reset_filter_display(type, tag, order);
    $page.removeClass('newpage');
}

function popupHide(){
    $('#popup').hide();
    $('#grayout').hide();
    $('#popup').attr('class', '');
}
