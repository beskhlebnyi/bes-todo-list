$(document).on('turbolinks:load', function () {
  $(".login-box").slideDown(800);
  
  $(".alert").delay(4000).slideUp(200, function() {
    $(this).alert('close');
  });

});
