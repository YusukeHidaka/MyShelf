$(window).on('turbolinks:load', function(){

  var modals = document.getElementsByClassName( "Modal" );
  for(var k=0,l=modals.length; l>k; k++){
    // modalにidを付与
    modals[k].setAttribute('id', "modal-content-" + k);
  };

  var modal_buttons = document.getElementsByClassName( "modal-button" );
  for(var i=0,l=modal_buttons.length; l>i; i++){
    // buttonにdata-targetを付与
    modal_buttons[i].setAttribute('data-target', "modal-content-" + i);
  	modal_buttons[i].onclick = function(){
      var status = $(this).data("status")
      // modal表示のための記述
      var nowModalSyncer;
      modal_setting(this);
    }
  }

  function modal_setting(that) {
    that.blur();
    var target = that.getAttribute( "data-target" );
    if( typeof( target )=="undefined" || !target || target==null ){
      return false;
    }

    nowModalSyncer = document.getElementById( target );
    if( nowModalSyncer == null ){
      return false;
    }

    $( "body" ).append( '<div id="modal-overlay"></div>' );
  	$( "#modal-overlay" ).fadeIn( "fast" );

  	centeringModalSyncer();

	$( nowModalSyncer ).fadeIn( "slow" );
	$( "#modal-overlay,#modal-close" ).unbind().click( function() {
		$( "#" + target + ",#modal-overlay" ).fadeOut( "fast" , function() {
			$( '#modal-overlay' ).remove();
		});
  	nowModalSyncer = null;
  	});
  }

  $( window ).resize( centeringModalSyncer );
  function centeringModalSyncer() {
    if( nowModalSyncer == null ) return false;
    var w = $( window ).width();
    var h = $( window ).height();
    var cw = $( nowModalSyncer ).outerWidth();
    var ch = $( nowModalSyncer ).outerHeight();
    $( nowModalSyncer ).css( {"left": ((w - cw)/2) + "px","top": ((h - ch)/2) + "px"} );
  }
});
