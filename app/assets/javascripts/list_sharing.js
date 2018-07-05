$(document).ready(function() {
  $(document).on('click','.finded-user', {} ,function(e) {
    let userId = this.dataset.user_id
    let userEmail = this.dataset.user_email

    $(`<div class="added-user" data-user_id="${userId}">${userEmail}</div>`).appendTo("#chosen-users")
    $(`<input name="shared_user_ids[]" value="${userId}" type="hidden">`).appendTo('#list-form')
  })
})