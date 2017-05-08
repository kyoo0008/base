<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${param.ctgrymasterNm}"/>
</c:import>


<script type="text/javaScript" language="javascript" defer="defer">
	
	function fn_egov_delete(url){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.location.href = url;	
		}		
	}
</script>

<div id="cntnts">

<form name="listForm" id="listForm" method="post">
	
	<table class="chart_board">
	    <colgroup>
				<col class="co1"/>
				<col class="co3"/>
				<col class="co6"/>
				<col class="co6"/>
				<col class="co6"/>
		</colgroup>
	    <caption class="hdn">카테고리관리</caption>
	    <thead>
	      <tr>
	        <th>카테고리ID</th>
	        <th>카테고리명</th>
	        <th>순서변경</th>
	        <th>하위로추가</th>
	        <th>관리</th>
	      </tr> 
	    </thead>
	    <tbody>
	    	<c:set var="_ROOT_ID" value=""/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:choose>
		    	<c:when test="${empty result.upperCtgryId}">
		    		<c:set var="_ROOT_ID" value="${result.ctgryId}"/>
		    	</c:when>
		    	<c:otherwise>    
				<tr>
					<td><c:out value="${result.ctgryId}"/></td>
					<td class="tit">						
						<c:forEach begin="1" end="${result.ctgryLevel}" step="1">
				            &nbsp;
				        </c:forEach>
			        	<img src="${_IMG}/btn/folder_${result.ctgryLevel}.gif"/>
			        	<c:choose>
			        		<c:when test="${not empty result.upperCtgryId}"><c:out value="${result.ctgryNm}"/></c:when>
			        		<c:otherwise><c:out value="${param.ctgrymasterNm}"/></c:otherwise>
			        	</c:choose> 
						</td>
					<td>
			        	<c:if test="${not empty result.upperCtgryId}">
			        		<c:url var="uSortUrl" value="/mng/cop/bbs/ctg/updateBBSCtgrySortOrdr.do">
			        			<c:param name="sortTyCode" value="U"/>
			        			<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
								<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
								<c:param name="ctgryId" value="${result.ctgryId}"/>
								<c:param name="upperCtgryId" value="${result.upperCtgryId}"/>
								<c:param name="sortOrdr" value="${result.sortOrdr}"/>
			        		</c:url>
			        		<c:url var="dSortUrl" value="/mng/cop/bbs/ctg/updateBBSCtgrySortOrdr.do">
			        			<c:param name="sortTyCode" value="D"/>
			        			<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
								<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
								<c:param name="ctgryId" value="${result.ctgryId}"/>
								<c:param name="upperCtgryId" value="${result.upperCtgryId}"/>
								<c:param name="sortOrdr" value="${result.sortOrdr}"/>
			        		</c:url>
			        		
			        		<a href="${uSortUrl}"><img src="${_IMG}/btn/btn_goup.gif"/></a>
			        		<a href="${dSortUrl}"><img src="${_IMG}/btn/btn_godown.gif"/></a>
			        	</c:if>
			        </td>
			        <c:url var="addUrl" value="/mng/cop/bbs/ctg/addBBSCtgry.do">
						<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
						<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
						<c:param name="upperCtgryId" value="${result.ctgryId}"/>
					</c:url>	
					<td>
						<a href="${addUrl}"><img src="${_IMG}/btn/add_btn_2.gif"/></a>
					</td>
					<td>
				        <c:if test="${not empty result.upperCtgryId}">
				        	<c:url var="viewUrl" value="/mng/cop/bbs/ctg/selectBBSCtgry.do">
								<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
								<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
								<c:param name="ctgryId" value="${result.ctgryId}"/>
							</c:url>							
				        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
				        	<c:url var="delUrl" value="/mng/cop/bbs/ctg/deleteBBSCtgry.do">
								<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
								<c:param name="ctgrymasterId" value="${result.ctgrymasterId}"/>
								<c:param name="ctgryId" value="${result.ctgryId}"/>
							</c:url>	
				        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
				        </c:if>
				    </td>
				</tr>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 1}">
		      <tr>
		        <td class="listCenter" colspan="5"><spring:message code="common.nodata.msg" /></td>
		      </tr>
		    </c:if>
		</tbody>    
    </table>
    
    <div class="btn_r">
    	<c:url var="addUrl" value="/mng/cop/bbs/ctg/addBBSCtgry.do">
			<c:param name="ctgrymasterNm" value="${param.ctgrymasterNm}"/>
			<c:param name="ctgrymasterId" value="${searchVO.ctgrymasterId}"/>
			<c:param name="upperCtgryId" value="${_ROOT_ID}"/>
		</c:url>	
		<a href="${addUrl}"><img src="${_IMG}/btn/btn_creat.gif" alt="생성"/></a>
	</div>
</form>

</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	