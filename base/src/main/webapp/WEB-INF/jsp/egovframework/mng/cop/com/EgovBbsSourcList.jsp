<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="소스 선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="BOARD_MANAGE"/>
			<c:param name="depth1" value="SOURC_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="소스 관리"/>
		</c:import>
	</c:otherwise>
</c:choose>


<script type="text/javascript" language="javascript">
function fn_egov_delete(url){
 
    if(confirm("삭제하시겠습니까?")){
    	document.location.href = url;
    }
}

function fn_egov_view_HisManage(id) {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsSourcHistoryList.do?";
	url = url + "bbsSourcId=" + id;
	var win = window.open(url ,'his',' scrollbars=yes, resizable=yes, left=0, top=0, width=760,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_selectSourc(id, nm, fileNm) {
	opener.fn_egov_updateSourc(id, nm, fileNm);
	window.close();
}
</script>


<div id="cntnts">

<p class="total">총  ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <table class="chart_board">
           <colgroup>
				<col class="co1"/>
				<col class="co6"/>
				<col class="co6"/>
				<col class="co3"/>
				<col class="co6"/>
				<c:if test="${USER_INFO.userSe > 10}"><col class="co6"/></c:if>
				<col class="co6"/>
			</colgroup>
          <thead>
            <tr>
			    <th>번호</th>
			    <th>미리보기</th>
			    <th><spring:message code="cop.sourcSeCode" /></th>
			    <th><spring:message code="cop.sourcNm" /></th>
			    <th>등록일/수정일</th>
			    <c:if test="${USER_INFO.userSe > 10}"><th>관리</th></c:if>
			    <th>
				    <c:choose>
						<c:when test="${searchVO.selectMode eq 'Y'}">선택</c:when>
						<c:otherwise>복원</c:otherwise>
					</c:choose>
				</th>
			  </tr>
          </thead>
          <tbody>
	
	  
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
		    <td>
		    	<c:choose>
					<c:when test="${not empty result.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}/${result.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}/${result.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>		    	
		    </td>
		    <td><c:out value="${result.sourcSeCodeNm}"/></td>
		    <td><c:out value="${result.sourcNm}"/></td>
			<td>
				<fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/><br/>	
				<fmt:formatDate value="${result.lastUpdusrPnttm}"  pattern="yyyy-MM-dd"/>
			</td>
			<c:if test="${USER_INFO.userSe > 10}">
				<td>				
		        	<c:url var="viewUrl" value="/mng/cop/com/selectBbsSourc.do">
		        		<c:param name="searchSourcSeCode" value="${searchVO.searchSourcSeCode}" />
						<c:param name="bbsSourcId" value="${result.bbsSourcId}" />
						<c:param name="selectMode" value="${searchVO.selectMode}" />
						<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
						<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>							
		        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
		        	<c:url var="delUrl" value="/mng/cop/com/deleteBbsSourc.do">
		        		<c:param name="searchSourcSeCode" value="${searchVO.searchSourcSeCode}" />
		        		<c:param name="bbsSourcId" value="${result.bbsSourcId}" />
		        		<c:param name="selectMode" value="${searchVO.selectMode}" />
						<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
						<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>	
		        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
			    </td>
		    </c:if>
		    <td>
		    <c:choose>
				<c:when test="${searchVO.selectMode eq 'Y'}"><a href="#" onclick="fn_egov_selectSourc('<c:out value="${result.bbsSourcId}"/>', '<c:out value="${result.sourcNm}"/>', '<c:out value="${result.prevewFileNm}"/>');return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></c:when>
				<c:otherwise><a href="#" onclick="fn_egov_view_HisManage('<c:out value="${result.bbsSourcId}"/>');return false;"><img src="${_IMG}/btn/btn_search02.gif" alt="찾기"/></a></c:otherwise>
			</c:choose> 
		    </td>
		  </tr>
		 </c:forEach>	  
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td colspan="7" ><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>
 
	 </tbody>  
	</table>
	
			
  	
  			<div id="paging">
			    <c:url var="pageUrl" value="/mng/cop/com/selectBbsSourcList.do?">
			    	<c:param name="searchSourcSeCode" value="${searchVO.searchSourcSeCode}" />
			    	<c:param name="selectMode" value="${searchVO.selectMode}" />
            		<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
            		<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>
			    </c:url>
			
			    <ul>
			      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			    </ul>
		    </div>
		    
		    <div id="bbs_search">
		    	<form name="frm" action ="<c:url value="/mng/cop/com/selectBbsSourcList.do"/>" method="post">
		    	<input type="hidden" name="selectMode" value="${searchVO.selectMode}"/>
					<label for="ftext" class="hdn">분류검색</label>
					<select name="searchSourcSeCode" id="searchSourcSeCode" class="searchCate inp">
        				<option value=""><spring:message code="cop.sourcSeCode" /></option>
        		  		<c:forEach var="result" items="${codeList}" varStatus="status">
        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${searchVO.searchSourcSeCode == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
        		  		</c:forEach>
        	  		</select>
					<select name="searchCnd" id="searchCnd">
		                <option selected value=''>분류검색</option>
		                <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code="cop.sourcNm" /></option>	                             
		            </select>
					<label for="inp_text" class="hdn">검색어입력</label>
					<input name="searchWrd" type="text" size="25" class="inp" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35"  class="inp_s" id="inp_text"/>
					<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색"/>
				</form>
		  </div>
		  
		  <c:if test="${USER_INFO.userSe > 10}">
		  	<div class="btn_r">
				<c:url var="addUrl" value="/mng/cop/com/addBbsSourc.do">
					<c:param name="searchSourcSeCode" value="${searchVO.searchSourcSeCode}" />
					<c:param name="selectMode" value="${searchVO.selectMode}" />
				</c:url>
		    	<a href="${addUrl}"><img src="${_IMG}/btn/btn_creat.gif" alt="생성"/></a>
		  	</div>
		  </c:if>

</div>        


<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
	</c:otherwise>
</c:choose>
