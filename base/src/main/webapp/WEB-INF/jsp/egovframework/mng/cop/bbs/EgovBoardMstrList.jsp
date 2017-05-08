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

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="siteId" value="${searchVO.siteId}"/>
   		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
   		<c:param name="trgetId" value="${searchVO.trgetId}" />
	</c:url>
	
	<c:url var="_PAGE_PARAM" value="${_BASE_PARAM}">
		<c:param name="registSeCode" value="${searchVO.registSeCode}" />
		<c:param name="selectMode" value="${searchVO.selectMode}" />
		<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="게시판선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:set var="menu" value="BOARD_MANAGE"/>
		<c:if test="${searchVO.trgetId eq 'MMAMVP_SERVICE_BOARD'}">
			<c:set var="menu" value="MLTMD_MANAGE"/>
		</c:if>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="${menu}"/>
			<c:param name="depth1" value="BOARD_ADMIN"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="게시판관리"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript">
	function fnBBS_Manage(url) {
		var win = window.open(url ,'bbs',' scrollbars=yes, resizable=yes, left=0, top=0, width=1100,height=750');
		if(win != null) {
			win.focus();
		}
	}
	
	function fnBBS_ScoreManage(url) {
		var win = window.open(url ,'bbsScore',' scrollbars=yes, resizable=yes, left=0, top=0, width=1100,height=750');
		if(win != null) {
			win.focus();
		}
	}
	
	function fn_egov_delete_brdMstr(url){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.location.href = url;	
		}		
	}
	
	function fn_egov_selectBbsList(id, nm) {
		opener.fn_egov_updateBbsList(id, nm);
	}
</script>
<div id="cntnts">
<c:if test="${searchVO.selectMode ne 'Y' and USER_INFO.userSe > 10}">
	<form name="SiteListForm" action="${pageContext.request.contextPath}/mng/cop/bbs/SelectBBSMasterInfs.do?trgetId=${searchVO.trgetId}" method="post">
		<div id="bbs_search">
			<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
		</div>
	</form>
</c:if>	
<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
   
  <table class="chart_board">
    <colgroup>
			<col class="co1"/>
			<col class="co3"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<c:if test="${searchVO.selectMode eq 'Y'}"><col class="co6"/></c:if>
	</colgroup>
    <caption class="hdn">게시판관리</caption>
    <thead>
      <tr>
        <th>번호</th>
        <th>게시판명</th>
        <th>코멘트사용</th>
        <th>사용여부</th>
        <th>게시글관리</th>
        <th>생성일</th>
        <th>관리</th>
        <c:if test="${searchVO.selectMode eq 'Y'}"><th>선택</th></c:if>
      </tr> 
    </thead>
    <tbody>
    

    <c:forEach var="result" items="${resultList}" varStatus="status">
      <tr>
        <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
        <td class="tit"><c:out value="${result.bbsNm}"/></td>
        <td>
        	<c:if test="${result.commentUseAt == 'Y'}">
		   		<img src="${_IMG}/btn/use_yes.gif"/>
		   	</c:if>
		   	<c:if test="${result.commentUseAt == 'N'}">
		   		<img src="${_IMG}/btn/use_no.gif"/>
		   	</c:if>
        </td>
        <td>
        	<c:if test="${result.svcAt == 'Y'}">
		   		<img src="${_IMG}/btn/use_yes.gif"/>
		   	</c:if>
		   	<c:if test="${result.svcAt == 'N'}">
		   		<img src="${_IMG}/btn/use_no.gif"/>
		   	</c:if>
        </td>
        <td>
        	<c:url var="manageUrl" value="/mng/cop/bbs/selectBoardList.do${_BASE_PARAM}">
				<c:param name="bbsId" value="${result.bbsId}"/>
			</c:url>	
        	<a href="${manageUrl}" onclick="fnBBS_Manage(this.href);return false;"><img src="${_IMG}/btn/btn_letter.gif"/></a>
        </td>
        <td><c:out value="${result.frstRegisterPnttm}"/></td>
        <td>
        	<c:url var="viewUrl" value="/mng/cop/bbs/SelectBBSMasterInf.do${_PAGE_PARAM}">
				<c:param name="bbsId" value="${result.bbsId}"/>
				<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
			</c:url>							
        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
        	<c:url var="delUrl" value="/mng/cop/bbs/DeleteBBSMasterInf.do${_PAGE_PARAM}">
				<c:param name="bbsId" value="${result.bbsId}"/>
				<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
			</c:url>
        	<a href="${delUrl}" onclick="fn_egov_delete_brdMstr(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
	    </td>
	    <c:if test="${searchVO.selectMode eq 'Y'}"><td><a href="#" onclick="fn_egov_selectBbsList('<c:out value="${result.bbsId}"/>', '<c:out value="${result.bbsNm}"/>');return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td></c:if>
      </tr>
    </c:forEach>

    <c:if test="${fn:length(resultList) == 0}">
      <tr>
        <td class="listCenter" colspan="8"><spring:message code="common.nodata.msg" /></td>
      </tr>
    </c:if>

    </tbody>    
    </table>
  
  <div id="paging">
    <c:url var="pageUrl" value="/mng/cop/bbs/SelectBBSMasterInfs.do${_PAGE_PARAM}">
    </c:url>

    <ul>
      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
    </ul>
  </div>
  
  <div id="bbs_search">
  	<form name="frm" method="post" action="<c:url value="/mng/cop/bbs/SelectBBSMasterInfs.do"/>">
  		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  		<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
  		<input type="hidden" name="selectMode" value="${searchVO.selectMode}"/>
  		<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
  		<input type="hidden" name="registSeCode" value="${searchVO.registSeCode}"/>
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchCnd" id="ftext">
  		  <!--<option selected value=''>--선택하세요--</option>-->
  		  <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
  		  <!-- <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>-->	
  	  	</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" class="inp_s" id="inp_text" />
		<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
	</form>
  </div>
  
  <c:if test="${not empty searchVO.siteId }">
 	<div class="btn_r">
	 	<c:url var="addUrl" value="/mng/cop/bbs/addBBSMaster.do${_PAGE_PARAM}">
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