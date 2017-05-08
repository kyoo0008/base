<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="/template/web/${siteInfo.tmplatCours}/image"/>
<c:set var="_CSS" value="/template/web/${siteInfo.tmplatCours}/css"/>
<c:set var="C_JS" value="/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="keywords" content="충남, 교육청, 연구정보원, 충남교육청 연구정보원" />
<meta name="subject" content="스마트 충남" />
<meta name="description" content="여기는 스마트 충남 포털 사이트입니다." />
<meta name="copyright" content="Copyright ⓒ 2011 SmartCNE. All Rights Reserved." />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="author" content="onmakers" />
<title>알립니다.</title>
<link rel="stylesheet" type="text/css" href="${_CSS}/styles.css" />
<script type="text/javascript" src="${C_JS}/common.js"></script>
<script type="text/javaScript" language="javascript">

/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {

	var chk = document.getElementById("chkPopup");
	if(chk && chk.checked) {
		fnSetCookiePopup( "mainPopupList", "done" , 1);
	}
	window.close();
}

</script>
<style type="text/css"> 
	html{height:100%; }
	/*  popup_list 20120529  */
	#wrap_pop{width:400px;background:url('${_IMG}/common/plist_top.gif') 0 top no-repeat;padding-top:123px;}
	#wrap_pop .pop_cont{width:350px;background:url('${_IMG}/common/plist_center_bg.gif') 0 bottom repeat-y;padding:25px;margin:0;}
	#wrap_pop .pop_list{margin:0;padding:0;}
	#wrap_pop .pop_list li{list-style:none;background:url('${_IMG}/common/plist_bul.gif') 0 center no-repeat;padding:5px 0 5px 15px;border-bottom:1px solid #e7e7e7;}
</style>
</head>
<body>
	<div id="wrap_pop">	
		<div class="pop_cont">
			<ul class="pop_list">
				<c:forEach items="${popupMainLIst}" var="resultInfo" varStatus="status">
					<li><a href="#" onclick="fn_egov_popupOpen_PopupManage('${resultInfo.popupId}','${resultInfo.fileUrl}','${resultInfo.popupWsize}','${resultInfo.popupHsize}','${resultInfo.popupHlc}','${resultInfo.popupWlc}','${resultInfo.stopVewAt}');return false;">
					<c:choose><c:when test="${fn:length(resultInfo.popupTitleNm) > 30}"><c:out value='${fn:substring(resultInfo.popupTitleNm, 0, 30)}'/>...</c:when><c:otherwise><c:out value="${resultInfo.popupTitleNm}"/></c:otherwise></c:choose></a></li>				
				</c:forEach>
			</ul>
		</div>
		<img src="${_IMG}/common/plist_bottom.gif" alt="" />
	</div>

	
	<div id="popmainboxdn" style="bottom:0px;position:fixed;">
		<p><input type="checkbox" name="chkPopup" id="chkPopup" onclick="fnPopupCheck()" />오늘하루 열지 않기</p>
	</div>
		
</body>
</html>