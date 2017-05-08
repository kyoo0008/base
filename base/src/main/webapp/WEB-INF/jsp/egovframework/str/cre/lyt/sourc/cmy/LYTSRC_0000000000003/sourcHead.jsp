<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="LOGIN_USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${_WEB_FULL_PATH}/${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_CSS" value="${_WEB_FULL_PATH}/${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="${_CSS}/style.css" type="text/css" charset="utf-8" /> 
		<title><c:out value="${param.title}"/></title>
		<script type="text/javascript" src="${C_JS}/jquery/jquery-1.8.2.min.js"></script>
		<script type="text/javascript" src="${C_JS}/common.js"></script>
		<script type="text/javaScript" language="javascript" defer="defer">
		<!--
			<c:if test='${not empty message}'>
				alert("${message}");
			</c:if>
			function goUrl(url){ 
				if(url != "") { 
					location.href=url;
				}
			}
		-->
		</script>
	</head>

	 <body>
		<noscript>${message}</noscript>
		<div id="community">
			<div class="community">

				<c:choose>
					<c:when test="${param.defaultHeader eq 'Y'}">
						<h1 class="cm_top"><img src="${_IMG}/tit_cm_make.jpg" alt="U-스쿨포털커뮤니티 만들기 U-스쿨포털커뮤니티에 오신 것을 환영합니다. 즐거운 학습 · 교류를 제공하는 서비스 입니다." /></h1>
					</c:when>
					<c:otherwise>
						<div class="cm_top">
							<div  class="cm_bg_top" style="background:url('<c:choose><c:when test="${empty cmmntyVO.atchFileNm}">${_IMG}/bg_cm_topimg.jpg</c:when><c:otherwise>${CmmntyFileStoreWebPath}${cmmntyVO.atchFileNm}</c:otherwise></c:choose>') 0 0 no-repeat;">
								<h1><c:out value="${cmmntyVO.cmmntyNm}"/></h1>
								<a href="/cmy/<c:out value='${cmmntyVO.cmmntyAdres}' />.do">http://${siteInfo.siteUrl}/cmy/<c:out value='${cmmntyVO.cmmntyAdres}' />.do</a>
								<dl>
									<dt>개설일 :</dt>
									<dd><fmt:formatDate value="${cmmntyVO.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></dd>
									<dt> / 회원수 :</dt>
									<dd><fmt:formatNumber value="${cmmntyVO.userCo}"/>명</dd>
									<dt>/ 현재현황 :</dt>
									<dd>새글 <fmt:formatNumber value="${cmmntyVO.articleNewCo}"/>개</dd>
								</dl>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
	
				<div class="cm_contents">
					<div class="cm_content">
						
      					<c:if test="${param.defaultHeader ne 'Y'}">
							<!-- community left  start -->
							<div class="cm_side">
	
								<div class="memberinfo">
										<span class="my">
											<c:choose>
												<c:when test="${empty LOGIN_USER_INFO}">
													손님
												</c:when>
												<c:otherwise>
													<strong><c:out value="${LOGIN_USER_INFO.name}" /></strong> 님
													<c:choose>
														<c:when test="${USER_INFO.useAt eq 'Y' and USER_INFO.mngrAt eq 'N'}">
															<c:choose>
																<c:when test="${USER_INFO.authorCode eq '02'}">(준회원)</c:when>
																<c:when test="${USER_INFO.authorCode eq '03'}">(정회원)</c:when>
															</c:choose>
														</c:when>
														<c:when test="${USER_INFO.useAt eq 'Y' and USER_INFO.mngrAt eq 'Y'}">(시샵)</c:when>
														<c:otherwise>(비회원)</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose> 
										</span>  
										
										<c:choose>
											<c:when test="${empty LOGIN_USER_INFO}"><a href="<%=EgovUserDetailsHelper.getRedirectLoginUrl()%>" class="btn5"><span>로그인</span></a></c:when>
											<c:otherwise><a href="<%=EgovUserDetailsHelper.getRedirectUserUpdateUrl()%>" class="btn5"><span>정보수정</span></a></c:otherwise>
										</c:choose>
									
										<select name="cmmntyUserSbsrsb" class="sel_lm160" onchange="goUrl(this.value);" title="커뮤니티 목록선택 이동">
										<c:choose>
											<c:when test="${not empty LOGIN_USER_INFO}">
										            <c:choose>
														<c:when test="${fn:length(USER_SBSCRB) == 0}"><option value="">가입목록이 없습니다.</option></c:when>
														<c:otherwise><option value="">커뮤니티 가입목록</option></c:otherwise>
													</c:choose>
										            <c:forEach var="cmmntyUserSbsrsb" items="${USER_SBSCRB}" varStatus="status">
										                <option value="/cmy/<c:out value='${cmmntyUserSbsrsb.cmmntyAdres}' />.do" <c:if test="${cmmntyUserSbsrsb.cmmntyId eq cmmntyVO.cmmntyId}">selected</c:if> ><c:out value="${cmmntyUserSbsrsb.cmmntyNm}"/></option>
										            </c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">가입목록이 없습니다.</option>
											</c:otherwise>
										</c:choose>
										</select>
								</div>
	
								<div class="cm_intro">
									<span class="img">
										<c:choose>
											<c:when test="${empty cmmntyVO.atchFileIcon}"><img src="${_IMG}/school_img.gif" width="88" height="58" alt="<c:out value="${cmmntyVO.cmmntyNm}"/> 대표이미지"/></c:when>
											<c:otherwise><img src="${CmmntyFileStoreWebPath}<c:out value="${cmmntyVO.atchFileIcon}"/>" width="88" height="58" alt="<c:out value="${cmmntyVO.cmmntyNm}"/> 대표이미지"/></c:otherwise>
										</c:choose>
									</span>
									<a href="/cop/cmy/selectCmmntyInfo.do?cmmntyId=<c:out value='${cmmntyVO.cmmntyId}'/>" class="btn3"><span>커뮤니티소개</span></a>
									<c:if test="${not empty LOGIN_USER_INFO}">
<c:choose>
											<c:when test="${USER_INFO.useAt eq 'Y' and USER_INFO.mngrAt eq 'N'}"><a href="${_PREFIX}/selectCmmntyUserSecsn.do?cmmntyId=<c:out value='${cmmntyVO.cmmntyId}' />" class="btn10"><span>회원탈퇴</span></a></c:when>
											<c:when test="${USER_INFO.useAt ne 'Y'}"><a href="${_PREFIX}/selectCmmntyUserBySelf.do?cmmntyId=<c:out value='${cmmntyVO.cmmntyId}' />" class="btn10"><span>가입신청</span></a></c:when>
										</c:choose>

									</c:if>
								</div>
	
								<div class="cm_search">
									<form name="unitySearch" method="post" action="<c:url value='${_PREFIX}/selectCmmntyBoardList.do'/>">
										<input name="searchCnd" type="hidden" value="0" />
										<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.cmmntyId}'/>" />
										<fieldset>
											<legend>검색입력폼 </legend>
											<label for="all_search">전체검색</label>
											<input type="text" name="searchWrd" class="inp" id="all_search"  />
											<span class="btn4"><button  type="submit">검색</button></span>
										</fieldset>
									</form>
								</div>
	
								<div class="cm_mbox">
									<h2>메뉴</h2>
									<ul>
										<c:forEach var="cmmntyMnu" items="${cmmntyMnuList}" varStatus="status">
											<c:url var="mnuUrl" value="${_PREFIX}/bbs/selectBoardList.do">
												<c:param name="bbsId" value="${cmmntyMnu.bbsId}"/>
												<c:param name="trgetId" value="${cmmntyVO.cmmntyId}"/>
											</c:url>
											<li><a href="<c:out value='${mnuUrl}'/>" title="<c:out value="${cmmntyMnu.bbsNm}" />"><c:out value="${cmmntyMnu.bbsNm}" /></a></li>
										</c:forEach>
									</ul>
								</div>
	
								<c:if test="${USER_INFO.authorCode ge 10}">
									<div class="cm_mbox">
										<h2>관리</h2>
										<ul>
											<li><a href="${_PREFIX}/forUpdateCmmntyInf.do?cmmntyId=<c:out value="${cmmntyVO.cmmntyId}" />">커뮤니티정보관리</a></li>
											<li><a href="${_PREFIX}/selectCmmntyMasterInfs.do?trgetId=<c:out value="${cmmntyVO.cmmntyId}" />">메뉴관리</a></li>
											<li><a href="/cop/com/selectCmmntyUserList.do?trgetId=<c:out value="${cmmntyVO.cmmntyId}" />">회원관리</a></li>
											<li><a href="/cop/com/selectConfirmRequestByTrget.do?trgetId=<c:out value="${cmmntyVO.cmmntyId}" />">승인관리</a></li>
											<c:if test="${USER_INFO.mngrAt eq 'Y'}">
												<li><a href="${_PREFIX}/selectCmmntyClosing.do?cmmntyId=<c:out value='${cmmntyVO.cmmntyId}' />">커뮤니티 폐쇄</a></li>
											</c:if>
										</ul>
									</div>
								</c:if>
								
								
							</div>
							<!-- community left  end -->

        				</c:if>