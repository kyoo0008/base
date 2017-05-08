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
					
				
					<h3 class="icon1">동영상 검색결과</h3>
					<div class="result2">
						<c:if test="${fn:length(resultList) == 0}">
							<p class="empty"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(resultList) > 0}"> 
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:url var="viewUrl" value="http://${result.siteUrl}/mma/selectMltmdMvpInfo.do">
									<c:param name="mltmdMvpId" value="${result.mltmdMvpId}" />
				   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
							    </c:url>
								<li>
									<a href="<c:out value="${viewUrl}"/>"> <c:choose><c:when test="${not empty result.thumbFilePath}"><img src="${mediaMovieImageWebUrl}${result.thumbFilePath}" alt="<c:out value="${result.mvpSj}"/>" onerror="this.src='${_IMG}/search/no_img.gif'"/></c:when><c:otherwise><img src="${_IMG}/search/no_img.gif" alt="<c:out value="${result.mvpSj}"/>" /></c:otherwise></c:choose></a>
									<span><c:out value="${result.mvpSj}"/></span>
								</li>
							</c:forEach>
						</ul>
						</c:if>
						
						<div id="paging2">
							<c:url var="pageUrl" value="/sch/vodSearch.do">
								<c:param name="searchCnd" value="${searchVO.searchCnd}" />
								<c:param name="searchWrd" value="${searchVO.searchWrd}" />
							</c:url>
						   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
						   <ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
						</div>
					
					</div>
				</div>

<c:import url="/msi/sch/tmplatBottom.do" charEncoding="utf-8"/>