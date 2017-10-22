$(function () {
  $('.UserIcon__pic').click(function() {
    // メニュー表示/非表示
    $(this).next('ul').slideToggle('fast');
  });

  //　マウスカーソルの位置（メニュー上/メニュー外）
  $('.UserIcon__pic,ul').hover(function(){
    over_flg = true;
  }, function(){
    over_flg = false;
  });

  // メニュー領域外をクリックしたらメニューを閉じる
  $('body').click(function() {
    if (over_flg == false) {
      $('ul').slideUp('fast');
    }
  });
});
