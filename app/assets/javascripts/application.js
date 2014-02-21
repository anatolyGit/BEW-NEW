// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery-2.0.3.min
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery.remotipart
//= require_tree .

$(document).ready(function(){
	$(" #logoutNavi li").hover(function(){
		$(this).find('ul:first').css({visibility: "visible",display: "none"}).show(250);
		},function(){
		$(this).find('ul:first').css({visibility: "hidden"});
	}); 
	$(".action").click(
		function() {
			working(this);
		}
	);
	new Tablesort(document.getElementById('sort'));
});

function working(this1)
{
	if (!$(this1).hasClass("inprogress")) {
			$(this1).attr("title", $(this1).html());
			if ($(this1).hasClass("status16") || $(this1).hasClass("status19")) {
				$(this1).html("着手中");
				//$(this).removeClass("status16");
			} else if ($(this1).hasClass("status17"))
			{
				$(this1).html("画像準備中");
			} else if ($(this1).hasClass("status5"))
			{
				$(this1).html("Wチェック中");
			} else if ($(this1).hasClass("status21"))
			{
				$(this1).html("修正中");
			} else if ($(this1).hasClass("status3"))
			{
				$(this1).html("修正中");
			}
			 else if ($(this1).hasClass("status22"))
			{
				$(this1).html("Dirチェック中");
			} else if ($(this1).hasClass("status5"))
			{
				$(this1).html("Wチェック中");
			} else if ($(this1).hasClass("status24"))
			{
				$(this1).html("Dir作業中");
			} else if ($(this1).hasClass("status12"))
			{
				$(this1).html("リリース前チェック中");
			} else if ($(this1).hasClass("status29"))
			{
				$(this1).html("Dirリリース前チェック中");
			} else if ($(this1).hasClass("status14"))
			{
				$(this1).html("リリース後チェック中");
			} else if ($(this1).hasClass("status30"))
			{
				$(this1).html("Dirリリース後チェック中");
			} 


			$(this1).addClass("inprogress");

			$( "#dialog" ).on( "dialogclose", function( event, ui ) {
				$(".inprogress").each(function() {
					$(this1).html($(this1).attr("title"));
					$(this1).removeAttr("title");
					$(this1).removeClass("inprogress");
				});
				 
			} );
			return true;
		} else {
			return false;
		}
}