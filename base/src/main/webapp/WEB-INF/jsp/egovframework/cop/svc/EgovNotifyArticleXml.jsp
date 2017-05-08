<?xml version="1.0" encoding="utf-8"?>
<root>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
	<notifyItems count="${resultCount}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<item>
				<nttNo><![CDATA[<c:out value="${result.nttNo}"/>]]></nttNo>
				<siteNm><![CDATA[<c:out value="${result.siteNm}"/>]]></siteNm>
				<siteUrl><![CDATA[<c:out value="${result.siteUrl}"/>]]></siteUrl>
				<nttSj><![CDATA[<c:out value="${result.nttSj}"/>]]></nttSj>
				<nttCn><![CDATA[<c:out value="${result.nttCn}"/>]]></nttCn>
				<ntcrNm><![CDATA[<c:out value="${result.ntcrNm}"/>]]></ntcrNm>
				<frstRegisterPnttm><![CDATA[<fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/>]]></frstRegisterPnttm>
			</item>
		</c:forEach>
	</notifyItems>
</root>