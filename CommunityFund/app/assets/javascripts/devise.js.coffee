# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#fancy validators for username, email and password

#every single time there is a text input, try to validate and give feedback to user

#todo: make it turn to fail state when user deletes input after getting to a success state
jQuery ->
  $('#signup-username-input').bind 'input', (->
    value = $(this).val() # get the current value of the input field.
    #change warning to success if value is over 5
    if value.length > 5
      $("#signup-username").attr("class","form-group has-success")
      $("#signup-username-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
    else if value != ""
      $("#signup-username").attr("class","form-group has-error")
      $("#signup-username-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
  .trigger('input');

  $('#signup-email-input').bind 'input', (->
    value = $(this).val() # get the current value of the input field.
    #change warning to success if it fits a nice email regex
    re = /\S+@\S+\.\S+/;
    if re.test(value) == true
      $("#signup-email").attr("class","form-group has-success")
      $("#signup-email-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
    else if value != ""
      $("#signup-email").attr("class","form-group has-error")
      $("#signup-email-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
  .trigger('input');

  $('#signup-password-input').bind 'input', (->
    value = $(this).val() # get the current value of the input field.
    #change warning to success if password is 7 chars long
    if value.length > 7
      $("#signup-password").attr("class","form-group has-success")
      $("#signup-password-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
    else if value != ""
      $("#signup-password").attr("class","form-group has-error")
      $("#signup-password-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
  .trigger('input');

  $('#signup-password-confirm-input').bind 'input', (->
    value = $(this).val() # get the current value of the input field.
    #change warning to success if password confirm is the same as password
    if $('#signup-password-input').val() == value and value != ""
      $("#signup-password-confirm").attr("class","form-group has-success")
      $("#signup-password-confirm-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
    else if value != ""
      $("#signup-password-confirm").attr("class","form-group has-error")
      $("#signup-password-confirm-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
  .trigger('input');