$(document).ready(function(){	
	$("#side_button").click(function () {
		if(!$(this).data("status")) {
			$( "#fixed" ).animate({left:0},300);
			$(this).css({background:'url(/cait/str/cre/lyt/tmplat/sit/LYTTMP_0000000000003/images/common/close.png) no-repeat'}).animate({top:'20px'},300);
			$(this).data("status","over");
		}else {
			$( "#fixed" ).animate({left:'-74px'},300);
			$(this).css({"background":"url(/cait/str/cre/lyt/tmplat/sit/LYTTMP_0000000000003/images/common/open.png) no-repeat"}).animate({top:'110px'},300);
			$(this).data("status","");
		}
	});
});
function MainMenu() {
	
	this.start = function() {
		this.menuBox = document.getElementById("lnb").getElementsByTagName("ul")[0].childNodes;
		this.menuLen = this.menuBox.length;
	
		//alert(this.menuLen);
		
		for( var i=0; i < this.menuLen; i++) {
			if(this.menuBox.item(i).tagName != "LI") {continue;}
			this.menuLink = this.menuBox.item(i).getElementsByTagName("a")[0];
			this.menuLink.i = i;
			this.menuLink.onmouseover = this.menuLink.onfocus = 
				function() { eval(mMenu.mouseOver(this.i));  };
		
		}
	};
	
	this.mouseOver = function(val) {
		
		for ( var i = 0; i < this.menuLen; i++) {
			if(this.menuBox.item(i).tagName != "LI") {continue;}
			this.subList = this.menuBox.item(i).getElementsByTagName("div")[0];
			
			
			if(i == val) {
				this.subList.style.display = "block";
			} else {
				this.subList.style.display = "none";
			}
		}
		
	};
	
}
/* main_banner */ 
function changeServicePanel(idx) {
	panelNum = idx;
	rollingOff();
	for (var i=1; i<=20; i++) {
		var btn = document.getElementById('popBtn'+i);
		var panel = document.getElementById('pop'+i);
		if (!btn) {
			break;
		}
		if (idx == i) {
			btn.src = btn.src.replace('_off.gif', '_on.gif');
			panel.className = 'on';
			panel.style.display="block";
		} else {
			btn.src = btn.src.replace('_on.gif', '_off.gif');
			panel.className = '';
			panel.style.display="none";
			
		}
	}
}
/* main_banner */ 
function changeServicePanel(idx) {
	panelNum = idx;
	rollingOff();
	for (var i=1; i<=20; i++) {
		var btn = document.getElementById('popBtn'+i);
		var panel = document.getElementById('pop'+i);
		if (!btn) {
			break;
		}
		if (idx == i) {
			btn.src = btn.src.replace('_off.gif', '_on.gif');
			panel.className = 'on';
			panel.style.display="block";
		} else {
			btn.src = btn.src.replace('_on.gif', '_off.gif');
			panel.className = '';
			panel.style.display="none";
			
		}
	}
}
var panelNum1 = 1;
function rollingPanel() {
	var panel = document.getElementById('pop'+panelNum1);
	var btn = document.getElementById('popBtn'+panelNum1);
	panel.className = '';
	panel.style.display="none";
	btn.src = btn.src.replace('_on.gif', '_off.gif');
	panelNum1 += 1;
	panel = document.getElementById('pop'+panelNum1);
	btn = document.getElementById('popBtn'+panelNum1);
	if (!panel) {
		panelNum1 = 1;
		panel = document.getElementById('pop'+panelNum1);
		btn = document.getElementById('popBtn'+panelNum1);
	}
	btn.src = btn.src.replace('_off.gif', '_on.gif');
	panel.className = 'on';	
	panel.style.display="block";
}


$(document).ready(function() {
	$(".slide_banner").jCarouselLite({
		visible : 6,
		speed : 2000,
		auto : 800,
		playBtn : "#bn_start",
		stopBtn : "#bn_stop"
	});
});

