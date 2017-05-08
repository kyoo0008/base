 		var initCfgBackGround = false;	var transCfgBackGroundFlag = true;
 		var initCfgMenu = false;	var transCfgMenuResponseFlag = true;
 		var initCfgSite = false;	var transCfgSiteResponseFlag = true;
 		
 		function fn_egov_login_req() {
 			alert('로그인 하신 후 이용해주세요');
 			return false;
 		}
 		
 		jQuery(document).ready(function() {
			
			
			jQuery('#btnCfgBackGround').click(function() {	
				cfgCommonPopHide();
				if(jQuery('#btnCfgBackGround').attr('href') == '#') {
					return fn_egov_login_req();
				}
				
				if(initCfgBackGround) {
					//jQuery('#common_pop_bg').show();
					cfgCommonPopShow('common_pop_bg');
				} else if(transCfgBackGroundFlag) {
					/*
					jQuery.getJSON('/uss/ivp/cfg/selectComtnbcrnscrinList.do', function(data) {
						$.each(data, function(index, entry) {
							
						});
						jQuery('#common_pop_bg').append(data.html);
						jQuery('#common_pop_bg').show();
	                	initCfgBackGround = true;
						
					});
					*/
					transCfgBackGroundFlag = false;
		 			jQuery.ajax({
		                type: 'GET',
		                url: '/uss/ivp/cfg/selectComtnbcrnscrinList.do',
		                dataType: 'html',
		                success: function(html, textStatus) {
		                	jQuery('#common_pop_bg').append(html);
		                	jQuery('#common_pop_bg').show();
		                	initCfgBackGround = true;
		                },
		                error: function(xhr, textStatus, errorThrown) {
		                    alert('An error occurred! ' + ( errorThrown ? errorThrown :xhr.status ));
		                }
		            });
		 			transCfgBackGroundFlag = true;
		 			
		 			cfgCommonPopShow('common_pop_bg');
				}
				
				return false;
	        });
	        
	        jQuery('#btnCfgMenu').click(function() {
	        	cfgCommonPopHide();
	        	if(jQuery('#btnCfgMenu').attr('href') == '#') {
	        		return fn_egov_login_req();
				}
	        	if(initCfgMenu) {
					//jQuery('#common_pop_menu').show();
	        		cfgCommonPopShow('common_pop_menu');
				} else if(transCfgMenuResponseFlag) {
					transCfgMenuResponseFlag = false;
		 			jQuery.ajax({
		                type: 'GET',
		                url: '/uss/ivp/cfg/ComtnindvdlestbsList.do',
		                dataType: 'html',
		                success: function(html, textStatus) {
		                	jQuery('#common_pop_menu').append(html);
		                	jQuery('#common_pop_menu').show();
		                	initCfgMenu = true;
		                },
		                error: function(xhr, textStatus, errorThrown) {
		                	alert('An error occurred! ' + ( errorThrown ? errorThrown :xhr.status ));
		                }
		            });
		 			transCfgMenuResponseFlag = true;
		 			
		 			cfgCommonPopShow('common_pop_menu');
				}
				
				return false;
	        });
	        
	        jQuery('#btnCfgSite').click(function() {
	        	cfgCommonPopHide();
	        	if(initCfgSite) {
					//jQuery('#common_pop_site').show();
	        		cfgCommonPopShow('common_pop_site');
				} else if(transCfgSiteResponseFlag) {
					transCfgSiteResponseFlag = false;
		 			jQuery.ajax({
		                type: 'GET',
		                url: '/uss/ion/bnr/selectPortalBannerList.do',
		                dataType: 'html',
		                success: function(html, textStatus) {
		                	jQuery('#common_pop_site').append(html);
		                	jQuery('#common_pop_site').show();
		                	initCfgSite = true;
		                },
		                error: function(xhr, textStatus, errorThrown) {
		                	alert('An error occurred! ' + ( errorThrown ? errorThrown :xhr.status ));
		                }
		            });
		 			transCfgSiteResponseFlag = true;
		 			
		 			cfgCommonPopShow('common_pop_site');
				}
				
				return false;
	        });
	        
	        if(jQuery("#chained").length > 0) {
	        	jQuery("#chained").scrollable({circular: true, mousewheel: true}).navigator();
	        }
		});
 		
 		function cfgCommonPopHide() {
 			jQuery('#layer_blind_box').remove();
 			jQuery('#common_pop_bg').hide();
 			jQuery('#common_pop_menu').hide();
 			jQuery('#common_pop_site').hide();
 			return false;
        };
        
        function cfgCommonPopShow(id) {
        	jQuery('#wrapper').append("<div id='layer_blind_box' style='position:absolute; top:0; left:0; width:100%; height:100%; background:#000; z-index:50;'></div>");
        	jQuery('#layer_blind_box').css('opacity', 0.3);
        	//jQuery('#' + id).fadeIn(300);
        	jQuery('#' + id).css('z-index', 100);
        	jQuery('#' + id).show();
        }
 		
		function fn_egov_SelectBoxValue(sbName)
		{
			var FValue = "";
			for(var i=0; i < document.getElementById(sbName).length; i++)
			{
				if(document.getElementById(sbName).options[i].selected == true){
					
					FValue=document.getElementById(sbName).options[i].value;
				}
			}
			
			return  FValue;
		}
		
		function fn_egov_RadioBoxValue(sbName)
	  	{
	  		var FLength = document.getElementsByName(sbName).length;
	  		var FValue = "";
	  		for(var i=0; i < FLength; i++)
	  		{
	  			if(document.getElementsByName(sbName)[i].checked == true){
	  				FValue = document.getElementsByName(sbName)[i].value;
	  			}
	  		}
	  		return FValue;
	  	}
	    
		function fnGetCookiePopup( name, value, expiredays ) {
			var results = document.cookie.match ( '(^|;) ?' + name + '=([^;]*)(;|$)' );  
			  if ( results )    
				  return ( unescape ( results[2] ) );  
			 else    
				 return null;
		}
		
	    function fnSetCookiePopup( name, value, expiredays ) {
		  	  var todayDate = new Date();
		  	  todayDate.setDate( todayDate.getDate() + expiredays );
			  if(value != null) {
		  		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
			  } else {
				  document.cookie = name + "=; path=/; expires=" + todayDate.toGMTString() + ";";
			  }
		    }
	    
	    function fn_egov_popupOpen_PopupManage(popupId,fileUrl,width,height,top,left,stopVewAt){

	    	var url = "/uss/ion/pwm/openPopupManage.do?";
	    	url = url + "fileUrl=" + fileUrl;
	    	url = url + "&stopVewAt=" + stopVewAt;
	    	url = url + "&popupId=" + popupId;
	    	var name = popupId;
	    	var openWindows = window.open(url,name,"width="+width+",height="+height+",top="+top+",left="+left+",toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");
	    	
	    	if (window.focus) {openWindows.focus();}
	    }
	    
	    function fnTabListLoading(frmId, frmUrl) {
			var frm = document.getElementById(frmId);
			if(frm) {
				if(frm.src == "about:blank") {
					frm.src = frmUrl;
				}
			}
		}
	    
	    function initTabMenu(tabContainerID) {
	    	var tabContainer = document.getElementById(tabContainerID);
	    	var tabAnchor = tabContainer.getElementsByTagName("a");
	    	var i = 0;
	     
	    	for(i=0; i<tabAnchor.length; i++) {
	    		if (tabAnchor.item(i).className == "tab")
	    			thismenu = tabAnchor.item(i);
	    		else
	    			continue;
	     
	    		thismenu.container = tabContainer;
	    		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
	    		thismenu.targetEl.style.display = "none";
	    		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
	     
	    		thismenu.onclick = function tabMenuClick() {
	    			currentmenu = this.container.current;
	    			if (currentmenu == this)
	    				return false;
	     
	    			if (currentmenu) {
	    				currentmenu.targetEl.style.display = "none";
	    				if (currentmenu.imgEl) {
	    					currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
	    				} else {
	    					currentmenu.className = currentmenu.className.replace(" on", "");
	    				}
	    			}
	    			this.targetEl.style.display = "";
	    			if (this.imgEl) {
	    				this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
	    			} else {
	    				this.className += " on";
	    			}
	    			this.container.current = this;
	     
	    			return true;
	    		};
	    		thismenu.onfocus = function tabMenuClick() {
	    			currentmenu = this.container.current;
	    			if (currentmenu == this)
	    				return false;
	     
	    			if (currentmenu) {
	    				currentmenu.targetEl.style.display = "none";
	    				if (currentmenu.imgEl) {
	    					currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
	    				} else {
	    					currentmenu.className = currentmenu.className.replace(" on", "");
	    				}
	    			}
	    			this.targetEl.style.display = "";
	    			if (this.imgEl) {
	    				this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
	    			} else {
	    				this.className += " on";
	    			}
	    			this.container.current = this;
	     
	    			return true;
	    		};
	    		if (!thismenu.container.first)
	    			thismenu.container.first = thismenu;
	    	}
	    	if (tabContainer.first)
	    		tabContainer.first.onclick();
	     
	    }

	    function initLayerTabMenu(tabContainerID, tabClassName) {
	    	var tabContainer = document.getElementById(tabContainerID);
	    	var tabAnchor = tabContainer.getElementsByTagName("a");
	    	var i = 0;
	     
	    	for(i=0; i<tabAnchor.length; i++) {
	    		//if (tabAnchor.item(i).className == "toptab")
	    		if (tabAnchor.item(i).className == tabClassName)
	    		{
	    			thismenu = tabAnchor.item(i);
	    		}
	    		else
	    			continue;
	     
	    		thismenu.container = tabContainer;
	    		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
	    		thismenu.targetEl.style.display = "none";
	    		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
	     
	    		thismenu.onclick = function tabMenuClick() {
	    			currentmenu = this.container.current;
	    			if (currentmenu == this)
	    				return false;
	     
	    			if (currentmenu) {
	    				currentmenu.targetEl.style.display = "none";
	    				if (currentmenu.imgEl) {
	    					currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
	    				} else {
	    					currentmenu.className = currentmenu.className.replace(" on", "");
	    				}
	    			}
	    			this.targetEl.style.display = "";
	    			if (this.imgEl) {
	    				this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
	    			} else {
	    				this.className += " on";
	    			}
	    			this.container.current = this;
	     
	    			return true;
	    		};
	    		thismenu.onfocus = function tabMenuClick() {
	    			currentmenu = this.container.current;
	    			if (currentmenu == this)
	    				return false;
	     
	    			if (currentmenu) {
	    				currentmenu.targetEl.style.display = "none";
	    				if (currentmenu.imgEl) {
	    					currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
	    				} else {
	    					currentmenu.className = currentmenu.className.replace(" on", "");
	    				}
	    			}
	    			this.targetEl.style.display = "";
	    			if (this.imgEl) {
	    				this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
	    			} else {
	    				this.className += " on";
	    			}
	    			this.container.current = this;
	     
	    			return true;
	    		};
	    		if (!thismenu.container.first)
	    			thismenu.container.first = thismenu;
	    	}
	    	if (tabContainer.first)
	    		tabContainer.first.onclick();
	     
	    }

		