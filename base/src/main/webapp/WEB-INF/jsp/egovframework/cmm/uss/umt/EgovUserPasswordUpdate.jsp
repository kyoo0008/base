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
	<c:param name="menuSeq" value="05"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordCnfirm" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">	

<c:if test="${result}">
	alert("<c:out value="${message}"/>");
</c:if>

function checkForm(form) {
	if(!validatePasswordCnfirm(form)){
    	return false;
    }
	
	if($.trim($('#password').val()) !=$.trim($('#password2').val())){
        alert("<spring:message code="fail.user.passwordUpdate2" />");
        return false;
    }
				
	if (!confirm('<spring:message code="common.update.msg" />')) {
		return false;
	}
}
</script>
			<div id="sub_content">

				<h2><img src="${_IMG}/login/change_tit.gif" alt="아이디찾기 아래의 사용자 확인 방법중 하나를 선택하여 회원기입 시 등록한 정보를 입력해주세요." /></h2>
			
				<!-- change_box  start -->
				<div class="change_box">
					
					<form:form commandName="passwordCnfirm" action="${pageContext.request.contextPath}/uss/umt/cmm/EgovUserPasswordUpdate.do" method="post" onsubmit="return checkForm(this)">
						<fieldset>
							<legend>비밀번호 변경 폼</legend>

									<div class="change_intro">
										<span>* 자주쓰는 사이트의 비밀번호가 같을 경우, 도용되기 쉬우므로 주기적으로 변경하셔서 사용하는 것이 좋습니다.</span>
										<span>* 아이디와 주민등록번호, 생일, 전화번호 등 개인정보와 관련된 숫자, 반복된 문자등 다른 사람이 쉽게 알수 있는 비밀번호는 기인정보 유출의 위험이 높으므로 사용을 자제해 주시기 바랍니다.</span>
									</div>

									<div class="change_inp">
										<div>
											<label for="new_pw">새로운 비밀번호</label>
											<input type="password" id="password" name="password" class="inp" id="new_pw" />
											<span class="tblue">비밀번호는 영문, 숫자 혼합하여 6자~12자로 하여 주시기 바랍니다.</span>
										</div>
										
										<div>
											<label for="new_pw">새 비밀번호 확인</label>
											<input type="password" id="password2" name="password2" class="inp" id="new_pw_ch" />
											<span>재확인을 위해서 입력하신 비밀번호를 다시 한번 입력해 주세요.</span>
										</div>
									</div>

									<div class="btn_c">
										<span class="btn"><button type="submit">확인</button></span>
										<span class="btn2"><button type="reset">취소</button></span>
									</div>
								
				
						</fieldset>
					</form:form>
				</div>
				<!-- // change_box end -->

			</div>


<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>
