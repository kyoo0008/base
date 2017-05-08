<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>
<c:set var="_MODE" value=""/>

<c:choose>
	<c:when test="${empty searchVO.siteId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="SITE_MANAGE"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="사이트관리"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="siteManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript">

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_siteinfo(){
	var form = document.siteManageVO;
    
    if (!validateSiteManageVO(form)) {                    
        return false;        
    }
    
    if(!$.isNumeric($('#passwordMummLt').val())) {
		alert("비밀번호 최소길이는 숫자만 입력하세요");
		$('#passwordMummLt').focus();
		return false;
	}
    
    if(!$.isNumeric($('#passwordMxmmLt').val())) {
		alert("비밀번호 최대길이는 숫자만 입력하세요");
		$('#passwordMummLt').focus();
		return false;
	}
    
    if(!$.isNumeric($('#passwordChangeCycle').val())) {
		alert("비밀번호 변경주기는 숫자만 입력하세요");
		$('#passwordChangeCycle').focus();
		return false;
	}
    
    $("#bbsIdList option").attr("selected", "selected");
    
    if($.trim($('#siteId').val()) == "") {
		$('#siteId').val($('#takeSiteId').val());
	}
    
    if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
    
}

function fn_egov_selectTemplate(se) {
	var url = "/mng/cop/com/selectLytTemplateList.do?";
	url = url + "selectMode=Y&searchTmplatLcasCode=" + se;
	
	var win = window.open(url ,'lytTemplate',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_updateTemplate(id, nm, se, fileNm) {
	var seId = (se == 'sit' ? 'lyt' : 'cmy');
	$('#' + seId + 'TmplatId').val(id);
	$('#' + seId + 'TmplatNm').text(nm);
	if(fileNm) {
		$('#' + seId + 'TmplatImage').attr('src', '${tmplatFileStoreWebPathByPreFile}/' + fileNm);
	} else {
		$('#' + seId + 'TmplatImage').attr('src', '${_IMG}/board/no_img.gif');
	}
}

function fn_egov_selectSourc(se) {
	var url = "/mng/cop/com/selectLytSourcList.do?";
	url = url + "selectMode=Y&searchSourcSeCode=" + se;
	
	var win = window.open(url ,'lytSourc',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_updateSourc(id, nm, se, fileNm) {
	var seId = (se == 'sit' ? 'lyt' : 'cmy');
	$('#' + seId + 'SourcId').val(id);
	$('#' + seId + 'SourcNm').text(nm);
	if(fileNm) {
		$('#' + seId + 'SourcImage').attr('src', '${sourcFileStoreWebPathByPreFile}/' + fileNm);
	} else {
		$('#' + seId + 'SourcImage').attr('src', '${_IMG}/board/no_img.gif');
	}
}

function fnImagePreviewBefore(seId) {
	if($('#' + seId).attr('src') != '${_IMG}/board/no_img.gif') {
		fnImagePreview($('#' + seId).attr('src'));
	} else {
		alert('이미지가 없습니다.');
	}
}



function fn_egov_updateBbsList(id, nm) {
	var exists = false;
	$('#bbsIdList option').each(function(){
		if($(this).val() == id) {
			exists = true;
		}
	});	
	
	if(!exists) {
		$("#bbsIdList").append("<option value='"+ id +"'>" + nm + "</option>");
	}
}

function fnContentAdd(cntntsTyCode) {
	if(cntntsTyCode == 'SMCTS01') {	//게시판
		var siteId = ($.trim($('#siteId').val()) == "") ? $('#takeSiteId').val() : $('#siteId').val();
		
		var url = "/mng/cop/bbs/SelectBBSMasterInfs.do?";
		url = url + "selectMode=Y&siteId=" + siteId;
		
		var win = window.open(url ,'bbsSelect',' scrollbars=yes, resizable=yes, left=0, top=0, width=900,height=650');
		if(win != null) {
			win.focus();
		}
	}
}

function fnContentDel(cntntsTyCode) {
	if(cntntsTyCode == 'SMCTS01') {	//게시판
		$("#bbsIdList option:selected").remove();
	}
}

function fnContentMove(cntntsTyCode, moveTy) {
	if(cntntsTyCode == 'SMCTS01') {	//게시판
		if(moveTy == 'UP') {		//위로
			$('#bbsIdList option:selected').each(function(){
			  $(this).insertBefore($(this).prev());
			 });
		} else if(moveTy == 'DOWN') {//아래로
			$('#bbsIdList option:selected').each(function(){
			  $(this).insertAfter($(this).next());
			 });
		} 
	}
}

function fnOrgCodePop() {
	var url = "${pageContext.request.contextPath}/mng/sym/ext/selectOrgCodeList.do?";
	url = url + "selectMode=Y";
	
	var win = window.open(url ,'orgcode',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_selectOrgCode(id, nm) {
	$('#insttCode').val(id);
	$('#siteNm').val(nm);
	$('#brwsrSj').val(nm);
}


$(document).ready( function() {
		$('#indvdlInfoPolicy').tinymce({
			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
			language : "ko", 
			theme : "advanced",
			skin : "o2k7",
			skin_variant : "silver",
			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,template",
			theme_advanced_buttons1 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,image,media,cleanup,|,tablecontrols",
			theme_advanced_buttons2 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,template,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,
			content_css : "/template/manage/css/default.css",
			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
			convert_urls : false
		});
		
		$('#cpyrhtSttemntSvc').tinymce({
			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
			language : "ko", 
			theme : "advanced",
			skin : "o2k7",
			skin_variant : "silver",
			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,template",
			theme_advanced_buttons1 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,image,media,cleanup,|,tablecontrols",
			theme_advanced_buttons2 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,template,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,
			content_css : "/template/manage/css/default.css",
			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
			convert_urls : false
		});
		
		$('#emailColctPolicy').tinymce({
			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
			language : "ko", 
			theme : "advanced",
			skin : "o2k7",
			skin_variant : "silver",
			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,template",
			theme_advanced_buttons1 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,image,media,cleanup,|,tablecontrols",
			theme_advanced_buttons2 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,template,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,
			content_css : "/template/manage/css/default.css",
			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
			convert_urls : false
		});
		
		$('#useStplat').tinymce({
			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
			language : "ko", 
			theme : "advanced",
			skin : "o2k7",
			skin_variant : "silver",
			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,template",
			theme_advanced_buttons1 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,image,media,cleanup,|,tablecontrols",
			theme_advanced_buttons2 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,template,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,
			content_css : "/template/manage/css/default.css",
			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
			convert_urls : false
		});
			
		$(".imgCol").click(function() {
			$(this).parent().parent().parent().find('.editor').toggle();
			$(this).parent().find('.imgCol').toggle();
		});
		
	});
	

</script>


<div id="cntnts">
    	<c:choose>
    	<c:when test="${_MODE eq 'REG'}">
    		<c:url var="actionUrl" value="/mng/sym/sit/insertSiteInfo.do"/>
    	</c:when>
    	<c:otherwise>
    		<c:url var="actionUrl" value="/mng/sym/sit/updateSiteInfo.do"/>
    	</c:otherwise>
    	</c:choose>
        <form:form commandName="siteManageVO" name="siteManageVO" action="${actionUrl}" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist_siteinfo();"> 
        <form:hidden path="siteId"/>
        <form:hidden path="takeSiteId"/>
        <form:hidden path="lytTmplatId"/>
        <form:hidden path="cmyTmplatId"/>
        <form:hidden path="lytSourcId"/>
        <form:hidden path="cmySourcId"/>
        <form:hidden path="mobileUseAt"  value="N"  />
                
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="searchCondition" type="hidden" value="<c:out value="${searchVO.searchCondition}"/>"/>
		<input name="searchKeyword" type="hidden" value="<c:out value="${searchVO.searchKeyword}"/>"/>
    
		<fieldset>
        <legend class="hdn">사이트 입력 폼</legend>
        
        <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
          	<c:url var="listUrl" value="/mng/sym/sit/selectSiteInfoList.do">
		        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
				<c:param name="searchCondition" value="${searchVO.searchCondition}" />
				<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
        </div>
          
          
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
		  <caption> </caption>
          <colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label for="siteNm">기관명</label></th>
              <td>
              	<%-- <form:hidden path="insttCode"/> --%>
              	
              	<form:select path="insttCode">
              		<form:option value='' label="기관유형선택" />
     	      		<form:options items="${codeList}" itemValue="code" itemLabel="codeNm"/>
           		</form:select>
           		
           		<form:input path="siteNm" size="88" maxlength="100" cssClass="inp" /> <a href="#" style="display:none" onclick="fnOrgCodePop();return false;"><img src="${_IMG}/btn/btn_search02.gif"/></a>
                <div><form:errors path="siteNm"/></div>         
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="siteUrl">도메인</label></th>
              <td>
                <form:input path="siteUrl" size="100" maxlength="255" cssClass="inp" />
                <div><form:errors path="siteUrl"/></div>               
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="brwsrSj">브라우저타이틀</label></th>
              <td>
                <form:input path="brwsrSj" size="100" maxlength="100" cssClass="inp" />
                <div><form:errors path="brwsrSj"/></div>               
              </td>
            </tr>
            <tr>
              <th><label for="tlphonNo">전화번호</label></th>
              <td>
                <form:input path="tlphonNo" size="20" maxlength="15" cssClass="inp" />
                <div><form:errors path="tlphonNo"/></div>               
              </td>
            </tr>
            <tr>
              <th><label for="faxNo">팩스번호</label></th>
              <td>
                <form:input path="faxNo" size="20" maxlength="15" cssClass="inp" />
                <div><form:errors path="faxNo"/></div>               
              </td>
            </tr>
            <tr>
              <th><label for="upendLogoFileNm">상단로고</label></th>
              <td>
              	<input type="file" name="upendLogoFileIdFile" id="upendLogoFileNm" title="상단로고파일" class="input300 inp" >
              	<c:if test="${not empty siteManageVO.upendLogoFileNm}"><br/><img src="${SiteFileStoreWebPath}${siteManageVO.siteId}/${siteManageVO.upendLogoFileNm}"/></c:if>
              </td>
            </tr>
			<tr>
              <th><label for="lptLogoFileNm">하단로고</label></th>
              <td>
              	<input type="file" name="lptLogoFileIdFile" id="lptLogoFileNm" title="하단로고파일" class="input300 inp" >
              	<c:if test="${not empty siteManageVO.lptLogoFileNm}"><br/><img src="${SiteFileStoreWebPath}${siteManageVO.siteId}/${siteManageVO.lptLogoFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
              <th><label for="peprsntImageFileNm">대표이미지</label></th>
              <td>
              	<input type="file" name="peprsntImageFile" id="peprsntImageFile" title="대표이미지" class="input300 inp" >
              	<c:if test="${not empty siteManageVO.peprsntImageFileNm}"><br/><img src="${SiteFileStoreWebPath}${siteManageVO.siteId}/${siteManageVO.peprsntImageFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
              <th><label for="sloganFileNm">슬로건</label></th>
              <td>
              	<input type="file" name="sloganFile" id="sloganFile" title="슬로건" class="input300 inp" >
              	<c:if test="${not empty siteManageVO.sloganFileNm}"><br/><img src="${SiteFileStoreWebPath}${siteManageVO.siteId}/${siteManageVO.sloganFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
              <th><label for="sloganReplcText">슬로건대체텍스트</label></th>
              <td>
                <form:textarea path="sloganReplcText" rows="5" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="sloganReplcText"/></div>                                
              </td>   
            </tr>
            <tr>
              <th><label for="adres">주소</label></th>
              <td>
                <form:input path="adres" size="100" maxlength="100" cssClass="inp" />
                <div><form:errors path="adres"/></div>               
              </td>
            </tr>
            <tr>
              <th><label for="adresFileNm">주소파일</label></th>
              <td>
              	<input type="file" name="adresFileIdFile" id="adresFileNm" title="주소파일명" class="input300 inp" >
              	<c:if test="${not empty siteManageVO.adresFileNm}"><br/><img src="${SiteFileStoreWebPath}${siteManageVO.siteId}/${siteManageVO.adresFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
              <th><label for="adresReplcText">주소대체텍스트</label></th>
              <td>
                <form:textarea path="adresReplcText" rows="5" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="adresReplcText"/></div>                                
              </td>   
            </tr>
            <tr>
              <th><label for="la">위도</label></th>
              <td>
                <form:input path="la" size="20" maxlength="15" cssClass="inp" />
                <div><form:errors path="la"/></div>                                
              </td>   
            </tr>
            <tr>
              <th><label for="lo">경도</label></th>
              <td>
                <form:input path="lo" size="20" maxlength="15" cssClass="inp" />
                <div><form:errors path="lo"/></div>                                
              </td>   
            </tr>
             <tr>
              <th>홈페이지 레이아웃</th>
              <td>     
              	<table>
              		<caption>홈페이지 레이아웃 설정폼</caption>
						<colgroup>
							<col width="130"/>
							<col/>
						</colgroup>
							<tbody>
			              		<tr>
			              			<td>
			              				<table>
			              					<tr><td align="center" style="height:30px;background-color:rgb(248, 248, 248)"><strong><font color="#666666">레이아웃</font></strong></td></tr>
			              					<tr>
			              						<td>            				
						           					<c:choose>
						           						<c:when test="${not empty lytSourcVO.prevewFileNm}">
						           							<a href="#" onclick="fnImagePreviewBefore('lytSourcImage');return false;"><img id="lytSourcImage" src="${sourcFileStoreWebPathByPreFile}/${lytSourcVO.prevewFileNm}" width="120" height="107"/></a>
						           						</c:when>
						           						<c:otherwise>
						           							<a href="#" onclick="fnImagePreviewBefore('lytSourcImage');return false;"><img id="lytSourcImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
						           						</c:otherwise>
						           					</c:choose>   
			           							</td>
			           						</tr>
			           						<tr>
						              			<td align="center"><div id="lytSourcNm"><c:out value="${lytSourcVO.sourcNm}"/></div></td>
						              		</tr>
						              		<tr>
						              			<td align="center"><a href="#" onclick="fn_egov_selectSourc('sit'); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
						              		</tr>
						              	</table>    
			              			</td>
			              			<td>
			              				<table>
			              					<tr><td align="center" style="height:30px;background-color:rgb(248, 248, 248)"><strong><font color="#666666">템플릿</font></strong></td></tr>
			              					<tr>
			              						<td>            				
						           					<c:choose>
						           						<c:when test="${not empty lytTmplatVO.prevewFileNm}">
						           							<a href="#" onclick="fnImagePreviewBefore('lytTmplatImage');return false;"><img id="lytTmplatImage" src="${tmplatFileStoreWebPathByPreFile}/${lytTmplatVO.prevewFileNm}" width="120" height="107"/></a>
						           						</c:when>
						           						<c:otherwise>
						           							<a href="#" onclick="fnImagePreviewBefore('lytTmplatImage');return false;"><img id="lytTmplatImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
						           						</c:otherwise>
						           					</c:choose>   
			           							</td>
			           						</tr>
			           						<tr>
						              			<td align="center"><div id="lytTmplatNm"><c:out value="${lytTmplatVO.tmplatNm}"/></div></td>
						              		</tr>
						              		<tr>
						              			<td align="center"><a href="#" onclick="fn_egov_selectTemplate('sit'); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
						              		</tr>
						              	</table>    
			              			</td>
			              			<td>
				              			<table>
				              				<tr><td align="center" style="height:30px;background-color:rgb(248, 248, 248)"><strong><font color="#666666">메인화면 게시판</font></strong></td></tr>
			              					<tr>
			              						<td>
						              				<select id="bbsIdList" name="bbsIdList" multiple="multiple" size="11" style="width:120px;height:107px">
						              					<c:forEach var="result" items="${siteManageVO.mainContentsList}" varStatus="status">
						              						<option value="${result.progrmId}"><c:out value="${result.progrmNm}"/></option>
						              					</c:forEach>
						              				</select>			              				
						              			</td>	
						              			<td width="40" align="center">
						              				<a href="#" onclick="fnContentMove('SMCTS01', 'UP');return false;"><img src="${_IMG}/btn/btn_goup.gif" alt="위로이동"/></a>
						              				<br/>
						              				<a href="#" onclick="fnContentMove('SMCTS01', 'DOWN');return false;"><img src="${_IMG}/btn/btn_godown.gif" alt="아래로이동"/></a>
						              			</td>		              			
						              		</tr>
						              		<tr>
						              			<td align="center">추가/삭제</td>
						              		</tr>
						              		<tr>
						              			<td align="center">
						              				<a href="#" onclick="fnContentAdd('SMCTS01');return false;"><img src="${_IMG}/btn/btn_plus.gif" alt="추가"/></a>			              				
						              				<a href="#" onclick="fnContentDel('SMCTS01');return false;"><img src="${_IMG}/btn/btn_minus.gif" alt="삭제"/></a>
						              			</td>
						              		</tr>
						              	</table>
					              	</td>
			              		</tr>
			              	</tbody>
              	</table>  
              </td>
            </tr>
            <tr>
              <th>커뮤니티 레이아웃</th>
              <td>     
              	<table>
              		<caption>커뮤니티 레이아웃 설정폼</caption>
						<colgroup>
							<col width="130"/>
							<col/>
						</colgroup>
							<tbody>
			              		<tr>
			              			<td>
			              				<table>
			              					<tr><td align="center" style="height:30px;background-color:rgb(248, 248, 248)"><strong><font color="#666666">레이아웃</font></strong></td></tr>
			              					<tr>
			              						<td>            				
						           					<c:choose>
					           						<c:when test="${not empty cmySourcVO.prevewFileNm}">
					           							<a href="#" onclick="fnImagePreviewBefore('cmySourcImage');return false;"><img id="cmySourcImage" src="${sourcFileStoreWebPathByPreFile}/${cmySourcVO.prevewFileNm}" width="120" height="107"/></a>
					           						</c:when>
					           						<c:otherwise>
					           							<a href="#" onclick="fnImagePreviewBefore('cmySourcImage');return false;"><img id="cmySourcImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
					           						</c:otherwise>
					           					</c:choose> 
			           							</td>
			           						</tr>
			           						<tr>
						              			<td align="center"><div id="cmySourcNm"><c:out value="${cmySourcVO.sourcNm}"/></div></td>
						              		</tr>
						              		<tr>
						              			<td align="center"><a href="#" onclick="fn_egov_selectSourc('cmy'); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
						              		</tr>
						              	</table>    
			              			</td>
			              			<td>
			              				<table>
			              					<tr><td align="center" style="height:30px;background-color:rgb(248, 248, 248)"><strong><font color="#666666">템플릿</font></strong></td></tr>
			              					<tr>
			              						<td>            				
						           					<c:choose>
					           						<c:when test="${not empty cmyTmplatVO.prevewFileNm}">
					           							<a href="#" onclick="fnImagePreviewBefore('cmyTmplatImage');return false;"><img id="cmyTmplatImage" src="${tmplatFileStoreWebPathByPreFile}/${cmyTmplatVO.prevewFileNm}" width="120" height="107"/></a>
					           						</c:when>
					           						<c:otherwise>
					           							<a href="#" onclick="fnImagePreviewBefore('cmyTmplatImage');return false;"><img id="cmyTmplatImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
					           						</c:otherwise>
					           					</c:choose> 
			           							</td>
			           						</tr>
			           						<tr>
						              			<td align="center"><div id="cmyTmplatNm"><c:out value="${cmyTmplatVO.tmplatNm}"/></div></td>
						              		</tr>
						              		<tr>
						              			<td align="center"><a href="#" onclick="fn_egov_selectTemplate('cmy'); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
						              		</tr>
						              	</table>    
			              			</td>
			              		</tr>
			              	</tbody>
              	</table>  
              </td>
            </tr>
            <c:if test="${_MODE eq 'REG'}">
            <tr>
                <th>기본메뉴 자동생성</th>
                <td>
          	     	<spring:message code="button.yes" /> : <form:radiobutton path="autoMakeMenuAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="autoMakeMenuAt"  value="N" />
                </td>
              </tr>
            </c:if>
            <tr>
              <th>보안설정 <c:if test="${USER_INFO.userSe > 10}">[<input type="checkbox" id="scrtySetupBtcbAt" name="scrtySetupBtcbAt" value="Y"/><label for="scrtySetupBtcbAt">일괄적용</label>]</c:if>
              </th>
              <td>
                	<table>
						<caption>보안설정폼</caption>
						<colgroup>
							<col width="130"/>
							<col/>
						</colgroup>
							<tbody>
								<tr>
									<th> <label>마우스보안허용</label></th>
									<td>
										<spring:message code="button.yes" /> : <form:radiobutton path="mouseScrtyApplcAt"  value="Y" />&nbsp;
					          	     	<spring:message code="button.no" /> : <form:radiobutton path="mouseScrtyApplcAt"  value="N"  />
					          	     	<br/><form:errors path="mouseScrtyApplcAt" />
									</td>
								</tr>
								<tr>
									<th> <label>키보드보안허용</label></th>
									<td>
										<spring:message code="button.yes" /> : <form:radiobutton path="kybrdScrtyApplcAt"  value="Y" />&nbsp;
					          	     	<spring:message code="button.no" /> : <form:radiobutton path="kybrdScrtyApplcAt"  value="N"  />
					          	     	<br/><form:errors path="kybrdScrtyApplcAt" />
									</td>
								</tr>
								<tr style="display:none">
									<th> <label>중복로그인허용</label></th>
									<td>
										<spring:message code="button.yes" /> : <form:radiobutton path="dplctLoginPermAt"  value="Y" />&nbsp;
					          	     	<spring:message code="button.no" /> : <form:radiobutton path="dplctLoginPermAt"  value="N"  />
					          	     	<br/><form:errors path="dplctLoginPermAt" />
									</td>
								</tr>
								<tr style="display:none">
									<th> <label><em>*</em> 비밀번호길이</label></th>
									<td>
										<form:input path="passwordMummLt" size="5" cssClass="inp"/> ~ <form:input path="passwordMxmmLt" size="5" cssClass="inp"/>
									</td>
								</tr>
								<tr style="display:none">
									<th> <label><em>*</em> 비밀번호조합</label></th>
									<td>
										<form:checkbox path="passwordNumberPolicyAt" value="Y" label="숫자"/> +
										<form:checkbox path="passwordChrctrPolicyAt" value="Y" label="문자"/> +
										<form:checkbox path="passwordSpclchrctrPolicyAt" value="Y" label="특수문자"/>
									</td>
								</tr>
								<tr style="display:none">
									<th> <label><em>*</em> 비밀번호변경주기</label></th>
									<td>
										<form:input path="passwordChangeCycle" size="5" cssClass="inp"/>개월
									</td>
								</tr>
							</tbody>
						</table>     
              </td>
            </tr>
            <tr>
              <th>보안정책 <c:if test="${USER_INFO.userSe > 10}">[<input type="checkbox" id="scrtyPolicyBtcbAt" name="scrtyPolicyBtcbAt" value="Y"/><label for="scrtyPolicyBtcbAt">일괄적용</label>]</c:if></th>
              <td>
                	<table width="100%">
						<caption>보안정책</caption>
						<colgroup>
							<col width="130"/>
							<col/>
						</colgroup>
							<tbody>
								<tr>
									<td colspan="2">
										<img src="${_IMG}/btn/btn_minus.gif" class="imgCol" style="display:none"/><img src="${_IMG}/btn/btn_plus.gif" class="imgCol"/> <strong class="org">* 변동정보는 다음과같이 입력하세요 (기관명:<font color="#7d7d7d">$SITE_NM$</font>, 전화번호:<font color="#7d7d7d">$PHONE_NO$</font>, 팩스번호:<font color="#7d7d7d">$FAX_NO$</font>)</strong>
									</td>
								</tr>
					            <tr class="editor" style="display:none">
					              <th><label for="indvdlInfoPolicy">개인정보처리방침</label></th>
					              <td>
					                <form:textarea path="indvdlInfoPolicy" rows="30" cssStyle="width:90%;" cssClass="inp_default" />
					                <div><form:errors path="indvdlInfoPolicy"/></div>         
					              </td>
					            </tr>
					            <tr class="editor" style="display:none">
					              <th><label for=cpyrhtSttemntSvc>저작권신고서비스</label></th>
					              <td>
					                <form:textarea path="cpyrhtSttemntSvc" rows="30" cssStyle="width:90%;" cssClass="inp_default" />
					                <div><form:errors path="cpyrhtSttemntSvc"/></div>         
					              </td>
					            </tr>
					            <tr class="editor" style="display:none">
					              <th><label for="emailColctPolicy">이메일수집거부</label></th>
					              <td>
					                <form:textarea path="emailColctPolicy" rows="30" cssStyle="width:90%;" cssClass="inp_default" />
					                <div><form:errors path="emailColctPolicy"/></div>         
					              </td>
					            </tr>
					            <tr class="editor" style="display:none">
					              <th><label for="useStplat">가입약관</label></th>
					              <td>
					                <form:textarea path="useStplat" rows="30" cssStyle="width:90%;" cssClass="inp_default" />
					                <div><form:errors path="useStplat"/></div>         
					              </td>
					            </tr>
							</tbody>
						</table>     
              </td>
            </tr>
            <tr>
                <th>활성여부</th>
                <td>
          	     	<spring:message code="button.yes" /> : <form:radiobutton path="actvtyAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="actvtyAt"  value="N"  />
          	     	<br/><form:errors path="actvtyAt" />
                </td>
              </tr>
    
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
          	<c:url var="listUrl" value="/mng/sym/sit/selectSiteInfoList.do">
		        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
				<c:param name="searchCondition" value="${searchVO.searchCondition}" />
				<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
      </form:form>

    </div>        

    <c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	