<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MILEAGE_MANAGE"/>
	<c:param name="depth1" value="MILEAGE_LIST"/>
	<c:param name="title" value="마일리지내역"/>		
</c:import>

<script type="text/javaScript" language="javascript">

	function egov_regist() {
		document.frm.action="<c:url value="/mng/uss/ion/mlg/addMlgUserlogView.do"/>";
		document.frm.submit();
	}
	
	function egov_update(userlogId) {
		document.frm.pageIndex.value = "<c:out value='${searchVO.pageIndex}'/>";
		document.frm.userlogId.value = userlogId;
		document.frm.action="<c:url value="/mng/uss/ion/mlg/updateMlgUserlogView.do"/>";
		document.frm.submit();
	}
</script>
<div id="cntnts">

<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

	<table class="chart_board">
		<colgroup>
			<col class="co2"/>
			<col class="*"/>
			<col class="*"/>
			<col class="*"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<!--<col class="*"/>
			<col class="*"/>
			<col class="co6"/>-->
			<col class="*"/>
		</colgroup>
	    <caption class="hdn">마일리지조회</caption>
	    <thead>
	      <tr>
	        <th class="first">번호</th>
	        <th>사이트</th>
	        <th>구분</th>
	        <th>아이디</th>
	        <th>이전마일리지</th>
	        <th>발생마일리지</th>
	        <th>현재마일리지</th>
	        <!-- <th>내용</th>
	        <th>메모</th>
	        <th>참조아이디</th>-->
	        <th>발생일자</th>
	      </tr> 
	    </thead>
	    <tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.siteNm}"/></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.mlgNm}"/></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.userId}"/></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><fmt:formatNumber value="${result.oldMlgScore}" type="number"/>점</a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><fmt:formatNumber value="${result.mlgScore}" type="number"/>점</a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><fmt:formatNumber value="${result.newMlgScore}" type="number"/>점</a></td>
				<!-- <td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.scoreCn}"/></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.memo}"/></a></td>
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><c:out value="${result.refrnProgrmId}"/></a></td> -->
				<td><a href="javascript:egov_update('<c:out value="${result.userlogId}"/>')"><fmt:formatDate value="${result.registerPnttm}"  pattern="yyyy-MM-dd"/></a></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      <tr>
	        <td class="listCenter" colspan="11"><spring:message code="common.nodata.msg" /></td>
	      </tr>
	    </c:if>
		</tbody>
		</table>
		
		
		<div class="btn_r"><a href="javascript:egov_regist();"><img src="${_IMG}/btn/btn_regist.gif" alt="등록" /></a></div>
		
		<div id="paging">
						    <c:url var="pageUrl" value="/mng/uss/ion/mlg/selectMlgUserlogList.do?">
						    	<c:if test="${not empty searchVO.userId}"><c:param name="userId" value="${searchVO.userId}" /></c:if>
						      <c:if test="${not empty searchVO.searchMlgCode}"><c:param name="mlgCode" value="${searchVO.searchMlgCode}" /></c:if>
						      <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
      						  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
      						  <c:if test="${not empty searchVO.searchSiteId}"><c:param name="searchSiteId" value="${searchVO.searchSiteId}" /></c:if>
						    </c:url>						
						    <ul>
						      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
						    </ul>
						</div>
						
						
						<div id="bbs_search">
							<form name="frm" method="post" action="<c:url value='/mng/uss/ion/mlg/selectMlgUserlogList.do'/>">
								<input type="hidden" name="userlogId"/>
								<input name="pageIndex" type="hidden" value="1" />
								<input name="userNm" type="hidden" value="<c:out value='${param.userNm}'/>" />
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
								          	<option value="">구분선택</option>
								          	<c:forEach var="code" items="${codeList}" varStatus="status">
								            	<option value="<c:out value="${code.mlgCode}"/>" <c:if test="${searchVO.searchMlgCode == code.mlgCode}">selected="selected"</c:if>><c:out value="${code.mlgNm}" /></option>
								          	</c:forEach>
								    </select>
									<select name="searchCondition" id="ftext">
										<option value="">항목선택</option>
										<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
							          	<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>점수내용</option>
							          	<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>참조프로그램ID</option>
							          	<option value="3" <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>메모</option>
									</select>
									<label for="inp_text" class="hdn">검색어입력</label>
									<input name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" type="text" class="inp_s" id="inp_text" />
									<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
								</fieldset>
							</form>
						</div>


</div>	


<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	