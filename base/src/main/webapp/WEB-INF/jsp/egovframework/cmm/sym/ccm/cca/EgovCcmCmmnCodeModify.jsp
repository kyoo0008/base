<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm/cca"/>
 
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="CODE_MANAGE"/>
	<c:param name="validator" value="cmmnCode"/>
	<c:param name="title" value="공통코드 관리"/>
</c:import>

<script type="text/javaScript" language="javascript">
 function fn_egov_modify_CmmnCode(form){

		if(!validateCmmnCode(form)){ 			
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

<form:form commandName="cmmnCode" name="cmmnCode" method="post" action="${pageContext.request.contextPath}${_PREFIX}/EgovCcmCmmnCodeModify.do">
<form:hidden path="clCode"/>
<form:hidden path="codeId"/>

	<table class="chart2">
	<colgroup>
		<col width="150"/>
		<col width=""/>
	</colgroup>
	  <tr> 
	    <th><em>*</em> 분류코드명</th>
	    <td><c:out value="${cmmnCode.clCodeNm}"/></td>
	  </tr>
	  <tr>
	    <th><em>*</em> 코드ID</th>          
	    <td><c:out value="${cmmnCode.codeId}"/> </td>
	  </tr> 
	  <tr>
	    <th><em>*</em> <label for="codeIdNm">코드ID명</label></th>          
	    <td>
	      <form:input  path="codeIdNm" size="60" maxlength="60" cssClass="inp_long"/>
	      <form:errors path="codeIdNm"/>
	    </td>    
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="codeIdDc">코드ID설명</label></th>
	    <td>
	      <form:textarea path="codeIdDc" rows="7" cols="60" cssClass="inp_default"/>
	      <form:errors   path="codeIdDc"/>
	    </td>
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="useAt">사용여부</label></th>
	    <td>
	      <form:select path="useAt">
		      <form:option value="Y" label="사용"/>
		      <form:option value="N" label="미사용"/>
	      </form:select>
	    </td>    
	  </tr>     
	</table>

	<div class="btn_r">
		<c:url var="listUrl" value="${_PREFIX}/EgovCcmCmmnCodeList.do">
			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<input type="image" src="<c:url value='${MNG_IMG}/btn/btn_modify.gif'/>" alt="수정" onclick="return fn_egov_modify_CmmnCode(this.form);"/>

		<a href="<c:out value="${listUrl}"/>"><img src="<c:url value='${MNG_IMG}/btn/btn_list.gif'/>" alt="목록"/></a>
	</div>


</form:form>
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>