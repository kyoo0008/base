<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_IMG" value="/template/search/images"/>
<c:set var="_CSS" value="/template/search/css"/>
<c:set var="C_JS" value="/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/search.css" type="text/css" charset="utf-8" /> 
  <script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
  <script type="text/javascript" src="${C_JS}/common.js"></script>
<title><c:out value="${siteInfo.siteNm}"/> 통합검색</title>

</head>

 <body>


	<div id="etc_wrap">
		<!-- header start -->
		<div id="etc_header">
			<div class="etc_header">
				<h1><a href="/"><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.upendLogoFileNm}" alt="<c:out value="${siteInfo.siteNm}"/>" /></a></h1>
				<h2 class="top_txt"><img src="${_IMG}/search/txt_search.gif" alt="통합검색" /></h2>

				<div class="gnb">
					<a href="">HOME</a><span>|</span>
					<c:choose>
						<c:when test="${empty USER_INFO.id}">
							<a href="<%=EgovUserDetailsHelper.getRedirectLoginUrl()%>">로그인</a><span>|</span>
							<a href="<%=EgovUserDetailsHelper.getRedirectRegistUrl()%>">회원가입</a><span>|</span>
						</c:when>
						<c:otherwise>
							<a href="<%=EgovUserDetailsHelper.getRedirectLogoutUrl()%>">로그아웃</a><span>|</span>
							<a href="<%=EgovUserDetailsHelper.getRedirectUserUpdateUrl()%>">정보수정</a><span>|</span>
						</c:otherwise>
					</c:choose>
					<a href="<%=egovframework.com.cmm.service.Globals.DOMAIN%>">포탈홈</a>
				</div>


				<div class="search_box">
					<form name="totalSearchForm" action="<c:url value="/sch/search.do"/>" method="post" onsubmit="return fnTotalSearch(this);">
						<fieldset>
								<label class="hdn" for="ftext">통합검색 분류선택</label>
								<select id="searchCnd" name="searchCnd" id="ftext">
									<option value="">통합검색</option>
									<option value="bbs" <c:if test="${searchVO.searchCnd eq 'bbs'}">selected="selected"</c:if>>게시물</option>
									<option value="vod" <c:if test="${searchVO.searchCnd eq 'vod'}">selected="selected"</c:if>>VOD</option>
									<option value="cmy" <c:if test="${searchVO.searchCnd eq 'cmy'}">selected="selected"</c:if>>커뮤니티</option>
								</select>
								<label class="hdn" for="searchWrd">통합검색어 입력</label>		
								<input type="text" name="searchWrd" id="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" class="inp" />
								<input type="image" src="${_IMG}/search/btn_search.gif" alt="검색" class="btn_search"  />
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<!-- //header end-->

		<!-- etc_content start -->
		<div id="etc_content">
			<div class="etc_content">