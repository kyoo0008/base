<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/cmy"/>
  
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="CMMNTY_MANAGE"/>
	<c:param name="depth1" value="CMMNTY_ING"/>
	<c:param name="title" value="커뮤니티관리"/>
</c:import>

<script type="text/javascript">

	function fn_egov_delete_cmmnty(url){
		if(confirm('선택하신 커뮤니티를 폐쇄 하시겠습니까?')){
			document.location.href = url;	
			return true;
		}else{
			return false;
		}		
	}
</script>

<div id="cntnts">

	<c:if test="${USER_INFO.userSe > 10}">
		<form name="SiteListForm" action="${_PREFIX}/selectCmmntyUseList.do" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
	
<form name="listForm" action="<c:url value='${_PREFIX}/selectCmmntyUseList.do'/>" method="post">
	<p class="total">총 게시물 ${paginationInfo.totalRecordCount}개ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

	<table class="chart_board">
		<colgroup>
			<col class="co1"/>
			<col class="co3"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
		</colgroup>
		<thead>
		<tr>
			<th>순번</th>
			<th>커뮤니티명/주소</th>
			<th>운영여부</th>
			<th>회원수</th>
			<th>개설자</th>
			<th>생성일</th>
			<th>관리</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
		<tr>
			<td nowrap><fmt:formatNumber value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" type="number"/></td>
			<td class="tit">
				<c:out value="${result.cmmntyNm}"/><br/>
				<a href="http://<c:out value='${siteInfo.siteUrl}' />/cmy/<c:out value="${result.cmmntyAdres}"/>.do" target="_blank">http://<c:out value='${siteInfo.siteUrl}' />/cmy/<c:out value="${result.cmmntyAdres}"/>.do</a>
			</td>
			<td>
				<c:choose>
				 <c:when test="${result.useAt eq 'Y'}">운영중</c:when>
				 <c:otherwise>폐쇄</c:otherwise>
				</c:choose>
			</td>
			<td><fmt:formatNumber value="${result.userCo}" type="number"/></td>
			<td><c:out value="${result.frstRegisterNm}"/> (<c:out value="${result.frstRegisterId}"/>)</td>
			<td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
			<td>
			<c:url var="viewUrl" value="${_PREFIX}/selectCmmntyUseInfo.do">
				<c:param name="siteId" value="${searchVO.siteId}"/>
	       		<c:param name="cmmntyId" value="${result.cmmntyId}"/>
	       		<c:if test="${not empty searchVO.searchUse}"><c:param name="searchUse" value="${searchVO.searchUse}" /></c:if>
				<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
				<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
				<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			</c:url>							
        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
        	<!--
        	<c:url var="delUrl" value="${_PREFIX}/updtCmmntyClosing.do">
        		<c:param name="cmmntyId" value="${result.cmmntyId}"/>
				<c:if test="${not empty searchVO.searchUse}"><c:param name="searchUse" value="${searchVO.searchUse}" /></c:if>
				<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
				<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
				<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			</c:url>
        	<a href="${delUrl}" onclick="return fn_egov_delete_cmmnty(this.href);"><img src="${_IMG}/btn/del.gif"/></a>
        	-->
			</td>
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

	<div id="paging">
	<c:url var="pageUrl" value="${_PREFIX}/selectCmmntyUseList.do?">
		<c:if test="${not empty searchVO.searchUse}"><c:param name="searchUse" value="${searchVO.searchUse}" /></c:if>
		<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
	</c:url>
	<ul>
		<c:if test="${not empty paginationInfo}">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
		</c:if>
	</ul>
	</div>

	<div id="bbs_search">
		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchUse" class="select">
			<option value=''>운영여부</option>
			<option value='Y'<c:if test="${searchVO.searchUse eq 'Y'}"> selected="selected"</c:if>>운영중</option>
			<option value='N'<c:if test="${searchVO.searchUse eq 'N'}"> selected="selected"</c:if>>폐쇄</option>
		   </select>
		<select name="searchCnd" class="select">
			<option value=''>분류검색</option>
			<option value='0'<c:if test="${searchVO.searchCnd eq '0'}"> selected="selected"</c:if>>커뮤니티명</option>
			<option value='1'<c:if test="${searchVO.searchCnd eq '1'}"> selected="selected"</c:if>>개설자명</option>
			<option value='2'<c:if test="${searchVO.searchCnd eq '2'}"> selected="selected"</c:if>>커뮤니티명+개설자명</option>
			<option value='3'<c:if test="${searchVO.searchCnd eq '3'}"> selected="selected"</c:if>>커뮤니티소개</option>
			<option value='4'<c:if test="${searchVO.searchCnd eq '4'}"> selected="selected"</c:if>>커뮤니티주소</option>
		   </select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input name="searchWrd" type="text" size="25" class="inp" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35"  class="inp_s" id="inp_text"/>
		<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색"/>
	</div>


</form>

</DIV>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	