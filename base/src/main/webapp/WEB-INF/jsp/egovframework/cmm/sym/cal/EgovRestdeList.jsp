<%
 /**
  * @Class Name  : EgovRestdeList.jsp
  * @Description : EgovRestdeList 화면
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
<title>휴일 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/common/css/egovframework/cmm/sym/cal/com.css" />
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/cal/EgovRestdeList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Restde(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Restde(){
	location.href = "/sym/cal/EgovRestdeRegist.do";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Restde(restdeNo){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/cal/EgovRestdeDetail.do'/>";
	varForm.restdeNo.value   = restdeNo;
	varForm.submit();
}
-->
</script>
</head>

<DIV id="content" style="display">
<form name="Form" action="" method="post">
	<input type=hidden name="restdeNo">
</form>
<form name="listForm" action="<c:url value='/sym/cal/EgovRestdeList.do'/>" method="post">
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%"class="title_left">

   <img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle" alt="제목"/>&nbsp;휴일 목록</td>
  <th>
  </th>
  <td width="10%">
   	<select name="searchCondition" class="select">
		   <option selected value=''>--선택하세요--</option>
		   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>휴일일자</option>
		   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>휴일명</option>
	   </select>
	</td>
  <td width="35%">
    <input name="searchKeyword" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" /> 
  </td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="조회" width="8" height="20"/></td>
      <td background="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_search_Restde();">조회</a></td>
      <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="조회" width="8" height="20"/></td>
      <td width="10"></td>

      <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_left.gif" alt="등록" width="8" height="20"/></td>
      <td background="${pageContext.request.contextPath}/images/egovframework/cmm/sym/cal/btn/bu2_bg.gif" class="text_left" nowrap><a href="javascript:fn_egov_regist_Restde();">등록</a></td>
      <td><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/btn/bu2_right.gif" alt="등록" width="8" height="20"/></td>
    </tr>
   </table>
  </th>  
 </tr>
</table>

<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<table width="700" cellpadding="0" class="table-line" border="0">
<thead>
<tr>  
	<th class="title" width="10%" nowrap>순번</th>
	<th class="title" width="20%" nowrap>휴일일자</th>
	<th class="title" width="30%" nowrap>휴일명</th>
	<th class="title" width="25%" nowrap>휴일구분</th>
</tr>
</thead>    
<tbody>
<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_detail_Restde('${resultInfo.restdeNo}');">
	<td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
	<td class="lt_text3" nowrap><c:out value='${fn:substring(resultInfo.restdeDe, 0,4)}'/>-<c:out value='${fn:substring(resultInfo.restdeDe,  4,6)}'/>-<c:out value='${fn:substring(resultInfo.restdeDe, 6, 8)}'/></td>
	<td class="lt_text" nowrap>${resultInfo.restdeNm}</td>
	<td class="lt_text3" nowrap>${resultInfo.restdeSe}</td>
</tr>   
</c:forEach>

<c:if test="${fn:length(resultList) == 0}">
	<tr> 
		<td class="lt_text3" colspan=4>
			<spring:message code="common.nodata.msg" />
		</td>
	</tr>   	          				 			   
</c:if>
    	
    	
</tbody>  
</table>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<div align="center">
	<div>
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="fn_egov_pageview"
				/>
	</div>
</div>

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>

</DIV>

