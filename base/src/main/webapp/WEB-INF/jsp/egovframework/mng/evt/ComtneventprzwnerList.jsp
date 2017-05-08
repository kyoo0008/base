<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="egovframework.com.cmm.service.Globals"  %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="MNG_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_PREFIX" value="/mng/evt"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="EVENT_MANAGE"/>
	<c:param name="depth1" value="EVENT_WINNER"/>
	<c:param name="title" value="이벤트관리 - 이벤트 당첨자"/>
</c:import>	
<style type="text/css">
.phone_text01 {border:1px solid #ddd8ce; padding: 0px 0; width:95%; height:50px;overflow-y:scroll;}
.coupon {background:#fefdfd;height:18px;line-height:18px;border:1px solid #ddd8ce;padding-left:3px;width:100px;}
</style>
<script type="text/javascript">

function smsSend(form) {
	var frm = document.przwnerForm;
	if(frm.trnsmitCn.value == "") {
		alert("내용을 입력하세요");
		return false;
	}

	if(confirm("전송 하시겠습니까?")) {
		frm.action = "./insertEventSms.do";
		return true;
	}
	return false;
}
</script>

<div id="cntnts">

		<form name="przwnerForm" method="post" action="${pageContext.request.contextPath}${_PREFIX}/insertEventSms.do">
		<input type="hidden" name="trnsmitTelno" value="<%=Globals.PHONE%>"/>
		<input name="schdulId" type="hidden" value="<c:out value="${searchVO.schdulId}" />"/>
		<input type="hidden" name="reservationAt" value="N"/>
        <input name="pageIndex" type="hidden" value="<c:out value="${searchVO.pageIndex}" />"/>
	
		<p class="total">총 당첨인원 ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
	
		<table class="chart_board">

		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>등록일</th>
				<th>취소</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listtd"><c:out value="${status.count}" /></td>
				<td class="listtd"><c:out value="${result.userId}" /></td>
				<td class="listtd"><c:out value="${result.userNm}" /></td>
				<td class="listtd"><c:out value="${result.email}" /></td>
				<td class="listtd"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
				<td class="listtd">
				<c:url var="przwnerUrl" value="delComtneventprzwner.do?">
					<c:param name="schdulId" value="${result.schdulId}" />
					<c:param name="userId" value="${result.userId}" />
					<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
					<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
				</c:url>
				<a href="${przwnerUrl}" onclick="return confirm('선택하신 명단을 당첨 취소 시키시겠습니까?');"><img src="${MNG_IMG}/btn/btn_cancel.gif" alt="취소하기" /></a>
			</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      	<td colspan="7"><spring:message code="common.nodata.msg" /></td>
	      </c:if>

		</tbody>
		</table>

	<div id="paging">
		<c:url var="pageUrl" value="${_PREFIX}/selectComtneventprzwnerList.do">
			<c:param name="schdulId" value="${searchVO.schdulId}" />
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>

		<c:if test="${not empty paginationInfo}">
			<ul>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			</ul>
		</c:if>

	</div>

	<div id="bbs_search">
	<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCondition">
			<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>이름</option>
			<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이메일</option>
			<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>연락처</option>
		</select>
		<input type="text" class="inp_s" id="inp_text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword }" />" />
		<input type="image" src="${pageContext.request.contextPath}/template/common/images/sub/board/btn_search.gif" alt="검색" />
	</div>
	</form>
</div>
<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	