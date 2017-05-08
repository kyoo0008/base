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
	<c:param name="depth2" value="EVENT_DPT"/>
	<c:param name="title" value="통합캘린더"/>
</c:import>
<script type="text/javascript" src="${MNG_CHART}/FusionCharts.js"></script>
<script type="text/javascript" src="${MNG_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js"></script>

<script type="text/javaScript" language="javascript">
/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(pdKind){
	var fromDate = document.statsVO.fromDate.value;
	var toDate = document.statsVO.toDate.value;

	if (fromDate == "") {
		alert("기간 시작일자를 입력하세요");
		return false;
	} else if (toDate == "") {
		alert("기간 종료일자를 입력하세요");
		return false;
	}
   	document.statsVO.submit();
}
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

	if (document.statsVO.fromDate.value != "" && document.statsVO.toDate.value != "") {
		var fromDate = document.statsVO.fromDate.value;
		var toDate = document.statsVO.toDate.value;
		document.statsVO.fDate.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
		document.statsVO.tDate.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
	}
	
}


window.onload=function() {
	fnInitAll();
}
</script>


<style type="text/css"> 
#cntnts .list li {display:inline-block; margin:0 15px; padding:2px;}
#cntnts .list li:hover {background:#efefef;}
#cntnts a.slt {color:#6DB500; font-weight:bold;}
</style>


<div id="cntnts">
<form:form name="statsVO" commandName="statsVO" method="post" action="/mng/sts/selectEvtStats.do">
		<table>
			<tr>
				<td>
					<input type="hidden" name="fromDate" value="${statsVO.fromDate}" size="10"/>
					<input type="hidden" name="toDate" value="${statsVO.toDate}" size="10"/>
					<input type="text" id="fDate" class="inp" maxlength="5"/>
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.statsVO, document.statsVO.fromDate, document.statsVO.fDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a>
					<input type="text" name="tDate" id="tDate" class="inp" maxlength="5"/>
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.statsVO, document.statsVO.toDate, document.statsVO.tDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a> 
					<input type="image" src="/template/manage/images/btn/btn_select.gif" alt="선택" onclcik="return fnSearch();"/> 
				</td>

			</tr>
	</table>
	
	<table class="chart_board">
	<thead>
			<tr>
				<th>이벤트 제목</th>
				<th>이벤트 유형</th>
				<th>이벤트 진행상태</th>
				<th>참여자수</th>
				<th>당첨자수</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${evtStats}" var="result" varStatus="status">	
			<tr>
				<td><b><c:out value="${result.statsNm}"/></b></td>
				<td><c:out value="${result.statsKind}"/></td>
				<td>
					<c:choose>
					<c:when test="${result.statAt eq '1' and result.useAt eq 'Y'}">
						<font color="red">진행중</font>
					</c:when>
					<c:otherwise>
						<c:choose>
						<c:when test="${result.useAt eq 'Y'}">진행</c:when>
						<c:when test="${result.useAt eq 'C'}">마감</c:when>
						<c:when test="${result.useAt eq 'R'}">보류</c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>
				</td>
				<td><a href="/mng/evt/selectComtneventadhrncList.do?schdulId=<c:out value="${result.statId}"/>"><fmt:formatNumber value="${result.irdsMlgScore}" type="number"/></a></td>
				<td><a href="/mng/evt/selectComtneventprzwnerList.do?schdulId=<c:out value="${result.statId}"/>"><fmt:formatNumber value="${result.adsbtrMlgScore}" type="number"/></a></td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(evtStats) == 0}">
			<tr>
				<td colspan="7" align="center"><spring:message code="info.nodata.msg" /></td>
			</tr>
		</c:if>
		</tbody>
	</table>

	
</form:form>

</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	