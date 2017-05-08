<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%
	/*
		사이트맵 			: /msi/siteMap.do
		개인정보보호정책 	: /msi/indvdlInfoPolicy.do
		이용약관			: /msi/useStplat.do
		이메일수집거부		: /msi/emailColctPolicy.do
	*/
%>
<c:set var="IS_MOBILE"><%=egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)%></c:set>
<c:set var="TEMPLATE_PATH" value="${IS_MOBILE ? 'mbl' : 'web'}"/>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${_WEB_FULL_PATH}/template/${TEMPLATE_PATH}/${siteInfo.lytTmplatId}/image"/>
<c:choose>
	<c:when test="${siteInfo.mobileUseAt eq 'Y' and IS_MOBILE}">
		mobileSource
	</c:when>
	<c:otherwise>
					<ul class="bottom_menu">
				       <li class="bar"><a href="${_WEB_FULL_PATH}/msi/siteMap.do"><b>사이트맵</b></a></li>
				       <li class="bar"><a href="${_WEB_FULL_PATH}/msi/indvdlInfoPolicy.do"><b>개인정보보호정책</b></a></li>
				       <li class="bar_center"><a href="${_WEB_FULL_PATH}/msi/useStplat.do"><b>이용약관</b></a></li>
				       <li class="bar_center"><a href="${_WEB_FULL_PATH}/msi/emailColctPolicy.do"><b>이메일무단수집거부</b></a></li>
				    </ul>
				     
					<div>
				    	<h1><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.lptLogoFileNm}" alt="<c:out value="${siteInfo.siteNm}"/>" /></h1>
				    </div>
					<p class="copyright"><img src="${SiteFileStoreWebPath}${siteInfo.siteId}/${siteInfo.adresFileNm}" alt="<c:out value="${siteInfo.adresReplcText}"/>" /></p>
		
				</div>
			</div>
		</body>
		</html>

	</c:otherwise>
</c:choose>