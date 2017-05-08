<?xml version="1.0" encoding="utf-8"?>
<root>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
	<authStepInfo>
		<step>${AuthStep}</step>
		<result>${StepResult}</result>
		<loginUrl><c:if test="${StepResult eq 'Y'}"><![CDATA[http://<c:out value="${siteInfo.siteUrl}"/>/uat/uia/actionAppLogin.do]]></c:if></loginUrl>
	</authStepInfo>
	<c:if test="${AuthStep eq 'LOGIN' and StepResult eq 'Y'}">
		<siteInfo>
			<siteName><![CDATA[<c:out value="${siteInfo.siteNm}"/>]]></siteName>
			<siteUrl><![CDATA[http://<c:out value="${siteInfo.siteUrl}"/>]]></siteUrl>
			<logoutUrl><![CDATA[http://<c:out value="${siteInfo.siteUrl}"/>/uat/uia/actionLogout.do]]></logoutUrl>
			<latitude><![CDATA[<c:out value="${siteInfo.la}"/>]]></latitude>
			<longitude><![CDATA[<c:out value="${siteInfo.lo}"/>]]></longitude>
		</siteInfo>
		<calUrlList>
			<c:forEach var="result" items="${calUrlList}" varStatus="status">
				<calUrl>
					<name><![CDATA[<c:out value="${result.menuNm}"/>]]></name>
					<url><![CDATA[${result.menuWebPath}]]></url>
				</calUrl>
			</c:forEach>
		</calUrlList>
		<notifyUrlList>
			<c:forEach var="result" items="${notifyUrlList}" varStatus="status">
				<notifyUrl>
					<name><![CDATA[<c:out value="${result.cmmntyNm}"/>]]></name>
					<url><![CDATA[http://${result.siteUrl}/cop/cmy/bbs/selectBoardList.do?trgetId=${result.trgetId}&bbsId=${result.bbsId}]]></url>
				</notifyUrl>
			</c:forEach>
		</notifyUrlList>
		<vodUrlList>
			<vodUrl>
				<name><![CDATA[<c:out value="${siteInfo.siteNm}"/>]]> 동영상</name>
				<url><![CDATA[http://<c:out value="${siteInfo.siteUrl}"/>/mma/MblMltmdMvpInfoList.do]]></url>
			</vodUrl>
		</vodUrlList>
		<siteUrlList>
			<c:forEach var="result" items="${siteList}" varStatus="status">
				<siteUrl>
					<name><![CDATA[<c:out value="${result.siteNm}"/>]]></name>
					<url><![CDATA[http://<c:out value="${result.siteUrl}"/>/?token=${USER_INFO.ssoToken}]]></url>
				</siteUrl>
			</c:forEach>
		</siteUrlList>
	</c:if>
</root>