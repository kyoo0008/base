<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="SITE_MANAGE"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="사이트관리"/>
</c:import>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnDelete(url) {
    if(confirm('<spring:message code="common.delete.msg" />')){
    	document.location.href = url;	
    }
}

//-->
</script>

<div id="cntnts">
    
	 
	<c:if test="${USER_INFO.userSe > 10}">
		<form name="SiteListForm" action="${pageContext.request.contextPath}/mng/sym/sit/selectSiteInfoList.do" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>	
	
      <!-- contents start -->
      <form name="SiteListForm" action="<c:url value='/mng/sym/sit/selectSiteInfoList.do'/>" method="post">
      <input name="pageIndex" type="hidden" value="1" />
      <input type="hidden" name="siteId" value="${searchVO.siteId}"/>

		<p class="total">총 사이트 ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <table class="chart_board">
           <colgroup>
				<col class="co1"/>
				<col class="co3"/>
				<col class="co3"/>
				<col class="co6"/>
				<col class="co6"/>
			</colgroup>
          <thead>
            <tr>
              <th>번호</th>
              <th>사이트명</th>
              <th>사이트도메인</th>
              <th>등록일자</th>
              <th>수정</th>
            </tr>
          </thead>
          <tbody>

          <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
            <tr>
              <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
              <td><c:out value="${resultInfo.siteNm}"/></td>
              <td><a href="http://<c:out value="${resultInfo.siteUrl}"/>" target="_blank"><c:out value="${resultInfo.siteUrl}"/></a></td>        
              <td><fmt:formatDate value="${resultInfo.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
              <td>
	        	<c:url var="viewUrl" value="/mng/sym/sit/selectSiteInfo.do">
				  <c:param name="siteId" value="${resultInfo.siteId}" />
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		  <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
	      		  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>						
	        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
	        	
		    </td>
            </tr>
          </c:forEach>
      
          <c:if test="${fn:length(resultList) == 0}">
            <tr>
              <td class="listCenter" colspan="5"><spring:message code="common.nodata.msg" /></td>
            </tr>
          </c:if>

          </tbody>    
          </table>
      </form>
    </div>        

    <c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	