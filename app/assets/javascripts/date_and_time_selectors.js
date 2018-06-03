$(function(){
  if($('.time').length > 0){
    Time.time_select();
  }
  if($("[name*='answer(1i)']").length > 0){
    $("[name*='answer(1i)']:not([type='hidden'])").wrap("<div class='col-md-2 margin-left'></div>");
    $("[name*='answer(3i)']:not([type='hidden'])").wrap("<div class='col-md-2 margin-left'></div>");
    $("[name*='answer(2i)']:not([type='hidden'])").wrap("<div class='col-md-3 margin-left'></div>");
  }
});

var Time = {
  time_select: function(){
    var time = $('.time');
    if (time.length > 0){

      var hours = '';
      var minutes = '';
      var minutes_step = 10;

      for( i = 1; i <= 12; ++i ){
        hours += '<option>' + i + '</option>';
      }

      var min = '';
      for( i = 0; i < 60; i += minutes_step ){
        var min = i < 10 ? '0' + i : i;
        minutes += '<option>' + min + '</option>'
      }
      var am_pm = '<option value="AM">AM</option><option value="PM">PM</option>';

      time.append('<div class="col-md-1 margin-left"><select class="hour form-control">' + hours + '</select></div>' +
                  '<div class="col-md-1 margin-left"><select class="minute form-control">' + minutes + '</select></div>' +
                  '<div class="col-md-1 margin-left"><select class="am-pm form-control">' + am_pm + '</select></div>');

      $('.time select').each(function(){
        $(this).change(function(){
          var _this = $(this);
          date = _this.parent().parent().find('[type="hidden"]');
          date.val('');
          _this.parent().parent().find('.form-control').each(function(i){
            switch(i) {
              case 1:
                date.val(date.val() + ':');
                break;
              case 2:
                date.val(date.val() + ' ');
                break;
            }
            date.val(date.val() + $(this).val());
          });
        });
      });
      time.find('[type="hidden"]').each(function(){
        var _this = $(this);
        if(_this.val().length > 0){
          selects = _this.parent().find('.form-control');
          selects.first().val(_this.val().split(/ |:/) [0]);
          selects.first().parent().next().children().val(_this.val().split(/ |:/) [1]);
          selects.last().val(_this.val().split(/ |:/) [2]);
        }
      });
    }
  }
}