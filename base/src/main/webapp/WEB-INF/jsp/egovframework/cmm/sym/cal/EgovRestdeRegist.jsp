<%
 /**
  * @Class Name  : EgovRestdeRegist.jsp
  * @Description : EgovRestdeRegist 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<html>
<head>
<title>휴일 등록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/common/css/egovframework/cmm/sym/cal/com.css" />
<script type="text/javascript" src="<c:url value='/template/common/js/egovframework/cmm/sym/cal/EgovCalPopup.js' />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="restde" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Restde(){
	location.href = "${pageContext.request.contextPath}/sym/cal/EgovRestdeList.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
 function fn_egov_regist_Restde(form){
	if(confirm("<spring:message code="common.save.msg" />")){
		if(!validateRestde(form)){ 			
			return;
		}else{
			form.submit();
		}
	}
}
-->
</script>
</head>

<body>
<DIV id="content" style="width:712px">
<!-- ------------------------------------------------------------------ 상단타이틀 -->
<form:form commandName="restde" name="restde" method="post">
<!-- ----------------- 상단 타이틀  영역 -->
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left">
   <img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle" alt="제목">&nbsp;휴일 등록</td>
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
    <th width="20%" height="23" class="required_text" nowrap >휴일일자<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"  align="absmiddle"></th>
    <td width="80%" nowrap>
		<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
    	<form:hidden path="restdeDe" />
		<input name="vrestdeDe" type="text" size="10" value=""  maxlength="10" readonly onClick="javascript:fn_egov_NormalCalendar(document.restde, document.restde.restdeDe, document.restde.vrestdeDe);" />
		<a href="javascript:fn_egov_NormalCalendar(document.restde, document.restde.restdeDe, document.restde.vrestdeDe);" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/template/common/images/egovframework/cmm/sym/cal/bu_icon_carlendar.gif' />" alt="달력"></a>
   	</td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일명<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td width="80%" nowrap>
      <form:input  path="restdeNm" size="50" maxlength="50"/>
      <form:errors path="restdeNm"/>
    </td>    
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일설명<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td>
      <form:textarea path="restdeDc" rows="3" cols="60"/>
      <form:errors   path="restdeDc"/>
    </td>
  </tr> 
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >휴일구분<img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/required.gif" alt="필수"  width="15" height="15"></th>          
    <td width="80%" nowrap>    
      <form:select path="restdeSeCode">
	      <form:options items="${restdeCode}" itemValue="code" itemLabel="codeNm"/>
      </form:select>
	</td>
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
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="저장" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class=text_left" nowrap><a href="javascript:fn_egov_list_Restde()">목록</a></td>
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="저장" width="8" height="20"></td>      
  <td width="10"></td>

  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="저장" width="8" height="20"></td>
  <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_regist_Restde(document.restde);">저장</a></td>
  <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="저장" width="8" height="20"></td>      
</tr>
</table>

<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
</form:form>
</DIV>
</body>
</html>