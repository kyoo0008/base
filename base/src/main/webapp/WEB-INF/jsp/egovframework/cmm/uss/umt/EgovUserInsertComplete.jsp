<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="step" value="4"/>
</c:import>

		<div class="join_success">
					
			<img src="${_IMG}/login/join_end.gif" alt="회원가입이 완료되었습니다. 로그인 후 사용해주시기 바랍니다." />
			
		</div>


<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>