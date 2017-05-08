	    
	    function fnGetCookie(name) {
	    	/*
	  	  var prefix = name + "=";

	  	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  	  if (cookieStartIndex == -1) return null;
	  	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
	  	  */
	    	var results = document.cookie.match ( '(^|;) ?' + name + '=([^;]*)(;|$)' );  
			  if ( results )    
				  return ( unescape ( results[2] ) );  
			 else    
				 return null;
	    }
	    
	    function fnGetCookiePopup(name) {
	    	/*
	  	  var prefix = name + "=";

	  	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  	  if (cookieStartIndex == -1) return null;
	  	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
	  	  */
	    	var results = document.cookie.match ( '(^|;) ?' + name + '=([^;]*)(;|$)' );  
			  if ( results )    
				  return ( unescape ( results[2] ) );  
			 else    
				 return null;
	    }
	    
	    
	    
	    function fnSetCookieValue(name, value) {
	    	var expireDate = new Date();
	    	expireDate.setFullYear(expireDate.getFullYear() + 1);
	    	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expireDate.toGMTString() + ";";
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
	    
	    function fnImagePreview(url) {
    		var URL 	=	'';
    		var winNM	=	'Preview';
    		var OPT		=	'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=no,resizable=0,top=30,left=30,copyhistory=0 width=1024 height=859';		
    		var imgwin = window.open(URL,winNM,OPT);	

    		var what = url;
    		imgwin.focus(); 

    		 imgwin.document.open(); 

    		 imgwin.document.write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>\n");  
    		 imgwin.document.write("<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n");

    		 imgwin.document.write("<title>크게보기</title>\n");   // 새창으로 페이지 제목

    		 imgwin.document.write("<sc"+"ript>\n"); 

    		 imgwin.document.write("function resize() {\n"); 

    		 imgwin.document.write("pic = document.il;\n"); 

    		 imgwin.document.write("if (eval(pic).height) { var name = navigator.appName\n"); 

    		 imgwin.document.write("  if (name == 'Microsoft Internet Explorer') { myHeight = eval(pic).height + 60;  myWidth = eval(pic).width + 10;\n"); 

    		 imgwin.document.write("  } else { myHeight = eval(pic).height + 56; myWidth = eval(pic).width + 8; }\n"); 

    		 imgwin.document.write("  clearTimeout();\n"); 

    		 imgwin.document.write("  var height = screen.height;\n"); 

    		 imgwin.document.write("  var width = screen.width;\n"); 

    		 imgwin.document.write("  var leftpos = width / 2 - myWidth / 2;\n"); //hjhj

    		 imgwin.document.write("  var toppos = height / 2 - myHeight / 2; \n"); 

    		 imgwin.document.write("  self.moveTo(leftpos, toppos);\n"); 

    		 imgwin.document.write("  self.resizeTo(myWidth, myHeight);\n"); 

    		 imgwin.document.write("}else setTimeOut(resize(), 100);}\n"); 

    		 imgwin.document.write("</sc"+"ript>\n"); 

    		 imgwin.document.write("</head><body style='margin:0px;padding:0px'>\n"); 

    		 imgwin.document.write("<img border=0 src="+what+" xwidth='100' xheight='9' name='il' onload='resize();' alt='이미지를 클릭하시면 창이 닫힙니다.' title='이미지를 클릭하시면 창이 닫힙니다.' onclick='javascript:window.close()' />\n"); 

    		 imgwin.document.write("</body></html>\n"); 

    		 imgwin.document.close();
    	}
	    
	    function goUrl(value) {
		  	var obj = document.getElementById("sLink"+value);
		  	if(value != "") {
		  		if(obj.value == "") {
		  			alert("사이트를 선택하세요"); return false;	
		  		}
		  		window.open(obj.value);
		  	}
		  }


	    function fn_byte_convert(val) {
	    	var size = "0 KB";

            if (val >= 1073741824)
                size = fn_comma(round(val / 1073741824, 2)) + " GB";
            else if (val >= 1048576)
                size = fn_comma(round(val / 1048576, 2)) + " MB";
            else if (val >= 1024)
                size = fn_comma(round(val / 1024, 2)) + " KB";
            else if (val > 0 && round(val < 1024, 2))
                size = "1 KB";

            return size;
	    }
	    
	    function round(n, digits) {
	    	var factor = Math.pow(10, digits); // 정수부 반올림
	    	var increment = 5/(factor*10);

	    	return Math.floor((n+increment)*factor)/factor;
    	}

	    	
		function fn_comma(n) {
			var reg = /(^[+-]?\d+)(\d{3})/;
			n += '';
			while (reg.test(n)) {
				n = n.replace(reg, '$1' + ',' + '$2');
			}
			
			return n;
		}
		
	    function fn_egov_editor_file_add(userFile, editorId) {
	    	var list = "";
                list += "<tr id='" + userFile.AtchFileId + '_' + userFile.FileSn + "'>";
                list += "<td><img src='/template/manage/images/ico_file.gif' alt='파일'/> " + userFile.FileName + "</td>";
                list += "<td class='size'>" + fn_byte_convert(userFile.FileSize) + "</td>";
                list += "<td class='del'><a href=\"/cmm/fms/deleteStreamLongFile.do?tmprFileId=" + userFile.TmprFileId + "\" onclick=\"fn_egov_editor_tmpr_file_del('" + editorId + "','" + userFile.TmprFileId + "');return false;\"><img src=\"/template/manage/images/btn_sdelete.gif\"/></a></td>";
                list += "</tr>";
            
            $('#fileGroupId_' + editorId).val(userFile.AtchFileId);
            $('#fileCurrSize_' + editorId).val(userFile.TotalFileMg);
            $('#fileCurrCount_' + editorId).val(userFile.TotalFileCount);
            
            $('#multiFileList_' + editorId).append(list);
           
            if(userFile.IsEdit == 'True') {
            	$('#' + userFile.AtchFileId + '_' + userFile.OriginFileSn).remove();
            }
            
            fn_egov_file_clean_action(editorId);
	    }
	    
	    function fn_egov_editor_tmpr_file_del(editorId, tmprFileId) {
	    	
	    	if(confirm('삭제하시면 본문에서도 삭제됩니다. 계속하시겠습니까?')) {	    		
	    		var url = "/cmm/fms/deleteStreamLongFileByAjax.do?tmprFileId=" + tmprFileId;	    		
	    		$.getJSON(url, function(data) {
	    			if(data.delCount > 0) {
	    				fn_egov_editor_file_del_action(data, editorId);
	    			}
	    		})
	    		.success(function() {})
	    		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
	    		.complete(function() {});
	    	}
	    }
	    
	    function fn_egov_editor_file_del(editorId, estnAt, progrmId, atchFileId, fileSn) {
	    	
	    	if(confirm('삭제하시면 본문에서도 삭제됩니다. 계속하시겠습니까?')) {	    		
	    		var url = "/cmm/fms/deleteFileInfByAjax.do?estnAt=" + estnAt + "&progrmId=" + progrmId + "&atchFileId=" + atchFileId + "&fileSn=" + fileSn;	    		
	    		
	    		$.getJSON(url, function(data) {
	    			if(data.delCount > 0) {
	    				fn_egov_editor_file_del_action(data, editorId);
	    			}
	    		})
	    		.success(function() {})
	    		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
	    		.complete(function() {});
	    	}
	    }
	    
	    function fn_egov_editor_file_del_action(data, editorId) {
	    	
	    	$('#fileCurrSize_' + editorId).val(data.totalFileMg);
            $('#fileCurrCount_' + editorId).val(data.totalFileCount);
	    	$('#' + data.atchFileId + '_' + data.fileSn).remove();			
			tinyMCE.activeEditor.dom.remove(tinyMCE.activeEditor.dom.select('[class=' + data.atchFileId + '_' + data.fileSn + ']'));
			fn_egov_file_clean_action(editorId);
	    }
	    
	    function fn_egov_file_clean_action(editorId) {
	    	if($('#multiFileList_' + editorId).children().length == 1) {
	    		$('#tr_file_empty_' + editorId).show();
	    	} else {
	    		$('#tr_file_empty_' + editorId).hide();
	    	}
	    	
	    	$('#lblMaxCount_' + editorId).html($('#posblAtchFileNumber_' + editorId).val());
	    	$('#lblMaxSize_' + editorId).html(fn_byte_convert($('#posblAtchFileSize_' + editorId).val()));
	    	$('#lblCurrCount_' + editorId).html($('#fileCurrCount_' + editorId).val());
	    	$('#lblCurrSize_' + editorId).html(fn_byte_convert($('#fileCurrSize_' + editorId).val()));
	    }
	    
	    function fn_egov_downFile(url) {
	    	window.open(url);
	    }
	    
	    var nowZoom = 100;
		function zoomIn() {
			nowZoom = nowZoom - 10;
			if(nowZoom <= 70) nowZoom = 70;
			zooms();
		}


		function zoomOut() {
				nowZoom = nowZoom + 20;
				if(nowZoom >= 500) nowZoom = 500;
				zooms();
		}
		
		function zoomReset(){
			nowZoom = 100; 
			zooms();
		}
		
		function zooms(){
			document.body.style.zoom = nowZoom + '%';
		
			if(nowZoom==70){
				alert ("30%축소 되었습니다. 더 이상 축소할 수 없습니다.");
			}
			
			if(nowZoom==500){
				alert ("500%확대 되었습니다. 더 이상 확대할 수 없습니다.");
			}
		}
		
		function fnTotalSearch(form) {
	  		var searchCnd = $('#searchCnd option:selected').val();
	  		var searchWrd = $.trim($('#searchWrd').val());
	  			
			if(searchWrd == "") {
				alert("검색어를 입력해주세요");
				$('#searchWrd').focus();
				return false;
			}
			
			if(searchWrd.length < 2) {
				alert("검색어는 2자 이상 입력해주세요");
				$('#searchWrd').focus();
				return false;
			}
			
			if(searchCnd == 'bbs') {
				form.action = "/sch/bbsSearch.do";
			} else if(searchCnd == 'vod') {
				form.action = "/sch/vodSearch.do";
			} else if(searchCnd == 'cmy') {
				form.action = "/sch/cmySearch.do";
			}
	  	}
		
		function commonPopShow(id) {
        	$('#wrapper').append("<div id='layer_blind_box' style='position:absolute; top:0; left:0; width:100%; height:100%; background:#000; z-index:50;'></div>");
        	$('#layer_blind_box').css('opacity', 0.3);
        	//jQuery('#' + id).fadeIn(300);
        	$('#' + id).css('z-index', 100);
        	$('#' + id).fadeIn();
        }
        
        function commonPopHide(id) {
 			$('#layer_blind_box').remove();
 			$('#' + id).fadeOut();
        };
        
        var token = "";
        var loginYn = "";
        $(function(){ 
        	$.getJSON('/uat/uia/selectLoginInfo.do', function(data) {
        		token = data.token;
        		loginYn = data.loginYn;
    		})
    		.success(function() {})
    		.error(function() {})
    		.complete(function() {});
        	
        	$('a').click(function() {
        		ssoLinkAction(this);
        	});
        });
        
        function ssoLinkAction(aObj) {
	        if(token != "" && loginYn == "Y" && aObj.href.indexOf('javascript') == -1 && aObj.href.indexOf(document.domain) == -1) {
	    		var makeUrl = aObj.href;	
	    		if(aObj.href.indexOf('token') == -1) {
					makeUrl = aObj.href + (aObj.href.indexOf('?') == -1 ? '?' : '&') + 'token=' + token;
				}	        		
	    		aObj.href = makeUrl;
	    	}
        }
        
        /*******************************************************************************
         * Tab Button 처리 
         * by moon
         */
        (function($) {  
        	$.fn.tabToggle = function(obj) {
        		obj = $.extend({
        			tabClass : null,
        			titClass : null,
        			bbsList : null,
        			moreBtn : null,
        			height : 10,			
        			top : 0,
        			left: 0					
        		}, obj || {});
        		return this.each(function() {
        			var rowCount = $(this).children(obj.tabClass).size();
        			$(this).css({"position":"relative","height":obj.height});
        														
        			$(this).children(obj.tabClass).each(function(index){
        				$(this).children(obj.titClass).css({"position":"absolute"});				
        				$(this).children(obj.bbsList).css({
        					"position":"absolute",
        					"top" : obj.top,
        					"left" : obj.left
        				});
        				if(index != 0) {
        					$(this).children(obj.bbsList).css({"visibility":"hidden","height":"0"});
        					$(this).children(obj.moreBtn).css({"visibility":"hidden","height":"0"});
        				}
        				var curTab = this;
        				$(this).children(obj.titClass).children("a").hover(function() {
        					$(curTab).parent().children(obj.tabClass).each(function(index) {
        						$(this).children(obj.bbsList).css({"visibility":"hidden","height":"0"});
        						$(this).children(obj.moreBtn).css({"visibility":"hidden","height":"0"});						
        					});
        					$(curTab).children(obj.bbsList).css({"visibility":"visible","height":"auto"});
        					$(curTab).children(obj.moreBtn).css({"visibility":"visible","height":"auto"});					
        					$(obj.titClass).removeClass("tabActive");
        					$(this).parent(obj.titClass).addClass("tabActive");
        				});
        				
        				$(this).children(obj.titClass).children("a").focus(function() {
        					$(curTab).parent().children(obj.tabClass).each(function(index) {
        						$(this).children(obj.bbsList).css({"visibility":"hidden","height":"0"});
        						$(this).children(obj.moreBtn).css({"visibility":"hidden","height":"0"});
        					});
        					$(curTab).children(obj.bbsList).css({"visibility":"visible","height":"auto"});
        					$(curTab).children(obj.moreBtn).css({"visibility":"visible","height":"auto"});
        					$(this).parent(obj.titClass).addClass("tabActive");					
        				});
        			});											
        			if(obj.moreBtn) {
        				$(obj.moreBtn).css({"position":"absolute","top":"0","right":"0"});	
        			};											
        		});										
        	};
        })(jQuery);


		