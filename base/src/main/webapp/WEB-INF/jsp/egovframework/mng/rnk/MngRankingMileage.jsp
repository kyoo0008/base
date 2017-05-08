<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="MNG_JS" value="/template/common/js"/>
<c:set var="_C_IMG" value="/template/common/images"/>
<c:set var="_IMG" value="/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MILEAGE_MANAGE"/>
	<c:param name="depth1" value="RANKING_MILEAGE"/>
	<c:param name="title" value="마일리지 TOP 10"/>
</c:import>

<script type="text/javascript" src="${MNG_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js"></script>
<script type="text/javaScript" language="javascript">
/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(){
	var fromDate = document.listForm.searchBeginDate.value;
	var toDate = document.listForm.searchEndDate.value;
	
	if (fromDate == "") {
		alert("기간 시작일자를 입력하세요");
		return false;
	} else if (toDate == "") {
		alert("기간 종료일자를 입력하세요");
		return false;
	}
   	
	return true;
}

function fnSort(col, sort) {
	document.listForm.searchSortItem.value = col;
	document.listForm.searchSortOrder.value = sort;
	document.listForm.submit();
}

/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

	if (document.listForm.searchBeginDate.value != "" && document.listForm.searchEndDate.value != "") {
		var fromDate = document.listForm.searchBeginDate.value;
		var toDate = document.listForm.searchEndDate.value;
		document.listForm.fDate.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
		document.listForm.tDate.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
	}
	
}

/*********************************************************
 * Excel 처리 
 *********************************************************/
function fnExcel(){
	document.listForm.action="<c:url value="/mng/rnk/MileageRankingExcel.do"/>";
   	document.listForm.submit();
}

window.onload=function() {
	fnInitAll();
}
</script>

<div id="cntnts">

<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

		<table class="chart_board">

		<thead>
			<tr>
				<th>순위</th>
				<th>아이디 <c:if test="${searchVO.searchSortItem eq 'USER_ID'}"><c:if test="${searchVO.searchSortOrder eq 'ASC'}"><a href="#" onclick="fnSort('USER_ID', 'DESC'); return false;">△</a></c:if><c:if test="${searchVO.searchSortOrder eq 'DESC'}"><a href="#" onclick="fnSort('USER_ID', 'ASC'); return false;">▽</a></c:if></c:if></th>				
				<th>증감마일리지 <c:choose><c:when test="${searchVO.searchSortItem eq 'PLUS_MLG_SCORE'}"><c:if test="${searchVO.searchSortOrder eq 'ASC'}"><a href="#" onclick="fnSort('PLUS_MLG_SCORE', 'DESC'); return false;"><font color="red">△</font></a></c:if><c:if test="${searchVO.searchSortOrder eq 'DESC'}"><a href="#" onclick="fnSort('PLUS_MLG_SCORE', 'ASC'); return false;"><font color="red">▽</font></a></c:if></c:when><c:otherwise><a href="#" onclick="fnSort('PLUS_MLG_SCORE', 'ASC'); return false;"><font color="#657591">▽</font></a></c:otherwise></c:choose></th>
				<th>가감마일리지 <c:choose><c:when test="${searchVO.searchSortItem eq 'MINUS_MLG_SCORE'}"><c:if test="${searchVO.searchSortOrder eq 'ASC'}"><a href="#" onclick="fnSort('MINUS_MLG_SCORE', 'DESC'); return false;"><font color="red">△</font></a></c:if><c:if test="${searchVO.searchSortOrder eq 'DESC'}"><a href="#" onclick="fnSort('MINUS_MLG_SCORE', 'ASC'); return false;"><font color="red">▽</font></a></c:if></c:when><c:otherwise><a href="#" onclick="fnSort('MINUS_MLG_SCORE', 'ASC'); return false;"><font color="#657591">▽</font></a></c:otherwise></c:choose></th>
				<th>기간마일리지 <c:choose><c:when test="${searchVO.searchSortItem eq 'MLG_SCORE'}"><c:if test="${searchVO.searchSortOrder eq 'ASC'}"><a href="#" onclick="fnSort('MLG_SCORE', 'DESC'); return false;"><font color="red">△</font></a></c:if><c:if test="${searchVO.searchSortOrder eq 'DESC'}"><a href="#" onclick="fnSort('MLG_SCORE', 'ASC'); return false;"><font color="red">▽</font></a></c:if></c:when><c:otherwise><a href="#" onclick="fnSort('MLG_SCORE', 'ASC'); return false;"><font color="#657591">▽</font></a></c:otherwise></c:choose></th>
				<th>보유마일리지 <c:choose><c:when test="${searchVO.searchSortItem eq 'NEW_MLG_SCORE'}"><c:if test="${searchVO.searchSortOrder eq 'ASC'}"><a href="#" onclick="fnSort('NEW_MLG_SCORE', 'DESC'); return false;"><font color="red">△</font></a></c:if><c:if test="${searchVO.searchSortOrder eq 'DESC'}"><a href="#" onclick="fnSort('NEW_MLG_SCORE', 'ASC'); return false;"><font color="red">▽</font></a></c:if></c:when><c:otherwise><a href="#" onclick="fnSort('NEW_MLG_SCORE', 'ASC'); return false;"><font color="#657591">▽</font></a></c:otherwise></c:choose></th>
				<th>내역보기</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listtd">${result.rn}</td>
				<td class="listtd">${result.userId}</td>
				<td class="listtd"><fmt:formatNumber value="${result.plusMlgScore}" type="number"/>점</td>
				<td class="listtd"><fmt:formatNumber value="${result.minusMlgScore}" type="number"/>점</td>
				<td class="listtd"><fmt:formatNumber value="${result.mlgScore}" type="number"/>점</td>
				<td class="listtd"><fmt:formatNumber value="${result.newMlgScore}" type="number"/>점</td>
				<td class="listtd"><a href="<c:url value='/mng/uss/ion/mlg/selectMlgUserlogList.do?userId=${result.userId}'/>&searchBeginDate=${searchVO.searchBeginDate}&searchEndDate=${searchVO.searchEndDate}&searchSiteId=${searchVO.searchSiteId}&mlgCode=${searchVO.mlgCode}"><img src="${_IMG}/btn/btn_breakdown.gif" alt="내역"/></a></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      <tr>
	        <td class="listCenter" colspan="6"><spring:message code="common.nodata.msg" /></td>
	      </tr>
	    </c:if>
		</tbody>
		</table>

		<div id="paging">
		    <c:url var="pageUrl" value="/mng/rnk/MileageRanking.do?">
		      <c:if test="${not empty searchVO.searchMlgCode}"><c:param name="mlgCode" value="${searchVO.searchMlgCode}" /></c:if>
		      <c:if test="${not empty searchVO.searchBeginDate}"><c:param name="searchBeginDate" value="${searchVO.searchBeginDate}" /></c:if>
			  <c:if test="${not empty searchVO.searchEndDate}"><c:param name="searchEndDate" value="${searchVO.searchEndDate}" /></c:if>
			  <c:if test="${not empty searchVO.searchSiteId}"><c:param name="searchSiteId" value="${searchVO.searchSiteId}" /></c:if>			  
			  <c:if test="${not empty searchVO.searchSortItem}"><c:param name="searchSortItem" value="${searchVO.searchSortItem}" /></c:if>
			  <c:if test="${not empty searchVO.searchSortOrder}"><c:param name="searchSortOrder" value="${searchVO.searchSortOrder}" /></c:if>
		    </c:url>						
		    <ul>
		      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
		    </ul>
		</div>
		
		<div id="bbs_search">
			<form name="listForm" method="post" action="<c:url value='/mng/rnk/MileageRanking.do'/>" onsubmit="return fnSearch();">
				<fieldset>
					<legend>검색조건입력폼</legend>
					<label for="ftext" class="hdn">분류검색</label>
					<select name="searchSiteId" >
						<option value="">사이트선택</option>
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}" <c:if test="${result.siteId == searchVO.searchSiteId}">selected="selected"</c:if> >${result.siteNm}</option>
						</c:forEach>		
					</select>
					<select id="searchMlgCode" name="searchMlgCode" title="<spring:message code="cop.category.view" />">
				          	<option value="">마일리지구분</option>
				          	<c:forEach var="code" items="${codeList}" varStatus="status">
				            	<option value="<c:out value="${code.mlgCode}"/>" <c:if test="${searchVO.searchMlgCode == code.mlgCode}">selected="selected"</c:if>><c:out value="${code.mlgNm}" /></option>
				          	</c:forEach>
				    </select>
					<select name="searchUserTypeCode" >
						<option value="">사용자유형</option>
						<option value="S" <c:if test="${searchVO.searchUserTypeCode eq 'S'}">selected="selected"</c:if> >학생</option>
						<option value="P" <c:if test="${searchVO.searchUserTypeCode eq 'P'}">selected="selected"</c:if> >학부모</option>
						<option value="T" <c:if test="${searchVO.searchUserTypeCode eq 'T'}">selected="selected"</c:if> >교직원</option>
					</select>
				    <input type="hidden" name="searchBeginDate" value="${searchVO.searchBeginDate}"/>
                  	<input type="hidden" name="searchEndDate" value="${searchVO.searchEndDate}"/>
                  	
                  	<input type="hidden" name="searchSortItem" value="${searchVO.searchSortItem}"/>
                  	<input type="hidden" name="searchSortOrder" value="${searchVO.searchSortOrder}"/>
                  	
					<input type="text" name="fDate" class="inp" value="" size="10" readonly="readonly" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchBeginDate, document.listForm.fDate);" tabindex="1" />
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchBeginDate, document.listForm.fDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif" style="vertical-align:middle;border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a>
                  <input type="text" name="tDate" class="inp" value="" size="10" readonly="readonly" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchEndDate, document.listForm.tDate);" tabindex="2" />
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.searchEndDate, document.listForm.tDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif" style="vertical-align:middle;border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a> 
					<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
					
					<a href="#" onclick="fnExcel(); return false;"><img src="/template/manage/images/excel.gif" alt="엑셀로 다운받기" /></a>
				</fieldset>
			</form>
			
		</div>
</div>	

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	