$(function(){
  if($('[data-insert-place]').length > 0){
    InsertBlock.insert_html_block($('[data-insert-place]'));
  }

  if($('witness_name').length > 0){
    WitnessName.insert_name();
  }
});

var InsertBlock = {
  insert_html_block: function(data_insert){
    data_insert.each(function(){
      var this_class = '.place_for_insert_' + $(this).data('insert-place');
      var div = $(this).detach();
      $(this_class).append(div);
      div = null;
    });
  }
}

var WitnessName = {
  insert_name: function(){
    var name_fields = $(".container:contains('Name') .form-control")
    if(WitnessName.get_name(name_fields).length > 2){
      $('witness_name').text(WitnessName.get_name(name_fields));
    }
    name_fields.on('change', function(){
      $('witness_name').text(WitnessName.get_name(name_fields));
    });
  },

  get_name: function(name_fields){
    var name = '';
    name_fields.each(function(){
      name += $(this).val() + ' ';
    });
    return name.toUpperCase();
  }
}
