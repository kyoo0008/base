<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="LOGIN_USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="communityUserVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

	function fn_cmmnty_regist_user(){

		if (!validateCommunityUserVO(document.communityUserVO)){
			return false;
		}
		
		if(confirm('커뮤니티에 가입 하시겠습니까?')) {
			return true;
		}else {
			return false;	
		}
	}


</script>

<div class="cm_sub_box">
	<h2>커뮤니티 정보 관리</h2>
	<div class="cm_sub_cont">
							
		<form:form commandName="communityUserVO" name="communityUserVO" method="post" action="${_PREFIX}/insertCmmntyUserBySelf.do" onsubmit="return fn_cmmnty_regist_user(this)">
		<form:hidden path="cmmntyId"/>
          <table class="cm_chart" summary="커뮤니티 가입 정보 입력하는 표입니다">
            <tr>
              <th>회원정보</th>
              <td><c:out value="${LOGIN_USER_INFO.id}" />  (<c:out value="${LOGIN_USER_INFO.name}" />)</td>
			</tr>
			<tr>
              <th>자기소개</th>
              <td><form:textarea id="userIntrcn" path="userIntrcn" rows="10" cols="30" cssClass="inp_area"/><form:errors path="userIntrcn" /></td>
             </tr>
          </table>
          
          <div class="btn_c">
			<span class="btn"><button type="submit">확인</button></span>
			<!-- <span class="btn2"><button type="button">취소</button></span> -->
		  </div>        
		</form:form>
	</div>
</div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>