
ctgryObj = function(upperCtgryId, ctgryId, ctgryNm, ctgryLevel) {
		this.upperCtgryId = upperCtgryId;
		this.ctgryId = ctgryId;
		this.ctgryNm = ctgryNm;
		this.ctgryLevel= ctgryLevel;
};

function fnFindctgryObj(ctgryId) {
	for(var i = 0 ; i < boardCateList.length ; i++){
		var cate = boardCateList[i];
		if(cate.ctgryId == ctgryId) {
			return cate;
		}
	}
	
	return null;
}

function fnCtgryChange(ctgryLevel) {
	var actObj = document.getElementById("ctgry" + ctgryLevel);
	var targetObj = document.getElementById("ctgry" + (ctgryLevel + 1));
	if(targetObj != null) {
		for(var cmIdx = ctgryLevel + 1 ; cmIdx <= boardCateLevel ; cmIdx++){
			var cmObj = document.getElementById("ctgry" + cmIdx);
			if(cmObj != null) {
				for(var i = cmObj.length - 1 ; i > 0 ; i--){
					cmObj.options.remove(i);
				}
			}
		}
		
		var currVal = actObj.options[actObj.selectedIndex].value;
		var currCtgryObj = fnFindctgryObj(currVal);
		if(currCtgryObj != null) {
			var pos = 1;
			for(var i = 0 ; i < boardCateList.length ; i++){
				var cate = boardCateList[i];
				if(cate.upperCtgryId == currCtgryObj.ctgryId && cate.ctgryLevel == ctgryLevel + 1) {
					targetObj.options[pos] = new Option(cate.ctgryNm, cate.ctgryId);
					pos++;
				}
			}
		}
	}
}

function fnCtgryInit(searchCateList) {
	var arr = searchCateList.replace('[','').replace(']','').split(",");
	for(var i = 0; i < arr.length; i++) {
		if(arr[i].trim() != '') {
			var cmObj = document.getElementById("ctgry" + (i+1));
			if(cmObj != null) {
				for(var y = 0; y < cmObj.length; y++){
					if(cmObj[y].value == arr[i].trim()) {
						cmObj[y].selected = true;
						fnCtgryChange(i+1);
						break;
					}
				}
			}
		}
	}
}


String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
};

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

function fn_egov_bbs_basic_regist(frm) {

	return validateBoard(frm);
}


function fn_egov_bbs_editor(adfile_config) {
	
	$('#' + adfile_config.editorId).tinymce({
		script_url : '/lib/tiny_mce/tiny_mce.js',
		language : "ko", 
		theme : "advanced",
		skin : "o2k7",
		skin_variant : "silver",
		plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile",
		theme_advanced_buttons1 : "img,|,attach",//"image,file,media",
		theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
		theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		theme_advanced_fonts: "굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",
		content_css : "/template/manage/css/default.css",
		template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
		convert_urls : false,
		forced_root_block : false,
		adfile_external_param : adfile_config,		
		setup : function(ed) {  
			ed.addButton('img', {            
				title : '이미지 삽입/편집',
				image : '/lib/tiny_mce/img/icon_01.gif',
				onclick : function() {                
					ed.execCommand('mceAdvImage');            
				}        
			});
			ed.addButton('attach', {            
				title : '파일 첨부',            
				image : '/lib/tiny_mce/img/icon_03.gif',
				onclick : function() {                
					ed.execCommand('mceAdvFile');            
				}        
			});    
		}
	});
	
	$('#btnAddFile_' + adfile_config.editorId).show();
	$('#btnAddFile_' + adfile_config.editorId).click(function() {
		tinyMCE.activeEditor.windowManager.open({
			file : '/lib/tiny_mce/plugins/advfile/file.htm',
			width : 500 + parseInt(tinyMCE.activeEditor.getLang('advfile.delta_width', 0)),
			height : 460 + parseInt(tinyMCE.activeEditor.getLang('advfile.delta_height', 0)),
			inline : 1
		}, {
			plugin_url : '/lib/tiny_mce/plugins/advfile',
			window : window,
			insert_html : false
		});
		return false;
	});
	
	fn_egov_file_clean_action(adfile_config.editorId);
	
	$('#nttSj').focus();
}

