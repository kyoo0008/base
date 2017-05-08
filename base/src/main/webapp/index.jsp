<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String domain = request.getServerName();

	if("Y".equals(request.getParameter("mobileCancle"))) {
		egovframework.com.utl.fcc.service.EgovHttpUtil.removeIsMobile(request);
		egovframework.com.utl.fcc.service.EgovHttpUtil.setIsMobileCancled(request);
	} else if(egovframework.com.utl.fcc.service.EgovHttpUtil.checkMobileHeader(request)) {
		if(request.getSession().getAttribute("IS_MOBILE_CANCLE") == null) {		
			egovframework.com.utl.fcc.service.EgovHttpUtil.removeIsMobileCancled(request);
			egovframework.com.utl.fcc.service.EgovHttpUtil.setIsMobile(request);
		}
	}
	
	String refreshUrl = "/index.do" + (request.getQueryString() != null ? "?" + request.getQueryString() : "");
	String returnUrl = egovframework.com.utl.cas.service.EgovSessionCookieUtil.getCookie(request, "returnUrl");
	
	if(returnUrl != null){
		refreshUrl = returnUrl;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>
			<c:out value="${siteInfo.siteNm}"/>
			<c:choose>
				<c:when test="${CURR_URL eq '/msi/indvdlInfoPolicy.do'}">&gt; <spring:message code="etc.link.indvdlInfoPolicy" /></c:when>
				<c:when test="${CURR_URL eq '/msi/useStplat.do'}">&gt; <spring:message code="etc.link.useStplat" /></c:when>
				<c:when test="${CURR_URL eq '/msi/emailColctPolicy.do'}">&gt; <spring:message code="etc.link.emailColctPolicy" /></c:when>							
				<c:when test="${CURR_URL eq '/msi/siteMap.do'}">&gt; <spring:message code="etc.link.sitemap" /></c:when>
				<c:otherwise>				
					<c:if test="${not empty currRootMpm.menuNm}">&gt;<c:out value="${currMpm.menuPathByName}"/></c:if>
				</c:otherwise>
			</c:choose>
		</title>
<noscript>
	<meta http-equiv="refresh" content="0; url=<%=refreshUrl%>"/>
</noscript>
<script type="text/javascript">
	location.href = "index.do" + location.search;
</script>
</head>
<body>
</body>
</html>