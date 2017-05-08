<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />

<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="siteId" value="${searchVO.siteId}" />
		<c:if test="${!empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
		<c:if test="${!empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
		<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MBER_MANAGE"/>
	<c:param name="depth1" value="MBER_MANAGE"/>
	<c:param name="depth2" value="MBER_MANAGE"/>
	<c:param name="title" value="회원관리"/>
</c:import>	
<c:set var="_ACTION" value="/mng/usr/EgovMberManage.do" />
<script type="text/javascript">
<!--
<c:if test='${not empty message}'>
alert("${message}");
</c:if>

function fncExcelDown() {

    if(confirm("총 <c:out value="${paginationInfo.totalRecordCount}" />명을 엑셀로 받으시겠습니까?")) {
        document.listForm.action = "<c:url value='/mng/usr/EgovMberManageExcel.do'/>";
        document.listForm.submit(); 
    }
}

function fn_egov_delete(url){
	if(confirm('<spring:message code="common.delete.msg" />')){
		document.location.href = url;	
	}		
}

function fn_egov_confirm(url, at) {
	if(at == 'Y') {
		if(confirm('<spring:message code="common.acknowledgement.msg" />')){
			document.location.href = url;	
		}
	} else if(at == 'N') {
		if(confirm('<spring:message code="common.acknowledgementcancel.msg" />')){
			document.location.href = url;	
		}
	}
}

function fncAddView() {
	document.listForm.action = "<c:url value='/mng/usr/EgovMberAddView.do'/>";
    document.listForm.submit(); 
}

-->
</script>

<div id="cntnts">
 
	<c:if test="${USER_INFO.userSe > 10}">
		<form id="SiteListForm" name="SiteListForm" action="${_ACTION }" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>	
	
		<form:form name="listForm" action="${_ACTION }" method="post">
		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
		<p class="total">총  회원 ${paginationInfo.totalRecordCount}명ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>

		<table class="chart_board">
		<colgroup>
			<col width="70"/>				
			<col width="80"/>
			<col width="70"/>
			<col/>
			<col/>
			<col/>
			<col/>
			<col width="120"/>
			<col width="120"/>
			<col width="80"/>
			
			
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>권한</th>
				<th>아이디</th>
				<th>이름</th>
				<th>주소</th>
				<th>이메일</th>
				<th>핸드폰</th>
				<th>가입일</th>
				<th>승인</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listtd"><fmt:formatNumber value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" type="number"/></td>
				<td class="listtd">
				<c:choose>
					<c:when test="${result.userSeCode eq '02' }">일반</c:when>
					<c:when test="${result.userSeCode eq '04' }">학부모</c:when>
					<c:when test="${result.userSeCode eq '06' }">학생</c:when>
					<c:when test="${result.userSeCode eq '07' }">강사</c:when>
					<c:when test="${result.userSeCode eq '08' }">교사</c:when>
					<c:when test="${result.userSeCode eq '10' }">사이트관리자</c:when>
					<c:when test="${result.userSeCode eq '99' }">통합관리자</c:when>
				</c:choose>
				</td>
				<td class="listtd"><c:out value="${result.userId}" /></td>
				<td class="listtd"><c:out value="${result.userNm}" /></td>
				<td class="listtd"><c:out value="${result.adres}" /></td>
				<td class="listtd"><c:out value="${result.emailAdres}" /></td>
				<td class="listtd"><c:out value="${result.moblphonNo}" /></td>
				<td class="listtd"><c:out value="${result.frstRegistPnttm}" /></td>
				<td class="listtd">
					<c:choose>
						<c:when test="${result.confmAt eq 'Y'}">
							<c:url var="confirmUrl" value="/mng/usr/EgovMberManageConfrm.do${_BASE_PARAM}">
								<c:param name="userId" value="${result.userId}" />
								<c:param name="confmAt" value="N"/>
							</c:url>
							<a href="${confirmUrl}" onclick="fn_egov_confirm(this.href, 'N');return false;" title="승인취소"><img src="${_IMG}/board/btn_appr_can.gif" alt="취소"/></a>
						</c:when>
						<c:otherwise>
							<c:url var="confirmUrl" value="/mng/usr/EgovMberManageConfrm.do${_BASE_PARAM}">
								<c:param name="userId" value="${result.userId}" />
								<c:param name="confmAt" value="Y"/>
							</c:url>
							<a href="${confirmUrl}" onclick="fn_egov_confirm(this.href, 'Y');return false;" title="승인하기"><img src="${_IMG}/board/btn_appr.gif" alt="승인"/></a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:url var="editUrl" value="./EgovUserSelectUpdtView.do${_BASE_PARAM}">
						<c:param name="userId" value="${result.userId}" />
						<c:if test="${!empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>
		        	<a href="${editUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
		        	<c:url var="delUrl" value="/mng/usr/EgovMberManageDelete.do">
		        		<c:param name="userId" value="${result.userId}" />
		        		<c:if test="${!empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>	
		        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
			    </td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      <tr>
	      	<td class="listtd" colspan="10">
	        	<spring:message code="common.nodata.msg" />
	        </td>
	      </tr>
	    </c:if>

		</tbody>
		</table>
	
	<div class="btn_r">
       	<a href="<c:url value='/mng/usr/EgovMberAddView.do'/>"><img src="${_IMG}/btn/btn_regist.gif" /></a>
		<%-- <a href="#" onclick="fncAddView();return false;"><img src="${_IMG}/btn/btn_regist.gif" /></a> --%>
	</div>

	<div id="paging">
		<c:url var="pageUrl" value="/mng/usr/EgovMberManage.do${_BASE_PARAM}">
		</c:url>

		<c:if test="${not empty paginationInfo}">
			<ul>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			</ul>
		</c:if>
	</div>
	
	<div id="bbs_search">
		<label for="ftext1" class="hdn">분류검색</label>
		<select name="searchSe" id="ftext1">
			<option value="">권한분류</option>
			<option value="02" <c:if test="${searchVO.searchSe == '02'}">selected="selected"</c:if>>일반</option>
			<option value="04" <c:if test="${searchVO.searchSe == '04'}">selected="selected"</c:if>>학부모</option>
			<option value="06" <c:if test="${searchVO.searchSe == '06'}">selected="selected"</c:if>>학생</option>
			<option value="07" <c:if test="${searchVO.searchSe == '07'}">selected="selected"</c:if>>강사</option>
			<option value="08" <c:if test="${searchVO.searchSe == '08'}">selected="selected"</c:if>>교사</option>
			<option value="10" <c:if test="${searchVO.searchSe == '10'}">selected="selected"</c:if>>사이트관리자</option>
			<option value="99" <c:if test="${searchVO.searchSe == '99'}">selected="selected"</c:if>>통합관리자</option>
  	  	</select>
		<label for="ftext2" class="hdn">분류검색</label>
		<select name="searchCondition" id="ftext2">
			<option value="">검색항목</option>
			<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
			<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이름</option>
			<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>핸드폰</option>
			<option value="3" <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>이메일</option>
			<option value="7" <c:if test="${searchVO.searchCondition == '7'}">selected="selected"</c:if>>생년월일</option>
  	  	</select>
  	  	<select name="searchCnd" id="ftext">
  	  		<option value="OR" <c:if test="${searchVO.searchCnd == 'OR' or searchVO.searchCnd == ''}">selected="selected"</c:if>>연관검색</option>
			<option value="AND" <c:if test="${searchVO.searchCnd == 'AND'}">selected="selected"</c:if>>일치검색</option>
		</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp" id="inp_text" />
		<input type=image src="${_IMG}/board/btn_search.gif" alt="검색" />
	</div>

	</form:form>
</div>
<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	