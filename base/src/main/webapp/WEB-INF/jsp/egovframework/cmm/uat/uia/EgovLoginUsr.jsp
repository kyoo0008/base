<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="IS_MOBILE"><%=egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)%></c:set>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:choose>
	<c:when test="${IS_MOBILE}">
		
	</c:when>
	<c:otherwise>
		
		<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8"/>
			<script type="text/javascript">	
				<c:if test='${not empty message}'>
					alert("${message}");
				</c:if>
				function checkCertLogin(frm) {
					if(frm.id.value == "") {
						alert("아이디를  입력해주세요");
						frm.id.focus();
						return false;
					}
				}
				
				function checkGnrlLogin(frm) {
		    		if(frm.id.value == "") {
						alert("아이디를  입력해주세요");
						frm.id.focus();
						return false;
					}
		
		    		if(frm.pwd.value == "") {
						alert("비밀번호를  입력해주세요");
						frm.pwd.focus();
						return false;
					}
				}
			</script>
			<div class="login_box">
			
				<!-- 스마트스쿨 로그인 -->
				<div class="smartshool login">
					<h2><img src="${_IMG}/login/login_txt.gif" alt="로그인" /></h2>
					<p class=""><img src="${_IMG}/login/txt_smart.gif" alt="로그인이 필요한 서비스입니다. 로그인 해주세요. 회원이 아닌 분은 회원가입 해 주세요." /></p>
					
					<div class="login_inp">
					<form action="<c:url value='/uat/uia/actionLogin.do'/>" name="frmGnrlLogin" method="post" onsubmit="return checkGnrlLogin(this)">
						<fieldset>
								<legend>스마트스쿨 로그인 입력폼</legend>
								<span>
									<label for="id"><img src="${_IMG}/login/txt_id.gif" alt="아이디" /></label>
									<input type="text" id="id" name="id" value="admin" class="inp" />
								</span>
								<span>
									<label for="pwd"><img src="${_IMG}/login/txt_pwd.gif" alt="패스워드" /></label>
									<input type="password" id="pwd" name="password" value="1" class="inp" />
								</span>
								<input type="image" src="${_IMG}/login/btn_login.gif" alt="로그인" class="btn_login" />
						</fieldset>
					</form>
					</div>

					<ul>
						<li><a href="<%=EgovUserDetailsHelper.getRedirectRegistUrl()%>"><img src="${_IMG}/login/btn_join.gif" alt="회원가입" /></a></li>
						<li><a href="<%=EgovUserDetailsHelper.getRedirectFindIdUrl()%>"><img src="${_IMG}/login/btn_find.gif" alt="아이디/패스워드찾기" /></a></li>
					</ul>
				</div>
				<!-- //스마트스쿨 로그인 -->
				<%-- 
				<!-- 교직원 로그인 -->
				<div class="admin login">
					<h2><img src="${_IMG}/login/tit_admin.gif" alt="교직원 인증서 로그인" /></h2>
					<p class=""><img src="${_IMG}/login/txt_admin.gif" alt="EPKI인증서 로그인은 세종시 첫마을 스마트스쿨의 교직원을 대상으로 서비스 됩니다." /> </p>

					<a href=""><img src="${_IMG}/login/btn_exe.gif" alt="인증서 로그인을 위한프로그램 설치" /></a>

					<div class="login_inp">
						<form action="<c:url value='/uat/uia/actionCrtfctLogin.action'/>" name="frmCertLogin2" method="post" onsubmit="return checkCertLogin(this)">
							<fieldset>
								<legend>교직원 인증서 로그인 입력폼</legend>
								<input type="text" id="id" name="id" class="inp" title="아이디입력" />
								<span  class="btn"><button type="submit">로그인</button></span>
								<a href="http://www.epki.go.kr" target="_blank" class="btn2">EPKI 인증센터</a>
							</fieldset>
						</form>
					</div>

					<ul>
						<li class="em">-교직원은 반드시 EPKI인증서로 로그인해야 학사업무관리 시스템을 비롯한제반 서비스시스템을 원활하게 이용할 수 있습니다.</li>
						<li>-교직원이 아닌 일반회원은 EPKI인증 로그인을 하실 수 없습니다.</li>
					</ul>


				</div>
				<!--//교직원 로그인 -->
				--%>
			</div>
	
		
		<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>
	</c:otherwise>
</c:choose>