class @GroupAvatar
  constructor: ->
    $('.js-choose-group-avatar-button').bind "click", ->
      form = $(this).closest("form")
      form.find(".js-group-avatar-input").click()
    $('.js-group-avatar-input').bind "change", ->
      form = $(this).closest("form")
      filename = $(this).val().replace(/^.*[\\\/]/, '')
      form.find(".js-avatar-filename").text(filename)
