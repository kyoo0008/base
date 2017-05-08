<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<c:set var="repleTxt"><strong class="orange">${searchVO.searchWrd}</strong></c:set>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/search/images"/>
<c:import url="/msi/sch/tmplatHead.do" charEncoding="utf-8"/>

				<div class="search_word">
					<strong class="sword">검색어</strong> "<strong class="orange"><c:out value="${searchVO.searchWrd}"/></strong>"에 대한 검색결과 입니다.
				</div>
		

				<div class="result_box">
					
				
					<h3 class="icon1">게시물 검색결과</h3>
					<div class="result1">
						<c:if test="${fn:length(resultList) == 0}">
							<p class="empty"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(resultList) > 0}"> 
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:url var="viewUrl" value="http://${result.siteUrl}/cop/bbs/selectBoardArticle.do">
									<c:param name="nttNo" value="${result.nttNo}" />
									<c:param name="menuId" value="${result.menuId}" />
									<c:param name="bbsId" value="${result.bbsId}" />
				   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
							    </c:url>
								<li>
									<a href="<c:out value="${viewUrl}"/>"><strong class="tit"><c:out value="${result.nttSj}"/></strong></a> <span>작성자 [ <c:out value="${result.ntcrNm}"/> ]   /   작성일 [ <fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/> ] </span>
									<p><a href="<c:out value="${viewUrl}"/>"><c:out value="${fn:replace(fn:substring(result.nttCn, 0, 220), searchVO.searchWrd, repleTxt)}" escapeXml="false" /></a></p>
								</li>
							</c:forEach>
						</ul>
						</c:if>
						
						<div id="paging2">
							<c:url var="pageUrl" value="/sch/bbsSearch.do">
								<c:param name="searchCnd" value="${searchVO.searchCnd}" />
								<c:param name="searchWrd" value="${searchVO.searchWrd}" />
							</c:url>
						   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
						   <ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
						</div>
					
					</div>
				</div>

<c:import url="/msi/sch/tmplatBottom.do" charEncoding="utf-8"/>