<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" type="text/css" href="/template/manage/css/default.css" charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="/template/manage/css/login.css" charset="utf-8" />
 

 
 
	<title></title>
	
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
	<base target="_self"/>
	</head>
 
	<body>
		<div id="admin_wrap">


					<div class="login_box">
						<h3><img src="/template/manage/images/login/txt_welcom.gif" alt=" 관리자페이지입니다." /></h3>
						<p class="txt"><img src="/template/manage/images/login/txt_login.gif" alt="관리자 아이디와 비밀번호를 입력하여 주시기 바랍니다." /></p>

						<form action="<c:url value='/uat/uia/actionLogin.do'/>" name="frmLogin" method="post" onsubmit="return checkLogin()" class="login_inp">
							<fieldset>
								<legend>로그인폼</legend>
								<p>
									<label for="id"><img src="/template/manage/images/login/txt_id.gif" alt="아이디" /></label>
									<input type="text" id="inputId" name="id" class="linp" value="master"/>
								</p>
								<p>
									<label for="pwd"><img src="/template/manage/images/login/txt_pw.gif" alt="비밀번호" /></label>
									<input type="password" id="inputPw" name="password" class="linp" value="1111"/>
								</p>
								<input type="image" src="/template/manage/images/login/btn_login.gif" alt="로그인" class="btn_login" />
							</fieldset>
						</form>
					</div>
					<div class="admin_foot alC"><img src="/template/manage/images/login/copyright.gif" alt="COPYRIGHT(C)2011 BY emt. ALL RIGHTS RESERVED. tel : 1644-9420 | fax : 1644-9421"></div>
					

		</div>
	
	</body>
</html>