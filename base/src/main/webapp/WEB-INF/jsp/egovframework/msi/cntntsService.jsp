<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="_C_CSS" value="/template/common/css"/>
<c:set var="_C_JS" value="/template/common/js"/>
<c:choose>
	<c:when test="${param.tmplatImportAt ne 'N'}">
		<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
			<c:param name="isMain" value="${isMain}"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta http-equiv="Content-Script-Type" content="text/javascript" />
			<meta http-equiv="Content-Style-Type" content="text/css" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge" />	
			<link charset="utf-8" href="${_C_CSS}/default.css" type="text/css" rel="stylesheet"/>
			<script type="text/javascript" src="${_C_JS}/jquery/jquery-1.8.2.min.js"></script>
			<script type="text/javascript" src="${_C_JS}/common.js"></script>
		</head>
		<body>
	</c:otherwise>
</c:choose>

<c:if test="${not empty ImportUrl}">
	<c:import url="/EgovPageLink.do?link=${ImportUrl}" charEncoding="utf-8" var="html"/>
	<c:set var="html" value="${fn:replace(html, '$SITE_NM$', siteInfo.siteNm)}"/>
	<c:set var="html" value="${fn:replace(html, '$PHONE_NO$', siteInfo.tlphonNo)}"/>
	<c:set var="html" value="${fn:replace(html, '$FAX_NO$', siteInfo.faxNo)}"/>
	<c:out value="${html}" escapeXml="false"/>
</c:if>


<c:choose>
	<c:when test="${param.tmplatImportAt ne 'N'}">
		<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8">
			<c:param name="isMain" value="${isMain}"/>
		</c:import>
	</c:when>
	<c:otherwise>
		</body>
		</html>
	</c:otherwise>
</c:choose>
