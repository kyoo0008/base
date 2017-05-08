<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${param.tmplatCours}"/>

<c:choose>
	<c:when test="${searchVO.tableId eq 'PopupZone'}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag}></c:if>
					<a target="_self" onfocus="changeServicePanel(${status.count})" onmouseover="changeServicePanel(${status.count})" href="#" onclick="return false;">
						<img alt="배너 ${status.count}" src="${_IMG}/main/icon_pop_on.gif" id="popBtn${status.count}" />
					</a>
					<span id="pop${status.count}"><a href="${result.linkUrl}" <c:if test="${result.popupTrgetAt eq 'Y'}">target="_blank"</c:if>><img src="http://${siteInfo.siteUrl}${BannerFileStoreWebPath}${siteInfo.siteId}/${result.bannerImageFile}" alt="popup${status.count}"/></a></span>
				<c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
		  </c:forEach>
	</c:when>
	<c:otherwise>
		  <c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag}></c:if>
					<c:forEach var="colum" items="${searchVO.columInfo}">
						<c:if test="${not empty colum.tag}">
							<${colum.tag} <c:if test="${colum.tag eq 'a'}"> href="<c:out value="${result.linkUrl}"/>" onclick="ssoLinkAction(this)" <c:if test="${result.popupTrgetAt eq 'Y'}">target="_blank"</c:if> title="<c:out value="${result.bannerNm}"/>"</c:if><c:if test="${not empty colum.cssClass}"> class="${colum.cssClass}"</c:if>>
						</c:if>
						<c:choose>
							<c:when test="${colum.colname eq 'bannerImage'}"><img src="http://${siteInfo.siteUrl}${BannerFileStoreWebPath}${siteInfo.siteId}/${result.bannerImageFile}" alt="<c:out value="${result.bannerNm}"/>" /></c:when>
							<c:when test="${colum.colname eq 'bannerNm'}"><c:out value="${result.bannerNm}"/></c:when>
							<c:when test="${colum.colname eq 'bannerUrl'}"><c:out value="${result.linkUrl}"/></c:when>
							<c:when test="${colum.colname eq 'linkButton'}"><img src="${_IMG}/page/btn_skip.gif" alt="바로가기" /></c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
						<c:if test="${not empty colum.tag}"></${colum.tag}></c:if>				
					</c:forEach>
				<c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
		  </c:forEach>
	</c:otherwise>
</c:choose>	