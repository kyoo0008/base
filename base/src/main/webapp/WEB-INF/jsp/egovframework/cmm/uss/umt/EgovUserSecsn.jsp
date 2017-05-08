<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>

<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="06"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="pwdCnfirm" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
<c:if test="${result}">
	alert("<c:out value="${message}"/>");
	location.href = "<%=EgovUserDetailsHelper.getRedirectLogoutUrl()%>";
</c:if>

function checkForm(form) {
	
	if(form.deleteResn.value == "") {
		alert("탈퇴사유를 입력하세요.");
		return false;
	}
	
	if (!confirm('회원탈퇴를 하시겠습니까?\n\n탈퇴시 모든 정보는 삭제 되며 해지된 ID는 재사용이 불가능합니다.')) {
		return false;
	}else{
		return true;
	}
}
</script>

			<div id="sub_content">

				<h2 class="secede_tit"><img src="${_IMG}/login/secede_tit.gif" alt="회원탈퇴" /></h2>
			
				<!-- pw_re_box  start -->
				<div class="parent_box">
					<form:form commandName="secsnCnfirm" name="secsnCnfirm" method="post" action="${pageContext.request.contextPath}/uss/umt/cmm/EgovUserSecsn.do" onsubmit="return checkForm(this);">
						<fieldset>
							<legend>학부모 신청 조회</legend>

							<h3>탈퇴 확인 정보</h3>
							<table class="chart2" summary="회원아이디, 이름 탈퇴확인정보를 나타낸 표입니다">
							<caption>탈퇴확인정보</caption>
							<tbody>
								<tr>
									<th>회원 아이디</th>
									<td><c:out value="${fn:substring(USER_INFO.id, 0,3)}"/><c:forEach begin="4" end="${fn:length(USER_INFO.id)}" step="1">*</c:forEach></td>
								</tr>
								<tr>
									<th>이름</th>
									<td><c:out value="${USER_INFO.name}"/></td>
								</tr>
								<tr>
									<th>탈퇴사유</th>
									<td><input type="text" name="deleteResn" id="deleteResn" size="58" maxlength="2500" class="inp" /></td>
								</tr>
							</tbody>
							</table>

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
