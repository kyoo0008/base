<%
 /**
  * @Class Name  : EgovRestdeDetail.jsp
  * @Description : EgovRestdeDetail 화면
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
<title>휴일 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/common/css/egovframework/cmm/sym/cal/com.css" />
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Restde(){
	location.href = "${pageContext.request.contextPath}/sym/cal/EgovRestdeList.do";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Restde(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/cal/EgovRestdeModify.do'/>";
	varForm.restdeNo.value   = "${result.restdeNo}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Restde(){
	if (confirm("<spring:message code="common.delete.msg" />")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/sym/cal/EgovRestdeRemove.do'/>";
		varForm.restdeNo.value   = "${result.restdeNo}";
		varForm.submit();
	}
}
-->
</script>
</head>
<form name="Form" action="" method="post">
	<input type=hidden name="restdeNo"/>
</form>
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%" class="title_left">
   <img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle" alt="제목"/>&nbsp;휴일 상세조회</td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
  <tr> 
    <th width="20%" height="23" class="required_text" nowrap >휴일일자<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"/></th>
    <td><c:out value='${fn:substring(result.restdeDe, 0,4)}'/>-<c:out value='${fn:substring(result.restdeDe, 4,6)}'/>-<c:out value='${fn:substring(result.restdeDe, 6,8)}'/></td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일명<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"/></th>          
    <td>${result.restdeNm}</td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일설명<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"/></th>          
    <td><textarea class="textarea"  cols="75" rows="14"  style="width:450px;" disabled="true">${result.restdeDc}</textarea></td>
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일구분<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"/></th>          
    <td>${result.restdeSe}</td>    
  </tr> 
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="수정" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_modify_Restde();">수정</a></td>
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="수정" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="삭제" width="8" height="20"></td>  
  <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_delete_Restde();">삭제</a></td>  
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="삭제" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="목록" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_list_Restde();">목록</a></td>
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="목록" width="8" height="20"></td>           
</tr>
</table>
