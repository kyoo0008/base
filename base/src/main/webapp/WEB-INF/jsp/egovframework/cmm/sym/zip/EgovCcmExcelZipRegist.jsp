<%
 /**
  * @Class Name  : EgovCcmExcelZipRegist.jsp
  * @Description : EgovCcmExcelZipRegist 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>우편번호 엑셀파일 등록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/cmm/sym/zip/com.css" />
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
	location.href = "${pageContext.request.contextPath}/sym/ccm/zip/EgovCcmZipList.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
	var varForm				 = document.all["Form"];

	// 파일 확장명 확인
	var arrExt      = "xls";
	var objInput    = varForm.elements["fileNm"];
	var strFilePath = objInput.value;
	var arrTmp      = strFilePath.split(".");
	var strExt      = arrTmp[arrTmp.length-1].toLowerCase();

	if (arrExt != strExt) {
		alert("엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오. ");
		abort;
	} 
	
	varForm.action           = "${pageContext.request.contextPath}/sym/ccm/zip/EgovCcmExcelZipRegist.do";
	varForm.submit();

}
-->
</script>
</head>

<body>
<!-- 엑셀 등록 메시지  -->
${sResult}
<DIV id="content" style="width:712px">
<!-- ------------------------------------------------------------------ 상단타이틀 -->
<form name="Form" action="<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>" method="post" enctype="multipart/form-data" >
<!-- ----------------- 상단 타이틀  영역 -->
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left">
   <img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle" alt="제목">&nbsp;우편번호 엑셀파일 등록</td>
 </tr>
</table>
<!-- ------------------------------------------------------------------ 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<!-- ------------------------------------------------------------------ 등록  폼 영역  -->
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >우편번호 엑셀파일<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>
  	<td><input name="fileNm" type="file" /></td>
  </tr>
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>

<!-- ------------------------------------------------------------------ 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<!-- ------------------------------------------------------------------ 목록/저장버튼  -->
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="목록" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_bg.gif" class=text_left" nowrap><a href="javascript:fn_egov_list_Zip()">목록</a></td>
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="목록" width="8" height="20"></td>      
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="저장" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_bg.gif" class="text_left" nowrap><a href="JavaScript:javascript:fn_egov_regist_ExcelZip();">저장</a></td>
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="저장" width="8" height="20"></td>      
</tr>
</table>

<input name="cmd" type="hidden" value="<c:out value='ExcelZipRegist'/>"/>
</form>
</DIV>
</body>
</html>