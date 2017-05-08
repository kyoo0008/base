<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />

<script type="text/javascript">
	function fn_cmmnty_closing(form) {
		if (confirm('정말로 커뮤니티를 폐쇄 하시겠습니까?')) {
			return true;
		}else{
			return false;
		}
	}

</script>

<div class="cm_sub_box">
	<h2>커뮤니티 폐쇄</h2>

	<div class="cm_sub_cont">
			
		<div class="closure">
			<strong class="blue">폐쇄 신청하기 전 꼭 확인해주세요</strong>

			<p>커뮤니티 폐쇄 신청이 이루어지면 모든 자료가 삭제 처리됩니다. <br />삭제가 완료된 후에는 자료복구를 할 수 없으므로 신중한 판단을 부탁드립니다 </p>

			<strong>폐쇄 안내를 확인하였으며 확인을 누르시면 폐쇄됩니다.</strong>
		</div>

		<form name="userFrm" method="post" action="${_PREFIX}/deleteCmmntyClosing.do">
			<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.cmmntyId}'/>"/>
			<div class="btn_c">
				<span class="btn"><button type="submit" onclick="return fn_cmmnty_closing(this.form);">폐쇄하기</button></span>
				<!-- <span class="btn2"><button type="button" onclick="location.href='<c:url value="${_PREFIX}/selectCmmntyInfs.do"/>'">취소하기</button></span> -->
	
			</div>
		</form>		
	</div>

</div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>