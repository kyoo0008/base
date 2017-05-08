<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="ETC_MANAGE"/>
	<c:param name="depth1" value="ETC_SITE"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="링크사이트관리"/>
</c:import>

<script type="text/javaScript" language="javascript">


function fn_egov_delete(url) {
	if(confirm('<spring:message code="common.delete.msg" />')){
    	document.location.href = url;	
    }
}

</script>

<div id="cntnts">
    
    <c:if test="${USER_INFO.userSe > 10}">
		<form id="siteForm" name="siteForm" action="<c:url value="/mng/uss/ion/sit/SiteListInqire.do"/>" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
	
	<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
	              
          <table width="100%" summary="사이트정보목록 테이블" class="chart_board">
          <caption class="hdn">사이트목록</caption>
          <colgroup>
            <col class="co1"/>
		    <col class="co6"/>
		    <col class="co3"/>
		    <col class="co3"/>
		    <col class="co6"/>
		    <col class="co6"/>
		    <col class="co6"/>
          </colgroup>
          <thead>
            <tr>
              <th class="first">번호</th>
              <th>주제분류</th>
              <th>사이트명</th>
              <th>사이트URL</th>
              <th>게시상태</th>
              <th>등록일자</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>

          <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
            <tr>
              <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
              <td><c:out value="${resultInfo.siteThemaClNm}"/></td>  
              <td><a href="${resultInfo.linkSiteUrl}" target="_blank"><c:out value="${resultInfo.linkSiteNm}"/></a></td>
              <td><a href="${resultInfo.linkSiteUrl}" target="_blank"><c:out value="${resultInfo.linkSiteUrl}"/></a></td>        
              <td>
	        	<c:if test="${resultInfo.actvtyAt eq 'Y'}">
			    	<img src="${_IMG}/btn/use_yes.gif" alt="Y"/>
			    </c:if>
			    <c:if test="${resultInfo.actvtyAt eq 'N'}">
			    	<img src="${_IMG}/btn/use_no.gif" alt="N"/>
			    </c:if>
	          </td>
              <td><fmt:formatDate value="${resultInfo.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
              <td>
	        	<c:url var="viewUrl" value="/mng/uss/ion/sit/SiteInfoUpdtView.do">
		          	<c:param name="linkSiteId" value="${resultInfo.linkSiteId}" />
		          	<c:param name="siteId" value="${searchVO.siteId}"/>
					<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		            <c:param name="pageIndex" value="${searchVO.pageIndex}" />
		            <c:param name="searchCondition" value="${searchVO.searchCondition}" />
		            <c:param name="searchCate" value="${searchVO.searchCate}" />
		      		<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
	          	</c:url>				
	        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
	        	<c:url var="delUrl" value="/mng/uss/ion/sit/SiteInfoDelete.do">
				  	<c:param name="linkSiteId" value="${resultInfo.linkSiteId}" />
		          	<c:param name="siteId" value="${searchVO.siteId}"/>
					<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		            <c:param name="pageIndex" value="${searchVO.pageIndex}" />
		            <c:param name="searchCondition" value="${searchVO.searchCondition}" />
		            <c:param name="searchCate" value="${searchVO.searchCate}" />
		      		<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
				</c:url>
	        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
		    </td>
            </tr>
          </c:forEach>
      
          <c:if test="${fn:length(resultList) == 0}">
            <tr>
              <td class="listCenter" colspan="7"><spring:message code="common.nodata.msg" /></td>
            </tr>
          </c:if>

          </tbody>    
          </table>
       
      
      <div id="paging">
          <c:url var="pageUrl" value="/mng/uss/ion/sit/SiteListInqire.do">
          	<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
			<c:if test="${not empty param.searchCate}"><c:param name="searchCate" value="${param.searchCate}" /></c:if>
	        <c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
	        <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
          </c:url>
          <ul>
          <c:if test="${not empty paginationInfo}">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
          </c:if>
          </ul>
        </div>
      
      	<div id="bbs_search">
           <form name="listForm" action="<c:url value='/mng/uss/ion/sit/SiteListInqire.do'/>" method="post">
            <input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  			<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
            <fieldset>
              <legend class="hdn">찾기 폼</legend>
              <label for="cate" class="hdn">분류</label>
	          <select id="cate" name="searchCate" title="분류" class="cate_sel inp">
	            <option value="">주제분류</option>
	            <c:forEach var="code" items="${codeList}">
	              <option value="${code.code}" <c:if test="${param.searchCate == code.code}">selected</c:if>>${code.codeNm}</option>
	            </c:forEach>
	          </select>
              <label for="searchCondition" class="hdn">검색항목</label>
              <select name="searchCondition" id="ftext">
		  		  <!--<option selected value=''>--선택하세요--</option>-->
		  		  <option value="1" <c:if test="${searchVO.searchCondition eq '1'}">selected="selected"</c:if> >사이트명</option>
		  		  <option value="2" <c:if test="${searchVO.searchCondition eq '2'}">selected="selected"</c:if> >사이트URL</option>
		  	  </select>
              <input name="searchKeyword" id="searchKeyword" type="text" size="35" class="inp" value="<c:out value="${searchVO.searchKeyword}"/>" maxlength="35" />
              <input type="image" class="searchBtn vMid" src="${_IMG}/btn/btn_search.gif" alt="검색"/>
            </fieldset>
            </form>     
          </div>   
          
		<c:if test="${not empty searchVO.siteId }">
	        <div class="btn_r">
	        	<c:url var="addUrl" value="/mng/uss/ion/sit/SiteInfoRegistView.do">
		          	<c:param name="siteId" value="${searchVO.siteId}"/>
					<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
					<c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
		        </c:url>
		          
	          <a href="${addUrl}"><img src="${_IMG}/btn/btn_regist.gif" alt="등록"/></a>
	        </div>      
        </c:if>

</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	