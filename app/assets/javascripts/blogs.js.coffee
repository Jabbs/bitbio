jQuery ->
  $('.blog-list-item').mouseenter ->
    $(this).children().removeClass('black')
    $(this).children().addClass('bluee')
  $('.blog-list-item').mouseleave ->
    $(this).children().addClass('black')
    $(this).children().removeClass('bluee')