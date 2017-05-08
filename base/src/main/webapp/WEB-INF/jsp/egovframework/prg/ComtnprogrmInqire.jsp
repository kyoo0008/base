<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ComtnprogrmRegister.jsp
  * @Description : Comtnprogrm Register 화면
  * @Modification Information
  * 
  * @author (주)청암IT
  * @since 2013.02.20
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>
<c:set var="SE_CODE" value="1"/>
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>

<c:if test="${not empty message}">
<script type="text/javascript">
	alert("${message}");
</script>
</c:if>

<script type="text/javascript">
<!--
$(document).ready(function() {
	$("#viewTrgter").click(function() {
		window.open(this.href, "viewTrgter", "width=800,height=500");
		return false;
	});
	
	$("#requestBtn1").click(function() {
		window.open(this.href, "requestWindow", "width=500,height=300");
		return false;
	});
	
	$("#requestBtn2").click(function() {
		window.open(this.href, "requestWindow", "width=700,height=500");
		return false;
	});
	
});

//-->
</script>

	<div class="alR mB10">
		<c:url var="viewTrgter" value="/prg/ComtnprogrmtrgterList.do">
			<c:param name="prgId" value="${comtnprogrmVO.prgId }"/>
		</c:url>
		<c:choose> <%-- 담당가사 및 선생이상 --%>
		<c:when test="${USER_INFO.id eq comtnprogrmVO.tcherId or SE_CODE >=8 }">
			<span class="bbtn_normal"><a href="${viewTrgter }" id="viewTrgter">신청자확인</a></span>
		</c:when>
		<c:otherwise>
			<%-- <span class="bbtn_normal"><a href="${viewTrgter }" id="viewTrgter">신청자확인</a></span> --%>
		</c:otherwise>
		</c:choose>		
	</div>

	<div id="pbbs_wrap">
	 
	  <div class="board_view">
		<dl class="info_view">
		  <dt>프로그램명</dt>
		  <dd class="prgTit">${comtnprogrmVO.prgNm }</dd>		  
		</dl>
		<dl class="info_view">
		  <dt>학습주제</dt>
		  <dd class="prgTit">${comtnprogrmVO.lrnThema }</dd>		  
		</dl>
		<dl class="info_view2">
		  <dt>운영기간</dt>
		  <dd>
		  	<fmt:parseDate var="operBgnde" value="${comtnprogrmVO.operBgnde }" pattern="yyyy-MM-dd"/>
		  	<fmt:parseDate var="operEndde" value="${comtnprogrmVO.operEndde }" pattern="yyyy-MM-dd"/>
		  	<fmt:formatDate value="${operBgnde }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${operEndde}" pattern="yyyy-MM-dd"/>
		  </dd>
		  <dt>접수기간</dt>
		  <dd>
		  	<fmt:parseDate var="rceptBgnde" value="${comtnprogrmVO.rceptBgnde }" pattern="yyyy-MM-dd"/>
		  	<fmt:parseDate var="rceptEndde" value="${comtnprogrmVO.rceptEndde }" pattern="yyyy-MM-dd"/>
		  	<fmt:formatDate value="${rceptBgnde }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${rceptEndde}" pattern="yyyy-MM-dd"/>
		  </dd>
		</dl>		
		<dl class="info_view2">
		  <dt>강의장소</dt>
		  <dd>${comtnprogrmVO.lctrePlace }</dd>
		  <dt>소요시간</dt>
		  <dd>${comtnprogrmVO.reqreTime }</dd>
		</dl>
		<dl class="info_view2">
		  <dt>신청자수/정원</dt>
		  <dd>${comtnprogrmVO.trgterCnt} / ${comtnprogrmVO.psncpaNmpr }</dd>
		  <dt>진행상태</dt>
		  <dd>
		  	<c:set var="bttnColor" value=""/>
			<c:set var="sttusNm" value=""/>
			<c:choose>
			<c:when test="${comtnprogrmVO.sttusSeCode eq 'ST01'}"><c:set var="bttnColor" value="bbtn_color1"/><c:set var="sttusNm" value="접 수 중"/></c:when>
			<c:when test="${comtnprogrmVO.sttusSeCode eq 'ST02'}"><c:set var="bttnColor" value="bbtn_color3"/><c:set var="sttusNm" value="접수마감"/></c:when>
			<c:when test="${comtnprogrmVO.sttusSeCode eq 'ST10'}"><c:set var="bttnColor" value="bbtn_color2"/><c:set var="sttusNm" value="접수대기"/></c:when>			
			</c:choose>
			<span class="${bttnColor}">
				<span><c:out value="${sttusNm}"/></span>
			</span>&nbsp;
			<%--접수중에 인원이 꽉찮을때 나오는 메세지 --%>
			<c:if test="${comtnprogrmVO.trgterCnt >= comtnprogrmVO.psncpaNmpr and comtnprogrmVO.sttusSeCode eq 'ST01'}">
		  		<strong>[정원이 꽉찮습니다.]</strong>
		  	</c:if>	  
		  </dd>
		</dl>
		<dl class="info_view2">
		  <dt>운영기관</dt>
		  <dd>${comtnprogrmVO.operInsttNm }</dd>
		  <dt>강사</dt>
		  <dd>${comtnprogrmVO.tcherNm }</dd>
		</dl>
		<div class="view_cont">
		  ${comtnprogrmVO.detailCn }
		</div>
	  </div>

		<div class="btn_all2">
			<div class="fL">
				<c:url var="listUrl" value="/prg/ComtnprogrmList.do">
					<c:param name="menuId" value="${param.menuId }"/>
					<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
					<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
					<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
					<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
					<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>
				</c:url>
				<span class="bbtn"><a href="${listUrl }">목록으로</a></span>
			</div>
			
			<%-- <c:if test="${comtnprogrmVO.sttusSeCode eq 'ST01'}"> --%>
			<c:if test="${comtnprogrmVO.sttusSeCode eq 'ST01' and (comtnprogrmVO.psncpaNmpr >= comtnprogrmVO.trgterCnt)}">
			<div class="fR">
				<%--접수중일때, 정원이 꽉않찮을때 활성화 해라 --%>
				<c:url var="perRequestUrl" value="/prg/addComtnprogrmtrgterView.do">
					<c:param name="prgId" value="${comtnprogrmVO.prgId }"/>
					<c:param name="reqstTyCode" value="PER"/>
					<c:param name="trgterCnt" value="${comtnprogrmVO.trgterCnt}"/>
					<c:param name="psncpaNmpr" value="${comtnprogrmVO.psncpaNmpr}"/>
				</c:url>
				<span class="bbtn_confirm2">
					<c:choose>
					<c:when test="${empty comtnprogrmVO.tcherId }"><button onclick="alert('강사지정이 안되었습니다.')">개인신청</button></c:when>
					<c:otherwise><a href="${perRequestUrl }" id="requestBtn1">개인신청</a></c:otherwise>
					</c:choose>					
				</span>				
				<c:if test="${SE_CODE >= 8}">
				<c:url var="orgRequestUrl" value="/prg/addComtnprogrmtrgterView.do">
					<c:param name="prgId" value="${comtnprogrmVO.prgId }"/>
					<c:param name="reqstTyCode" value="ORG"/>
					
					<c:param name="trgterCnt" value="${comtnprogrmVO.trgterCnt}"/>
					<c:param name="psncpaNmpr" value="${comtnprogrmVO.psncpaNmpr}"/>
				</c:url>
				<span class="bbtn_confirm2">
					<c:choose>
					<c:when test="${empty comtnprogrmVO.tcherId }"><button onclick="alert('강사지정이 안되었습니다.')">단체신청</button></c:when>
					<c:otherwise><a href="${orgRequestUrl }" id="requestBtn2">단체신청</a></c:otherwise>
					</c:choose>
				</span>
				</c:if>
			</div>
			</c:if>
		</div>
	</div>

<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>