$(document).ready(function() {
  var show_result = function(evt, data, status, xhr){
    $(this).find('.result').show().html(xhr.responseText);
  };

  $(".querybox").bind("ajax:success", show_result);

  $("#clear").click(function() {
    $('.result').hide().empty();
  });
});
