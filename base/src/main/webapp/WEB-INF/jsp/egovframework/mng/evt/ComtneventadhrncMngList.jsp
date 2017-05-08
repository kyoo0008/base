<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="MNG_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_PREFIX" value="/mng/evt"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="EVENT_MANAGE"/>
	<c:param name="depth1" value="EVENT_LIST"/>
	<c:param name="title" value="통합캘린더관리"/>
</c:import>	

<div id="cntnts">

		<form:form name="listForm" method="post">
			<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
			<input type="hidden" name="searchSe" value="${searchVO.searchSe}" />
        	<input name="pageIndex" type="hidden" value="<c:out value="${searchVO.pageIndex}" />"/>
		<p class="total">총 참여인원 ${paginationInfo.totalRecordCount}명ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}
		
		<c:url var="resultUrl" value="/evt/selectComtnschdulResult.do"> 
		<c:param name="schdulId" value="${searchVO.schdulId}" />
		</c:url>
		</p>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="colspan" value="0"/>
			<c:forEach var="resultAnswer" items="${result.userAnswerList}" varStatus="status">
				<c:set var="colspan" value="${colspan + 1}"/>
			</c:forEach>
		</c:forEach>
		<table class="chart_board">
		<thead>
			<tr>
				<th>번호</th>
				<th>구분</th>
				<th>아이디</th>
				<th>이름</th>
				<!-- <th colspan="${colspan}">제출답안</th>
				<th>점수</th> -->
				<th>제출일</th>
				<!-- <th width="75">수동추첨</th> -->
				<th width="75">삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="userScore" value="0"/>
			<tr>
				<td class="listtd"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
				<td class="listtd">
					<c:choose>
						<c:when test="${result.userTy eq 'S'}">학생</c:when>
						<c:when test="${result.userTy eq 'T'}">교사</c:when>
						<c:when test="${result.userTy eq 'P'}">일반</c:when>
						<c:when test="${result.userTy eq 'M'}">관리자</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose>
				</td>
				<td class="listtd"><c:out value="${result.userId}" /></td>
				<td class="listtd"><c:out value="${result.adhrncNm}" /></td>
				<!-- <c:forEach var="resultAnswer" items="${result.userAnswerList}" varStatus="status">
					<td class="listtd" width="70"><c:out value="${resultAnswer.userCnsr}" /></td>
					<c:set var="userScore" value="${userScore + resultAnswer.userScore}"/>
				</c:forEach>
				<td class="listtd"><c:out value="${userScore}" /></td>-->
				<td class="listtd"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
				<!-- 
				<td class="listtd">
					<c:if test="${result.wnerAt eq '0'}">
						<c:url var="awardUrl" value="${_PREFIX}/addComtneventprzwnerhopr.do">
							<c:param name="schdulId" value="${searchVO.schdulId}" />
							<c:param name="userId" value="${result.userId}" />
							<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
							<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
							<c:if test="${!empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
						</c:url>
						<a href="${awardUrl}" onclick="return confirm('선택하신 명단을 당첨 등록 하시겠습니까?');"><img src="${MNG_IMG}/btn/btn_evt1.gif" alt="수동추첨" /></a>
					</c:if>
				</td>
				 -->
				<td>
					<c:url var="delUrl" value="${_PREFIX}/deleteComtneventadhrnc.do">
						<c:param name="siteId" value="${searchVO.siteId}"/>
		            	<c:param name="userId" value="${result.userId}" />
		            	<c:param name="schdulId" value="${searchVO.schdulId}" />
		            	<c:if test="${!empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
						<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
						<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
					</c:url>
					<a href="${delUrl}" onclick="return confirm('삭제하시겠습니까?');"><img src="${MNG_IMG}/btn/del.gif" alt="삭제하기" /></a>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      	<td colspan="30"><spring:message code="common.nodata.msg" /></td>
	      </c:if>
		</tbody>
		</table>

	<div id="paging">
		<c:url var="pageUrl" value="${_PREFIX}/selectComtneventadhrncList.do?">
			<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="schdulId" value="${searchVO.schdulId}" />
			<c:if test="${not empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>

		<c:if test="${not empty paginationInfo}">
			<ul>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			</ul>
		</c:if>

	</div>

	<div id="bbs_search">
	<label for="ftext" class="hdn">분류검색</label>

		<select name="searchCondition">
			<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
			<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이름</option>
		</select>
		<input type="text" class="inp_s" id="inp_text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword }" />" />
		<input type="image" src="<c:url value='/template/common/images/sub/board/btn_search.gif'/>" alt="검색" />
	</div>
	<a href="${resultUrl}" onclick="window.open(this.href,'evtResult','height=700,width=680,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" target="_blank" title="결과보기"><img src="${MNG_IMG}/btn/result_s.gif"></a> 
	<a href="selectComtneventadhrncExcel.do?schdulId=<c:out value="${searchVO.schdulId}"/>"><img src="${pageContext.request.contextPath}/template/manage/images/excel.gif" alt="엑셀로 다운받기" /></a>
	</form:form>

</div>
<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	