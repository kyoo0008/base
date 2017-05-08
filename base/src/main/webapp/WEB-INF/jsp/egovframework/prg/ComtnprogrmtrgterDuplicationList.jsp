<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>	 
	<title>체험프로그램 중복자 목록</title>
	<c:choose>
	<c:when test="${not empty message }">
	<script type="text/javascript">
	<!--
		alert("${message}");		
	//-->	
	</script>
	</c:when>
	<c:otherwise>
	
	</c:otherwise>
	</c:choose>
</head>
<body>
<div id="pop_page">
	<div class="pop_top">
		<h1>중복자 목록</h1>
	</div>
	<div class="pop_cont">
		<div id="pbbs_wrap">
			<table class="list_table">
			<thead>
				<tr>
					<th>ID</th>
					<th>이름</th>								
				</tr>
			</thead>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${result.userId }</td>
					<td>${result.adhrncNm }</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</body>
</html>