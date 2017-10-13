$(window).on('load', function() {
  console.log('久々やな、こーゆうの')
  var timer;
  var preInput = "";

  ajaxSearch = function(input) {
    $.ajax({
      url: "/original_books/search",
      type: "GET",
      dataType: 'script',                          // jsファイルを指定したいので、dataTypeをscriptに指定
      data: ("keyword=" + input)
    });
  };

  triggerAjax = function(input) {
    if(preInput !== input){                        //文字列が変更ときのみメソッド実行する
      console.log('検索メソッド実行')
      clearTimeout(timer);
      timer = setTimeout(ajaxSearch, 500, input); // 処理を500ms毎に実行
    };
  };


  $('#book_search').on('keyup', function() {
    input = $.trim($(this).val());                // 文字列の先頭と末尾の空白を削除
    console.log('keyupに応じて切り取る。')
    triggerAjax(input);
    preInput = input;
  });
});
