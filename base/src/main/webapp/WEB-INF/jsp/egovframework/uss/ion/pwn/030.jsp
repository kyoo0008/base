<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/web/smart_001/image"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/web/smart_001/css"/>
<c:set var="C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
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

	<div style="position:relative; width:450px; font-size:12px; background:url(${_IMG}/common/popuptem_450_bg1.jpg) no-repeat left bottom;">
		<div style="padding:25px 55px 45px 25px;background:url(${_IMG}/common/popuptem_450_bg.jpg) no-repeat left top; ">
			<h1 style="margin-bottom:20px; color:#3e75c8; font-size:14px;"><c:out value="${popupManageVO.popupTitleNm}"/></h1>
			<div style="width:370px;">
				<c:out value="${popupManageVO.popupCn}" escapeXml="false" />
			</div>
			<p style="position:absolute; bottom:13px; right:14px; "><img src="${_IMG}/common/popuptem_450_pencil.png" alt="" /></p>
		</div>
	</div>
	
	<c:if test="${popupManageVO.stopVewAt eq 'Y'}">	
		<div id="popmainboxdn">
			<p><input type="checkbox" name="chkPopup" id="chkPopup" onclick="fnPopupCheck()" />다음에 이 창 열지 않기</p>
		</div>
	</c:if>
		
</body>
</html>