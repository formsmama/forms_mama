$(function(){
  if($('.amount_block').length > 0){
    $('.amount_block:last').parent().parent().parent().append("<div class='container'><div class='row new_roman col-md-9'><div class='who_pay_text'></div></div></div>");
    SupportAmount.who_pay($('.amount_block:last .income-math'), $('.amount_block:first .income-math'), $('.who_pay_text'));
    $('.amount_block .income-math').keyup(function(){
      SupportAmount.who_pay($('.amount_block:last .income-math'), $('.amount_block:first .income-math'), $('.who_pay_text'));
    });
  }
});

var SupportAmount = {
  joint_child_support_amount: function(_this){
    if(_this.val() == ''){
      return;
    }
    var month_income = parseInt(_this.val());
    var percentage = parseInt($('.children_percentage').val()) / 100;
    var result = Math.round(month_income * percentage * 100) / 100;
    _this.parent().find('.under_amount_text').prop('innerText', '$ ' + month_income + ' * ' + (percentage * 100) + '%  = ' + result);
    return result;
  },

  who_pay: function(dad_field, mom_field, text_field){
    var dad_result = SupportAmount.joint_child_support_amount(dad_field);
    var mom_result = SupportAmount.joint_child_support_amount(mom_field);
    var mom = $('.amount_block:first .income-math').data('plaintiff-name');
    var dad = $('.amount_block:first .income-math').data('defendant-name');
    if(dad_result == undefined || mom_result == undefined){
      return;
    }
    if(dad_result > mom_result){
      text_field.html('<span><b>'+ dad + ' $' + dad_result + ' – ' + mom + ' $' + mom_result + ' = $' + (Math.round((dad_result - mom_result)* 100) / 100) + '. ' + dad + ' has to pay ' + (Math.round((dad_result - mom_result)* 100) / 100) + '$ per month for child support to ' + mom + '. /</span> <span class="spain">' + dad + ' $' + dad_result + ' –  ' + mom + ' $' + mom_result + ' = $' + (Math.round((dad_result - mom_result)* 100) / 100) + ' es la responsabilidad de manutención de menor que ' + dad + ' tendrá que pagar a ' + mom + ' por mes.</span>');
    }
    else{
      text_field.html('<span><b>' + mom + ' $' + mom_result + ' – ' + dad + ' $' + dad_result + ' = $' + (Math.round((mom_result - dad_result)* 100) / 100) + '. ' + mom + ' has to pay ' + (Math.round((mom_result - dad_result)* 100) / 100) + '$ per month for child support to ' + dad + '. /</span> <span class="spain">' + mom + ' $' + mom_result + ' –  ' + dad + ' $' + dad_result + ' = $' + (Math.round((mom_result - dad_result)* 100) / 100) + ' es la responsabilidad de manutención de menor que ' + mom + ' tendrá que pagar a ' + dad + ' por mes.</span>');
    }
  }
}