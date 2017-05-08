<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm/cde"/>

<c:import url="/mng/template/popTop.do" charEncoding="utf-8">
	<c:param name="validator" value="cmmnDetailCode"/>
	<c:param name="title" value="공통코드관리"/>
</c:import>

<script type="text/javaScript" language="javascript">
	function fn_egov_get_CodeId(form){
		form.cmd.value = "";
		form.submit();
	}

	function fn_egov_regist_CmmnDetailCode(form){
		
		if(!validateCmmnDetailCode(form)){ 			
			return false;
		}
		
		if(confirm('<spring:message code="common.save.msg" />')) {
			return true;
		}else {
			return false;	
		}
	}
</script>
<div id="cntnts">

<form:form commandName="cmmnDetailCode" name="cmmnDetailCode" method="post" action="${pageContext.request.contextPath}${_PREFIX}/EgovCcmCmmnDetailCodeRegist.do">
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
	    <th><em>*</em> <label for="clCode">코드ID</label></th>          
	    <td>
			<select name="clCode" class="select" onChange="javascript:fn_egov_get_CodeId(document.cmmnDetailCode)">
				<c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
					<option value='<c:out value="${result.clCode}"/>' <c:if test="${result.clCode == cmmnCode.clCode}">selected="selected"</c:if> ><c:out value="${result.clCodeNm}"/></option>
				</c:forEach>			  		   
			</select>
			<select name="codeId" class="select">
				<c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
					<option value='<c:out value="${result.codeId}"/>' <c:if test="${result.codeId eq searchVO.searchCode}">selected="selected"</c:if>><c:out value="${result.codeIdNm}"/></option>
				</c:forEach>			  		   
			</select>
	    </td>
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="code">코드</label></th>
	    <td>
	      <form:input  path="code" size="15" maxlength="15" cssClass="inp"/>
	      <form:errors path="code"/>
	    </td>
	  </tr>
	  <tr>
	    <th><em>*</em> <label for="codeNm">코드명</label></th>          
	    <td>
	      <form:input  path="codeNm" size="60" maxlength="60" cssClass="inp_long"/>
	      <form:errors path="codeNm"/>
	    </td>    
	  </tr> 
	  <tr> 
	    <th><em>*</em> <label for="codeDc">코드설명</label></th>
	    <td>
	      <form:textarea path="codeDc" rows="3" cols="60" cssClass="inp_default"/>
	      <form:errors   path="codeDc"/>
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
		<c:url var="listUrl" value="${_PREFIX}/EgovCcmCmmnDetailCodeList.do?">
			<c:if test="${not empty searchVO.searchCode}"><c:param name="searchCode" value="${searchVO.searchCode}" /></c:if>
			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<input type="image" src="<c:url value='/template/common/images/sub/board/btn_drawing.gif'/>" alt="저장" onclick="return fn_egov_regist_CmmnDetailCode(this.form);"/>
		<a href="<c:out value="${listUrl}"/>"><img src="<c:url value='/template/common/images/sub/board/btn_cancel.gif'/>" alt="취소"/></a>	
	</div>


</form:form>
</div>

<c:import url="/mng/template/popBottom.do" charEncoding="utf-8"/>
