$ ->
  root = $('#matrixHQ').attr('href')
  $('.view-group-progress').click (event) ->
    event.preventDefault()
    group = $('#progress_group_id').val()
    if '' == group || null == group then alert 'Сначала необходимо выбрать группу.' else document.location = "#{root}study/group/#{group}/progress"



  $('#disciplines_for_group').change ->
    discipline = $(this).children(":selected").val()
    group = $('#progress_group').val()
    window.location.href = if discipline then "#{root}study/group/#{group}/progress/discipline/#{discipline}" else "#{root}study/group/#{group}/progress"