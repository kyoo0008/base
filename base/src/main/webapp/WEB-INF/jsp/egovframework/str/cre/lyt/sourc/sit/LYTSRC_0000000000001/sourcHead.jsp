<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<% org.springframework.web.util.UrlPathHelper helper = new org.springframework.web.util.UrlPathHelper();%>
<%
	/*
		사이트맵 			: /msi/siteMap.do
		개인정보보호정책 	: /msi/indvdlInfoPolicy.do
		이용약관			: /msi/useStplat.do
		이메일수집거부		: /msi/emailColctPolicy.do
	*/
%>
<c:set var="PUBLISH_APPEND_FREFIX"><%=Globals.getPublishAppendPrefix(request)%></c:set>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_CSS" value="${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}"/>
<c:set var="_JS" value="${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="C_CSS" value="${_WEB_FULL_PATH}/template/common/css"/>
<c:set var="CURR_URL" value="<%=helper.getOriginatingRequestUri(request) %>"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>

<c:set var="_SITE00" value="http://portal.cait.ca:9080${pageContext.request.contextPath}"/>
<c:set var="_SITE01" value="http://dev1.cait.ca:9080${pageContext.request.contextPath}"/>
<c:set var="_SITE02" value="http://dev2.cait.ca:9080${pageContext.request.contextPath}"/>
<c:set var="_SITE03" value="http://dev3.cait.ca:9080${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />		
	<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
	<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
	<script charset="utf-8" src="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/script.js" type="text/javascript"></script>
	<c:if test="${currMpm.htmlUseAt eq 'Y'}">
		<link charset="utf-8" href="${MnuFileStoreWebPathByWebFile}${currMpm.siteId}/${currMpm.menuId}/style.css" type="text/css" rel="stylesheet"/>
		<script charset="utf-8" src="${MnuFileStoreWebPathByWebFile}${currMpm.siteId}/${currMpm.menuId}/script.js" type="text/javascript"></script>
	</c:if>	
	<c:if test="${not empty param.BBS_TMPLATID}">
	<link charset="utf-8" href="${BbsFileStoreWebPathByWebFile}${param.BBS_TMPLATID}/style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${BbsFileStoreWebPathByWebFile}${param.BBS_TMPLATID}/script.js"></script>
	</c:if>
	<c:if test="${siteInfo.mouseScrtyApplcAt eq 'Y' }"><script type="text/javascript">$(document).ready(function(){$(document).bind("contextmenu",function(e){return false;});});</script></c:if>
	<c:if test="${siteInfo.kybrdScrtyApplcAt eq 'Y' }">
	<script type="text/javascript">$(document).ready(function(){$(document).bind('selectstart',function() {return false;});$(document).bind('dragstart',function(){return false;});$(document).keydown(function (e) {if(e.ctrlKey && e.which == 65) return false;if(e.ctrlKey && e.which == 67) return false;});});	</script>
	</c:if>
	<title>청암진로진학취업지원센터</title>

</head>
<body>
	<!-- header -->
	<div id="header">
		<h1><a href="${_SITE00 }/index.jsp"><img src="${_IMG}/main/logo.png" alt="스마트스쿨 SmartSchool" /></a></h1>
		
		<div class="top">
			
		</div>
	</div>
	<!-- //header -->
<c:choose>
<c:when test="${param.isMain eq 'Y'}">
			<!-- wrap -->
		<div id="wrap">
			<div id="intro">
				<ul>
					<li class="site1">
						<h2>사이트1</h2>
						<div class="slidebox" ><a href="#info01"><span class="hdn">사이트1</span> </a></div> 
						<div class="info" id="info01">
							<p><img src="${_IMG}/main/img01.png" alt="사이트1 배경이미지" /></p>
							<a href="${_SITE01}" class="btn_go"><img src="${_IMG}/main/01_homepage.gif" alt="사이트1 홈페이지 바로가기" /></a>
						</div>
					</li>

					<li class="site2">
						<h2>사이트2</h2>
						<div class="slidebox" ><a href="#info02"><span class="hdn">사이트2</span> </a></div> 
						<div class="info" id="info02">
							<p><img src="${_IMG}/main/img02.png" alt="사이트2 배경이미지" /></p>
							<a href="${_SITE02}" class="btn_go"><img src="${_IMG}/main/02_homepage.gif" alt="사이트2 홈페이지 바로가기" /></a>
						</div>
					</li>

					<li class="site3">
						<h2>사이트3</h2>
						<div class="slidebox" ><a href="#info03"><span class="hdn">사이트3</span> </a></div> 
						<div class="info" id="info03">
							<p><img src="${_IMG}/main/img03.png" alt="사이트3 배경이미지" /></p>
							<a href="${_SITE03}/index.do" class="btn_go"><img src="${_IMG}/main/03_homepage.gif" alt="사이트3 홈페이지 바로가기" /></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- //wrap -->
</c:when>
<c:otherwise>
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
	<script language="javascript">
		location.href = "index.do" + location.search;
	</script>
	<noscript>
	<meta http-equiv="refresh" content="0; url=<%=refreshUrl%>"/>
</noscript>
</c:otherwise>
</c:choose>