$(document).ready(function(){
	$(".slidebox > a").mouseover(function(){
		$(this).parents(".slidebox").stop().animate({top:"-381px"}, {duration:500});
		$(this).parents("li").mouseleave(function(){
			$(this).children(".slidebox").stop().animate({top:"0px"}, {duration:500});
		});
		return false;
	});
});