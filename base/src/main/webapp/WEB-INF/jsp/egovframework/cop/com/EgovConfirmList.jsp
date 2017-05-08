<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/com"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<script type="text/javascript">
	function fn_egov_inqire_confirmInfo(cnfmNo) {
		document.userfrm.confmNumber.value = cnfmNo;
		document.userfrm.action = "<c:url value='/cop/com/forUpdateConfirmRequest.do'/>";
		document.userfrm.submit();		
	}
</script>

<div class="cm_sub_box">
	<h2>회원승인 관리</h2>
	<div class="cm_sub_cont">

		<table class="cm_chart1" summary="커뮤니티전체 승인회원 목록을 보여줍니다">
		 	<caption>커뮤니티 생성 정보 입력</caption>
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>승인유형</th>
					<th>승인일자</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="result" items="${resultList}" varStatus="status">
			  <tr>
			    <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>		    
			    <td><c:out value="${result.confmRqesterId}"/></td>
			    <td><c:out value="${result.confmRqesterNm}"/></td>
			    <td><c:out value="${result.confmSttusCodeNm}"/></td>
				<td><c:out value="${result.confmDe}"/></td>
				<td>
					<c:choose>
			    		<c:when test="${result.confmSttusCode == 'AP01'}">
			    			<span class="btn6"><button type="button" onclick="fn_egov_inqire_confirmInfo('<c:out value="${result.confmNumber}"/>');">가입승인</button></span>	    		
			    		</c:when>
			    		<c:otherwise>
			    			-
			    		</c:otherwise>
			    	</c:choose>
				</td>
			  </tr>
			 </c:forEach>	  
			 <c:if test="${fn:length(resultList) == 0}">
			  <tr>
			    <td colspan="6" ><spring:message code="common.nodata.msg" /></td>  
			  </tr>		 
			 </c:if>
		 </tbody>
		</table>
		
		<div id="paging">
			<c:url var="pageUrl" value="${_PREFIX}/selectConfirmRequestByTrget.do">
				<input type="hidden" name="trgetId" value="<c:out value="${searchVO.trgetId}"/>" />
				<c:if test="${not empty searchVO.searchTy}"><c:param name="searchTy" value="${searchVO.searchTy}" /></c:if>
				<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
				<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			</c:url>
			<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
			<ui:pagination paginationInfo="${paginationInfo}" type="smart_001" jsFunction="${pagingParam}"  />
		</div>
		
		<div class="cm_search_box">
			<form name="userfrm" action ="${_PREFIX}/selectConfirmRequestByTrget.do" method="post">
				<input type="hidden" name="confmNumber" value="0" />
				<input type="hidden" name="confmerId" value='<c:out value="${searchVO.confmerId}"/>' />
				<input type="hidden" name="trgetId" value="<c:out value="${searchVO.trgetId}"/>" />
				<fieldset>
					<label class="hdn" for="fapp">승인요청 분류선택</label>
					<select name="searchTy" id="fapp">
						<option value="AP01" <c:if test="${searchVO.searchTy == 'AP01'}">selected="selected"</c:if> >승인요청</option>
					   	<option value="AP02" <c:if test="${searchVO.searchTy == 'AP02'}">selected="selected"</c:if> >승인허가</option>	
					   	<option value="AP03" <c:if test="${searchVO.searchTy == 'AP03'}">selected="selected"</c:if> >승인반려</option>	
					</select>
					<label class="hdn" for="ftext">검색 분류선택</label>
					<select name="searchCnd" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >이름</option>
					   	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>	
					</select>
					<label class="hdn" for="word">검색어입력</label>		
					<input type="text"  name="searchWrd" id="word" class="inp" value="<c:out value="${searchVO.searchWrd}"/>" />
					<span class="btn4"><button type="submit">검색</button></span>
				</fieldset>
			</form> 
		</div>
	</div>
</div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>