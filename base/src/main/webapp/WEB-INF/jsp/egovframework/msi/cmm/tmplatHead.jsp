<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="_DOMAIN" value="<%=egovframework.com.cmm.service.Globals.DOMAIN%>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/member/css"/>
<c:set var="C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/login.css" type="text/css" charset="utf-8" />  
  <script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
  <script type="text/javascript" src="${C_JS}/common.js"></script>
<title><c:out value="${siteInfo.siteNm}"/></title>
</head>

 <body>


	<div id="wrap">
		
		<!-- header start -->
		<div id="header">
			<div class="header">
				<h1><a href="${pageContext.request.contextPath}/"><img src="${_IMG}/login/logo.png" alt="스마트스쿨" /></a></h1>
				<c:choose>
					<c:when test="${empty param.step}"><div class="tit_intro"><img src="${_IMG}/login/intro_text.png" alt="사이트에 오신 것을 진심으로 환영합니다" /></div></c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${param.step eq 1 }"><div class="tit_intro_step"><img src="${_IMG}/login/join_step01.gif" alt="약관동의(현재단계) → 가입인증 → 회원정보입력 → 가입완료  " /></div></c:when>
							<c:when test="${param.step eq 2 }"><div class="tit_intro_step"><img src="${_IMG}/login/join_step02.gif" alt="약관동의 → 가입인증(현재단계) → 회원정보입력 → 가입완료  " /></div></c:when>
							<c:when test="${param.step eq 3 }"><div class="tit_intro_step"><img src="${_IMG}/login/join_step03.gif" alt="약관동의 → 가입인증→ 회원정보입력(현재단계)  → 가입완료  " /></div></c:when>
							<c:when test="${param.step eq 4 }"><div class="tit_intro_step"><img src="${_IMG}/login/join_step04.gif" alt="약관동의 → 가입인증 → 회원정보입력 → 가입완료(현재단계)  " /></div></c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- //header end -->

		<!-- content strat -->
		<div id="content">
			<c:if test="${not empty param.menuSeq}">
			<ul class="submenu">
				<li <c:if test="${param.menuSeq eq '01'}">class="on"</c:if>><a href="${pageContext.request.contextPath}<%=EgovUserDetailsHelper.getRedirectFindIdUrl()%>">아이디찾기</a></li>
				<li <c:if test="${param.menuSeq eq '02'}">class="on"</c:if>><a href="${pageContext.request.contextPath}<%=EgovUserDetailsHelper.getRedirectFindPasswordUrl()%>">비밀번호 재발급</a></li>
				<li <c:if test="${param.menuSeq eq '03'}">class="on"</c:if>><a href="${pageContext.request.contextPath}<%=EgovUserDetailsHelper.getRedirectUserUpdateUrl()%>">회원정보변경</a></li>
				<!-- <li <c:if test="${param.menuSeq eq '04'}">class="on"</c:if>><a href="<%=EgovUserDetailsHelper.getRedirectLoginUrl()%>">학부모신청/조회</a></li>-->
				<li <c:if test="${param.menuSeq eq '05'}">class="on"</c:if>><a href="${pageContext.request.contextPath}<%=EgovUserDetailsHelper.getRedirectUserPasswordUpdateUrl()%>">비밀번호 변경</a></li>
				<li <c:if test="${param.menuSeq eq '06'}">class="on"</c:if>><a href="${pageContext.request.contextPath}<%=EgovUserDetailsHelper.getRedirectUserDeleteUrl()%>">회원탈퇴</a></li>
			</ul>
			</c:if>