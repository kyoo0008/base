<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%
	/*
		사이트맵 			: /msi/siteMap.do
		개인정보보호정책 	: /msi/indvdlInfoPolicy.do
		이용약관			: /msi/useStplat.do
		이메일수집거부		: /msi/emailColctPolicy.do
	*/
%>
<c:set var="IS_MOBILE"><%=egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)%></c:set>
<c:set var="TEMPLATE_PATH" value="${IS_MOBILE ? 'mbl' : 'web'}"/>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${_WEB_FULL_PATH}/template/${TEMPLATE_PATH}/${siteInfo.lytTmplatId}/image"/>
<c:set var="_CSS" value="${_WEB_FULL_PATH}/template/${TEMPLATE_PATH}/${siteInfo.lytTmplatId}/css"/>
<c:set var="_JS" value="${_WEB_FULL_PATH}/template/${TEMPLATE_PATH}/${siteInfo.lytTmplatId}/js"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:choose>
	<c:when test="${siteInfo.mobileUseAt eq 'Y' and IS_MOBILE}">
		mobileSource
	</c:when>
	<c:otherwise>
	
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<meta http-equiv="keywords" content="<c:out value="${siteInfo.siteNm}"/>" />
		<meta name="subject" content="<c:out value="${siteInfo.siteNm}"/>" />
		<meta name="description" content="여기는 <c:out value="${siteInfo.siteNm}"/> 사이트입니다." />
		<meta name="copyright" content="Copyright ⓒ 2012 Sejong. All Rights Reserved." />
		<meta http-equiv="imagetoolbar" content="no" />
		<meta name="author" content="onmakers" />
		<link rel="stylesheet" type="text/css" href="${_CSS}/styles.css" />
		<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="${C_JS}/common.js"></script>
		<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
		<script charset="utf-8" src="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/script.js" type="text/javascript"></script>
		<c:if test="${currMpm.htmlUseAt eq 'Y'}">
			<link charset="utf-8" href="${MnuFileStoreWebPathByWebFile}${currMpm.siteId}/${currMpm.menuId}/style.css" type="text/css" rel="stylesheet"/>
			<script charset="utf-8" src="${MnuFileStoreWebPathByWebFile}${currMpm.siteId}/${currMpm.menuId}/script.js" type="text/javascript"></script>
		</c:if>
		<title><c:out value="${siteInfo.siteNm}"/></title>
		</head>
		<body>
		<p id="skipnav"><a href="#container">본문 바로가기</a></p>
		<hr />
		   	<div id="wrapper">
		    
		     <div>
		        <h1><a href="<c:url value="${_WEB_FULL_PATH}"/>" title="홈으로이동"><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.upendLogoFileNm}" alt="<c:out value="${siteInfo.siteNm}"/>" /></a></h1>
		       	<ul>
	       			<c:choose>
	       				<c:when test="${empty USER_INFO.id}">
	       					<a href="<c:url value="/uat/uia/egovLoginUsr.do"/>">로그인</a>
	       					<a href="<c:url value="/uss/umt/cmm/EgovSelectMber.do"/>">회원가입</a>
	       				</c:when>
	       				<c:otherwise>
	       					<a href="<c:url value="/uat/uia/actionLogout.do"/>">로그아웃</a>
	       					<a href="<c:url value="/uat/uia/actionLogout.do"/>">정보수정</a>
	       				</c:otherwise>
	       			</c:choose>
		       	</ul>
		     </div>
		<hr />
			<div id="container">
			
				
				<c:if test="${currMpm.htmlUseAt eq 'Y'}">
					<c:import url="/EgovPageLink.do?link=${LytFileStoreWebPathByJspFile}${currMpm.siteId}/${currMpm.menuId}" charEncoding="utf-8"/>
				</c:if>
				<c:if test="${currMpm.cntntsTyCode eq 'CTS05'}">
					<iframe id="cntnsIframe" src="${currMpm.url}" scrolling="no" frameborder="0" width="100%" height="1200"></iframe>
				</c:if>
				<c:if test="${currMpm.cntntsTyCode eq 'CTS06'}">
					<c:import url="${currMpm.url}" charEncoding="utf-8"/>
				</c:if>
		
	</c:otherwise>
</c:choose>		