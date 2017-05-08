<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	var rst = '<c:out value="${realhpVO.result}"/>';
	var msg = '<c:out value="${realhpVO.message}"/>';
	var cod = '<c:out value="${realhpVO.code}"/>';
	
	if (rst == 1) {
		if (cod == 1)
			alert("주민등록번호가 일치하지 않습니다. 다시 입력해주시 바랍니다.");
		else if (cod == 2)
			alert("법인폰 사용자는 휴대폰 인증 서비스를 이용할 수 없습니다.");
		else if (cod == 3)
			alert("선불 이용자는 휴대폰 인증 서비스를 이용할 수 없습니다.");
		else if (cod == 4)
			alert("무선인터넷 차단 이용자는 휴대폰 인증 서비스를 이용할 수 없습니다.");
		else if (cod == 99)
			alert("기타 명의 정보 조회에 실패하였습니다.");
	} else if (rst == 2) {
		alert("실명인증 서비스가 원할하지 않습니다. 잠시 후 다시 이용해 주시기 바랍니다");
	}else if (rst == 0) {
		parent.displayHpCheck('<c:out value="${realhpVO.authnum}"/>');
	}

</script>