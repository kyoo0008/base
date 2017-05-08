function TabMenu() {
	this.currentMenu = 1;

	this.start = function() {
		this.menuHead = document.getElementById(this.menuName).getElementsByTagName("h3");		
		this.menuLen = this.menuHead.length;
		
		for (var i = 1; i <= this.menuLen; i++) {
			this.menuLink = this.menuHead.item(i-1).getElementsByTagName("a")[0];
			this.menuLinkBtn = this.menuLink.getElementsByTagName("img")[0];

			if(i == this.currentMenu) {					
				document.getElementById(this.blockName + i).style.display ="block";
				if(document.getElementById(this.blockName + i + "more") != null)					
					document.getElementById(this.blockName + i + "more").style.display = "block";				
				this.menuLinkBtn.src = this.menuLinkBtn.src.replace("_off.", "_on.");			
			}else {
				document.getElementById(this.blockName + i).style.display ="none";
				if(document.getElementById(this.blockName + i + "more") != null)
					document.getElementById(this.blockName + i + "more").style.display = "none";
				this.menuLinkBtn.src = this.menuLinkBtn.src.replace("_on.", "_off.");
			}
			this.menuLink.i = i;
			this.menuLink.fnName = this.fnName;
			
			this.menuLink.onmouseover = this.menuLink.onfocus =	function() {
				eval( this.fnName + ".mouseOver(" + this.i +")")					
			}
			this.menuLink.onclick =	function() {
				return false;				
			}
		}
	}
	
	this.mouseOver = function(val) {
		
		for(var i = 1; i <= this.menuLen; i++) {
			this.menuLink = this.menuHead.item(i-1).getElementsByTagName("a")[0];
			this.menuLinkBtn = this.menuLink.getElementsByTagName("img")[0];
			//alert(this.blockName);
			if( i == val) {
				//alert(this.blockName);
				document.getElementById(this.blockName + i).style.display = "block";
				if(document.getElementById(this.blockName + i + "more") != null)					
					document.getElementById(this.blockName + i + "more").style.display = "block";
				this.menuLinkBtn.src = this.menuLinkBtn.src.replace("_off.", "_on.");
				//alert(val + "|" + i + "|" +this.menuLinkBtn.src);
			}else {
				document.getElementById(this.blockName + i).style.display = "none";
				if(document.getElementById(this.blockName + i + "more") != null)
					document.getElementById(this.blockName + i + "more").style.display = "none";
				this.menuLinkBtn.src = this.menuLinkBtn.src.replace("_on.", "_off.");
			}
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
			btn.src = btn.src.replace('_off.png', '_on.png');
			panel.className = 'on';
			panel.style.display="block";
		} else {
			btn.src = btn.src.replace('_on.png', '_off.png');
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
	btn.src = btn.src.replace('_on.png', '_off.png');
	panelNum1 += 1;
	panel = document.getElementById('pop'+panelNum1);
	btn = document.getElementById('popBtn'+panelNum1);
	if (!panel) {
		panelNum1 = 1;
		panel = document.getElementById('pop'+panelNum1);
		btn = document.getElementById('popBtn'+panelNum1);
	}
	btn.src = btn.src.replace('_off.png', '_on.png');
	panel.className = 'on';	
	panel.style.display="block";
}