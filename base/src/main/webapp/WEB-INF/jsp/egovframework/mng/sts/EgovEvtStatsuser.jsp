<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="MNG_CHART" value="/template/manage/chart"/>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="_C_IMG" value="/template/common/images"/>
<c:set var="MNG_JS" value="/template/common/js"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="STAT_MANAGE"/>
	<c:param name="depth1" value="EVENT_STAT"/>
	<c:param name="depth2" value="EVENT_USR"/>
	<c:param name="title" value="이벤트통계 - 사용자별"/>
</c:import>

<script type="text/javascript">
	
	function fn_przwner(userId, userNm) {
		var frm = document.popFrm;
		frm.userId.value = userId;
		frm.userNm.value = userNm;
		
		var win = window.open('about:blank' ,'evt',' scrollbars=yes, resizable=yes, left=0, top=0, width=1000,height=650');
		if(win != null) {
			document.popFrm.target="evt";
			document.popFrm.submit();
			
			win.focus();
		}
	}
</script>
<form name="popFrm" action="<c:url value='/mng/evt/selectComtneventprzwnerUserList.do'/>" method="post">
	<input type="hidden" name="userId"/>
	<input type="hidden" name="userNm"/>
</form>

<div id="cntnts">
		<table class="chart_board">

		<thead>
			<tr>
				<th>순번</th>
				<th>이름</th>
				<th>아이디</th>
				<th>당첨횟수</th>
				<th>내역</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">	
			<tr>
				<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
				<td><c:out value="${result.statsNm}"/></td>
				<td><c:out value="${result.statId}"/></td>
				<td><c:out value="${result.statsCo}"/></td>
				<td class="listtd"><a href="#" onclick="fn_przwner('${result.statId}', '${result.statsNm}');return false;"><img src="${MNG_IMG}/btn/btn_breakdown.gif" alt="내역"/></a></td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="7" align="center"><spring:message code="info.nodata.msg" /></td>
			</tr>
		</c:if>
		</tbody>
		</table>

	<div id="paging">
		<c:url var="pageUrl" value="/mng/sts/selectEvtStatUser.do?">
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
	<form:form name="listForm" action="/mng/sts/selectEvtStatUser.do" method="post">
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCondition" id="ftext">
			<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
			<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이름</option>
  	  	</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp_s" id="inp_text" />
		<input type=image src="${MNG_IMG}/board/btn_search.gif" alt="검색" />
	</form:form>
	</div>
</div>	

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	