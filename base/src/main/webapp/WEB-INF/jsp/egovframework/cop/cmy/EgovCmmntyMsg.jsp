<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.com.cmm.service.Globals" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />



        <div class="com_con_list3">
          <h5 class="t_title">커뮤니티처리 결과</h5>

		  <div class="commwelcome">
			<div class="welcometxt">
				<strong>
				<c:choose>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_MBER_A' or cmmntyVO.resultCode eq 'CMMNTY_MBER_B'}">
						커뮤니티 가입을 환영합니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'DEL_REQ_SUCCESS'}">
						탈퇴가 정상 처리 되었습니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_CLOSING'}">
						커뮤니티가 정상적으로 폐쇄되었습니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_INTRCP'}">
						커뮤니티 가입실패
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_MBER_FC'}">
						커뮤니티 가입실패
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'ING'}">
						현재 승인요청 중입니다.
					</c:when>
					<c:otherwise>
						요청처리 실패
					</c:otherwise>
				</c:choose>
				</strong>
				<p>
					<c:choose>
					<c:when test="${cmmntyVO.resultCode eq'CMMNTY_MBER_A'}">
						<span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span>에 가입신청이 정상적으로 요청 되었습니다.<br/>해당 커뮤니티의 운영정책에 따라 운영진의 승인 후 회원으로 활동 하실 수 있습니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq'CMMNTY_MBER_B'}">
						<span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span>에 가입하신 것을 축하드립니다! <br/>많은 활동 부탁드립니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq'DEL_REQ_SUCCESS'}">
						<span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span> 커뮤니티에 탈퇴처리가 완료 되었습니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_CLOSING'}">
						<span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span> 커뮤니티가 정상적으로 폐쇄되었습니다. <br/>그동안 수고 하셨습니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_INTRCP'}">
						해당 커뮤니티의 운영정책에 따라 기존회원에 대한 재가입이 불가 합니다.<br/>재가입의 경우 운영자(시샵)에 재가입 승인정책이 필요합니다.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'CMMNTY_MBER_FC'}">
						이미 <span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span> 커뮤니티에 가입 하였습니다<br/> 다시한번 확인 하여 주십시오.
					</c:when>
					<c:when test="${cmmntyVO.resultCode eq 'ING'}">
						현재 회원님은 <span class="bold"><c:out value="${cmmntyInfo.cmmntyNm}"/></span> 커뮤니티에 가입승인요청 중입니다.<br/>운영진의 승인 후 회원으로 활동 하실 수 있습니다.
					</c:when>
					<c:otherwise>
						요청하신 처리가 이루어지지 않았습니다.
					</c:otherwise>
				</c:choose>
				</p>
			</div>
		  </div>
   		  <div class="center">
		  	  <a href="/cmy/<c:out value="${cmmntyInfo.cmmntyAdres}.do"/>" title="메인화면으로 이동"><img src="${_IMG}/btn/btn_ok2.gif" alt="확인" /></a>
		  </div>


        </div>


<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>