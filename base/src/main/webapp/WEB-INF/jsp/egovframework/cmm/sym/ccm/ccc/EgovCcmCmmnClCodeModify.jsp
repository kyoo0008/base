<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="CODE_MANAGE"/>
	<c:param name="validator" value="cmmnClCode"/>
	<c:param name="title" value="공통코드 관리"/>
</c:import>

<script type="text/javaScript">
function fn_egov_modify_CmmnClCode(form){

	if(!validateCmmnClCode(form)){ 			
		return;
	}
	if(confirm('<spring:message code="common.update.msg" />')) {
		return true;
	}else {
		return false;	
	}
}
</script>

<div id="cntnts">

<form:form commandName="cmmnClCode" name="cmmnClCode" method="post" action="${pageContext.request.contextPath}${_PREFIX}/EgovCcmCmmnClCodeModify.do">
<form:hidden path="clCode"/>

	<table class="chart2">
	<colgroup>
		<col width="150"/>
		<col width=""/>
	</colgroup>
	  <tr>
	    <th><em>*</em> <label for="clCode">분류코드</label></th>          
	    <td><c:out value="${cmmnClCode.clCode}"/></td>
	  </tr> 
	  <tr>
	    <th><em>*</em> <label for="clCodeNm">분류코드명</label></th>          
	    <td>
	      <form:input path="clCodeNm" size="60" maxlength="60" cssClass="inp_long"/>
	      <form:errors path="clCodeNm"/>
	    </td>    
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="clCodeDc">분류코드설명</label></th>
	    <td>
	      <form:textarea path="clCodeDc" rows="7" cols="60" cssClass="inp_default"/>
	      <form:errors path="clCodeDc"/>
	    </td>
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="useAt">사용여부</label></th>
	    <td>
	      <form:select path="useAt">
		      <form:option value="Y" label="Yes"/>
		      <form:option value="N" label="No"/>
	      </form:select>
	    </td>    
	  </tr>     
	</table>

  	<div class="btn_r">
		<c:url var="listUrl" value="${_PREFIX}/EgovCcmCmmnClCodeList.do">
			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<input type="image" src="<c:url value='${MNG_IMG}/btn/btn_modify.gif'/>" alt="수정" onclick="return fn_egov_modify_CmmnClCode(this.form);"/>

		<!-- a href="${delUrl}" onclick="return confirm('삭제하시겠습니까?');"><img src="<c:url value='${MNG_IMG}/btn/btn_del.gif'/>" alt="삭제"/></a  -->
		<a href="<c:out value="${listUrl}"/>"><img src="<c:url value='${MNG_IMG}/btn/btn_list.gif'/>" alt="목록"/></a>
	</div>
	
</form:form>
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>