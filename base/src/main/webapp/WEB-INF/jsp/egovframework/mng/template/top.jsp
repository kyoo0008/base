<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="mngimg" value="/template/manage/images"/>
<c:set var="MENU_AUTO_MAKE_SITE_ID" value="<%=Globals.MENU_AUTO_MAKE_SITE_ID%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>관리자페이지 : <c:out value='${param.title}'/></title>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/default.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/page.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/com.css'/>"/>
<link type="text/css" href="<c:url value='/template/common/js/jquery/themes/base/jquery.ui.all.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/template/common/js/jquery/jquery-1.9.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/template/common/js/jquery/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/template/common/js/jquery/ui/i18n/jquery.ui.datepicker-ko.js'/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/template/common/js/common.js'/>"></script>

<c:if test="${not empty param.validator }">
	<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
	<validator:javascript formName="${param.validator }" staticJavascript="false" xhtml="true" cdata="false"/>
</c:if>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
<c:if test='${not empty message}'>
alert("${message}");
</c:if>
-->
</script>
</head>
<body>

<div id="wrap">
	<div id="header">
		<div class="topLc">
			<h1 class="logo"><a href="<c:url value="/mng/index.do"/>"><img src="<c:url value="${mngimg }/logo_admin.gif"/>" alt="관리자 페이지"/></a></h1>		
			<div id="topMenu">
				<ul class="list">
					<li><span class="nonBtn"><c:out value="${USER_INFO.name}"/>님</span></li>
					<li><a href="<%=egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper.getRedirectLogoutUrl()%>" class="nonBtn"><img src="<c:url value="${mngimg }/btn_logout.gif"/>" alt="로그아웃"/></a></li>
					<%-- 
					<li><a class="nonBtn" target="_blank" href="http://intra.itshome.co.kr/EMT/?ref=tools/workpaper/board.emt&amp;idx=000001149">요청게시판 <img src="${mngimg }/icon_arrow.gif"/></a></li>
					--%>
				</ul>
			</div>
		</div>
		<!-- 대메뉴 목록 -->
		<div id="mainMenu">
			<ul class="list">
				<c:if test="${USER_INFO.userSe > 10 }">
				<li><a href="<c:url value="/mng/sym/sit/selectSiteInfoList.do"/>" <c:if test="${param.menu eq 'SYSTEM_MANAGE' }">class="slt"</c:if> target="_self">시스템관리</a></li>
				</c:if>
				<li><a href="<c:url value="/mng/sym/mpm/selectMpmList.do"/>" <c:if test="${param.menu eq 'MENUCNTNTS_MANAGE' }">class="slt"</c:if> target="_self">메뉴관리</a></li>
				<li><a href="<c:url value="/mng/usr/EgovMberManage.do"/>" <c:if test="${param.menu eq 'MBER_MANAGE' }">class="slt"</c:if> target="_self">회원관리</a></li>
				<li><a href="<c:url value="/mng/cop/bbs/SelectBBSMasterInfs.do"/>" <c:if test="${param.menu eq 'BOARD_MANAGE' }">class="slt"</c:if> target="_self">게시판관리</a></li>
				<%-- <li><a href="<c:url value="/mng/prg/ComtnprogrmList.do"/>" <c:if test="${param.menu eq 'COURSE_MANAGE' }">class="slt"</c:if> target="_self">체험프로그램</a></li> --%>
				<li><a href="<c:url value="/mng/evt/selectSchdulinfoList.do"/>" <c:if test="${param.menu eq 'EVENT_MANAGE' }">class="slt"</c:if> target="_self">통합캘린더관리</a></li>
				<%-- <li><a href="<c:url value="/mng/uss/ion/mlg/selectMlginfoList.do"/>" <c:if test="${param.menu eq 'MILEAGE_MANAGE' }">class="slt"</c:if> target="_self">마일리지관리</a></li> --%>
				<%-- <li><a href="<c:url value="#"/>" <c:if test="${param.menu eq 'SMS_MANAGE' }">class="slt"</c:if> target="_self">SMS발송</a></li> --%>
				<li><a href="<c:url value="/mng/sts/selectScrinStats.do?statsKind=H"/>" <c:if test="${param.menu eq 'STAT_MANAGE' }">class="slt"</c:if> target="_self">통계관리</a></li>
				<li><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN001"/>" <c:if test="${param.menu eq 'ETC_MANAGE' }">class="slt"</c:if> target="_self">기타관리</a></li>
			</ul>
		</div>
	</div>
	
	<div id="container">
		<!-- 좌측메뉴 목록 -->
		<div id="leftMenu">
		<c:choose>
			<c:when test="${param.menu eq 'SYSTEM_MANAGE' }"> <!-- 환경설정 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/sym/sit/selectSiteInfoList.do"/>" <c:if test="${param.depth1 eq 'SITE_MANAGE' }">class="slt"</c:if>>사이트관리</a></li>
				<c:if test="${USER_INFO.userSe > 10}">		
					<li class="smnu"><a href="<c:url value="/mng/cop/com/selectLytTemplateList.do"/>" <c:if test="${param.depth1 eq 'TMPLAT_MANAGE' }">class="slt"</c:if>>템플릿관리</a></li>
					<li class="smnu"><a href="<c:url value="/mng/cop/com/selectLytSourcList.do"/>" <c:if test="${param.depth1 eq 'SOURC_MANAGE' }">class="slt"</c:if>>레이아웃 관리</a></li>
					<%-- <li class="smnu"><a href="<c:url value="/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do"/>" <c:if test="${param.depth1 eq 'CODE_MANAGE' }">class="slt"</c:if>>공통코드관리</a></li> --%>
				</c:if>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'MENUCNTNTS_MANAGE' }"> <!-- 메뉴/콘텐츠관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/sym/mpm/selectMpmList.do"/>" <c:if test="${param.depth1 eq 'MENU_MANAGE' }">class="slt"</c:if> target="_self">메뉴관리</a></li>
				<%-- 
				<c:if test="${USER_INFO.userSe > 10}">				
					<li class="smnu"><a href="<c:url value="/mng/sym/mpm/selectMpmList.do?siteId=${MENU_AUTO_MAKE_SITE_ID}"/>" <c:if test="${param.depth1 eq 'MENU_AUTHO_MANAGE' }">class="slt"</c:if> target="_self">기본 자동생성 메뉴관리</a></li>
				</c:if>
				--%>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'BOARD_MANAGE' }"> <!-- 게시판관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/cop/bbs/SelectBBSMasterInfs.do"/>" <c:if test="${param.depth1 eq 'BOARD_ADMIN' }">class="slt"</c:if>>게시판관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do"/>" <c:if test="${param.depth1 eq 'CTGRY_ADMIN' }">class="slt"</c:if>>카테고리관리</a></li>
				<c:if test="${USER_INFO.userSe > 10}">	
					<li class="smnu"><a href="<c:url value="/mng/cop/com/selectBbsTemplateList.do"/>" <c:if test="${param.depth1 eq 'TMPLAT_MANAGE' }">class="slt"</c:if>>게시판 템플릿 관리</a></li>
					<li class="smnu"><a href="<c:url value="/mng/cop/com/selectBbsSourcList.do"/>" <c:if test="${param.depth1 eq 'SOURC_MANAGE' }">class="slt"</c:if>>게시판 소스 관리</a></li>
				</c:if>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'MBER_MANAGE' }"> <!-- 회원관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/usr/EgovMberManage.do"/>" <c:if test="${param.depth2 eq 'MBER_MANAGE' }">class="slt"</c:if> target="_self">회원목록</a></li>	
			</ul>
			</c:when>
			
			<%-- <c:when test="${param.menu eq 'COURSE_MANAGE' }"> <!-- 체험프로그램 -->
			<ul class="list">
				<li class="smnu"><a href="#" <c:if test="${param.depth2 eq 'PROG_MANAGE' }">class="slt"</c:if> target="_self">체험프로그램관리</a></li>	
			</ul>
			</c:when> --%>
			
			<c:when test="${param.menu eq 'EVENT_MANAGE' }"> <!-- 통합캘린더관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/evt/selectSchdulinfoList.do"/>" <c:if test="${param.depth1 eq 'EVENT_LIST' }">class="slt"</c:if>>통합캘린더관리</a>
					<ul class="slist">
					<li><a href="<c:url value="/mng/evt/selectSchdulinfoList.do"/>" <c:if test="${empty param.searchSe}">class="slt"</c:if>>전체</a></li>
						<li><a href="<c:url value="/mng/evt/selectSchdulinfoList.do?searchSe=1"/>" <c:if test="${param.searchSe eq 1 }">class="slt"</c:if>>행사및일반일정</a></li>
						<!-- <li><a href="<c:url value="/mng/evt/selectSchdulinfoList.do?searchSe=2"/>" <c:if test="${param.searchSe eq 2 }">class="slt"</c:if>>이벤트</a></li>-->
						<li><a href="<c:url value="/mng/evt/selectSchdulinfoList.do?searchSe=3"/>" <c:if test="${param.searchSe eq 3 }">class="slt"</c:if>>설문조사</a></li>
						
					</ul>
				</li>				
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'MILEAGE_MANAGE' }"> <!-- 마일리지관리 -->
			<ul class="list">				
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/mlg/selectMlginfoList.do"/>" <c:if test="${param.depth1 eq 'MILEAGE_SETUP' }">class="slt"</c:if>>마일리지설정</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/mlg/selectMlgUserlogList.do"/>" <c:if test="${param.depth1 eq 'MILEAGE_LIST' }">class="slt"</c:if>>마일리지 내역</a></li>
				<li class="smnu"><a href="<c:url value="/mng/rnk/MileageRanking.do"/>" <c:if test="${param.depth1 eq 'RANKING_MILEAGE' }">class="slt"</c:if>>마일리지 TOP 10</a></li>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'SMS_MANAGE' }"> <!-- SMS/이메일관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/sms/selectSmsManage.do"/>" <c:if test="${param.depth1 eq 'SMS_SEND' }">class="slt"</c:if>>SMS/이메일관리</a>
					<ul class="slist">
						<li><a href="<c:url value="/mng/sms/selectSmsManage.do"/>" <c:if test="${param.depth2 eq 'SMS' }">class="slt"</c:if>>개별메시지전송</a></li>
						<li><a href="<c:url value="/mng/sms/selectMmsManage.do"/>" <c:if test="${param.depth2 eq 'MMS' }">class="slt"</c:if>>그룹메세지전송</a></li>
						<!-- <li><a href="<c:url value="/mng/ems/selectEmsManage.do"/>" <c:if test="${param.depth2 eq 'EMS' }">class="slt"</c:if>>이메일전송</a></li> -->
					</ul>
				</li>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'STAT_MANAGE' }"> <!-- 통계관리 -->
			<ul class="list">
				
				<li class="smnu"><a href="<c:url value="/mng/sts/selectScrinStats.do?statsKind=H"/>" <c:if test="${param.depth1 eq 'SCRIN_STAT' }">class="slt"</c:if>>일/월/년간 접속</a>
					<ul class="slist">
						<li><a href="<c:url value="/mng/sts/selectScrinStats.do?statsKind=H"/>" <c:if test="${param.statsKind eq 'H' }">class="slt"</c:if>>홈페이지</a></li>
						<%-- 
						<li><a href="<c:url value="/mng/sts/selectScrinStats.do?statsKind=M"/>" <c:if test="${param.statsKind eq 'M' }">class="slt"</c:if>>모바일</a></li>
						--%>
					</ul>
				</li>
				<li class="smnu"><a href="<c:url value="/mng/sts/selectBbsStats.do"/>" <c:if test="${param.depth1 eq 'BBS_STAT' }">class="slt"</c:if>>게시물 통계</a></li>
				<%-- 
				<!-- <li class="smnu"><a href="<c:url value="/mng/sts/selectMlgStats.do"/>" <c:if test="${param.depth1 eq 'MG_STAT' }">class="slt"</c:if>>마일리지 통계</a></li>-->	
				<!-- <li class="smnu"><a href="<c:url value="/mng/sts/selectMbrStats.do"/>" <c:if test="${param.depth1 eq 'MBR_STAT' }">class="slt"</c:if>>회원가입 통계</a></li>-->
				<!-- <li class="smnu"><a href="<c:url value="/mng/sts/selectCmyStats.do"/>" <c:if test="${param.depth1 eq 'CMY_STAT' }">class="slt"</c:if>>커뮤니티개설 통계</a></li>-->
				<!-- <li class="smnu"><a href="https://www.google.com/analytics/web/?pli=1#report/visitors-overview/a29280954w55337777p56340389/" target="_blank">접속 통계</a></li> -->				
				<!-- 
				<li class="smnu">
					<a href="/mng/sts/selectEvtStats.do" <c:if test="${param.depth1 eq 'EVENT_STAT' }">class="slt"</c:if>>이벤트통계</a>
					<c:if test="${param.depth1 eq 'EVENT_STAT'}">
					<ul class="slist">
						<li><a href="<c:url value="/mng/sts/selectEvtStats.do"/>" <c:if test="${param.depth2 eq 'EVENT_DPT' }">class="slt"</c:if>>회차별 통계</a></li>
						<li><a href="<c:url value="/mng/sts/selectEvtStatUser.do"/>" <c:if test="${param.depth2 eq 'EVENT_USR' }">class="slt"</c:if>>사용자별 통계</a></li>
					</ul>
					</c:if>
				</li>
				-->
				--%>
			</ul>
			</c:when>
			
			<c:when test="${param.menu eq 'ETC_MANAGE' }"> <!-- 기타관리 -->
			<ul class="list">
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN001"/>" <c:if test="${param.bannerTyCode eq 'BAN001' }">class="slt"</c:if>>팝업존관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN002"/>" <c:if test="${param.bannerTyCode eq 'BAN002' }">class="slt"</c:if>>배너존관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN003"/>" <c:if test="${param.bannerTyCode eq 'BAN003' }">class="slt"</c:if>>퀵메뉴관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN004"/>" <c:if test="${param.bannerTyCode eq 'BAN004' }">class="slt"</c:if>>메인배너관리(Type1)</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN005"/>" <c:if test="${param.bannerTyCode eq 'BAN005' }">class="slt"</c:if>>메인배너관리(Type2)</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/bnr/selectBannerList.do?bannerTyCode=BAN006"/>" <c:if test="${param.bannerTyCode eq 'BAN006' }">class="slt"</c:if>>서브배너관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/pwm/listPopup.do"/>" <c:if test="${param.depth1 eq 'ETC_POPUPWINDOW' }">class="slt"</c:if>>팝업관리</a></li>
				<li class="smnu"><a href="<c:url value="/mng/uss/ion/sit/SiteListInqire.do"/>" <c:if test="${param.depth1 eq 'ETC_SITE' }">class="slt"</c:if>>링크사이트관리</a></li>
			</ul>
			</c:when>
			
			
			
			<c:otherwise> <%--등록되지 않은 메뉴들 --%>
			<ul class="list">
				<li class="smnu"><a href="#" class="slt">메뉴1</a></li>
				<li class="smnu"><a href="#">메뉴2</a></li>
				<li class="smnu"><a href="#">메뉴3</a></li>
				<li class="smnu"><a href="#">메뉴4</a></li>
				<li class="smnu"><a href="#">메뉴5</a></li>
			</ul>
			</c:otherwise>
		</c:choose>					
		</div>
		
		<div id="rightPage">
			<div id="navi">
				<h2 class="naviTit"><c:out value='${param.title}'/></h2>
			</div>
			<div id="contents">
