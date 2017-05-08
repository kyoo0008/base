<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/common/images/popup"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/web/smart_001/css"/>
<c:set var="C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta content="IE=7" http-equiv="X-UA-Compatible"/>
<meta content="세종 스마트 스쿨" http-equiv="keywords"/>
<meta content="세종 스마트 스쿨" name="subject"/>
<meta content="여기는 세종 스마트 스쿨 포털 사이트입니다." name="description"/>
<meta content="Copyright ⓒ 2011 SmartCNE. All Rights Reserved." name="copyright"/>
<meta content="no" http-equiv="imagetoolbar"/>
<meta content="onmakers" name="author"/>
<title><c:out value='${popupManageVO.popupTitleNm}'/></title>
<link rel="stylesheet" type="text/css" href="${_CSS}/styles.css" />
<script type="text/javascript" src="${C_JS}/common.js"></script>
<script type="text/javaScript" language="javascript">

/* ********************************************************
* 체크버튼 클릭시
******************************************************** */
function fnPopupCheck() {

	var chk = document.getElementById("chkPopup");
	if(chk && chk.checked) {
		fnSetCookiePopup( "${popupManageVO.popupId}", "done" , 365);
	}
	window.close();
}

</script>
<style type="text/css"> 
	html{height:100%; }
</style>
</head>
<body style="background:none;">	
	<div style="width:460px; padding:8px 30px 150px; font-size:12px; background:url(${_IMG}/popuptem057_520_bg.jpg) no-repeat left bottom;">		
		<p style="margin:-8px -30px 0;">
			<img src="${_IMG}/popuptem057_520_img.jpg"/>
		</p>
		<h1 style="margin-bottom:20px; color:#ffffff; font-size:14px;"><c:out value="${popupManageVO.popupTitleNm}"/></h1>
		<div style="width:455px; color:#d6d6d6;">
			<c:out value="${popupManageVO.popupCn}" escapeXml="false" />
		</div>		
	</div>
	
	<c:if test="${popupManageVO.stopVewAt eq 'Y'}">	
		<div id="popmainboxdn">
			<p><input type="checkbox" name="chkPopup" id="chkPopup" onclick="fnPopupCheck()" />다음에 이 창 열지 않기</p>
		</div>
	</c:if>
		
</body>
</html>