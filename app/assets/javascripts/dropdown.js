$(window).on('turbolinks:load', function(){
  $('.Review__head__setting i').click(function() {
    // メニュー表示/非表示
    $(this).next('.Review__head__setting__menu').slideToggle('fast');
  });

  var over_flg;

  // マウスカーソルの位置（メニュー上/メニュー外）
  $('.Review__head__setting i,.Review__head__setting__menu').hover(function(){
    over_flg = true;
  }, function(){
    over_flg = false;
  });

  // メニュー領域外をクリックしたらメニューを閉じる
  $('body').click(function() {
    if (over_flg == false) {
      $('.Review__head__setting__menu').slideUp('fast');
    }
  });
});

$(window).on('turbolinks:load', function(){
  $('.UserIcon__pic').click(function() {
    // メニュー表示/非表示
    $(this).next('.UserIcon__menu').slideToggle('fast');
  });

  var over_flg;

  //　マウスカーソルの位置（メニュー上/メニュー外）
  $('.UserIcon__pic,.UserIcon__menu').hover(function(){
    over_flg = true;
  }, function(){
    over_flg = false;
  });

  // メニュー領域外をクリックしたらメニューを閉じる
  $('body').click(function() {
    if (over_flg == false) {
      $('.UserIcon__menu').slideUp('fast');
    }
  });
});
