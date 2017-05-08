<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<c:set var="isAuthenticated"><%=EgovUserDetailsHelper.isAuthenticated(request, response) %></c:set>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_PREFIX" value="${pageContext.request.contextPath}/uss/umt/cmm"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images" />
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8"/>

<script type="text/javaScript" language="javascript">
<!--
<c:if test="${isAuthenticated}">
alert("이미 로그인 하셨습니다.");
location.href ="<%=Globals.MAIN_PAGE%>";
</c:if>
//-->
	function user_grade(grade){
		var url = '${pageContext.request.contextPath}uss/umt/cmm/EgovStplatCnfirmMber.do';
			url = url+"?grade="+grade;
			document.seletUserGrade.action = url;
			document.seletUserGrade.submit();
	}
</script>
<form method="post" name="seletUserGrade" action="${pageContext.request.contextPath}/uss/umt/cmm/EgovStplatCnfirmMber.do">
	<!-- //20130311 회원선택 -->
	<!-- content strat -->
	<div id="content"> 
		<!-- 20130311 회원선택-->
		<div class="join_choice">
			<ul>
				<li class="odd"><a href="#" onclick="user_grade('general')"><img src="${_IMG }/login/join_btn01.png" alt="일반회원 가입신청" /></a></li>
				<li><a href="#" onclick="user_grade('student')"><img src="${_IMG }/login/join_btn02.png" alt="학생회원 가입신청" /></a></li>
				<li class="odd"><a href="#" onclick="user_grade('staff')"><img src="${_IMG }/login/join_btn03.png" alt="교직원회원 가입신청" /></a></li>
				<li><a href="#" onclick="user_grade('lecture')"><img src="${_IMG }/login/join_btn04.png" alt="강사회원 가입신청" /></a></li>
			</ul>
		</div>
	</div>
</form>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>