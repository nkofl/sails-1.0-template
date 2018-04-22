$ ->
  pathname = window.location.pathname
  $(".navbar-nav > li > a[href='#{pathname}']").parent().addClass('active')

  if $("meta[name='no-nav-img']").attr("content")
    $('#top-nav').addClass('bg-dark')
    $('#top-nav').removeClass('bg-trans')
    $('#nav-search').removeClass('d-none')
    $('.main-page').css({"padding-top": 70})
  else if $("meta[name='search-nav-img']").attr("content")
    $(window).scroll () ->
      if $(this).scrollTop() > 200
        $('#top-nav').addClass('bg-dark')
        $('#top-nav').removeClass('bg-trans')
        $('#nav-search').removeClass('d-none')
      else
        $('#top-nav').addClass('bg-trans')
        $('#top-nav').removeClass('bg-dark')
        $('#nav-search').addClass('d-none')
  else
    $('#nav-search').removeClass('d-none')
    $(window).scroll () ->
      if $(this).scrollTop() > 200
        $('#top-nav').addClass('bg-dark')
        $('#top-nav').removeClass('bg-trans')
      else
        $('#top-nav').addClass('bg-trans')
        $('#top-nav').removeClass('bg-dark')

