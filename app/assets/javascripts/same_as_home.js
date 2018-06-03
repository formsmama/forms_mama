$(function(){
  if($('.radio_3:first').length == 1){
    SameAsHomeRadio.radio_click($('.radio_3:first'));
  }
});

var SameAsHomeRadio = {
  radio_click: function(radio_button){
    radio_button.on('click', function(){
      var address = $('[data-toggle-option]').eq(7).find('.container div:eq(1) input').val();
      var city = $('[data-toggle-option]').eq(8).find('.container div:eq(1) input').val();
      var state = $('[data-toggle-option]').eq(9).find('.container .col-md-2 select').val();
      var zip = $('[data-toggle-option]').eq(10).find('.container div:eq(1) input').val();

      $('[data-toggle-option]').eq(11).find('.container div:eq(2) div input').prop('value', address);
      $('[data-toggle-option]').eq(12).find('.container div:eq(1) input').prop('value', city);
      $('[data-toggle-option]').eq(13).find('.container .col-md-2 select').prop('value', state);
      $('[data-toggle-option]').eq(14).find('.container div:eq(1) input').prop('value', zip);
    });

    $('[data-toggle-option]').eq(11).find('.container div:eq(2) div input').on('keydown', function(){
      $('.radio_3:first').prop('checked', false);
    });
    $('[data-toggle-option]').eq(12).find('.container div:eq(1) input').on('keydown', function(){
      $('.radio_3:first').prop('checked', false);
    });
    $('[data-toggle-option]').eq(14).find('.container div:eq(1) input').on('keydown', function(){
      $('.radio_3:first').prop('checked', false);
    });
    $('[data-toggle-option]').eq(13).find('.container .col-md-2 select').on('change', function(){
      $('.radio_3:first').prop('checked', false);
    });
  }
}