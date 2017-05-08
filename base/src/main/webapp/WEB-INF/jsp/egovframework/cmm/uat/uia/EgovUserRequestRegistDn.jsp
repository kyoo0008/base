<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>인증서 등록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/common/css/default.css'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/template/common/css/member.css'/>" />
<script type="text/javascript">
		<c:if test='${not empty message}'>
			alert("${message}");
		</c:if>

		function checkLogin() {
			var frm = document.frmLogin;
    		if(frm.id.value == "") {
				alert("아이디를  입력해주세요");
				frm.id.focus();
				return false;
			}

    		if(frm.password.value == "") {
				alert("비밀번호를  입력해주세요");
				frm.password.focus();
				return false;
			}
		}
		
	</script>
</head>
<body>
	<div class="cert_bg">
		<h1 class="cert_tit"><img src="<c:url value='/template/common/images/member/cert_logo.jpg'/>" alt="과학기술연수원" /></h1>
				<h2><img src="<c:url value='/template/common/images/member/cert_title.gif'/>" alt="인증서 등록" /></h2>
				<p class="txt">인증서 등록이 안되어 있으신 분께서는 인증서 등록을 먼저 해주세요.</p>
				<form action="<c:url value='/uat/uia/EgovUserIdPwRegistDn.do'/>" target="frmDn" method="post" name="frmLogin" class="cert_form" onsubmit="return checkLogin()">
					<fieldset>
						<legend class="hdn">인증서</legend>
						<div class="cert">
							<p class="id"><label><img src="<c:url value='/template/common/images/member/cert_id.gif'/>" alt="ID" /></label><input type="text" id="id" name="id" class="inp_txt" /></p>
							<p class="pw"><label><img src="<c:url value='/template/common/images/member/cert_pw.gif'/>" alt="PW" /></label><input type="password" id="pw" name="password" class="inp_txt" /></p>
						</div>
						<input type="image" src="<c:url value='/template/common/images/member/cert_login_btn.gif'/>" alt="LOGIN" class="cert_btn" />
					</fieldset>
				</form>

				<ul class="cert_list">
					<li class="point">* 인증서 등록시 오류가 나시는 분은 아래 사항을 확인해주세요.</li>
					<li>1. 본인 아이디를저확히 입력하셨는지 확인해주세요</li>
					<li>2. 등록가능 공인인증서: 교육과학기술부 인증서, 행정안전부 인증</li>
				</ul>
			<input type="image" src="<c:url value='/template/common/images/member/cert_close.jpg'/>" alt="닫기" class="cert_close" onclick="window.close();"/>
	</div>
	<iframe name="frmDn" style="width:0px; height:0px;"></iframe>
</body>
</html>