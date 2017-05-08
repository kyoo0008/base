<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_C_HTML" value="${pageContext.request.contextPath}/template/common/html"/>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>
<c:set var="_MODE" value=""/>
<c:set var="_EDITOR_ID" value="popupCn"/>

<c:choose>
	<c:when test="${empty searchVO.popupId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="ETC_MANAGE"/>
	<c:param name="depth1" value="ETC_POPUPWINDOW"/>	
	<c:param name="title" value="팝업관리"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript" src="${CMMN_JS }/egovframework/cmm/sym/cal/EgovCalPopup.js" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="popupManageVO" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript">
function fn_egov_regist(){
	if(!validatePopupManageVO(document.popupManageVO)){ 			
		return false;
	}
			
	var ntceBgndeYYYMMDD = $.trim($('#ntceBgndeYYYMMDD').val().replace(/-/g, ''));
	var ntceEnddeYYYMMDD = $.trim($('#ntceEnddeYYYMMDD').val().replace(/-/g, ''));

	if(ntceBgndeYYYMMDD == "") {
		alert("게시시작일자를 입력하세요");
		return false;
	}

	if(ntceEnddeYYYMMDD == "") {
		alert("게시종료일자를 입력하세요");
		return false;
	}

	var iChkBeginDe = Number(ntceBgndeYYYMMDD);
	var iChkEndDe = Number(ntceEnddeYYYMMDD);

	if(iChkBeginDe > iChkEndDe || iChkEndDe < iChkBeginDe ){
		alert("게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다. ");
		return false;
	}
	
	$('#ntceBgnde').val(ntceBgndeYYYMMDD + $('#ntceBgndeHH').val() +  $('#ntceBgndeMM').val());
	$('#ntceEndde').val(ntceEnddeYYYMMDD + $('#ntceEnddeHH').val() +  $('#ntceEnddeMM').val());
	
	if($('#${_EDITOR_ID}').html().length == 0) {
		alert('팝업내용은(는) 필수 입력값입니다');
		return false;
	}
	
	$('#fileGroupId').val($('#fileGroupId_${_EDITOR_ID}').val());
		
	if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
		return false;					
	}
}

function fnPopupWidth(width, height) {
	var form = document.popupManageVO;
	$('#popupWSize').val(width + 20);
	$('#popupHSize').val(height + ($('#stopVewAt').val() == 'Y' ? 30 : 20));
}

function onPreview(what) {
	var URL 	=	'';
	var winNM	=	'Preview';
	var OPT		=	'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=no,resizable=0,top=30,left=30,copyhistory=0 width=1024 height=859';		
	var imgwin = window.open(URL,winNM,OPT);	

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

$(document).ready( function() {
	
	var adfile_config = {
		storePath:"Popup.fileStorePath",
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
});
</script>


<div id="cntnts">
	<%-- 
	<c:choose>
		<c:when test="${_MODE eq 'REG' or _MODE == 'REG'} ">
			<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/pwm/registPopup.do"/>
		</c:when>
		<c:otherwise>
			<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/pwm/updtPopup.do"/>
		</c:otherwise>
	</c:choose>
	 --%>
	<c:if test="${_MODE eq 'REG' or _MODE == 'REG'}">
		<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/pwm/registPopup.do"/>
	</c:if>
	<c:if test="${_MODE eq 'UPT' or _MODE == 'UPT'}">
		<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/pwm/updtPopup.do"/>
	</c:if>
	<form:form commandName="popupManageVO" name="popupManageVO" action="${actionUrl}" method="post" onsubmit="return fn_egov_regist();">
		
		<form:hidden path="siteId"/>
      	<form:hidden path="sysTyCode"/>
      	
		<form:hidden path="popupId"/>
        <form:hidden path="ntceBgnde"/>
		<form:hidden path="ntceEndde"/>
		<form:hidden path="atchFileId"/>
		<form:hidden path="popupListAt"  value="Y" />
		<input name="cmd" type="hidden" value="save"/>		
		<input type="hidden" name="searchCondition" value="<c:out value="${searchVO.searchCondition}"/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
        <input type="hidden" id="posblAtchFileNumber_${_EDITOR_ID}" name="posblAtchFileNumber_${_EDITOR_ID}" value="100" />
        <input type="hidden" id="posblAtchFileSize_${_EDITOR_ID}" name="posblAtchFileSize_${_EDITOR_ID}" value="${2048 * 1024 * 1024}" />
		<input type="hidden" id="fileGroupId" name="fileGroupId" value="${popupManageVO.atchFileId}"/>
		<fieldset>
          <legend class="hdn">팝업창 입력 폼</legend>
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
			<caption> </caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label for="popupTitleNm">팝업창명</label></th>
              <td>
              	<form:input path="popupTitleNm" size="30" cssClass="inp_long" maxlength="225"/>
                <br/><form:errors path="popupTitleNm" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> 템플릿</th>
              <td>
              	<table border="0">
              		<tr>              		
		              	<td valign="top"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/999" <c:if test="${empty popupManageVO.fileUrl or popupManageVO.fileUrl eq '/uss/ion/pwn/999' }">checked="checked"</c:if>/> 기본<br><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/999.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/999.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/010" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/010' }">checked="checked"</c:if> onclick="fnPopupWidth(400, 420)"/> 템플릿1<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/010.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/010.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/020" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/020' }">checked="checked"</c:if> onclick="fnPopupWidth(445, 280)"/> 템플릿2<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/020.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/020.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/030" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/030' }">checked="checked"</c:if> onclick="fnPopupWidth(450, 250)"/> 템플릿3<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/030.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/030.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/040" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/040' }">checked="checked"</c:if> onclick="fnPopupWidth(530, 420)"/> 템플릿4<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/040.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/040.jpg" width="120" height="120"/></a></td>
		            </tr>
		            <tr>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/051" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/051' }">checked="checked"</c:if> onclick="fnPopupWidth(447, 420)"/> 템플릿5<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/051.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/051.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/052" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/052' }">checked="checked"</c:if> onclick="fnPopupWidth(442, 420)"/> 템플릿6<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/052.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/052.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/053" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/053' }">checked="checked"</c:if> onclick="fnPopupWidth(442, 420)"/> 템플릿7<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/053.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/053.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/054" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/054' }">checked="checked"</c:if> onclick="fnPopupWidth(437, 420)"/> 템플릿8<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/054.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/054.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/055" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/055' }">checked="checked"</c:if> onclick="fnPopupWidth(382, 420)"/> 템플릿9<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/055.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/055.jpg" width="120" height="120"/></a></td>
		            </tr>
		            <tr>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/056" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/056' }">checked="checked"</c:if> onclick="fnPopupWidth(517, 420)"/> 템플릿10<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/056.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/056.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/057" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/057' }">checked="checked"</c:if> onclick="fnPopupWidth(517, 420)"/> 템플릿11<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/057.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/057.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/058" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/058' }">checked="checked"</c:if> onclick="fnPopupWidth(517, 420)"/> 템플릿12<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/058.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/058.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/059" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/059' }">checked="checked"</c:if> onclick="fnPopupWidth(382, 420)"/> 템플릿13<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/059.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/059.jpg" width="120" height="120"/></a></td>
		              	<td valign="top" style="padding-left:10px"><input type="radio" name="fileUrl"  value="/uss/ion/pwn/060" <c:if test="${popupManageVO.fileUrl eq '/uss/ion/pwn/060' }">checked="checked"</c:if> onclick="fnPopupWidth(437, 420)"/> 템플릿14<br/><a href="#preview" onclick="onPreview('${CMMN_IMG}/popup/thumnail/060.jpg'); return false;"><img src="${CMMN_IMG}/popup/thumnail/060.jpg" width="120" height="120"/></a></td>		              	
              		</tr>
              	</table>
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="popupWlc">팝업창위치</label></th>
              <td>
				     좌측 : <form:input path="popupWlc" cssClass="inp" size="5" maxlength="10"/> px &nbsp;&nbsp; 상단 : <form:input path="popupHlc" cssClass="inp" size="5" maxlength="10"/> px
				  <form:errors path="popupWlc" cssClass="error"/>
				  <form:errors path="popupHlc" cssClass="error"/>
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="popupWSize">팝업창사이즈</label></th>
              <td>
                                    가로 : <form:input path="popupWSize" cssClass="inp" size="5" maxlength="10"/> px &nbsp;&nbsp; 세로 : <form:input path="popupHSize" cssClass="inp" size="5" maxlength="10"/> px
				  <form:errors path="popupWSize" cssClass="error"/>
				  <form:errors path="popupHSize" cssClass="error"/>
              </td>         
            </tr>
            
		   <tr> 
		    <th><em>*</em> <label id="IdNtceEnddeHH">게시 기간</label></th>
		    <td width="80%">
			    <input type="text" name="ntceBgndeYYYMMDD" id="ntceBgndeYYYMMDD" size="10" maxlength="10" class="inp" value="<c:out value="${fn:substring(popupManageVO.ntceBgnde, 0, 4)}" />-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceBgnde, 6, 8)}"/>" readonly="readonly"/>
			    <a href="#" onclick="javascript:fn_egov_NormalCalendar(document.popupManageVO, document.popupManageVO.ntceBgndeYYYMMDD);">
			    <img src="${CMMN_IMG }/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
			    </a>
			    <form:select path="ntceBgndeHH">
			        <form:options items="${ntceBgndeHH}" itemValue="code" itemLabel="codeNm"/>
			    </form:select>H
			    <form:select path="ntceBgndeMM">
			        <form:options items="${ntceBgndeMM}" itemValue="code" itemLabel="codeNm"/>
			    </form:select>M
			    <span>&nbsp;&nbsp;~&nbsp;&nbsp;</span>
			    <input type="text" name="ntceEnddeYYYMMDD" id="ntceEnddeYYYMMDD" size="10" maxlength="10" class="inp" value="<c:out value="${fn:substring(popupManageVO.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(popupManageVO.ntceEndde, 6, 8)}"/>"  readonly="readonly"/>
			    <a href="#" onclick="javascript:fn_egov_NormalCalendar(document.popupManageVO, document.popupManageVO.ntceEnddeYYYMMDD);">
			    <img src="${CMMN_IMG }/egovframework/cmm/sym/cal/bu_icon_carlendar.gif" align="middle" style="border:0px" alt="게시기간 종료달력" title="게시기간 종료달력"/>
			    </a>
			    <form:select path="ntceEnddeHH">
			        <form:options items="${ntceEnddeHH}" itemValue="code" itemLabel="codeNm"/>
			    </form:select>H
			    <form:select path="ntceEnddeMM">
			        <form:options items="${ntceEnddeMM}" itemValue="code" itemLabel="codeNm"/>
			    </form:select>M
		    </td>
		  </tr>
  
  			
            <tr>
              <th><em>*</em> <label for="stopVewAt">그만보기 설정 여부</label></th>
              <td>
              	설정함 : <form:radiobutton path="stopVewAt"  value="Y" />&nbsp;
              	설정안함 : <form:radiobutton path="stopVewAt"  value="N"  />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="ntceAt">게시여부</label></th>
              <td>
              	게시함 : <form:radiobutton path="ntceAt"  value="Y" />&nbsp;
              	게시안함 : <form:radiobutton path="ntceAt"  value="N"  />
              </td>         
            </tr>
            <%--
             <tr>
              <th><em>*</em> <label for="stopVewAt">팝업목록 게시여부</label></th>
              <td>
              	게시함 : <form:radiobutton path="popupListAt"  value="Y" />&nbsp;
              	게시안함 : <form:radiobutton path="popupListAt"  value="N"  />
              </td>         
            </tr> 
            --%>
			<tr>
			  <th><em>*</em> <label for="popupCn">내용</label></th>
              <td>
                <form:textarea path="popupCn" rows="30" cssStyle="width:100%"/>
                <form:errors path="popupCn" />
                
                <c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
                	<c:param name="editorId" value="${_EDITOR_ID}"/>
					<c:param name="estnAt" value="N" />
			    	<c:param name="param_atchFileId" value="${popupManageVO.atchFileId}" />
			    	<c:param name="imagePath" value="${_IMG }"/>
				</c:import>
              </td>
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
          <div class="btn_r">
            <input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }" alt="등록"/>
            <c:url var="listUrl" value="/mng/uss/ion/pwm/listPopup.do">
            	<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
            	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록" /></a>
          </div>
            
        </fieldset>
        
		</form:form>


</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	