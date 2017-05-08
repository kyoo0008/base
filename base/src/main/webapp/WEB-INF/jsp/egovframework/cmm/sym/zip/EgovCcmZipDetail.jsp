<%
 /**
  * @Class Name  : EgovCcmZipDetail.jsp
  * @Description : EgovCcmZipDetail 화면
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
<title>우편번호 상세조회</title>
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
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Zip(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipModify.do'/>";
	varForm.zip.value        = "${result.zip}";
	varForm.sn.value         = "${result.sn}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Zip(){
	if (confirm("<spring:message code="common.delete.msg" />")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipRemove.do'/>";
		varForm.zip.value        = "${result.zip}";
		varForm.sn.value         = "${result.sn}";
		varForm.submit();
	}
}
-->
</script>
</head>
<form name="Form" action="" method="post">
	<input type=hidden name="zip">
	<input type=hidden name="sn">
</form>
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%" class="title_left">
   <img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle" alt="제목">&nbsp;우편번호 상세조회</td>
 </tr>
</table>
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
  <tr> 
    <th width="20%" height="23" class="required_text" nowrap >우편번호<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>
    <td><c:out value='${fn:substring(result.zip, 0,3)}'/>-<c:out value='${fn:substring(result.zip, 3,6)}'/></td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >시도명<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.ctprvnNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >시군구명<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.signguNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >읍면동명<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.emdNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >리건물명<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.liBuldNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >번지동호<img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/zip/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>${result.lnbrDongHo}</td>    
  </tr> 
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="수정" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_modify_Zip();">수정</a></td>
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="수정" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="삭제" width="8" height="20"></td>  
  <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_delete_Zip();">삭제</a></td>  
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="삭제" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_left.gif" alt="목록" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_list_Zip();">목록</a></td>
  <td><img src="${pageContext.request.contextPath}/images/egovframework/cmm/sym/ccm/btn/bu2_right.gif" alt="목록" width="8" height="20"></td>           
</tr>
</table>
