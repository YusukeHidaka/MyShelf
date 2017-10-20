$(document).on('turbolinks:load',function(){
  var like_buttons = document.getElementsByClassName( "like-buttons" );
  for(var k=0,l=like_buttons.length; l>k; k++){
     like_buttons[k].onclick = function(){
       var status = $(this).data("status")
       // modal表示のための記述
       modal_setting(this);
     }
  };

  var unlike_buttons = document.getElementsByClassName( "unlike-buttons" );
  for(var k=0,l=modals.length; l>k; k++){
    // modalにidを付与
     modals[k].setAttribute('id', "modal-content-" + k);
  };
});
