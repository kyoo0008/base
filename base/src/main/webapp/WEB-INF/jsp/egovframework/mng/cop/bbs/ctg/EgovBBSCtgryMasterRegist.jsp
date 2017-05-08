<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_MODE" value=""/>
<c:set var="_PREFIX" value="${pageContext.request.contextPath}/mng/cop/bbs/ctg"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${empty searchVO.ctgrymasterId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertBBSCtgryMaster.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateBBSCtgryMaster.do"/>
	</c:otherwise>
</c:choose>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="BOARD_MANAGE"/>
	<c:param name="depth1" value="CTGRY_ADMIN"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="카테고리관리"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="ctgryMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fn_egov_regist(frm) {
	
	if (!validateCtgryMaster(frm)){
		return false;
	}
	
	if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
	
}

// -->
</script>

<div id="cntnts">

<form:form commandName="ctgryMaster" name="ctgryMaster" action="${_ACTION}" method="post" onsubmit="return fn_egov_regist(this)">
	
	<form:hidden path="siteId"/>
	<form:hidden path="sysTyCode"/>
    		
	<form:hidden path="ctgrymasterId"/>
	
	<!-- 검색조건 유지 -->
	<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

	<table class="chart2">
		<caption>등록폼</caption>
		<colgroup>
			<col class="co1"/>
			<col class="co2"/>
		</colgroup>
			<tbody>
				<tr>
					<th><em>*</em> <label>대분류명</label></th>
					<td>
						<form:input path="ctgrymasterNm" cssClass="inp_long"/>
						<br/><form:errors path="ctgrymasterNm" />
					</td>
				</tr>
			</tbody>
	</table>
  
	<div class="btn_r">
		<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
        <c:url var="listUrl" value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do">
        	<c:param name="siteId" value="${searchVO.siteId}" />
	        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
			<c:param name="searchCondition" value="${searchVO.searchCondition}" />
			<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
	    </c:url>
        <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
	</div>

</form:form>

</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	