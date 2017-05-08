<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="step" value="1"/>
</c:import>

<script type="text/javaScript">
	function cnfirm(){ 
		if (!$('input[id=agree01]:checked').is(':checked')) {
			alert('약관에 동의하지 않으셨습니다.');
		     return false;
		} 
		if (!$('input[id=agree02]:checked').is(':checked')) {
			alert('개인정보 수집 및 이용에 대한 안내 내용에 동의하지 않으셨습니다.');
		     return false;
		} 
	}
</script>


<h2 class="icon1">약관동의</h2>
				
				<p>약관 및 개인정보처리방침을 반드시 읽고 난 후 동의해주십시오.</p>

				<div class="agree_box">
					<form action="<c:url value="/uss/umt/cmm/EgovCertificate.do"/>" method="post" action="<c:url value="/uss/umt/cmm/EgovCertificate.do"/>" onsubmit="return cnfirm();">
					<input type="hidden" name="userSeCode" value="${searchVO.userSeCode}"/>
					<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
					<input type="hidden" name="grade" value="${user.grade}"/>
						<h3 class="icon2">이용약관</h3>
							<div class="cont">
								<c:catch var="ex">
									<c:import url="/EgovPageLink.do?link=${UseStplatUrl}" charEncoding="utf-8" var="html"/>
									<c:set var="html" value="${fn:replace(html, '$SITE_NM$', siteInfo.siteNm)}"/>
									<c:set var="html" value="${fn:replace(html, '$PHONE_NO$', siteInfo.tlphonNo)}"/>
									<c:set var="html" value="${fn:replace(html, '$FAX_NO$', siteInfo.faxNo)}"/>
									<c:out value="${html}" escapeXml="false"/>	
								</c:catch>
								<c:if test="${ex != null}">publishing not found</c:if>
							</div>
							<div class="check">
								<input type="checkbox" class="vMid" id="agree01" />
								<label for="agree01">약관을 충분히 이해하였으며 동의 합니다.</label>
							</div>


							<h3  class="icon2">개인정보 수집 및 이용에 대한 안내</h3>
							<div class="cont">
								<c:catch var="ex">
									<c:import url="/EgovPageLink.do?link=${IndvdlInfoPolicyUrl}" charEncoding="utf-8" var="html"/>
									<c:set var="html" value="${fn:replace(html, '$SITE_NM$', siteInfo.siteNm)}"/>
									<c:set var="html" value="${fn:replace(html, '$PHONE_NO$', siteInfo.tlphonNo)}"/>
									<c:set var="html" value="${fn:replace(html, '$FAX_NO$', siteInfo.faxNo)}"/>
									<c:out value="${html}" escapeXml="false"/>	
								</c:catch>
								<c:if test="${ex != null}">publishing not found</c:if>
							</div>
							<div class="check">
								<input type="checkbox" class="vMid" id="agree02" />
								<label for="agree02">개인정보 수집 및 이용에 대한 안내를 이해하였으며 동의 합니다.</label>
							</div>
						
							<div class="btn_c">
								<span class="btn"><button type="submit">동의</button></span>
								<span class="btn2"><button type="button" onclick="location.href='/'">동의하지 않습니다</button></span>
							</div>
						</form>
					</div>
					
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>