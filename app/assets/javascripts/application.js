// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require rails-ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require datetimepicker


$(document).ready(function() {
  $(".alert").delay(4000).slideUp(200, function() {
    $(this).alert('close');
  });

  $('#dateIniPick').datetimepicker({
    format: 'DD/MM/YYYY',
    ignoreReadonly: true,
    allowInputToggle: true
  });

  $(document).on('click','input[id^="status-check-"]', {} ,function(e) {
    var list_id = $(this).attr('id').split("-")[2]
    var task_id = $(this).attr('id').split("-")[3]
    
    if($(this).is(':checked')) {
      console.log($(this).attr('id').split("-")[2] + "- CHECKED");
      $(this).css({'display': 'none'});
      $(this).after('<span class="fa fa-spinner fa-spin fa-sm"></span>');

      $.post( `/lists/${list_id}/tasks/${task_id}`, {
        '_method': 'PATCH',
        'task': { 'status': '1' }
      });

    } else {
      console.log($(this).attr('id').split("-")[2] + "- UNCHECKED");
      $(this).css({'display': 'none'});
      $(this).after('<span class="fa fa-spinner fa-spin fa-sm"></span>');

      $.post( `/lists/${list_id}/tasks/${task_id}`, {
        '_method': 'PATCH',
        'task': { 'status': '0' }
      });
    }
  })
});



