<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/mma/images"/>

	<c:if test="${param.isMain ne 'Y'}">
				</div>
				<div class="sub_con_bot"></div>
			</div>
		</div>
	</c:if>
</div>
<div id="footer">
	<div class="foot_cont">
		<h2 class="foot_logo"><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.lptLogoFileNm}" alt="<c:out value="${siteInfo.siteNm}"/>" /></h2>
		
		<div class="footer_gnb">
			<a href="${_WEB_FULL_PATH}/msi/indvdlInfoPolicy.do"><spring:message code="etc.link.indvdlInfoPolicy" /></a><span>|</span>
			<a href="${_WEB_FULL_PATH}/msi/cpyrhtSttemntSvc.do"><spring:message code="etc.link.cpyrhtSttemntSvc" /></a><span>|</span>
			<a href="${_WEB_FULL_PATH}/msi/useStplat.do"><spring:message code="etc.link.useStplat" /></a><span>|</span>
			<a href="${_WEB_FULL_PATH}/msi/emailColctPolicy.do"><spring:message code="etc.link.emailColctPolicy" /></a>
		</div>

		<p class="address">${siteInfo.adresReplcText} TEL : ${siteInfo.tlphonNo}</p>

		<span class="copy_bold">COPYRIGHT (C)2012 BY SEJONG CITY OFFICE OF EDUCATION ALL RIGHTS RESERD.</span>
	</div>
</div>

</div>

</body>
</html>