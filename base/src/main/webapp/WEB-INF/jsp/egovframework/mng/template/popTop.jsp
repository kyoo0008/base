<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:url var="jsPath" value="../../js/egovframework" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><c:out value="${param.title}"/></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/jquery/jquery-1.9.1.min.js"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/default.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/page.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/com.css'/>"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/common.js"></script>
<c:if test="${not empty param.validator }">
	<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
	<validator:javascript formName="${param.validator }" staticJavascript="false" xhtml="true" cdata="false"/>
</c:if>
</head>
<body>
<c:set var="mngimg" value="${pageContext.request.contextPath}/template/manage/images"/>
<div id="wrap">

	
	<div id="container">
		
		<div id="navi">
				<h2 class="naviTit"><c:out value="${param.title}"/></h2>
			</div>
			
			<div id="contents">
