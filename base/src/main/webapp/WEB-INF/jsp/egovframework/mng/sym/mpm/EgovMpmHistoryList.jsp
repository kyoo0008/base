<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="_C_IMG" value="/template/common/images"/>
<c:set var="_C_JS" value="/template/common/js"/>
<c:set var="_IMG" value="/template/manage/images"/>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="메뉴 복원"/>
</c:import>

<script type="text/javascript" language="javascript">
function fn_egov_Rollback(id){
 
    if(confirm("복원하시겠습니까?")){
    	document.location.href = "/mng/sym/mpm/updateMpmRollBack.do?siteId=${searchVO.siteId}&menuId=${searchVO.menuId}&menuHistId=" + id;
    }
}

<c:if test="${rollbackComplete eq 'Y'}">
	alert('복원이 완료 되었습니다.');
</c:if>
</script>

<div id="cntnts">
	
			
<p class="total">총  ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <table class="chart_board">
           <colgroup>
				<col class="co1"/>
				<col class="co3"/>
				<col class="co6"/>
			</colgroup>
          <thead>
            <tr>
			    <th>번호</th>
			    <th>변경일자</th>
			    <th>복원</th>
			  </tr>
          </thead>
          <tbody>
	
	  
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
		    <td>
		    	<c:url var="viewUrl" value="/mng/sym/mpm/selectMpmHistory.do">
		    		<c:param name="siteId" value="${searchVO.siteId}"/>
		    		<c:param name="menuHistId" value="${result.menuHistId}" />
					<c:param name="menuId" value="${searchVO.menuId}" />
		      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>	
		    	<a href="${viewUrl}"><fmt:formatDate value="${result.lastUpdusrPnttm}"  pattern="yyyy-MM-dd HH:mm:ss"/></a>
		    </td>
		    <td><a href="#" onclick="fn_egov_Rollback('${result.menuHistId}'); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
		  </tr>
		 </c:forEach>	  
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td colspan="3" ><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>
 
	 </tbody>  
	</table>
	
	
			<div id="paging">
			    <c:url var="pageUrl" value="/mng/sym/mpm/selectMpmHistoryList.do">
			    	<c:param name="siteId" value="${searchVO.siteId}"/>
			    	<c:param name="menuId" value="${searchVO.menuId}" />
			    </c:url>
			
			    <ul>
			      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			    </ul>
		    </div>

</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	