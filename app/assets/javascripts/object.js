var Resources = {
	ItemsOrder: {
		init:function($el){
			$el.select2({minimumResultsForSearch: Infinity});
			$el.on('change', function(){
        		if ($('.currentpage').hasClass('newpage')) {return;}
        		var new_url = filter_sort_url();
        		$('.currentpage #list_display').html('<img src="/assets/ajax-loader.gif" />');
        		$('.currentpage #list_display').load(new_url);
    		});
 			Resources.ItemsOrder.position_adjust($el.closest('.order'));
		},
		position_adjust:function($el){
			//adjust location
    		var box_top 	= $('#resource_list').offset().top;
    		var select_top 	= $el.offset().top;
    		var top_diff 	= select_top - box_top - 11;
    		var orig_top 	= parseInt($el.css('top'));
    		var new_top		= orig_top - top_diff;
    		$el.css('top', new_top + 'px');
		}
	},
    Personalize: {
        Tags: {
            init:function(){
                $('#favoriteTags').select2();
                var last_valid_selection = $('#favoriteTags').val();

                $('#favoriteTags').change(function(e) {
                    if ($(this).val().length > 6) {
                        $(this).val(last_valid_selection);
                        $(this).change();
                        $('.inline_warning').show();
                    } else {
                        last_valid_selection = $(this).val();
                    }
                });
            }
        }
    },
    DragSlide: {
        x_start: 0,
        x_current: 0,       
        w_start: 0,
        w_start_2: 0,
        w_start_bar: 0,
        l_start_bar: 0,
        drag_started: false,
        init:function(){
            $('#resource_center').on('mousedown', Resources.DragSlide.drag_start);
            $('#resource_center').on('mousemove', Resources.DragSlide.drag_move);
            $('#resource_center').on('mouseup', Resources.DragSlide.drag_end);
        },
        drag_start:function(e){
            var $l      = $('#resource_list'),
                $r      = $('#resource_preview'),
                $bar    = $('#item_edit_bar'),
                bond_l  = $l.offset().left + $l.width() + 20 - 10,
                bond_r  = $l.offset().left + $l.width() + 20 + 10,
                bond_t  = $l.offset().top;
            if (e.pageX >= bond_l && e.pageX <= bond_r && e.pageY >= bond_t){
                e.preventDefault();
                Resources.DragSlide.x_start = e.pageX;
                Resources.DragSlide.w_start = $l.width();
                Resources.DragSlide.w_start_2 = $r.width();
                Resources.DragSlide.w_start_bar = $bar.width();
                Resources.DragSlide.l_start_bar = parseInt($bar.css('left'));
                Resources.DragSlide.drag_started = true;
            }
        },
        drag_move:function(e){
            var $l      = $('#resource_list'),
                $r      = $('#resource_preview'),
                $bar    = $('#item_edit_bar'),
                bond_l  = $l.offset().left + $l.width() + 20 - 10,
                bond_r  = $l.offset().left + $l.width() + 20 + 10,
                bond_t  = $l.offset().top;
            if (e.pageX >= bond_l && e.pageX <= bond_r && e.pageY >= bond_t){
                $('body').css('cursor', 'ew-resize');
            } else {
                $('body').css('cursor', 'inherit');
            }
            if (Resources.DragSlide.drag_started){
                e.preventDefault();
                var x_current   = e.pageX;
                var x_change    = x_current - Resources.DragSlide.x_start
                var w_current   = Resources.DragSlide.w_start + x_change;
                var w_current_2 = Resources.DragSlide.w_start_2 - x_change;
                var w_current_bar = Resources.DragSlide.w_start_bar - x_change;
                var l_current_bar = Resources.DragSlide.l_start_bar + x_change;


                var max_l = parseInt($('#resource_list').css('max-width'));
                $('#resource_list').width(w_current);
                var w_real  = $('#resource_list').width();
                $('#slider > div').width(w_real - 5);
                $('#resource_preview').width(w_current_2);

                var new_left = w_real + 48;
                $('#item_edit_bar').width(w_current_bar);
                $('#item_edit_bar').css('left', new_left + 'px');
            }
        },
        drag_end:function(e){
            if (Resources.DragSlide.drag_started){
                e.preventDefault();
                console.log('end');
                Resources.DragSlide.drag_started = false;
            }
        }
    }
}
