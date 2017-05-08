<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm/cde"/>

<c:import url="/mng/template/popTop.do" charEncoding="utf-8">
	<c:param name="validator" value="cmmnDetailCode"/>
	<c:param name="title" value="공통코드관리"/>
</c:import>

<script type="text/javaScript" language="javascript">
 function fn_egov_modify_CmmnDetailCode(form){

		if(!validateCmmnDetailCode(form)){ 			
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

<form:form commandName="cmmnDetailCode" name="cmmnDetailCode" method="post" action="${_PREFIX}/EgovCcmCmmnDetailCodeModify.do">
<form:hidden path="codeId"/>
<form:hidden path="code"/>
<input type="hidden" name="searchCode" value="<c:out value='${searchVO.searchCode}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>

<table class="chart2">
	<colgroup>
		<col width="150"/>
		<col width=""/>
	</colgroup>
	  <tr>
	    <th><em>*</em> <label for="code">코드ID</label></th>          
	    <td><c:out value="${cmmnDetailCode.codeId}"/> (<c:out value="${cmmnDetailCode.codeIdNm}"/>)</td>
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="code">코드</label></th>
	    <td><c:out value='${cmmnDetailCode.code}'/></td>
	  </tr>
	  <tr>
	    <th><em>*</em> <label for="codeNm">코드명</label></th>          
	    <td>
	      <form:input  path="codeNm" maxlength="60" cssClass="inp_long"/>
	      <form:errors path="codeNm"/>
	    </td>    
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="codeDc">코드설명</label></th>
	    <td>
	      <form:textarea path="codeDc" rows="7" cols="60" cssClass="inp_default"/>
	      <form:errors path="codeDc"/>
	    </td>
	  </tr> 
	  <tr style="display:none;"> 
	    <th><em>*</em> <label for="useAt">사용여부</label></th>
	    <td>
	      	<spring:message code="button.yes" /> : <form:radiobutton path="useAt" value="Y" />&nbsp;
          	<spring:message code="button.no" /> : <form:radiobutton path="useAt" value="N"  />
          	<br/><form:errors path="useAt" />
	    </td>    
	  </tr>     
	</table>

	<div class="btn_r">
		<c:url var="listUrl" value="${_PREFIX}/EgovCcmCmmnDetailCodeList.do">
			<c:if test="${not empty searchVO.searchCode}"><c:param name="searchCode" value="${searchVO.searchCode}" /></c:if>
			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<input type="image" src="<c:url value='${MNG_IMG}/btn/btn_modify.gif'/>" alt="수정" onclick="return fn_egov_modify_CmmnDetailCode(this.form);"/>

		<a href="<c:out value="${listUrl}"/>"><img src="<c:url value='${MNG_IMG}/btn/btn_list.gif'/>" alt="목록"/></a>
	</div>

</form:form>
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>