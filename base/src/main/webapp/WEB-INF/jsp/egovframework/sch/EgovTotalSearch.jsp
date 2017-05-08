<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="repleTxt"><strong class="orange">${searchVO.searchWrd}</strong></c:set>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/search/images"/>
<c:import url="/msi/sch/tmplatHead.do" charEncoding="utf-8"/>

				<div class="search_word">
					<strong class="sword">검색어</strong> "<strong class="orange"><c:out value="${searchVO.searchWrd}"/></strong>"에 대한 검색결과 입니다.
				</div>
		
		
				<div class="result_box">
					
				
					<h3 class="icon1">게시물검색결과</h3>
					<div class="result1">
						<c:if test="${fn:length(bbsResultList) == 0}">
							<p class="empty"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(bbsResultList) > 0}"> 
						<ul>
							<c:forEach var="result" items="${bbsResultList}" varStatus="status">
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
					
						<div class="smore">
							<c:url var="moreUrl" value="/sch/bbsSearch.do">
								<c:param name="searchCnd" value="bbs" />
			   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
						    </c:url>
							<a href="<c:out value="${moreUrl}"/>">더 많은 검색결과 보기</a>
						</div>
					</div>
					 
					<h3  class="icon1">동영상 검색결과</h3>
					<div class="result2">
						<c:if test="${fn:length(vodResultList) == 0}">
							<p class="empty"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(vodResultList) > 0}"> 
						<ul>
							<c:forEach var="result" items="${vodResultList}" varStatus="status">
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

						<div class="smore">
							<c:url var="moreUrl" value="/sch/vodSearch.do">
								<c:param name="searchCnd" value="vod" />
			   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
						    </c:url>
							<a href="<c:out value="${moreUrl}"/>">더 많은 검색결과 보기</a>
						</div>
					
					
					</div>
					
					 
					<h3 class="icon1">커뮤니티 검색결과</h3>
					<div class="result1">
						<c:if test="${fn:length(cmyResultList) == 0}">
							<p class="empty"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(cmyResultList) > 0}"> 
						<ul>
							<c:forEach var="result" items="${cmyResultList}" varStatus="status">
								<c:url var="viewUrl" value="http://${result.siteUrl}/cop/cmy/bbs/selectBoardArticle.do">
									<c:param name="nttNo" value="${result.nttNo}" />
									<c:param name="trgetId" value="${result.trgetId}" />
									<c:param name="bbsId" value="${result.bbsId}" />
				   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
							    </c:url>
								<li>
									<a href="<c:out value="${viewUrl}"/>"><strong class="tit"><c:out value="${result.nttSj}"/></strong></a> <span><c:out value="${result.cmmntyNm}"/>  /  작성자 [ <c:out value="${result.ntcrNm}"/> ]   /   작성일 [  <fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/> ] </span>
									<p><a href="<c:out value="${viewUrl}"/>"><c:out value="${fn:replace(fn:substring(result.nttCn, 0, 220), searchVO.searchWrd, repleTxt)}" escapeXml="false" /></a></p>
								</li>
							</c:forEach>
						</ul>
						</c:if>

						<div class="smore">
							<c:url var="moreUrl" value="/sch/cmySearch.do">
								<c:param name="searchCnd" value="cmy" />
			   					<c:param name="searchWrd" value="${searchVO.searchWrd}" />
						    </c:url>
							<a href="<c:out value="${moreUrl}"/>">더 많은 검색결과 보기</a>
						</div>
					
					</div>
				</div>

<c:import url="/msi/sch/tmplatBottom.do" charEncoding="utf-8"/>