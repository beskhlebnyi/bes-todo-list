$(document).on('turbolinks:load', function () {
  $(".login-box").slideDown(800);
});

$(document).on('turbolinks:load', function() {
  $(".submit-login").click(function () {
    $(".login-box").slideUp(800);
  });

  $(".disapear").click(function () {
    $(".login-box").hide();
  });

  $(".alert").delay(4000).slideUp(200, function() {
    $(this).alert('close');
  });
});
