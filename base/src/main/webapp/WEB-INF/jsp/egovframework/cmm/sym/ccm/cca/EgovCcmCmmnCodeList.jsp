<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm/cca"/>
  
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="CODE_MANAGE"/>
	<c:param name="title" value="공통코드관리"/>
</c:import>

<script type="text/javascript">
	function fn_egov_CmmnCode(url) {
		var win = window.open(url ,'code',' scrollbars=yes, resizable=yes, left=0, top=0, width=760,height=650');
		if(win != null) {
			win.focus();
		}
	}
</script>

<div id="cntnts">
<form name="listForm" action="<c:url value='${_PREFIX}/EgovCcmCmmnCodeList.do'/>" method="post">
<input type="hidden" name="searchCode" value="<c:out value='${searchVO.searchCode}'/>"/>
	<p class="total">총 게시물 ${paginationInfo.totalRecordCount}개ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

	<table class="chart_board">
		<colgroup>
			<col class="co1"/>
			<col class="co6"/>
			<col class="co3"/>
			<col class="co3"/>
			<col class="co3"/>
			<col class="co3"/>
			<col class="co3"/>
		</colgroup>
		<thead>
		<tr>
			<th>순번</th>
			<th>분류명</th>
			<th>코드ID</th>
			<th>코드ID명</th>
			<th>사용여부</th>
			<th>코드갯수</th>
			<th>하위코드관리</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
		<tr>
			<td nowrap><fmt:formatNumber value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" type="number"/></td>
			<td nowrap><c:out value="${resultInfo.clCodeNm}"/></td>
			<td><c:out value="${resultInfo.codeId}"/></td>
			<td>
				<c:url var="viewUrl" value="${_PREFIX}/EgovCcmCmmnCodeModify.do">
				  <c:if test="${not empty resultInfo.codeId}"><c:param name="codeId" value="${resultInfo.codeId}" /></c:if>
				  <c:if test="${not empty param.pageIndex}"><c:param name="searchVO" value="${param.pageIndex}" /></c:if>
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
				</c:url>
				<a href="${viewUrl}"><c:out value="${resultInfo.codeIdNm}"/></a>
			</td>
			<td><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
			<td><c:out value="${resultInfo.codeCnt}"/></td>
			<td><a href="/mng/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do?searchCode=<c:out value="${resultInfo.codeId}"/>" onclick="fn_egov_CmmnCode(this.href);return false;"><img src="/template/manage/images/btn/btn_letter.gif"/></a></td>
		</tr>   
		</c:forEach>
		
		<c:if test="${fn:length(resultList) == 0}">
			<tr> 
				<td class="lt_text3" colspan=7>
					<spring:message code="common.nodata.msg" />
				</td>
			</tr>   	          				 			   
		</c:if>

	</tbody>  
</table>

	<div class="btn_r">
		<c:url var="registerUrl" value="${_PREFIX}/EgovCcmCmmnCodeRegist.do?">
			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<a href="${registerUrl}"><img src="${MNG_IMG}/btn/btn_creat.gif" alt="생성"/></a>
	</div>

	<div id="paging">
		<c:url var="pageUrl" value="${_PREFIX}/EgovCcmCmmnCodeList.do?">
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<ul>
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
		</ul>
	</div>
	
	<div id="bbs_search">
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCondition" class="select">
			<option value='1' <c:if test="${searchVO.searchCondition eq '1' || searchVO.searchCondition eq ''}">selected="selected"</c:if>>코드ID</option>
			<option value='2' <c:if test="${searchVO.searchCondition eq '2'}">selected="selected"</c:if>>코드ID명</option>
		   </select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input name="searchKeyword" type="text" size="25" class="inp" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35"  class="inp_s" id="inp_text"/>
		<input type=image src="${MNG_IMG}/btn/btn_search.gif" alt="검색"/>
	</div>


</form>

</DIV>

