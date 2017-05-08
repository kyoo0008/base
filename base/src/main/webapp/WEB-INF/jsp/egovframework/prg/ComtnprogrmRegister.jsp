<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ComtnprogrmRegister.jsp
  * @Description : Comtnprogrm Register 화면
  * @Modification Information
  * 
  * @author (주)청암IT
  * @since 2013.02.20
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_C_LIB" value="/lib"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:set var="_EDITOR_ID" value="detailCn"/>
<c:set var="_MODE" value=""/>
<c:choose>
<c:when test="${empty comtnprogrmVO.prgId }">
	<c:set var="actionUrl" value="/prg/addComtnprogrm.do"/>
	<c:set var="_MODE" value="REG"/>
</c:when>
<c:otherwise>
	<c:set var="actionUrl" value="/prg/updateComtnprogrm.do"/>
</c:otherwise>
</c:choose>
<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="comtnprogrmVO" staticJavascript="false" xhtml="true" cdata="false"/ -->
<link type="text/css" href="${CMMN_JS }/jquery/calendar/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript" src="${CMMN_JS }/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${CMMN_JS }/jquery/calendar/ui.datepicker.js" charset="utf-8"></script>
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
		
	$("#operBgnde").datepicker({			
		changeMonth: true,
		changeYear: true		
	});	
	$("#operEndde").datepicker({				
		changeMonth: true,
		changeYear: true		
	});
	$("#rceptBgnde").datepicker({				
		changeMonth: true,
		changeYear: true		
	});
	$("#rceptEndde").datepicker({				
		changeMonth: true,
		changeYear: true		
	});
	
	$("#tcherBtn").click(function(){
		window.open(this.href, "teacherSearch", "width=600,height=500");
		return false;
	});
	
});

	function updateTeacher(userId, userName) {		
		$("#tcherId").val(userId);
		$("#tName").val(userName);
	}
// -->
</script>

<h3 class="icon1">체험프로그램 ${_MODE eq "REG"?"등록":"수정" }</h3>
<div id="pbbs_wrap">
	<div class="board_write">
		<form:form commandName="comtnprogrmVO" name="detailForm" id="detailForm" action="${actionUrl }" enctype="multipart/form-data" >		
			<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
			<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="menuId" value="${param.menuId }"/>		
			 
			<dl class="hdn">
				<dt>프로그램명 구분</dt>
				<dd><form:select path="prgSeCode" items="${prgSeCodeList}" itemValue="code" itemLabel="codeNm"/>
					&nbsp;<form:errors path="prgSeCode" />
				</dd>
			</dl>			 
			<dl>
				<dt>프로그램명</dt>
				<dd>
					<form:input path="prgNm" cssClass="inp wid80"/>	&nbsp;<form:errors path="prgNm" />					
				</dd>
			</dl>
			<dl>
				<dt>학습주제</dt>
				<dd><form:input path="lrnThema" cssClass="inp wid80"/>&nbsp;<form:errors path="lrnThema" /></dd>
			</dl>
			<dl class="info_write2">
				<dt>운영기간</dt>
				<dd>
					<fmt:parseDate var="operBgnde" value="${comtnprogrmVO.operBgnde }" pattern="yyyy-MM-dd"/>
		  			<fmt:parseDate var="operEndde" value="${comtnprogrmVO.operEndde }" pattern="yyyy-MM-dd"/>
		  			<input type="text" class="inp w80" name="operBgnde" id="operBgnde" maxlength="10" size="10" value="<fmt:formatDate value="${operBgnde }" pattern="yyyy-MM-dd"/>"/><form:errors path="operBgnde" />	~
		  			<input type="text" class="inp w80" name="operEndde" id="operEndde" maxlength="10" size="10" value="<fmt:formatDate value="${operEndde }" pattern="yyyy-MM-dd"/>"/><form:errors path="operEndde" />			
				</dd>
				<dt>접수기간</dt>
				<dd>
					<fmt:parseDate var="rceptBgnde" value="${comtnprogrmVO.rceptBgnde }" pattern="yyyy-MM-dd"/>
		  			<fmt:parseDate var="rceptEndde" value="${comtnprogrmVO.rceptEndde }" pattern="yyyy-MM-dd"/>
					<input type="text" class="inp w80" name="rceptBgnde" id="rceptBgnde" maxlength="10" size="10" value="<fmt:formatDate value="${rceptBgnde }" pattern="yyyy-MM-dd"/>"/><form:errors path="rceptBgnde" /> ~
					<input type="text" class="inp w80" name="rceptEndde" id="rceptEndde" maxlength="10" size="10" value="<fmt:formatDate value="${rceptEndde }" pattern="yyyy-MM-dd"/>"/><form:errors path="rceptEndde" />					
				</dd>
			</dl>
			<dl class="info_write2">
				<dt>강의장소</dt>
				<dd><form:input path="lctrePlace" cssClass="inp"/>&nbsp;<form:errors path="lctrePlace" /></dd>
				<dt>소요시간</dt>
				<dd><form:input path="reqreTime" cssClass="inp"/>&nbsp;<form:errors path="reqreTime" /></dd>
			</dl>
			<dl class="info_write2">
				<dt>정원</dt>
				<dd><form:input path="psncpaNmpr" cssClass="inp" maxlength="3" size="3"/> 명 &nbsp;<form:errors path="psncpaNmpr" /></dd>
				<dt>진행상태</dt>
				<dd><form:select path="sttusSeCode" items="${sttusSeCodeList}" itemValue="code" itemLabel="codeNm"/>&nbsp;<form:errors path="sttusSeCode" />
					<br/>※ 마감은 접수기간에 상관없이 마감처리함.
				</dd>
			</dl>
			<dl class="info_write2">
				<dt>운영기관</dt>
				<dd><form:input path="operInsttNm" cssClass="inp" maxlength="50"/> </dd>
				<dt>운영기관장명</dt>
				<dd><form:input path="operIstdrNm" cssClass="inp" maxlength="50"/> </dd>
			</dl>
			<dl>
				<dt>운영기관직인</dt>
				<dd>
					<div class="wsign">
						<c:if test="${not empty comtnprogrmVO.operIstdrFileNm}"><img src="${ProgrmFileStoreWebPath}${siteVO.siteId}/${comtnprogrmVO.operIstdrFileNm}" width="100" height="100"/></c:if>
					</div>
					<p>※ 이미지는 100* 100 픽셀 사이즈로 올려 주세요</p>
									
					<input type="file" name="operIstdrFile" id="operIstdrFile" class="inp" accept="image/*"/>
				</dd>
			</dl>
			<dl>
				<dt>강사선택</dt>
				<dd><input type="text" name="tName" id="tName" value="${comtnprogrmVO.tcherNm }" class="inp vMid"/>
					<form:hidden path="tcherId"/>
					<span class="bbtn_sm">
						<a href="<c:url value="/prg/selectTeacherSearch.do"/>" id="tcherBtn">검색</a>
					</span>
					&nbsp;<form:errors path="tcherId" />
				</dd>
			</dl>
			<dl>
				<dt class="hdn"><label for="detailCn">글내용</label></dt>
				<dd class="write_cont">
					<form:textarea path="detailCn" cssClass="txt"/>
						&nbsp;<form:errors path="detailCn" />
				</dd>
			</dl>			
			<div class="btn_c">				
				<c:url var="listUrl" value='/prg/ComtnprogrmList.do'>
					<c:param name="siteId" value="${searchVO.siteId}"/>					
					<c:param name="menuId" value="${param.menuId }"/>
					<c:param name="pageIndex" value="${searchVO.pageIndex}" />
					<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
					<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
					<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
					<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>	
					<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>		
				</c:url>			
				<span class="bbtn_bg1"><button type="submit">확인</button></span>
				<span class="bbtn_bg2"><a href="${listUrl}">취소</a></span>
			</div>		
		</form:form>
	</div>
</div>
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>

