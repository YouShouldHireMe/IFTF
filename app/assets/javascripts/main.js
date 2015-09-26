function getUrlParameter(name){
    var params = decodeURIComponent(window.location.search.substring(1)).split('&');
    for (var i = 0, len = params.length; i < len; i++) {
        pPair = params[i].split('=');
        if (pPair[0] == name) {
            return pPair[1] == undefined ? true : pPair[1];
        }
     }
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
function mergeArrayNoDup(a, b){
    var c = a.concat(b.filter(function (item) {
        return a.indexOf(item) < 0;
    }));
    return c;
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

function popupHide(){
    $('#popup').hide();
    $('#grayout').hide();
    $('#popup').attr('class', '');
}
