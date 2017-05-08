<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.com.evt.service.ComtnschdulinfoVO"%>
<c:set var="LOGIN_USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_PREFIX" value="/evt"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="menuId" value="${searchVO.menuId}"/>	
		<c:param name="pageIndex" value="${searchVO.pageIndex}" />
       	<c:if test="${!empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
		<c:if test="${!empty searchVO.searchYear}"><c:param name="searchYear" value="${searchVO.searchYear}" /></c:if>
		<c:if test="${!empty searchVO.searchMonth}"><c:param name="searchMonth" value="${searchVO.searchMonth}" /></c:if>	
		<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
		<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
	<c:param name="leftMenuViewAt" value="N"/>
</c:import>
<style type="text/css">
	#sub_container #sub_contnts{border-left:0px}
	#sub_container #sub_contnts{width:940px;padding:30px;min-height:400px;}
	#sub_container .container{background:none;}
	#sub_container  #contents{width:100%;}
	#sub_container #content{width:940px;padding:30px;min-height:400px;}
</style>
<div id="schedule">
		
		<ul class="cal_type">
			<c:url var="calendarUrl" value="${_PREFIX}/selectSchdulinfoCalendar.do${_BASE_PARAM}">
				<c:param name="mode" value="1" />
			</c:url>
			<li><a href="<c:out value='${calendarUrl}'/>" <c:if test="${searchVO.mode eq '1'}">class="this"</c:if>><span class="ctype1">달력으로 보기</span></a></li>
			<c:url var="listUrl" value="${_PREFIX}/selectSchdulinfoList.do${_BASE_PARAM}">
				<c:param name="mode" value="2" />
			</c:url>
			<li><a href="<c:out value='${listUrl}'/>" <c:if test="${searchVO.mode eq '2'}">class="this"</c:if>><span class="ctype2">목록으로 보기</span></a></li>
		</ul>
		
		<div class="schedule_view">
				<h3><c:out value='${comtnschdulinfoVO.schdulNm}'/></h3>	
				<dl class="view_info">
					<dt>분류 ${comtnschdulinfoVO.state } / ${comtnschdulinfoVO.useAt }</dt>
					<dd>
						<c:choose>
							<c:when test="${comtnschdulinfoVO.state and comtnschdulinfoVO.useAt eq 'Y'}">
								<span class="progress"><em>진행중</em></span>
							</c:when>
							<c:otherwise>
								<c:choose>
								<c:when test="${comtnschdulinfoVO.state and comtnschdulinfoVO.useAt eq 'N'}"><span class="ready"><em>대기중</em></span></c:when>
								<c:when test="${comtnschdulinfoVO.useAt eq 'C'}"><span class="finish"><em>마감</em></span></c:when>
								<c:when test="${comtnschdulinfoVO.useAt eq 'R'}"><span class="finish"><em>마감</em></span></c:when>
								<c:otherwise><span class="finish"><em>마감</em></span></c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</dd>
				</dl>
				<dl class="view_info2">
					<dt  class="writer">작성자</dt>
					<dd class="writer">관리자</dd>
					<dt>작성일</dt>
					<dd><fmt:formatDate value="${comtnschdulinfoVO.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></dd>
					<dt>조회수</dt>
					<dd ><fmt:formatNumber value="${comtnschdulinfoVO.inqireCo}" type="number"/></dd>
				</dl>
				<dl class="view_info">
					<dt>행사일정</dt>
					<dd>
						<c:out value="${fn:substring(comtnschdulinfoVO.schdulBgnde, 0,4)}-${fn:substring(comtnschdulinfoVO.schdulBgnde, 4,6)}-${fn:substring(comtnschdulinfoVO.schdulBgnde, 6,8)} ${fn:substring(comtnschdulinfoVO.schdulBgnde, 8,10)}:${fn:substring(comtnschdulinfoVO.schdulBgnde, 10,12)}"/> ~
            			<c:out value="${fn:substring(comtnschdulinfoVO.schdulEndde, 0,4)}-${fn:substring(comtnschdulinfoVO.schdulEndde, 4,6)}-${fn:substring(comtnschdulinfoVO.schdulEndde, 6,8)} ${fn:substring(comtnschdulinfoVO.schdulEndde, 8,10)}:${fn:substring(comtnschdulinfoVO.schdulEndde, 10,12)}"/>
            		</dd>
				</dl>
	
				<div class="view_cont"><c:url value='${comtnschdulinfoVO.schdulCn}'/></div>
			
				
			</div>
	
			<div class="btn_r">
				<c:choose>
					<c:when test="${empty LOGIN_USER_INFO and comtnschdulinfoVO.schdulClCode ne '1'}">
					<a href="#" onclick="alert('로그인이 필요합니다.');return false;" class="btn"><span>참여하기</span></a>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${comtnschdulinfoVO.state and comtnschdulinfoVO.useAt eq 'Y' and comtnschdulinfoVO.schdulClCode ne '1'}">
							<c:url var="addUrl" value="${_PREFIX}/selectComtnschdulEvent.do"> 
								<c:param name="schdulId" value="${comtnschdulinfoVO.schdulId}" />
								<c:param name="schdulClCode" value="${comtnschdulinfoVO.schdulClCode}" />
							</c:url>
							<a href="<c:out value='${addUrl}'/>" onclick="window.open(this.href,'evtPartcptn','height=600,width=550,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" class="btn" target="_blank" title="참여하기"><span>참여하기</span></a>
							</c:when>
						</c:choose>
						<c:if test="${comtnschdulinfoVO.schdulClCode eq '3' and evtCheck gt 0}">
							<c:url var="resultUrl" value="${_PREFIX}/selectComtnschdulResult.do"> 
								<c:param name="schdulId" value="${comtnschdulinfoVO.schdulId}" />
								<c:param name="schdulClCode" value="${comtnschdulinfoVO.schdulClCode}" />
							</c:url>
							<a href="<c:out value='${resultUrl}'/>" onclick="window.open(this.href,'evtResult','height=700,width=680,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" class="btn" target="_blank" title="결과보기"><span>결과보기</span></a> 
						</c:if>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${searchVO.mode eq '1'}"><c:set var="listTarget" value="selectSchdulinfoCalendar.do${_BASE_PARAM}" /></c:when>
					<c:when test="${searchVO.mode eq '2'}"><c:set var="listTarget" value="selectSchdulinfoList.do${_BASE_PARAM}" /></c:when>					
				</c:choose>
		        <c:url var="listUrl" value="${_PREFIX}/${listTarget}">
				</c:url>
		        <a href="<c:out value='${listUrl}'/>" class="btn"><span>목록으로</span></a>
			</div>
	
			
		</div>
		
        

<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>
