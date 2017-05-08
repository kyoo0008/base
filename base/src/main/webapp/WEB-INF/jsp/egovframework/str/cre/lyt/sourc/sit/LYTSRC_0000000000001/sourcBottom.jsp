<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%
	/*
		사이트맵 			: /msi/siteMap.do
		개인정보보호정책 	: /msi/indvdlInfoPolicy.do
		이용약관			: /msi/useStplat.do
		이메일수집거부		: /msi/emailColctPolicy.do
	*/
%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
	
		<!-- footer -->
		<div id="footer">
			<div class="finfo">
				<ul>
					<li><a href="#">하단메뉴1</a><span>|</span></li>
					<li><a href="#">하단메뉴2</a><span>|</span></li>
					<li><a href="#">하단메뉴3</a><span>|</span></li>
					<li><a href="#">하단메뉴4</a></li>
				</ul>
			</div>

			<div class="footer">
				<div class="address">
					<address>대전광역시 유성구 노은동75번길 66 미란빌딩2층</address>
					<p>Copyright (c) 2013 by sejong office of education. all rights reserved.</p>
				</div>
			</div>
		</div>
		<!-- //footer -->
</body>
</html>