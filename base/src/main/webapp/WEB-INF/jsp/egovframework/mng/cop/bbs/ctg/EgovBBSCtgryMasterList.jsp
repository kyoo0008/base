<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>


<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="BOARD_MANAGE"/>
	<c:param name="depth1" value="CTGRY_ADMIN"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="카테고리관리"/>
</c:import>

<script type="text/javaScript" language="javascript" defer="defer">

	function fnCtgy_Manage(url) {
		var win = window.open(url ,'ctgy',' scrollbars=yes, resizable=yes, left=0, top=0, width=760,height=650');
		if(win != null) {
			win.focus();
		}
	}
	
	function fn_egov_delete(url){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.location.href = url;	
		}		
	}
 // -->
</script>

<div id="cntnts">
	<c:if test="${USER_INFO.userSe > 10}">
		<form id="listForm" name="listForm" action="<c:url value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do"/>" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
	<p class="total">총  ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
   
  <table class="chart_board">
    <colgroup>
			<col class="co1"/>
			<col class="co1"/>
			<col class="co3"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
	</colgroup>
    <caption class="hdn">카테고리관리</caption>
    <thead>
      <tr>
        <th>번호</th>
        <th>대분류코드</th>
        <th>대분류명</th>
        <th>카테고리관리</th>
        <th>생성일</th>
        <th>관리</th>
      </tr> 
    </thead>
    <tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
					<td><c:out value="${result.ctgrymasterId}"/></td>
					<td class="tit"><c:out value="${result.ctgrymasterNm}"/></td>
					<td><a href="<c:url value="/mng/cop/bbs/ctg/selectBBSCtgryList.do"><c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/><c:param name="ctgrymasterNm" value="${result.ctgrymasterNm}"/></c:url>" onclick="fnCtgy_Manage(this.href);return false;"><img src="${_IMG}/btn/btn_cateadmin.gif"/></a></td>
					<td><c:out value="${result.creatDt}"/></td>
					<td>
			        	<c:url var="viewUrl" value="/mng/cop/bbs/ctg/selectBBSCtgryMaster.do">
			        		<c:param name="siteId" value="${result.siteId}"/>
			        		<c:param name="sysTyCode" value="${result.sysTyCode}"/>
							<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
							<c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
	            			<c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
	            			<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
						</c:url>							
			        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
			        	<c:url var="delUrl" value="/mng/cop/bbs/ctg/deleteBBSCtgryMaster.do">
			        		<c:param name="siteId" value="${result.siteId}"/>
			        		<c:param name="sysTyCode" value="${result.sysTyCode}"/>
							<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
							<c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
	            			<c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
	            			<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
						</c:url>	
			        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
				    </td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
		      <tr>
		        <td class="listCenter" colspan="6"><spring:message code="common.nodata.msg" /></td>
		      </tr>
		    </c:if>

    </tbody>    
    </table>
 
  <c:if test="${not empty searchVO.siteId }">
 	<div class="btn_r">
	 	<c:url var="addUrl" value="/mng/cop/bbs/ctg/addBBSCtgryMaster.do">
			<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		</c:url>	
	    <a href="${addUrl}"><img src="${_IMG}/btn/btn_creat.gif" alt="생성"/></a>
	  </div>  
  </c:if>
  
  <div id="paging">
    <c:url var="pageUrl" value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do">
    	<c:param name="siteId" value="${searchVO.siteId}"/>
		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		<c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
		<c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
    </c:url>

    <ul>
      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
    </ul>
  </div>
  
  <div id="bbs_search">
  	<form id="searchForm" name="searchForm" action="<c:url value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do"/>" method="post">
  		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  		<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCondition" id="ftext">
  		  <!-- option selected value=''>--선택하세요--</option-->
  		  <option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> >대분류명</option>
  	  	</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp_s" id="inp_text" />
		<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
	</form>
  </div>
</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	