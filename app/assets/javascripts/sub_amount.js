$(function(){
  SubAmount.sub_amount_click($('[class^="sub_amount_"]'));
});

var SubAmount = {
  sub_amount_click: function(sub_amount_button){
    sub_amount_button.each(function(){

      $(document).on('click', '.' + $(this).prop('class') + ' div:last-child a', function(event){
        event.preventDefault();

        var form = $('#answer_form').serialize();
        var answer_id = $(this).prev().val();
        var value = $(this).parent().prev().find('p input').val();
        var answer_id_question = $(this).parent().parent().parent().parent().prev().prev().find('div label input:last-child').val();

        if(answer_id_question == undefined){
          answer_id_question = $(this).parent().parent().parent().parent().prev().prev().find('strong').next().val();
        }

        if(SubAmount.check_value(value, $(this))){
          $.ajax({
            type: "POST",
            data: form + "&value=" + value + "&answer_id_first=" + answer_id_question +"&answer_id_second=" + answer_id + "&document_id=" + $('#document_id').val() + "&review=" + $('#review_present').val(),
            url: "/documents/"+$('#document_id').val()+"/step/"+$('#step_id').val()+"/render_questions"
          });
        }
      });
    });
  },

  check_value: function(value, _this){
    if(value < 1 || value > 9){
      _this.after('<div id="error" style="width:240px; background:#FAACAC; padding: 3px; border-radius: 5px; color: red; margin-top: 3px;"><span>Only from 1 to 9</span>/<span class="spain">Sólo del 1 al 9</span></div>');
      setTimeout(function(){ $('#error').remove(); }, 5000);
      return false;
    }
    return true;
  }
}