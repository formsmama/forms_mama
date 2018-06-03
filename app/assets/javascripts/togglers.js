$(function(){
  Togglers.checkbox_radio_toggler();
  var counters = $('.counter');
  if(counters.length == 1){
    counters.hide();
  }else{
    Togglers.dependant_fields(counters);
  }
});

var Togglers = {
  dependant_fields: function(counters){
    counters.each(function(){
      var first_depend_field = $(this).next().find('[type="text"]');

      if( first_depend_field.length > 0){
          first_depend_field.change(function(){
            first_depend_field.closest('div[data-toggle-option]').prev().find('.first_dependant_field').text($(this).val());
        });

        var second_depend_field = first_depend_field.closest('div[data-toggle-option]').next().next().next().next().find('[type="text"]');
        if( second_depend_field.length > 0)
            second_depend_field.change(function(){
              second_depend_field.closest('div[data-toggle-option]').prev().prev().prev().prev().prev().find('.second_dependant_field').text($(this).val());
        });
      }
    });
  },

  checkbox_radio_toggler: function(){
    //Toggler logic
    $('[class^="toggle_"]').each(function(){
      var this_prop_class = '.' + $(this).prop('class');

      if($(this_prop_class    + ':first :checkbox').length > 0){
        if(!$(this_prop_class + ':first :checkbox').is(':checked')){
          $(this_prop_class   + ':not(:first)').hide();
        }

        //Checkbox event
        $(document).change( '.' + $(this).prop('class') + ':first:has(:checkbox)', function(){
          if(!$(this_prop_class + ':first :checkbox').is(':checked')){
            $(this_prop_class   + ':not(:first)').hide();
          }else{
            $(this_prop_class   + ':not(:first)').show();
          }
        });
      }

      if($(this_prop_class + ':first [type="radio"]').length > 0){
        var selected_value = $('.' + $(this).prop('class') + ' [type="radio"]:checked').val();
        $('.' + $(this).prop('class') + ':not(:first)').hide().each(function(){
          if(selected_value != undefined){
            if(selected_value.indexOf($(this).data('toggle-option')) != -1){
              $(this).show();
            }
          }
        });

        //Radio button event
        $('.' + $(this).prop('class') + ' [type="radio"]').unbind('change').change(function(){
          var selected_value = $(this).next().text();
          var parent_class = '.' + $(this).closest('[class^="toggle_"]').prop('class');
          if(selected_value == 'No' && $(this).closest('[class^="toggle_"]').data('sub-toggle') == undefined){
            $(parent_class + ':not(:first) [type="radio"]:last').attr('checked', true);
          }

          Checkboxes.hide_checkboxes($(parent_class));

          if($(this).parent().parent().parent().parent().data('sub-toggle') == undefined){
            $(parent_class + ':not(:first)').hide().each(function(){
              Togglers.hide_sub_toggles($(this), selected_value);
            });
          }
        });
      }
    });

    //Toggler logic for sub-toggle
    $('[data-sub-toggle]').each(function(){

      var this_class = '.' + $(this).prop('class');
      var result = parseInt($(this).attr('data-sub-toggle'));
      var this_class_next = '.toggle_' + result;
      var selected_value = $(this_class + ' [type="radio"]:checked:last').val();
      var selected_class = 'toggle_' + $(this_class + ' [type="radio"]:checked:last').closest('[class^="toggle_"]').data('sub-toggle');

      if(!$('.' + $(this).prop('class') + ' [type="checkbox"]').length > 0 ){
        $(this_class_next).hide().each(function(){
          if(selected_value != undefined && selected_class != undefined){
            if(selected_value.indexOf($(this).data('toggle-option')) != -1 && selected_class == $(this).prop('class')){
              $(this).show();
            }
          }
        });
      }

      Checkboxes.checkbox_button_event($(this));

      //Radio button event
      $(this_class + '[data-sub-toggle="'+ $(this).data('sub-toggle')+'"]').change(function(){
        var selected_value = $('.' + $(this).prop('class') + ' [type="radio"]:checked:last').val();
        if(!$('.' + $(this).prop('class') + ' [type="checkbox"]').length > 0 ){
          if(result == $(this).data('sub-toggle')){
            $(this_class_next).hide().each(function(){
              Togglers.hide_sub_toggles($(this), selected_value);
            });
          }
        }

        //Checkbox button event
        Checkboxes.checkbox_button_event($(this));
      });
    });
  },

  hide_sub_toggles: function(_this, selected_value){
    var current_class = '.toggle_' + parseInt($(this).attr('data-sub-toggle'));

    if(_this.data('sub-toggle') != undefined){
      if( _this.find('[type="radio"]:checked').length > 0 ){
        var toggler = _this.find('[type="radio"]:checked').prop('checked', false).closest('div[data-sub-toggle]').attr('data-sub-toggle');
        $('.toggle_' + toggler).hide();
      }
      $(current_class).hide().each(function(){
        Togglers.hide_sub_toggles($(this));
      });
    }

    if(selected_value!= undefined && selected_value.indexOf(_this.data('toggle-option')) != -1){
      _this.show();
    }
  }
}

var Checkboxes = {
  checkbox_button_event: function(_this){
    if($('.' + _this.prop('class') + ' [type="checkbox"]').length > 0 ){
      var this_class = '.toggle_' + (parseInt(_this.data('sub-toggle')));

      if($('.' + _this.prop('class') + '[data-sub-toggle="'+ _this.data('sub-toggle')+'"]' + '[data-toggle-option="'+ _this.data('toggle-option')+'"]' + ' [type="checkbox"]').is(':checked')){
        $(this_class + '[data-toggle-option="'+ _this.data('toggle-option')+'"]').show();
      }else{
        $(this_class + '[data-toggle-option="'+ _this.data('toggle-option')+'"]').hide();
      }
    }
  },

  hide_checkboxes: function(_this){
    if($('.' + _this.prop('class') + ' [type="checkbox"]').length > 0 ){
      $('.' + _this.prop('class') + ' [type="checkbox"]:checked').prop('checked',false);
      $('.' + _this.prop('class') + '[data-sub-toggle]').each(function(){
        $('.toggle_' + (parseInt($(this).data('sub-toggle')))).hide();
      });
    }
  }
}