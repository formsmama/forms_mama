$(function(){
  if($('.date_after_born').length > 0){
    $("[id*='answer_1i']").on('change', function(){
      DateAfterBorn.check_year($("[type*='submit']"));
    });
  }
});

var DateAfterBorn = {
  check_year: function(submit_button){
    var selected_years = {};
    var togglers = [];
    var need_confirm = false;
    $("[class*='toggle_']:not([style*='display: none']):has('.date_after_born') .date_after_born").each(function(){
      var toggler = $(this).attr('toggler');
      if(togglers.indexOf(toggler) == -1) {
        togglers.push(toggler);
      }
      var born_year = $(this).attr('born_year');
      var year = $(this).find(".col-md-2 [id*='answer_1i']").val();
      if(selected_years[toggler] == undefined){
        selected_years[toggler] = [];
      }
      selected_years[toggler].push(born_year == year);
    });
    togglers.forEach(function(toggler){
      need_confirm = selected_years[toggler].indexOf(true) == -1 ? true : need_confirm;
    });
    if(need_confirm){
      submit_button.data('confirm', 'WARNING: You haven`t added all addresses for last 5 years(or from the birth date of a child younger than 5 years)!/ ADVERTENCIA: No ha añadido todas las direcciones por los últimos 5 años (o desde la fecha de nacimiento del menor de 5 años)  ');
    }else{
      submit_button.removeData('confirm');
    }
  }
};
