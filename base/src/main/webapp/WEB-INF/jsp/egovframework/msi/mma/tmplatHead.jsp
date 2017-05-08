<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/mma/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/mma/css"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/mma/js"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/default.css" type="text/css" charset="utf-8" /> 
  <script type="text/javascript" src="${_C_JS}/jquery/jquery-1.9.1.min.js"></script>
  <script type="text/javascript" src="${_JS}/slides.min.jquery.js"></script>
  <script type="text/javascript" src="${_C_JS}/common.js"></script>
  <c:if test="${not empty param.BBS_CSS}"><link charset="utf-8" href="${param.BBS_CSS}" type="text/css" rel="stylesheet"/></c:if>
  <c:if test="${not empty param.BBS_JS}"><script type="text/javascript" src="${param.BBS_JS}"></script></c:if>
<title><c:out value="${siteInfo.siteNm}"/> VOD</title>

</head>

<body>

<div id="skilNavi">
	<a href="#content" class="skipBtn">본문바로가기</a>
</div>

<div id="wrap">

<div id="top_header">
	<div class="top_header_body">
		<div class="home">
			<a href="<%=egovframework.com.cmm.service.Globals.DOMAIN%>">포탈 바로가기</a>
		</div>

		<div class="search">
			<form name="totalSearchForm" action="<c:url value="/sch/search.do"/>" method="post" onsubmit="return fnTotalSearch(this);">
				<input type="text" name="searchWrd" id="searchWrd" class="search_bar" /><input type="image" src="${_IMG}/common/btn_search.gif" name="topbtn_search" class="top_btn_search" alt="검색" />
			</form>
		</div>

		<ul class="gnb">
			<li><a href="<c:url value="/mma/index.do"/>">HOME<span>|</span></a></li>
			<c:choose>
				<c:when test="${empty USER_INFO.id}">
					<li><a href="<%=EgovUserDetailsHelper.getRedirectLoginUrl()%>">로그인<span>|</span></a></li>
					<li><a href="<%=EgovUserDetailsHelper.getRedirectRegistUrl()%>?siteId=${siteInfo.siteId}">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="<%=EgovUserDetailsHelper.getRedirectLogoutUrl()%>">로그아웃<span>|</span></a></li>
					<li><a href="<%=EgovUserDetailsHelper.getRedirectUserUpdateUrl()%>">정보수정</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>

<div id="header">
	<div class="header_body">
		<h1 class="logo"><a href="/"><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.upendLogoFileNm}" alt="<c:out value="${siteInfo.siteNm}"/>" /></a><a href="<c:url value="/mma/index.do"/>"><img class="vod" src="${_IMG}/common/logo_VOD.png" alt="VOD" /></a></h1>
	
		<ul class="menu">
			<c:forEach var="mpmDepth01" items="${mltmdCateList}" varStatus="status">
				<c:if test="${mpmDepth01.ctgryLevel eq 1}">		
					<li><a href="<c:url value="/mma/MltmdMvpInfoList.do?searchCate=${mpmDepth01.ctgryId}"/>"><c:out value="${mpmDepth01.ctgryNm}"/></a></li>
				</c:if>
			</c:forEach>
			<c:forEach var="bbs" items="${bbsList}" varStatus="status">
				<c:if test="${status.count eq 1}">	
					<li><a href="<c:url value="/mma/cop/bbs/selectBoardList.do?bbsId=${bbs.bbsId}"/>"><c:out value="${bbs.bbsNm}"/></a></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>

<c:choose>
	<c:when test="${param.isMain eq 'Y'}">
		<div id="container">
	</c:when>
	<c:otherwise>
		<div class="header_bg"></div>
		<div id="container">
			<div class="sub_content_box">
				<div id="sub_nav">
					<c:if test="${param.searchTarget eq 'MVP'}">
						<h2><c:out value="${currRootCtgry.ctgryNm}"/></h2>
						<ul class="sub_menu">
							<c:forEach var="mpmDepth02" items="${mltmdCateList}" varStatus="status">
								<c:if test="${mpmDepth02.ctgryLevel eq 2 and fn:contains(mpmDepth02.ctgryPathById, currRootCtgry.ctgryId)}">
									<c:choose>
										<c:when test="${mpmDepth02.lastNodeAt eq 'Y'}">
											<li class="sub<c:if test="${fn:contains(currCtgry.ctgryPathById, mpmDepth02.ctgryId)}"> on</c:if>">
												<a href="<c:url value="/mma/MltmdMvpInfoList.do?searchCate=${mpmDepth02.ctgryId}"/>"><c:out value="${mpmDepth02.ctgryNm}"/></a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="sub<c:if test="${fn:contains(currCtgry.ctgryPathById, mpmDepth02.ctgryId)}"> on</c:if>"><a href="<c:url value="/mma/MltmdMvpInfoList.do?searchCate=${mpmDepth02.ctgryId}"/>"><c:out value="${mpmDepth02.ctgryNm}"/></a>
											<ul class="depth_02">
												<c:forEach var="mpmDepth03" items="${mltmdCateList}">
													<c:if test="${fn:contains(currCtgry.ctgryPathById, mpmDepth02.ctgryId) and mpmDepth03.ctgryLevel eq 3 and fn:contains(mpmDepth03.ctgryPathById, mpmDepth02.ctgryId)}">
														<li><a href="<c:url value="/mma/MltmdMvpInfoList.do?searchCate=${mpmDepth03.ctgryId}"/>"><c:out value="${mpmDepth03.ctgryNm}"/></a></li>
													</c:if>
												</c:forEach> 
											</ul>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
					<c:if test="${param.searchTarget eq 'BBS'}">
						<h2><c:out value="${currBBS.bbsNm}"/></h2>
						<ul class="sub_menu">
							<c:forEach var="bbs" items="${bbsList}" varStatus="status">
									<li><a href="<c:url value="/mma/cop/bbs/selectBoardList.do?bbsId=${bbs.bbsId}"/>"><c:out value="${bbs.bbsNm}"/></a></li>
							</c:forEach>
						</ul>
					</c:if>
					<div class="sub_hot_movie">
						<h3>인기동영상</h3>
						<c:forEach var="mvp" items="${inqireBestList}" varStatus="status">
							<c:if test="${status.count eq 1}">
							<c:choose><c:when test="${not empty mvp.thumbFilePath}"><img src="${mediaMovieImageWebUrl}${mvp.thumbFilePath}" alt="<c:out value="${mvp.mvpSj}"/>" onerror="this.src='${_IMG}/common/no_img.png'"/></c:when><c:otherwise><img src="${_IMG}/common/no_img.png" alt="movie" /></c:otherwise></c:choose>
							</c:if>
						</c:forEach>
						<ul>
							<c:forEach var="mvp" items="${inqireBestList}" varStatus="status">
								<li>
									<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>"><span class="num">${status.count}</span><c:out value="${mvp.mvpSj}"/>
										<p class="hot_content"><c:out value="${fn:length(mvp.mvpCn) > 50 ? fn:substring(mvp.mvpCn, 0, 50) : mvp.mvpCn}"/></p>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				
				<div class="sub_con_body">
					<div class="sub_con_top">
						<h2><c:out value="${param.searchTarget eq 'MVP' ? currCtgry.ctgryNm : currBBS.bbsNm}"/></h2>
						<span class="location"><img src="${_IMG}/sub/icon_home.gif" alt="" />홈&gt;<c:out value="${param.searchTarget eq 'MVP' ? currCtgry.ctgryPathByName : currBBS.bbsNm}"/></span>
					</div>
					<div id="sub_content">
	</c:otherwise>
</c:choose>