<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/manage/js"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>
<c:set var="_MODE" value=""/>
<c:set var="MENU_AUTO_MAKE_SITE_ID" value="<%=Globals.MENU_AUTO_MAKE_SITE_ID%>"/>
<c:set var="_EDITOR_ID" value="htmlCn_Html"/>
<c:set var="_MOBILE_EDITOR_ID" value="mobileHtmlCn_Html"/>



<c:set var="_PREFIX" value="${pageContext.request.contextPath}/mng/sym/mpm"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${empty searchVO.menuId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertMpm.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateMpm.do"/>
	</c:otherwise>
</c:choose>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MENUCNTNTS_MANAGE"/>
	<c:param name="depth1" value="${searchVO.siteId eq MENU_AUTO_MAKE_SITE_ID ? 'MENU_AUTHO_MANAGE' : 'MENU_MANAGE'}"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="${searchVO.siteId eq MENU_AUTO_MAKE_SITE_ID ? '기본 자동생성 메뉴관리' : '메뉴관리'}"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript" src="${_JS}/select_design.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="mnu" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

    function fn_egov_preview_mnu() {
    	
    	if(!fn_egov_validatet_mnu()) {
    		return;
    	}
    	
    	document.mnu.action = "${pageContext.request.contextPath}/mng/sym/mpm/previewMpm.do";
		document.mnu.target = "previewForm";
		document.mnu.submit();
		
    }
    
    function fn_egov_preview_callback(url) {
    	if(url.indexOf == -1) {
    		url = url + '?';
    	}
    	
    	var win = window.open('about:blank' ,'preview','');
		
    	document.mnu.action = url + '&previewYn=Y';
		document.mnu.target = "preview";
		document.mnu.submit();
		
		if(win != null) {
			win.focus();
		}
    }
    
    function fn_egov_regist_mnu() {
    	if(!fn_egov_validatet_mnu()) {
    		return;
    	}
    	
    	$('#fileGroupId').val($('#fileGroupId_${_EDITOR_ID}').val());
    	$('#mobileFileGroupId').val($('#fileGroupId_${_MOBILE_EDITOR_ID}').val());
    	
    	if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
   			return;					
   		}
    	
    	document.mnu.action = "${_ACTION}";
		document.mnu.target = "_self";
		document.mnu.submit();
    }
    
   	function fn_egov_validatet_mnu() {
   		
   		if (!validateMnu(document.mnu)){
   			return false;
   		}
   		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val(); //구성유형
   		var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val(); //컨텐츠유형

   		if(compositionTyCode == 'LINK') {
			if($.trim($('#url').val()) == "") {
				alert("URL 을 입력하세요");
				$('#url').focus();
				return false;
			}
		}

   		var progrmId = "";
   		if(cntntsTyCode == 'CTS02') {
   			progrmId = $('#selectBbs option:selected').val();
			if(progrmId == "") {
				alert("게시판을 선택하세요");
				$('#selectBbs').focus();
				return false;
			}
		}
   		
   		if(cntntsTyCode == 'CTS04') {
   			progrmId = $('#selectProgrmId option:selected').val();
			if(progrmId == "") {
				alert("프로그램을 선택하세요");
				$('#selectProgrmId').focus();
				return false;
			}
		}

   		if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {
   			progrmId = "";
   			if($.trim($('#url').val()) == "") {
				alert("URL 을 입력하세요");
				$('#url').focus();
				return false;
			}
		}

   		if(!$.isNumeric($('#sortOrdr').val())) {
   			alert("노출순서는 숫자만 입력하세요");
   			$('#sortOrdr').focus();
			return false;
   		}
   		
   		$('#progrmId').val(progrmId);
   		
   		$('#htmlCn').val($('input:radio[name=htmlsourcTyCode]:checked').val() == 'HTML' ? $('#htmlCn_Html').val() : $('#htmlCn_Jsp').val());
   		$('#mobileHtmlCn').val($('input:radio[name=mobileHtmlsourcTyCode]:checked').val() == 'HTML' ? $('#mobileHtmlCn_Html').val() : $('#mobileHtmlCn_Jsp').val());
   		
   		if($.trim($('#menuId').val()) == "") {
   			$('#menuId').val($('#takeMenuId').val());
   		}
   		return true;
   	}

	function fn_egov_select_prog() {
   		
		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
		var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();
		if(compositionTyCode == 'LINK' && cntntsTyCode != 'CTS01') {
			$('input:radio[name=compositionTyCode]:input[value=CNTNTS]').attr('checked', true);
   		}
		
   		fn_egov_all_prog_hide();
   		
		if(cntntsTyCode == 'CTS01') {//없음
			
		} else if(cntntsTyCode == 'CTS02') {//게시판
			$('#bbsDiv').show();
		} else if(cntntsTyCode == 'CTS04') {//프로그램
			$('#progDiv').show();
		} else if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {//IFRAME or 포틀릿
			$('#urlTr').show();
		}
   	}
	
	function fn_egov_all_prog_hide() {
		
   		$('#bbsDiv').hide();
   		$('#progDiv').hide();
   		$('#urlTr').hide();
	}

   	function fn_egov_select_comp() {

   		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
		
		$('#htmlTr').hide(1, fnTabHide);
		$('#urlTr').hide();
		if(compositionTyCode == 'LINK') {
			$('input:radio[name=htmlUseAt]:input[value=N]').attr('checked', true);
			$('input:radio[name=cntntsTyCode]:input[value=CTS01]').attr('checked', true);
			fn_egov_all_prog_hide();    					
			$('#urlTr').show();
			
		} else if(compositionTyCode == 'CNTNTS') {
			if($('input:radio[name=htmlUseAt]:checked').val() == "Y") {
				$('#htmlTr').show(1, fnTabShow);
			}
			
			var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();    					
    		if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {
    			$('#urlTr').show();
    		}
		}
   	}

   	function fn_egov_select_html() {
   		
   		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
   		var htmlUseAt = $('input:radio[name=htmlUseAt]:checked').val();
   		
   		
   		if(compositionTyCode == 'LINK' && htmlUseAt == 'Y') {
   			$('input:radio[name=compositionTyCode]:input[value=CNTNTS]').attr('checked', true);
   			var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();    					
    		if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {
    			$('#urlTr').show();
    		} else {
   				$('#urlTr').hide();
    		}
   		}
   		
		if(htmlUseAt == 'Y') {
			$('#htmlTr').show(1, fnTabShow);
		} else if(htmlUseAt == 'N') {
			$('#htmlTr').hide(1, fnTabHide);
		} 
   	}
   	
   	function fn_egov_select_html_cn() {
   		var htmlsourcTyCode = $('input:radio[name=htmlsourcTyCode]:checked').val(); 
   		$('#div_HtmlCn_Html').hide();
		$('#div_HtmlCn_Jsp').hide();
		
   		if(htmlsourcTyCode == 'HTML') {
   			$('#div_HtmlCn_Html').show();
   		} else if(htmlsourcTyCode == 'JSP') {
   			$('#div_HtmlCn_Jsp').show();
   		} 
   	}
   	
	function fn_egov_select_html_mobile_cn() {
		var mobileHtmlsourcTyCode = $('input:radio[name=mobileHtmlsourcTyCode]:checked').val(); 
   		$('#div_MobileHtmlCn_Html').hide();
		$('#div_MobileHtmlCn_Jsp').hide();
		
   		if(mobileHtmlsourcTyCode == 'HTML') {
   			$('#div_MobileHtmlCn_Html').show();
   		} else if(mobileHtmlsourcTyCode == 'JSP') {
   			$('#div_MobileHtmlCn_Jsp').show();
   		} 
   	}

   	
   	function fnTabView(idx) {
   		
   		$('#tabLink01').removeClass('active');
   		$('#tabLink02').removeClass('active');
   		$('#tabLink' + idx).addClass('active');
   		
   		$('#tab01').hide();
   		$('#tab02').hide();    		
   		$('#tab' + idx).show();
   		
   	}

   	function fnTabShow() {
		
		if($('#tabLink01').attr('class') == 'active') {
			$('#tab01').show();
		} else if($('#tabLink02').attr('class') == 'active') {
			$('#tab02').show();
		}			
   	}
   	
	function fnTabHide() {
		$('#tab01').hide();
		$('#tab02').hide();
   	}
   	    	
   	$(document).ready( function() {
   		var adfile_config = {
			storePath:"Menu.fileStorePath",
			appendPath:"",
			siteId:"${searchVO.siteId}",
			editorId:"${_EDITOR_ID}"
		};
   		
   		var moblie_adfile_config = {
			storePath:"Menu.fileStorePath",
			appendPath:"",
			siteId:"${searchVO.siteId}",
			editorId:"${_MOBILE_EDITOR_ID}"
		};
   		
   		$('#' + adfile_config.editorId).tinymce({
   			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
   			language : "ko", 
   			theme : "advanced",
   			skin : "o2k7",
   			skin_variant : "silver",
   			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
   			theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
   			theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
   			theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
   			theme_advanced_toolbar_location : "top",
   			theme_advanced_toolbar_align : "left",
   			theme_advanced_statusbar_location : "bottom",
   			theme_advanced_resizing : true,
   			content_css : "${pageContext.request.contextPath}/template/manage/css/default.css",
   			template_external_list_url : "${pageContext.request.contextPath}/template/manage/docTemplate/mpm/template_list.js",
   			convert_urls : false,
   			adfile_external_param : adfile_config,
   			setup : function(ed) {  
   				ed.addButton('img', {            
   					title : '이미지 삽입/편집',
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_01.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvImage');            
   					}        
   				});
   				ed.addButton('attach', {            
   					title : '파일 첨부',            
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_03.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvFile');            
   					}        
   				});    
   			}
   		});
   		
   		fn_egov_file_clean_action(adfile_config.editorId);
   		
   		$('#' + moblie_adfile_config.editorId).tinymce({
   			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
   			language : "ko", 
   			theme : "advanced",
   			skin : "o2k7",
   			skin_variant : "silver",
   			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
   			theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
   			theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
   			theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
   			theme_advanced_toolbar_location : "top",
   			theme_advanced_toolbar_align : "left",
   			theme_advanced_statusbar_location : "bottom",
   			theme_advanced_resizing : true,
   			content_css : "/template/manage/css/default.css",
   			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
   			convert_urls : false,
   			adfile_external_param : moblie_adfile_config,
   			setup : function(ed) {  
   				ed.addButton('img', {            
   					title : '이미지 삽입/편집',
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_01.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvImage');            
   					}        
   				});
   				ed.addButton('attach', {            
   					title : '파일 첨부',            
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_03.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvFile');            
   					}        
   				});    
   			}
   		});
   		
   		fn_egov_file_clean_action(moblie_adfile_config.editorId);
   		
		$('input:radio[name=compositionTyCode]').click(fn_egov_select_comp);
		$('input:radio[name=htmlUseAt]').click(fn_egov_select_html);
		$('input:radio[name=htmlsourcTyCode]').click(fn_egov_select_html_cn);
		$('input:radio[name=mobileHtmlsourcTyCode]').click(fn_egov_select_html_mobile_cn);
		$('input:radio[name=cntntsTyCode]').click(fn_egov_select_prog);
		    			
		fn_egov_select_prog();
		fn_egov_select_html();
		fn_egov_select_html_cn();
		fn_egov_select_html_mobile_cn()
		fn_egov_select_comp(); 
		
		$('#tab02').hide();
		$('#menuNm').focus();
   			
   	});
    	
    </script>
    
<div id="cntnts">
<iframe id="previewForm" name="previewForm" frameborder="0" width="0" height="0"></iframe>
<form name="mnu" method="post" action="" enctype="multipart/form-data">
	<%-- 
	<form:hidden path="siteId"/>
	<form:hidden path="menuId"/>
	<form:hidden path="takeMenuId"/>
	<form:hidden path="progrmId"/>
	<form:hidden path="atchFileId"/>
	<form:hidden path="mobileAtchFileId"/>
	 --%>
	<input type="hidden" name="siteId" value="${mnuVO.siteId}"/>
	<input type="hidden" name="menuId" value="${mnuVO.menuId}"/>
	<input type="hidden" name="takeMenuId" value="${mnuVO.takeMenuId}"/>
	<input type="hidden" name="progrmId" value="${mnuVO.progrmId}"/>
	<input type="hidden" name="atchFileId" value="${mnuVO.atchFileId}"/>
	<input type="hidden" name="mobileAtchFileId" value="${mnuVO.mobileAtchFileId}"/>
	
	<input type="hidden" name="siteUrl" value="${siteInfo.siteUrl}"/>
	<input type="hidden" id="htmlCn" name="htmlCn"/>
	<input type="hidden" id="mobileHtmlCn" name="mobileHtmlCn"/>
	
	<input type="hidden" id="posblAtchFileNumber_${_EDITOR_ID}" name="posblAtchFileNumber_${_EDITOR_ID}" value="100" />
	<input type="hidden" id="posblAtchFileSize_${_EDITOR_ID}" name="posblAtchFileSize_${_EDITOR_ID}" value="${2048 * 1024 * 1024}" />
	<input type="hidden" id="fileGroupId" name="fileGroupId" value="${mnuVO.atchFileId}"/>
	
	<input type="hidden" id="posblAtchFileNumber_${_MOBILE_EDITOR_ID}" name="posblAtchFileNumber_${_MOBILE_EDITOR_ID}" value="100" />
	<input type="hidden" id="posblAtchFileSize_${_MOBILE_EDITOR_ID}" name="posblAtchFileSize_${_MOBILE_EDITOR_ID}" value="${2048 * 1024 * 1024}" />
	<input type="hidden" id="mobileFileGroupId" name="mobileFileGroupId" value="${mnuVO.mobileAtchFileId}"/>
	
	<div class="btn_r">
		<c:if test="${searchVO.siteId ne MENU_AUTO_MAKE_SITE_ID}">
			<a href="#" onclick="fn_egov_preview_mnu(); return false;""><img src="${_IMG}/btn/btn_preview.gif" alt="미리보기"/></a>
		</c:if>
		<a href="#" onclick="fn_egov_regist_mnu(); return false;"><img src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/></a>
      	<c:url var="listUrl" value='/mng/sym/mpm/selectMpmList.do'>
      		<c:param name="siteId" value="${param.siteId}"/>
      	</c:url>
		<a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
	</div>
	
	<table class="chart2">
	<caption>메뉴 등록폼</caption>
	<colgroup>
		<col width="150"/>
		<col/>
	</colgroup>
		<tbody>
		<c:if test="${not empty mnuVO.upperMenuId}">
			<tr>
				<th><em>*</em> <label>상위메뉴</label></th>
				<td>
					<select name="upperMenuId" id="upperMenuId" style="width:300px;height:21px;display:none;">
						<c:forEach var="result" items="${mpmList}" varStatus="status">
							<option value="${result.menuId}" <c:if test="${result.menuId == mnuVO.upperMenuId}">selected="selected"</c:if> ><c:forEach begin="1" end="${result.menuLevel}" step="1">&nbsp;</c:forEach><c:if test="${result.menuLevel ne 0}">&lt;img src=${_IMG}/btn/folder_${result.menuLevel}.gif&gt; </c:if>${result.menuNm}</option>
						</c:forEach>		
					</select>
					<script>
						makeSelectBoxGlobal("upperMenuId", "selectBoxSelectedAreaGlobal", "white", "${_IMG}/btn/select_btn.gif", "selectBoxOptionGlobal", "selectBoxSelectedAreaFocusGlobal", "selectBoxOptionOverGlobal");
					</script>
				</td>
			</tr>
		</c:if>
			<tr>
				<th><em>*</em> <label>메뉴명</label></th>
				<td>
					<input type="text" name="menuNm" value="${mnuVO.menuNm}" class="inp_long" size="50" maxlength="50"/>
					<%-- <form:input path="menuNm" cssClass="inp_long" size="50" maxlength="50" /> --%>
					<div><form:errors path="menuNm"/></div>      	 
				</td>
			</tr>
			<tr>
              <th><label for="imageFileNm">스마트아이콘</label></th>
              <td>
              	<input type="file" name="imageFileIdFile" id="imageFileNm" title="스마트아이콘" class="input300 inp" >
              	<c:if test="${not empty mnuVO.imageFileNm}"><br/><img src="${MenuFileStoreWebPath}${mnuVO.siteId}/${mnuVO.imageFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
				<th> <label>노출대상</label></th>
				<td>
					일반인 : <input type="checkbox" name="generalUseAt"  value="Y" <c:if test="${mnuVO.generalUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					학생 : <input type="checkbox" name="stdntUseAt"  value="Y" <c:if test="${mnuVO.stdntUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					학부모 : <input type="checkbox" name="stdnprntUseAt"  value="Y" <c:if test="${mnuVO.stdnprntUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					교직원 : <input type="checkbox" name="profsrUseAt"  value="Y" <c:if test="${mnuVO.profsrUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
				</td>
			</tr>
			<tr>
				<th><em>*</em> <label>구성유형</label></th>
				<td>
					링크 구성 : <form:radiobutton path="compositionTyCode"  value="LINK" />&nbsp;
	                                컨텐츠 구성 : <form:radiobutton path="compositionTyCode"  value="CNTNTS"/>
	            	<br/><form:errors path="compositionTyCode" />	 
				</td>
			</tr>
			<tr>
				<th><em>*</em> <label>HTML 사용여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="htmlUseAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="htmlUseAt"  value="N"  />
		            <br/><form:errors path="htmlUseAt" />
				</td>
			</tr>
			<tr id="htmlTr">
				<th><label>HTML</label></th>
				<td>
					<div class="conf_top">
				    	<ul class="tab_menu">
							<li><a href="#tab1" id="tabLink01" onclick="fnTabView('01');return false;" class="active">WEB</a></li>
						</ul>
					</div>
					
					<div id="tab01" class="cont">
						<table>
							<caption>메뉴 등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<tr>
										<th> <label>스타일시트</label></th>
										<td>
											<form:textarea path="styleCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="styleCn" />
										</td>
									</tr>
									<tr>
										<th> <label>자바스크립트</label></th>
										<td>
											<form:textarea path="scriptCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="scriptCn" />
										</td>
									</tr>
									<tr>
										<th> <label>내용유형</label></th>
										<td>
											HTML : <form:radiobutton path="htmlsourcTyCode"  value="HTML"/>&nbsp;
							                JSP : <form:radiobutton path="htmlsourcTyCode"  value="JSP"/>
							            	<br/><form:errors path="htmlsourcTyCode" />	 
										</td>
									</tr>
									<tr>
										<th> <label>내용</label></th>
										<td>
											<div id="div_HtmlCn_Html">
												<textarea id="htmlCn_Html" rows="50" style="width:100%;" class="inp_default" ><c:if test="${mnuVO.htmlsourcTyCode eq 'HTML'}">${mnuVO.htmlCn}</c:if> </textarea>
												<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								                	<c:param name="editorId" value="${_EDITOR_ID}"/>
													<c:param name="estnAt" value="N" />
											    	<c:param name="param_atchFileId" value="${mnuVO.atchFileId}" />
											    	<c:param name="imagePath" value="${_IMG }"/>
												</c:import>
											</div>
											<div id="div_HtmlCn_Jsp"><textarea id="htmlCn_Jsp" rows="50"style="width:90%;" class="inp_default" ><c:if test="${mnuVO.htmlsourcTyCode eq 'JSP'}">${mnuVO.htmlCn}</c:if> </textarea></div>
										</td>
									</tr>
								</tbody>
						</table>
					</div>
				</td>
			</tr>			
			<tr>
				<th><em>*</em> <label>컨텐츠유형</label></th>
				<td>
					<form:radiobuttons path="cntntsTyCode" items="${mnuCntsList}" itemLabel="codeNm" itemValue="code"/>
		        	<div><form:errors path="cntntsTyCode"/></div>
		        	<div id="bbsDiv" style="display:none">
		        			<select name="selectBbs" id="selectBbs" class="searchCate inp">
		        				<option value="">--- 선택하세요 ---</option>
		        				<c:choose>
		        					<c:when test="${searchVO.siteId ne MENU_AUTO_MAKE_SITE_ID}">
				        		  		<c:forEach var="result" items="${bbsList}" varStatus="status">        		  			
				        		  			<option value="<c:out value="${result.bbsId}"/>" <c:if test="${mnuVO.progrmId == result.bbsId}">selected="selected"</c:if>><c:out value="${result.bbsNm}"/></option>
				        		  		</c:forEach>
				        		  	</c:when>
				        		  	<c:otherwise>
				        		  		<c:forEach var="result" items="${attrbList}" varStatus="status">        		  			
				        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${mnuVO.progrmId == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
				        		  		</c:forEach>
				        		  	</c:otherwise>
				        		</c:choose>
		        	  		</select>
		        	</div>
		        	<div id="progDiv" style="display:none">
		        			<select name="selectProgrmId" id="selectProgrmId" class="searchCate inp">
		        				<option value="">--- 선택하세요 ---</option>
		        		  		<c:forEach var="result" items="${progList}" varStatus="status">
		        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${mnuVO.progrmId == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
		        		  		</c:forEach>
		        	  		</select>
		        	  		프로그램인자:<form:input path="progrmFactr" size="30" cssClass="inp" maxlength="30" />
		        	</div>        	
				</td>
			</tr>
			<tr id="urlTr">
				<th> <label>URL</label></th>
				<td>
					<form:input path="url" size="100" cssClass="inp" maxlength="255" />
		       		<div><form:errors path="url"/></div>  	 
				</td>
			</tr>
			<tr>
				<th> <label>새창여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="nwdAt"  value="Y" />&nbsp;
		            <spring:message code="button.no" /> : <form:radiobutton path="nwdAt"  value="N" />
		            <br/><form:errors path="nwdAt" />
				</td>
			</tr>
			<tr>
				<th> <label>노출여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="expsrUseAt"  value="Y" />&nbsp;
		            <spring:message code="button.no" /> : <form:radiobutton path="expsrUseAt"  value="N" />
		            <br/><form:errors path="expsrUseAt" />
				</td>
			</tr>
			<tr <c:if test="${empty mnuVO.upperMenuId}">style="display:none"</c:if>>
				<th> <label>노출순서</label></th>
				<td>
					<input type="hidden" name="menuLevel" value="<c:out value="${mnuVO.menuLevel}"/>"/>
					<form:input path="sortOrdr" size="10" cssClass="inp"/>
		       		<div><form:errors path="sortOrdr"/></div>  	
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="btn_r">
		<c:if test="${searchVO.siteId ne MENU_AUTO_MAKE_SITE_ID}">
			<a href="#" onclick="fn_egov_preview_mnu(); return false;""><img src="${_IMG}/btn/btn_preview.gif" alt="미리보기"/></a>
		</c:if>
		<a href="#" onclick="fn_egov_regist_mnu(); return false;"><img src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/></a>
      	<c:url var="listUrl" value='/mng/sym/mpm/selectMpmList.do'>
      		<c:param name="siteId" value="${param.siteId}"/>
      	</c:url>
		<a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
	</div>
	
</form>
	 
	 
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	