$(function(){
  $('.loop-button').each(function(){
    $(this).click(function(){
      $.ajax({
        type: "POST",
        data: $('#answer_form').serialize() + "&answer_id=" + $(this).attr('answer') + "&document_id=" + $('#document_id').val(),
        url: "/documents/" + $('#document_id').val() + ($(this).attr('name') == 'Delete' ? "/delete_fields_block" : "/add_fields_block")
      });
    });
  });
});