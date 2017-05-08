<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:set var="_PREFIX" value="/evt"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="menuId" value="${searchVO.menuId}"/>
		<c:if test="${!empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
		<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
		<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
	<c:param name="leftMenuViewAt" value="N"/>
</c:import>
<style type="text/css">
	#sub_container #sub_contnts{border-left:0px}
	#sub_container #sub_contnts{width:940px;padding:30px;min-height:400px;}
	#sub_container .container{background:none;}
	#sub_container  #contents{width:100%;}
	#sub_container #content{width:940px;padding:30px;min-height:400px;}
</style>
<!-- 
<link charset="utf-8" href='${CMMN_JS }/jquery/calendar/theme.css'  type='text/css' rel="stylesheet"/>
<link charset="utf-8" href='${CMMN_JS }/jquery/calendar/calendar.css'  type='text/css' rel="stylesheet"/>
 -->
<script charset="utf-8" src="${CMMN_JS }/common.js" type="text/javascript"></script>
<script charset="utf-8" src='${CMMN_JS }/jquery/calendar/calendar.js' type='text/javascript'></script>

<div id="schedule">
		<div class="month">
			<c:url var="prvUrl" value="${_PREFIX}/selectSchdulinfoCalendar.do${_BASE_PARAM}">
				<c:param name="searchSe" value="${searchVO.searchSe}" />
				<c:choose>
					<c:when test="${searchVO.searchMonth > 0}">
						<c:param name="searchYear" value="${searchVO.searchYear}" />
						<c:param name="searchMonth" value="${searchVO.searchMonth-1}" />
					</c:when>
					<c:otherwise>
						<c:param name="searchYear" value="${searchVO.searchYear-1}" />
						<c:param name="searchMonth" value="11" />
					</c:otherwise>
				</c:choose>
			</c:url>  
			<a href="<c:out value='${prvUrl}'/>"><img src="${_IMG}/calendar/btn_mprev.gif" alt="이전달"/></a> 
			<strong><c:out value='${fn:substring(searchVO.searchDate, 0,4)}'/>. <c:out value='${fn:substring(searchVO.searchDate, 4,6)}'/></strong>
			<c:url var="nextUrl" value="${_PREFIX}/selectSchdulinfoCalendar.do${_BASE_PARAM}">
				<c:param name="searchSe" value="${searchVO.searchSe}" />
				<c:choose>
					<c:when test="${searchVO.searchMonth < 11}">
						<c:param name="searchYear" value="${searchVO.searchYear}" />
						<c:param name="searchMonth" value="${searchVO.searchMonth+1}" />
					</c:when>
					<c:otherwise>
						<c:param name="searchYear" value="${searchVO.searchYear+1}" />
						<c:param name="searchMonth" value="0" />
					</c:otherwise>
				</c:choose>
			</c:url> 
			<a href="<c:out value='${nextUrl}'/>"><img src="${_IMG}/calendar/btn_mnext.gif" alt="다음달"/></a>
		</div>
		
		<ul class="cal_type">
			<c:url var="calendarUrl" value="${_PREFIX}/selectSchdulinfoCalendar.do${_BASE_PARAM}"/>
			<li><a href="<c:out value='${calendarUrl}'/>" class="this"><span class="ctype1">달력으로 보기</span></a></li>
			<c:url var="listUrl" value="${_PREFIX}/selectSchdulinfoList.do${_BASE_PARAM}"/>
			<li><a href="<c:out value='${listUrl}'/>"><span class="ctype2">목록으로 보기</span></a></li>
		</ul>
        
        <!--캘린더 시작-->
        <script type='text/javascript'>
		
			$(document).ready(function() {
			
				var date = new Date();
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();
				
				$('#calendar').fullCalendar({
					theme: true,
					header: {
						nYear: '<c:out value="${searchVO.searchYear}" />',
						nMonth: '<c:out value="${searchVO.searchMonth}" />',
						nDay: '<c:out value="${searchVO.searchDay}" />',
						left: ' ',
						//left: 'prev,next today',
						center: 'title',
						right: ''
					},
					editable: false,
					events: [
		
		
					<c:forEach var="result" items="${resultList}" varStatus="status">
						{
							cate: '<c:out value="${result.schdulClCode}"/>',
							title: '<c:out value="${result.schdulNm}"/>',
							start: new Date(<c:out value='${fn:substring(result.schdulBgnde, 0,4)}'/>, <c:out value='${fn:substring(result.schdulBgnde, 4,6)}'/>-1, <c:out value='${fn:substring(result.schdulBgnde, 6,8)}'/>, <c:out value='${fn:substring(result.schdulBgnde, 8,10)}'/>, <c:out value='${fn:substring(result.schdulBgnde, 10,12)}'/>),
							end: new Date(<c:out value='${fn:substring(result.schdulEndde, 0,4)}'/>, <c:out value='${fn:substring(result.schdulEndde, 4,6)}'/>-1, <c:out value='${fn:substring(result.schdulEndde, 6,8)}'/>, <c:out value='${fn:substring(result.schdulEndde, 8,10)}'/>, <c:out value='${fn:substring(result.schdulEndde, 10,12)}'/>),
							url: './selectComtnschdulinfo.do?schdulId=<c:out value="${result.schdulId}"/>&menuId=<c:out value="${searchVO.menuId}"/>&searchYear=<c:out value="${searchVO.searchYear}"/>&searchMonth=<c:out value="${searchVO.searchMonth}"/>&mode=1',
							allDay: false
						}<c:if test="${resultCnt != status.count}">,</c:if>
					</c:forEach>
					]
				});
				
			});
		
			function fnEgovSchdulSe(setValue) {
				location.href="./selectSchdulinfoCalendar.do?searchYear=<c:out value='${searchVO.searchYear}' />&searchMonth=<c:out value='${searchVO.searchMonth}' />&searchCondition=SCHDUL_SE&searchSe=" + setValue;
			}
		</script>
		<div id="calendar" class="mcalendar"></div>
	</div>
	
	<div class="cal_search_box">
		<form name="frm" action="<c:url value='${_PREFIX}/selectSchdulinfoCalendar.do'/>" method="post">
		<input type="hidden" name="menuId" value="${searchVO.menuId}"/>
		<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
		<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}"/>
		   <fieldset>
		     <label class="hdn" for="FindCo2">통합캘린더 일정 분류선택</label>
		     <select id="FindCo2" name="searchSe">
		         <option value="">-일정분류선택-</option>
		         <option value="1"<c:if test="${searchVO.searchSe eq '1'}"> selected="selected"</c:if>>행사및일반일정</option>
		         <option value="3"<c:if test="${searchVO.searchSe eq '3'}"> selected="selected"</c:if>>설문조사</option>
		       </select>
		       <label class="hdn" for="FindCo2">검색카테고리 선택</label>
		       <select id="FindCo2" name="searchCondition" class="search_sel">
		         <option value="0" <c:if test="${searchVO.searchCondition eq '0'}"> selected="selected"</c:if>>제목</option>
		         <option value="1" <c:if test="${searchVO.searchCondition eq '1'}"> selected="selected"</c:if>>내용</option>
		       </select>
		       <input type="text" name="searchKeyword" id="searchword"  title="검색어입력" class="inp" value='<c:out value="${searchVO.searchKeyword}"/>'/>
		       <input type="image" src="${_IMG}/calendar/btn_search.gif" alt="검색" title="검색창 연결하기" class="btn_search"/>
			</fieldset>
		</form>
	</div>



<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>