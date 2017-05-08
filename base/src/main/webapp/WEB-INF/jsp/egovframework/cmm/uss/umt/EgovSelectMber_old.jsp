<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<c:set var="isAuthenticated"><%=EgovUserDetailsHelper.isAuthenticated(request, response) %></c:set>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_PREFIX" value="${pageContext.request.contextPath}/uss/umt/cmm"/>

<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8"/>

<script type="text/javaScript" language="javascript">
<!--
<c:if test="${isAuthenticated}">
alert("이미 로그인 하셨습니다.");
location.href ="<%=Globals.MAIN_PAGE%>";
</c:if>
//-->
</script>

			<div class="join_box">
				<!-- 학부모 정회원가입 -->
				<div class="join parent">
					<div>
						<img src="${_IMG}/login/txt_parent.gif" alt="학부모정회원가입 - 회원가입시 자녀(학생)정보를 입력하시면 담당선생님의 승인 후 자녀의 학교생활 내역을 확인 하실 수 있습니다." />
					</div>
					<a href="${_PREFIX }/EgovStplatCnfirmMber.do?userSeCode=04&amp;siteId=${searchVO.siteId}"><img src="${_IMG}/login/btn_parent.gif" alt="학부모 정회원 가입신청" /></a>
					
				</div>
				<!-- //학부모 정회원가입 -->
				
				<!-- 일반 정회원가입 -->
				<div class="join general">	
					<div>
						<img src="${_IMG}/login/txt_general.gif" alt="일반정회원가입 - 일반회원 가입 후 각 학교의 시설물 대여 신청 및 커뮤니티를  이용하실 수 있습니다." />
					</div>
					<a href="${_PREFIX }/EgovStplatCnfirmMber.do?userSeCode=02&amp;siteId=${searchVO.siteId}"><img src="${_IMG}/login/btn_general.gif" alt="일반 정회원 가입신청" /></a>

				</div>
				<!-- //일반 정회원가입 -->

			</div>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>