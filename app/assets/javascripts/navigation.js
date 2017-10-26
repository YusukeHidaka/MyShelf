$(window).on('turbolinks:load', function(){
  $('.Header__navi__item a').each(function(){
    var $href = $(this).attr('href');
    if($(location).attr('pathname') == $href) {
      $(this).addClass('active');
    } else {
      $(this).removeClass('active');
    }
  });

  $('.Counter__item a').each(function(){
    var $href = $(this).attr('href');
    var current_path;
    if ($(location).attr('search') == "") {
      current_path = $(location).attr('pathname');
    } else {
      current_path = $(location).attr('pathname') + $(location).attr('search');
    }

    if(current_path == $href) {
      $(this).addClass('active');
    } else {
      $(this).removeClass('active');
    }
  });
});
