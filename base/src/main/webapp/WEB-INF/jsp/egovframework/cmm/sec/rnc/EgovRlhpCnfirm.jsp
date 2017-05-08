<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="serverName" value="<%=request.getServerName()%>"/>
<c:set var="serverPort" value="<%=request.getServerPort()%>"/>
<c:choose>
 <c:when test="${serverPort == 80}">
  <c:set var="serverPort" value=""/>
 </c:when>
 <c:otherwise>
  <c:set var="serverPort" value=":${serverPort}"/>
 </c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>핸드폰 인증</title>
<script type="text/javascript">
<!--
function fn_check_hp() {
	document.hpCheckForm.submit();
}
//-->
</script>
</head>
<body>

<c:choose>
<c:when test="${result}">
	<form:form id="hpCheckForm" name="hpCheckForm" method="post" action="http://www.checkon.co.kr/module/auth_hpsms.php">
	<input type="hidden" id="cp_id" name="cp_id" value="cybergongju1" />
	<input type="hidden" id="cp_pass" name="cp_pass" value="son9523" />
	<input type="hidden" id="cp_return" name="cp_return" value="http://${serverName}${serverPort}/sec/rnc/RealhpCheck.do"/>
	<input type="hidden" id="cp_ip" name="cp_ip" value="115.92.195.227" />
	<input type="hidden" id="cp_jumin" name="cp_jumin" value="<c:out value="${realhpVO.cp_jumin}"/>"/>
	<input type="hidden" id="cp_phone" name="cp_phone" value="<c:out value="${realhpVO.cp_phone}"/>"/>
	<input type="hidden" id="cp_telco" name="cp_telco" value="<c:out value="${realhpVO.cp_telco}"/>"/>
	<input type="hidden" name="cp_smsMsg" value="<%=java.net.URLEncoder.encode("부모동의 인증번호는 AUTHNUM 입니다", "euc-kr")%>"/>
	<input type="hidden" name="cp_client" value="<c:out value="${realhpVO.cp_client}"/>"/>
	</form:form>
	
	<script type="text/javascript">
	<!--
	document.hpCheckForm.submit();
	//-->
	</script>
</c:when>
<c:otherwise>
	<script type="text/javascript">
		var msg = '<c:out value="${message}"/>';
	
		if (msg != ''){
			alert(msg);
		}
		parent.checkIhidnum();
	</script>
</c:otherwise>
</c:choose>
</body>
</html>