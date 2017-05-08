<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>

<c:choose>
	<c:when test="${searchVO.trgtPge eq 'update'}"><c:set var="menuSeq" value="03"/></c:when>
	<c:when test="${searchVO.trgtPge eq 'password'}"><c:set var="menuSeq" value="05"/></c:when>
	<c:when test="${searchVO.trgtPge eq 'secsn'}"><c:set var="menuSeq" value="06"/></c:when>
</c:choose>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="${menuSeq}"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="pwdCnfirm" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
<c:if test="${not empty message}">
	alert("<c:out value="${message}"/>");
</c:if>
function checkForm(form) {	

	if(!validatePwdCnfirm(form)) {				
		return false;
	}

	return true;

}

</script>

			<div id="sub_content">

				<c:choose>
					<c:when test="${searchVO.trgtPge eq 'update'}"><h2><img src="${_IMG}/login/mb_tit.gif" alt="회원정보 변경" /></h2></c:when>
					<c:when test="${searchVO.trgtPge eq 'password'}"><h2><img src="${_IMG}/login/change_tit.gif" alt="아이디찾기 아래의 사용자 확인 방법중 하나를 선택하여 회원기입 시 등록한 정보를 입력해주세요." /></h2></c:when>
					<c:when test="${searchVO.trgtPge eq 'secsn'}"><h2 class="secede_tit"><img src="${_IMG}/login/secede_tit.gif" alt="회원탈퇴" /></h2></c:when>
				</c:choose>
			
				<!-- pw_re_box  start -->
				<div class="mb_re_box">
					<form:form commandName="pwdCnfirm" name="pwdCnfirm" method="post" action="${pageContext.request.contextPath}/uss/umt/cmm/EgovUserConfirm.do" onsubmit="return checkForm(this);">
						<input type="hidden" name="trgtPge" value="<c:out value="${searchVO.trgtPge}"/>" />
						<input type="hidden" name="userId" value="<c:out value="${userManageVO.userId}"/>" />
						<fieldset>
							<legend>회원정보 변경폼</legend>

							<div class="mb_intro">
								<span>* 본인확인을 위해 비밀번호를 입력해주세요</span>
							</div>

							<div class="mb_chk">
								 <span>아이디</span><ins><c:out value="${fn:substring(USER_INFO.id, 0,3)}"/><c:forEach begin="4" end="${fn:length(USER_INFO.id)}" step="1">*</c:forEach></ins>
								 <label for="password">비밀번호</label>
								<input type="password" id="password" name="password" class="inp" /><form:errors path="password" />
							</div>

							<div class="btn_c">
								<span class="btn"><button type="submit">확인</button></span>
								<span class="btn2"><button type="reset">취소</button></span>
							</div>


						
						</fieldset>
					</form:form>
				</div>
				<!-- //pw_re_box end -->

				</div>


<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>
