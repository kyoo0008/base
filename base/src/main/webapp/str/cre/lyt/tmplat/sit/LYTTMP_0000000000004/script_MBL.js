function tick(){
		$('.no_box li:first').slideUp( function () { $(this).appendTo($('.no_box')).slideDown(); });
	}
	setInterval(function(){ tick () }, 4000);

// 서브 메뉴 스크립트

$(document).ready(function(){
	$(".style_1").hide();
	$(".style_2").hide();
	$(".style_3").hide();
	$(".menu_1").click(function() {
		repalceNavImg(1);
	});
	$(".menu_2").click(function() {
		repalceNavImg(2);
	});
	$(".menu_3").click(function() {
		repalceNavImg(3);
	});
	$(".menu_4").click(function() {
		repalceNavImg(4);
	});
	$(".menu_5").click(function() {
		repalceNavImg(5);
	});
	$(".menu_6").click(function() {
		repalceNavImg(6);
	});
	$(".menu_7").click(function() {
		repalceNavImg(7);
	});
	$(".menu_8").click(function() {
		repalceNavImg(8);
	});
	$(".menu_9").click(function() {
		repalceNavImg(9);
	});
});

function repalceNavImg(num) {
	for (i=1; i <=9; i++) {
		if(num != i) {			
			$(".sub_wrap_" + i).hide();
		}else {
			$(".sub_wrap_" + i).toggle();
		}
	}
}