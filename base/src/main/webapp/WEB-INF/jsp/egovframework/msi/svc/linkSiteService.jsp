<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${param.tmplatCours}"/>

<c:set var="preSiteThemaClCode" value=""/>
<c:forEach var="result" items="${linkSiteList}" varStatus="status">
	<c:if test="${preSiteThemaClCode ne result.siteThemaClCode}">
		<form name="frmGo${status.count}" action="/goUrl.jsp" method="post" target="_blank" onsubmit="goUrl(${status.count}); return false;">
			<label for="sLink${status.count}" class="hdn"><c:out value="${result.siteThemaClNm}"/></label>
			<select id="sLink${status.count}" name="sLink">
	   			<option value="" selected="selected"><c:out value="${result.siteThemaClNm}"/></option>
	     		<c:forEach var="site" items="${linkSiteList}" varStatus="status">
	     			<c:if test="${site.siteThemaClCode eq result.siteThemaClCode}">
	   					<option value="<c:out value="${site.linkSiteUrl}"/>" ><c:out value="${site.linkSiteNm}"/></option>
	   				</c:if>
	     		</c:forEach>
			</select>
			<input type="image" src="${_IMG}/common/btn_move.png" alt="<c:out value="${result.siteThemaClNm}"/> 바로가기(새창열림)이동"/>
		</form>
		<c:set var="preSiteThemaClCode" value="${result.siteThemaClCode}"/>
	</c:if>
</c:forEach>
