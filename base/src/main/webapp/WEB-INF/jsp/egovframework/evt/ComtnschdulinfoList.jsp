<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
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

<div id="schedule">
		
		<ul class="cal_type">
			<c:url var="calendarUrl" value="${_PREFIX}/selectSchdulinfoCalendar.do${_BASE_PARAM}"/>
			<li><a href="<c:out value='${calendarUrl}'/>"><span class="ctype1">달력으로 보기</span></a></li>
			<c:url var="listUrl" value="${_PREFIX}/selectSchdulinfoList.do${_BASE_PARAM}"/>
			<li><a href="<c:out value='${listUrl}'/>" class="this"><span class="ctype2">목록으로 보기</span></a></li>
		</ul>
        
        <table summary="스마트충남 목록 캘린더" class="schedule_list">
          	<caption>캘린더 목록으로 보기</caption>
          	<colgroup>
				<col width="5%" />
				<col width="12%" />
				<col width="" />
				<col width="10%" />
				<col width="25%" />
				<col width="10%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>제목</th>
					<th>상태</th>
					<th>행사일정</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
	          <c:forEach var="result" items="${resultList}" varStatus="status">
	          <tr>
	            <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
	            <td>
	            	<c:choose>
						<c:when test="${result.schdulClCode eq '1'}">행사일정</c:when>
				    	<c:when test="${result.schdulClCode eq '2'}">이벤트</c:when>
				    	<c:when test="${result.schdulClCode eq '3'}">설문조사</c:when>
				    	<c:otherwise>기타</c:otherwise>
					</c:choose>
	            </td>
	            <td class="tit">
	            <c:url var="viewUrl" value="${_PREFIX}/selectComtnschdulinfo.do${_BASE_PARAM}">
	            	<c:param name="mode" value="2" />
	            	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
					<c:param name="schdulId" value="${result.schdulId}" />
				</c:url>
	            <a href="<c:out value="${viewUrl}"/>"><c:out value="${result.schdulNm}"/></a></td>
	            <td>
	            <c:choose>
					<c:when test="${result.state eq '1' and result.useAt eq 'Y'}"><span class="progress"><em>진행중</em></span></c:when>
					<c:otherwise>
						<c:choose>
						<c:when test="${result.state eq '1' and result.useAt eq 'N'}"><span class="ready"><em>진행중</em></span></c:when>
						<c:otherwise><span class="finish"><em>종료</em></span></c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
	            </td>
	            <td><strong><c:out value="${fn:substring(result.schdulBgnde, 0,4)}-${fn:substring(result.schdulBgnde, 4,6)}-${fn:substring(result.schdulBgnde, 6,8)}"/> ~ <c:out value="${fn:substring(result.schdulEndde, 0,4)}-${fn:substring(result.schdulEndde, 4,6)}-${fn:substring(result.schdulEndde, 6,8)}"/></strong></td>
	            <td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
	            <td><fmt:formatNumber value="${result.inqireCo}" type="number"/></td>
	          </tr>
	          </c:forEach>
			  <c:if test="${fn:length(resultList) == 0}">
				<td colspan="8"><spring:message code="common.nodata.msg" /></td>
			  </c:if>
			</tbody>
        </table>
	</div>

	<div id="paging">
	    <c:url var="pageUrl" value="${_PREFIX}/selectSchdulinfoList.do${_BASE_PARAM}">
      		<c:param name="mode" value="2" />
	    </c:url>
	   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
	   <ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
	</div>
      
	<div class="cal_search_box">
		<form name="frm" action="<c:url value='${_PREFIX}/selectSchdulinfoList.do'/>" method="post">
		<input type="hidden" name="menuId" value="${searchVO.menuId}"/>
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