<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/com"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<script type="text/javascript">
	
	function fn_egov_deleteUser(emplyrId) {
		var _target = document.userFrm.targetMethod.value;
		var url;

		if (confirm('<spring:message code="cop.withdraw.msg" />')) {
		
			if (_target == 'selectCmmntyUserList') {
				url = "<c:url value='/cop/com/deleteCmmntyUser.do'/>";
				document.userFrm.param_cmmntyId.value = document.userFrm.trgetId.value;
			} else if (_target == 'selectClubUserList') {
				url = "<c:url value='/cop/com/deleteClbUser.do'/>";
				document.userFrm.param_clbId.value = document.userFrm.trgetId.value;
			}		
			document.userFrm.param_emplyrId.value = emplyrId;
			document.userFrm.action = url;
			document.userFrm.submit();
		}
	}
	
	function fn_egov_reRegistUser(emplyrId){
		var _target = document.userFrm.targetMethod.value;
		var url;
		
		if (confirm('<spring:message code="cop.reregist.msg" />')) {
			if (_target == 'selectCmmntyUserList') {
				url = "<c:url value='/cop/com/reRegistCmmntyUser.do'/>";
				document.userFrm.param_cmmntyId.value = document.userFrm.trgetId.value;
			} else if (_target == 'selectClubUserList') {
				url = "<c:url value='/cop/com/reRegistClbUser.do'/>";
				document.userFrm.param_clbId.value = document.userFrm.trgetId.value;
			}
	
			document.userFrm.param_emplyrId.value = emplyrId;
			document.userFrm.action = url;
			document.userFrm.submit();	
			return true;
		}else{
			return false;
		}
	}
	
	function fn_egov_authorUser(emplyrId, cmId) {
		if (confirm('<spring:message code="common.update.msg" />')) {
			var authorCode = document.getElementById(cmId).value;
			document.userFrm.param_authorCode.value = authorCode;
			document.userFrm.param_emplyrId.value = emplyrId;
			document.userFrm.param_cmmntyId.value = document.userFrm.trgetId.value;
			document.userFrm.action = "<c:url value='/cop/com/authorUpdateCmmntyUser.do'/>";
			document.userFrm.submit();
			return true;
		}else{
			return false;
		}
	}
</script>

<div class="cm_sub_box">
	<h2>회원관리</h2>

	<div class="cm_sub_cont">
		
		<form name="userFrm" action ="${_PREFIX}/selectCmmntyUserList.do" method="post">
			<input type="hidden" name="targetMethod" value="${targetMethod}" />
			<input type="hidden" name=trgetId value="${trgetId}" />
			<input type="hidden" name="param_emplyrId" />
			<input type="hidden" name="param_cmmntyId" />
			<input type="hidden" name="param_clbId" />
			<input type="hidden" name="param_authorCode" />
				
			<div class="top_chobox">
				<legend>회원분류 선택</legend>
				<select name="searchSe">
					<option value="">전체</option>
					<c:forEach var="authorSearch" items="${authorList}">
						<c:if test="${authorSearch.authorCode ne '01'}">
						<option value="${authorSearch.authorCode}" <c:if test="${authorSearch.authorCode eq searchVO.searchSe}">selected="selected"</c:if>>${authorSearch.authorNm}</option>
						</c:if>
		            </c:forEach>>
				</select>
				<span class="btn6"><button type="submit">보기</button></span>
				<span class="btn5"><button type="button" onclick="location.reload()">새로고침</button></span>
			</div>

	  		<table class="cm_chart1" summary="커뮤니티 생성 정보 입력하는 표입니다">
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
						<th>이름</th>
						<th>아이디</th>
						<th>회원등급</th>
						<th>가입일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr>
	              <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
	              <td><c:out value="${result.userNm}" /></td>
	              <td><c:out value="${result.userId}" /></td>
	              <td>
	              	<select id="cmAuthor${status.index}" <c:if test="${result.mngrAt eq 'Y' }">disabled="disabled"</c:if>>
				    	<c:forEach var="author" items="${authorList}">
				    		<c:if test="${author.authorCode ne '01'}">
					    	<option value="${author.authorCode}" <c:if test="${author.authorCode eq result.authorCode}">selected</c:if>>${author.authorNm}</option>
					    	</c:if>
					    </c:forEach>
				    </select>
				    <c:if test="${result.mngrAt ne 'Y' }"><a href="#" onclick="return fn_egov_authorUser('<c:out value="${result.userId}"/>', 'cmAuthor${status.index}');" class="btn7"><span>등급<strong>변경</strong></span></a></c:if>			   
	              </td>
	              <td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
	              <td>
	              <c:if test="${result.mngrAt ne 'Y' }">
	              	<c:choose>
			    		<c:when test="${result.useAt == 'Y'}">
			    			<span class="btn5"><button type="button" onclick="return fn_egov_deleteUser('<c:out value="${result.userId}"/>');">강제탈퇴</button></span>
			    		</c:when>
			    		<c:otherwise>
			    			<span class="btn6"><button type="button" onclick="return fn_egov_reRegistUser('<c:out value="${result.userId}"/>');">재가입</button></span>
			    		</c:otherwise>
			    	</c:choose>
			    	</c:if>
	              </td>
	            </tr>
	            </c:forEach>
	            <c:if test="${fn:length(resultList) == 0}">
				  <tr>
				    <td colspan="6" ><spring:message code="common.nodata.msg" /></td>  
				  </tr>		 
				</c:if>
	            
	          </table>
          
	          <div id="paging">
				<c:url var="pageUrl" value="${_PREFIX}/selectCmmntyUserList.do?">
					<input type="hidden" name=trgetId value="${trgetId}" />
					<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
					<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
				</c:url>
				<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
				<ui:pagination paginationInfo="${paginationInfo}" type="smart_001" jsFunction="${pagingParam}"  />
			  </div>

		  	<div class="cm_search_box">
				<fieldset>
					<label class="hdn" for="ftext">검색 분류선택</label>
					<select name="searchCnd" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >이름</option>
		              	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
					</select>
					<label class="hdn" for="word">검색어입력</label>		
					<input type="text"  name="searchWrd" id="word" class="inp" value="<c:out value="${searchVO.searchWrd}"/>" />
					<span class="btn4"><button type="submit">검색</button></span>
				</fieldset>		  
			</div>
		</form>
	</div>
</div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>