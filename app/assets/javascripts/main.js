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
