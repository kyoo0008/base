<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/manage/js"/>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_MODE" value=""/>
<c:set var="_PREFIX" value="${pageContext.request.contextPath}/mng/cop/bbs/ctg"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${empty searchVO.ctgryId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertBBSCtgry.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateBBSCtgry.do"/>
	</c:otherwise>
</c:choose>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${param.ctgrymasterNm}"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="ctgry" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="${_JS}/select_design.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--


function fn_egov_regist(frm) {
	if (!validateCtgry(frm)){
		return false;
	}
	
	if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
}

// -->
</script>
<style type="text/css">
<!--
.selectBoxSelectedAreaGlobal {
	color:#626262;
	font-size:12px;
	font-family:dotum;
	font-weight:normal;
	background-color:#f5f5f5;
	padding-top:2px;
	line-height:22px;
	padding-left:5px;
	letter-spacing:-1px;
}
.selectBoxSelectedAreaFocusGlobal {
	color:#626262;
	font-size:12px;
	font-weight:normal;
	font-family:dotum;
	background-color:#f5f5f5;
	padding-top:2px;
	line-height:22px;
	padding-left:5px;
	letter-spacing:-1px;
}
.selectBoxOptionGlobal {
	color:#626262;
	font-size:12px;
	font-family:dotum;
	font-weight:normal;
	background-color:#f5f5f5;
	padding-top:2px;
	line-height:22px;
	padding-left:5px;
	letter-spacing:-1px;
}
.selectBoxOptionOverGlobal {
	color:#626262;
	font-size:12px;
	font-family:dotum;
	font-weight:normal;
	background-color:#e6e6e6;
	padding-top:2px;
	line-height:22px;
	padding-left:5px;
	letter-spacing:-1px;
}
.selectBoxOptionInnerLayer {
	overflow:auto;
	background-color:#f5f5f5;
	scrollbar-face-color:#F3F3F3;
	scrollbar-shadow-color:#6C6C6C;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-3dlight-color:#C9C9C9;
	scrollbar-darkshadow-color:#FFFFFF;
	scrollbar-track-color:#F3F3F3;
	scrollbar-arrow-color:#000000;
}
-->
</style>  
<div id="cntnts">

<form:form commandName="ctgry" name="ctgry" action="${_ACTION}" method="post" onsubmit="return fn_egov_regist(this)">

	<input type="hidden" name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
	<input type="hidden" name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
	<form:hidden path="ctgrymasterId"/>
	<form:hidden path="ctgryId"/>
	
	<table class="chart2">
		<caption>등록폼</caption>
		<colgroup>
			<col class="co1"/>
			<col class="co2"/>
		</colgroup>
			<tbody>
				<tr>
					<th><label>대분류명</label></th>
					<td><c:out value='${param.ctgrymasterNm}'/></td>
				</tr>
				<tr>
				<th><em>*</em> <label>상위카테고리</label></th>
				<td>
					<select name="upperCtgryId" id="upperCtgryId" style="width:300px;height:21px;display:none;">
						<c:forEach var="result" items="${ctgryList}" varStatus="status">
							<option value="${result.ctgryId}" <c:if test="${result.ctgryId == ctgry.upperCtgryId}">selected="selected"</c:if> ><c:forEach begin="1" end="${result.ctgryLevel}" step="1">&nbsp;</c:forEach><c:if test="${result.ctgryLevel ne 0}">&lt;img src=${_IMG}/btn/folder_${result.ctgryLevel}.gif&gt; </c:if><c:out value="${result.ctgryNm}"/></option>
						</c:forEach>		
					</select>
					<script>
						makeSelectBoxGlobal("upperCtgryId", "selectBoxSelectedAreaGlobal", "white", "${_IMG}/btn/select_btn.gif", "selectBoxOptionGlobal", "selectBoxSelectedAreaFocusGlobal", "selectBoxOptionOverGlobal");
					</script>
				</td>
			</tr>	
				<tr>
					<th><em>*</em> <label>카테고리명</label></th>
					<td>
						<form:input path="ctgryNm" cssClass="inp_long"/>
						<br/><form:errors path="ctgryNm" />
					</td>
				</tr>
			</tbody>
	</table>
	
	<div class="btn_r">
		<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
        <c:url var="listUrl" value="/mng/cop/bbs/ctg/selectBBSCtgryList.do">
        	<c:param name="ctgrymasterId" value="${searchVO.ctgrymasterId}" />
        	<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}" />
	        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
			<c:param name="searchCondition" value="${searchVO.searchCondition}" />
			<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
	    </c:url>
        <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
	</div>
	
</form:form>

</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	
