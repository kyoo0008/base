<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="_C_JS" value="/template/common/js"/>
<c:set var="_C_IMG" value="/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.emplyrId}">
	<c:set var="SE_CODE" value="${USER_INFO.authorCode}" />
</c:if>

<script type="text/javascript" src="${_C_JS}/board.js" ></script>
<script type="text/javascript">

function fn_egov_addNotice(url) {
   	<c:choose>
		<c:when test="${not empty USER_INFO.emplyrId}">
			location.href = url;
		</c:when>
		<c:otherwise>
			if (confirm('로그인 하시겠습니까?')) {
				location.href = "<%=egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper.getRedirectLoginUrl()%>";	
			}
		</c:otherwise>
	</c:choose>
   }

</script>

<div class="cm_sub_box">
	<h2>커뮤니티  검색 결과</h2>
	<div class="cm_sub_cont">
		<div id="bbs_cm_wrap">
			<div class="total">총 게시물 <strong>${paginationInfo.totalRecordCount}</strong>건 ㅣ 현재페이지 <strong>${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</div>
				
			<table summary="번호,제목작성자,파일,작성일,조회수" class="list_table">
	        	<caption>커뮤니티  검색 결과 리스트입니다.</caption>
	        	<thead>
	        	<tr>
		            <th class="num"><spring:message code="cop.nttNo"/></th>
		            <th class="tit"><spring:message code="cop.nttSj" /></th>
		            <th class="writer"><spring:message code="cop.ntcrNm" /></th>
		            <th class="date"><spring:message code="cop.frstRegisterPnttm" /></th>
		            <th class="hits"><spring:message code="cop.inqireCo" /></th>
	          	</tr>
	          	</thead>
			  	<tbody>
			    <c:forEach var="result" items="${resultList}" varStatus="status">
					<c:url var="viewUrl" value="${_PREFIX}/bbs/selectBoardArticle.do">
						<c:param name="nttNo" value="${result.nttNo}" />
						<c:param name="trgetId" value="${searchVO.cmmntyId}" />
						<c:param name="bbsId" value="${result.bbsId}" />
					    <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
			  			<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			  			<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				    </c:url>
			        <tr>
			        	<td class="num"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
			            <td class="tit">
			            	<c:if test="${result.ordrCodeDp gt 0}">
							  <img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" /><img src="${_IMG}/board/ico_reply.gif" alt="따라붙은글" />
					        </c:if>
					        <c:choose>
								<c:when test="${SE_CODE eq '10'}"><a href="<c:out value="${viewUrl}"/>"><c:out value="${result.nttSj}" /></a></c:when>
								<c:when test="${result.othbcAt eq 'N' and USER_INFO.emplyrId ne result.frstRegisterId}">
									<c:out value="${result.nttSj}" />
								</c:when>
								<c:when test="${SE_CODE < result.searchAuth}">
									<c:out value="${result.nttSj}" />
								</c:when>
								<c:otherwise><a href="<c:out value="${viewUrl}"/>"><c:out value="${result.nttSj}" /></a></c:otherwise>
							</c:choose>
							<c:if test="${result.othbcAt eq 'N'}"><img src="${_IMG}/board/ico_board_lock.gif" alt="잠긴글" /></c:if>
							<span class="boardrenum"></span>
			        	</td>
			        	<td class="writer"><c:out value="${result.ntcrNm}"/></td>

			        	<td class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
			        	<td class="hits"><c:out value="${result.inqireCo}"/></td>
					</tr>
			    </c:forEach>
			    <c:if test="${fn:length(resultList) == 0}">
					<td colspan="7"><spring:message code="common.nodata.msg" /></td>
				</c:if>
				      
			</table>
		
			<div id="paging">
			    <c:url var="pageUrl" value="${_PREFIX}/selectCmmntyBoardList.do">
			      <c:if test="${not empty searchVO.cmmntyId}"><c:param name="cmmntyId" value="${searchVO.cmmntyId}" /></c:if>
			      <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
	  			  <c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			    </c:url>
			   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
			   <ui:pagination paginationInfo="${paginationInfo}" type="smart_001" jsFunction="${pagingParam}" />
			</div>
			
			<div class="cm_search_box">
			  <form name="frm" method="post" action="<c:url value='${_PREFIX}/selectCmmntyBoardList.do'/>">
			  	<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
				<input name="pageIndex" type="hidden" value="1" />
				<input name="cmmntyId" type="hidden" value="<c:out value='${searchVO.cmmntyId}'/>" />
	            <fieldset>
	            	<label class="hdn" for="ftext">검색 분류선택</label>
					<select name="searchCnd" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
			          	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
			          	<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
					</select>
					<label class="hdn" for="word">검색어입력</label>		
					<input type="text"  name="searchWrd" id="word" class="inp" value="<c:out value="${searchVO.searchWrd}"/>" />
					<span class="btn4"><button type="submit">검색</button></span>
	            </fieldset>
	          </form>
			</div>
		</div>
	</div>
</div>
		
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>
