<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />

<script type="text/javascript">
	function fn_egov_deleteUser(form) {
		if (confirm('커뮤니티에서 탈퇴 하시겠습니까?')) {
			return true;
		}else{
			return false;
		}
	}

</script>

<div class="cm_sub_box">
	<h2>커뮤니티 탈퇴</h2>

	<div class="cm_sub_cont">
	
		<div class="closure">
			<strong class="blue">탈퇴하시기전 꼭 확인해주세요</strong>

			<p>커뮤니에서 탈퇴하시면 되면 자동으로 커뮤니티 회원정보가 삭제됩니다. <br />탈퇴하셔도 커뮤니티에 작성하신 게시물이 자동으로 삭제되지는 않습니다. </p>

			<strong>정말로 탈퇴 하시겠습니까?</strong>
		</div>

		<form name="userFrm" method="post" action="${_PREFIX}/deleteCmmntyUserSecsn.do">
			<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.cmmntyId}'/>"/>
			<div class="btn_c">
				<span class="btn"><button type="submit" onclick="return fn_egov_deleteUser(this.form);">탈퇴하기</button></span>
				<!-- <span class="btn2"><button type="button" onclick="location.href='<c:url value="${_PREFIX}/selectCmmntyInfs.do"/>'">취소하기</button></span> -->
	
			</div>
		</form>		
	</div>

</div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>