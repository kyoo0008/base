<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_C_LIB" value="/lib"/>
<c:set var="SE_CODE" value="1"/>
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<c:set var="_EDITOR_ID" value="reprtCn"/>
<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript">
<!--
$(document).ready( function() {
	var adfile_config = {
		storePath:"Event.fileStorePath",
		appendPath:"",
		siteId:"${searchVO.siteId}",
		editorId:"${_EDITOR_ID}"
	};
		
	$('#' + adfile_config.editorId).tinymce({
		script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
		language : "ko", 
		theme : "advanced",
		skin : "o2k7",
		skin_variant : "silver",
		plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
		//theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
		theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
		theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		theme_advanced_fonts : "굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",
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
});
 // -->
</script>
<h3 class="icon1">보고서 작성</h3>
	<form:form commandName="comtnprogrmtrgterVO" name="detailForm" id="detailForm" action="/prg/updateComtnprogrmtrgterReport.do" >
		<form:hidden path="prgId"/>	
		<input type="hidden" name="menuId" value="${param.menuId }"/>	
		<div id="pbbs_wrap">
			 <div class="board_write">
				<dl>
				  <dt>프로그램명</dt>
				  <dd>${comtnprogrmVO.prgNm }</dd>
				 </dl>
				<dl>
				  <dt>학습주제</dt>
				  <dd>${comtnprogrmVO.lrnThema }</dd>
				</dl>
				<dl>
				  <dt>운영기간</dt>
				  <dd>${comtnprogrmVO.operBgnde } ~ ${comtnprogrmVO.operEndde }</dd>
				</dl>
				<dl>
				  <dt>강의장소</dt>
				  <dd>${comtnprogrmVO.lctrePlace }</dd>
				</dl>
				<dl>
				  <dt>운영기관</dt>
				  <dd>${comtnprogrmVO.operInsttNm }</dd>
				</dl>
				<dl>
				  <dt>강사</dt>
				  <dd>${comtnprogrmVO.tcherNm }</dd>
				</dl>
	
				<dl>
					<dt class="hdn"><label for="nttCn">글내용</label></dt>
					<dd class="write_cont">
						<form:textarea path="reprtCn" cssClass="txt"/>					
					</dd>
				</dl>
			</div>
			
		</div>
	
		<div class="btn_c">
			<span class="bbtn_bg1"><button type="submit" >확인</button></span>
			<span class="bbtn_bg2">
				<c:url var="cancelUrl" value="/prg/ComtnprogrmtrgterMyList.do">
					<c:param name="menuId" value="${param.menuId }"/>					
				</c:url>
				<a href="${cancelUrl }">취소</a>
			</span> 
		</div>
	</form:form>
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>