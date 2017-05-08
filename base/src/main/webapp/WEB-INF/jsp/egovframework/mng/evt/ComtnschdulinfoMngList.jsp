<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>

<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="MNG_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_PREFIX" value="/mng/evt"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="EVENT_MANAGE"/>
	<c:param name="depth1" value="EVENT_LIST"/>
	<c:param name="title" value="통합캘린더관리"/>
</c:import>

<%
 /**
  * @Class Name : ComtnschdulinfoList.jsp
  * @Description : Comtnschdulinfo List 화면
  * @Modification Information
  * 
  * @author 이호영
  * @since 2011.08.17
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<script type='text/javascript'>
	function fnEgovSchdulSe(setValue, mode) {
		location.href="./selectSchdulinfoList.do?searchYear=<c:out value='${searchVO.searchYear}' />&searchMonth=<c:out value='${searchVO.searchMonth}' />&searchSe=" + setValue +"&mode=" + mode;
	}

	function awardSelect(id) {
		if(confirm("추첨하시겠습니까?")) {
			location.href = "addComtneventprzwner.do?schdulId=" + id;
		}
	}

</script>

<!-- List -->
<div id="cntnts">

	<c:if test="${USER_INFO.userSe > 10}">
		<form name="SiteListForm" action="${pageContext.request.contextPath}${_PREFIX}/selectSchdulinfoList.do" method="post">
			<input type="hidden" name="searchSe" value="${searchVO.searchSe}" />
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
	
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">

	<p class="total">총 게시물 ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

	<table class="chart_board">
		<thead>
			<tr>
				<th align="center">번호</th>
				<th align="center">유형</th>
				<th align="center">제목</th>
				<th align="center">기간</th>
				<th align="center">진행상태</th>
				<th align="center">등록일</th>
				<c:if test="${searchVO.searchSe ne '1'}">
					<!-- <th align="center">발표일자</th>
					<th align="center">추첨</th>
					<th align="center">당첨결과</th> -->
					<th align="center">응시현황</th>
				</c:if>
				<th align="center">관리</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>																						
				<td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
				<td align="center" class="listtd">
					<c:choose>
					<c:when test="${result.schdulClCode eq '1'}">행사및일반일정</c:when>
					<c:when test="${result.schdulClCode eq '2'}">이벤트</c:when>
					<c:when test="${result.schdulClCode eq '3'}">설문조사</c:when>
					</c:choose>
				</td>
				<td align="center" class="tit"><c:out value="${result.schdulNm}"/></td>
				
				<td align="center" class="listtd">
					<c:out value="${fn:substring(result.schdulBgnde, 0,4)}.${fn:substring(result.schdulBgnde, 4,6)}.${fn:substring(result.schdulBgnde, 6,8)}"/>
					 ~ <c:out value="${fn:substring(result.schdulEndde, 0,4)}.${fn:substring(result.schdulEndde, 4,6)}.${fn:substring(result.schdulEndde, 6,8)}"/>&nbsp;</td>
					 
				<td align="center" class="listtd">
				<c:choose>
					<c:when test="${result.state eq '1' and result.useAt eq 'Y'}">
						<font color="red"><img src="${MNG_IMG}/evt/calendar_ing.gif" alt="진행중" /></font>
					</c:when>
					<c:otherwise>
						<c:choose>
						<c:when test="${result.state eq '1' and result.useAt eq 'N'}"><img src="${MNG_IMG}/evt/calendar_ready.gif" alt="대기중" /></c:when>
						<c:when test="${result.useAt eq 'C'}"><img src="${MNG_IMG}/evt/calendar_clos.gif" alt="마감" /></c:when>
						<c:when test="${result.useAt eq 'R'}"><img src="${MNG_IMG}/evt/calendar_resrve.gif" alt="보류" /></c:when>
						<c:otherwise><img src="${MNG_IMG}/evt/calendar_clos.gif" alt="마감" /></c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>

				</td>
				
				<td align="center" class="listtd"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/>&nbsp;</td>

				<c:if test="${searchVO.searchSe ne '1'}">
					<!-- 
					<td align="center" class="listtd">
						<c:choose>
							<c:when test="${result.schdulClCode ne '1'}"><c:out value="${result.presnatnDe}"/></c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
					
		            <td align="center">
		            	<c:choose>
							<c:when test="${result.schdulClCode ne '1' and result.useAt eq 'C'}">
							<c:url var="awardUrl" value="addComtneventprzwner.do">
								<c:param name="schdulId" value="${result.schdulId}" />
								<c:param name="przwnerNmpr" value="${result.przwnerNmpr}" />
								<c:if test="${!empty searchVO.mode}"><c:param name="mode" value="${searchVO.mode}" /></c:if>
								<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
								<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
							</c:url>
							<a href="<c:out value="${awardUrl}"/>" onclick="return confirm('응시자의 정답자중 총 ${result.przwnerNmpr}을 추첨 하시겠습니까?\n\n기존 추첨한 데이타가 존재시 삭제 됩니다.');"><img src="${MNG_IMG}/btn/drawin_n.gif" alt="추첨하기" width="70"/></a>
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
		            <td align="center">
						<c:choose>
							<c:when test="${result.schdulClCode ne '1'}">
							<c:url var="przwnerUrl" value="${_PREFIX}/selectComtneventprzwnerList.do">
								<c:param name="schdulId" value="${result.schdulId}" />
								<c:if test="${!empty searchVO.mode}"><c:param name="mode" value="${searchVO.mode}" /></c:if>
								<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
								<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
							</c:url>
							<a href="<c:out value="${przwnerUrl}"/>"><img src="${MNG_IMG}/btn/results_n.gif" alt="결과보기" width="70" /></a></c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
		            </td>
		             -->
		            <td align="center">
		            	<c:choose>
							<c:when test="${result.schdulClCode ne '1'}">
							<c:url var="adhrncUrl" value="${_PREFIX}/selectComtneventadhrncList.do">
								<c:param name="siteId" value="${searchVO.siteId}"/>
								<c:param name="schdulId" value="${result.schdulId}" />
								<c:param name="searchSe" value="${searchVO.searchSe}" />
								<c:if test="${!empty searchVO.mode}"><c:param name="mode" value="${searchVO.mode}" /></c:if>
								<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
								<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
							</c:url>
							<a href="<c:out value="${adhrncUrl}"/>"><img src="${MNG_IMG}/btn/construct_n.gif" alt="응시현황" width="70" border="0" /></a>
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
		            </td>
	            
	            </c:if>
	            
	            <td align="center">
		            <c:url var="viewUrl" value="${_PREFIX}/updateComtnschdulinfoView.do">
		            	<c:param name="siteId" value="${searchVO.siteId}"/>
						<c:param name="schdulId" value="${result.schdulId}" />
						<c:param name="searchSe" value="${searchVO.searchSe}" />
						<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
						<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
					</c:url>
	            	<a href="<c:out value="${viewUrl}"/>"><img src="${MNG_IMG}/btn/edit.gif" alt="수정하기" /></a>

	            	<c:url var="delUrl" value="deleteComtnschdulinfo.do">
	            		<c:param name="siteId" value="${searchVO.siteId}"/>
						<c:param name="schdulId" value="${result.schdulId}" />
						<c:param name="searchSe" value="${searchVO.searchSe}" />
						<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
						<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
					</c:url>
	            	<a href="<c:out value="${delUrl}"/>" onclick="return confirm('삭제하시겠습니까?');"><img src="${MNG_IMG}/btn/del.gif" alt="삭제하기" /></a>
	            </td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
		      <tr>
		      	<td class="listtd" colspan="11">
		        	<spring:message code="common.nodata.msg" />
		        </td>
		      </tr>
		    </c:if>
			</tbody>
		</table>
</form:form>

	
	
	<!-- /List -->
	<div id="paging"> 
		<c:url var="pageUrl" value="${_PREFIX}/selectSchdulinfoList.do?">
			<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="searchSe" value="${searchVO.searchSe}" />
			<c:if test="${not empty searchVO.searchSe}"><c:param name="schdulClCode" value="${searchVO.searchSe}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	    </c:url>
	    <c:set var="pageParam"><c:out value="${pageUrl}"/></c:set>
		<c:if test="${not empty paginationInfo}">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageParam}"  />
		</c:if>
	</div>
	
	
	<div id="bbs_search">
		<form name="frm" method="post" action="<c:url value='${_PREFIX}/selectSchdulinfoList.do'/>">
		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
		<input type="hidden" name="searchSe" value="${searchVO.searchSe}" />
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCondition" id="ftext">
			<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> >제목</option>
			<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> >내용</option>
		</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp_s" id="inp_text" />
		<input type=image src="${MNG_IMG}/board/btn_search.gif" alt="검색" />
		</form>
	 </div>

	<c:if test="${not empty searchVO.siteId }">
		<div class="btn_r">
			<c:url var="addUrl" value="${_PREFIX}/addComtnschdulinfoView.do">
				<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:param name="schdulClCode" value="${searchVO.searchSe}" />
				<c:if test="${not empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
				<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
			</c:url>
			<a href="<c:out value="${addUrl}"/>"><img src="${MNG_IMG}/btn/btn_creat.gif" alt="작성" /></a>
		</div>
	</c:if>
	
</div>
<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
