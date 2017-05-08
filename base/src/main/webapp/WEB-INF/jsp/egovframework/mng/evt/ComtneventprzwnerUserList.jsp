<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${param.userNm} (${param.userId}) 이벤트 당첨내역 조회"/>
</c:import>

<div id="cntnts">

<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

	<table class="chart_board">
		<colgroup>
			<col class="co2"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="*"/>
			<col class="*"/>
			<col class="co6"/>
		</colgroup>
	    <caption class="hdn">마일리지조회</caption>
	    <thead>
	      <tr>
	        <th class="first">번호</th>
	        <th>이벤트명</th>
	        <th>시작일</th>
	        <th>종료일</th>
	        <th>발표일</th>
	      </tr> 
	    </thead>
	    <tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
				<td><c:out value="${result.schdulNm}"/></td>
				<td><c:out value="${fn:substring(result.schdulBgnde, 0,4)}.${fn:substring(result.schdulBgnde, 4,6)}.${fn:substring(result.schdulBgnde, 6,8)} ${fn:substring(result.schdulBgnde, 8,10)}:${fn:substring(result.schdulBgnde, 10,12)}"/></td>
				<td><c:out value="${fn:substring(result.schdulEndde, 0,4)}.${fn:substring(result.schdulEndde, 4,6)}.${fn:substring(result.schdulEndde, 6,8)} ${fn:substring(result.schdulEndde, 8,10)}:${fn:substring(result.schdulEndde, 10,12)}"/></td>
				<td><c:out value="${result.presnatnDe}"/></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      <tr>
	        <td class="listCenter" colspan="8"><spring:message code="common.nodata.msg" /></td>
	      </tr>
	    </c:if>
		</tbody>
		</table>

		<div id="paging">
	    <c:url var="pageUrl" value="/mng/evt/selectComtneventprzwnerUserList.do"></c:url>						
	    <c:if test="${not empty paginationInfo}">
			<ul>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			</ul>
		</c:if>
	</div>


</div>	


<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	
