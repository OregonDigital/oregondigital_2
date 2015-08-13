jQuery ->
  $("*[data-toggle-field]").click (e) ->
    e.preventDefault()
    field = $(this).attr("data-toggle-field")
    $("##{field}").toggleClass("hidden")
    $(this).toggleClass("active")
