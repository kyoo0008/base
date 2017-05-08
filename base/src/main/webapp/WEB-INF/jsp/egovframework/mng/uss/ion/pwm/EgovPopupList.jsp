<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="ETC_MANAGE"/>
	<c:param name="depth1" value="ETC_POPUPWINDOW"/>
	<c:param name="title" value="팝업관리"/>
</c:import>

<script type="text/javaScript" language="javascript">

function fn_egov_delete_PopupManage(url) {
	if(confirm('<spring:message code="common.delete.msg" />')){
    	document.location.href = url;	
    }
}

</script>


<div id="cntnts">

	<c:if test="${USER_INFO.userSe > 10}">
		<form id="siteForm" name="siteForm" action="<c:url value="/mng/uss/ion/pwm/listPopup.do"/>" method="post">
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
	
<div id="board">

  <p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
  
  <div id="board_list">
    <table width="100%" summary="게시판리스트입니다." class="chart_board">
    <caption class="hdn">팝업목록</caption>
    <colgroup>
      <col class="co1"/>
      <col class="co3"/>
      <col class="co6"/>
      <col class="co6"/>
      <col class="co6"/>
      <col class="co6"/>
      <col class="co6"/>
      <col class="co6"/>
      <col class="co6"/>
    </colgroup>
    <thead>
      <tr>
        <th class="first">번호</th>
        <th>팝업명</th>
        <th>게시기간</th>
        <th>팝업목록게시</th>
        <th>그만보기설정</th>
        <th>게시상태</th>
        <th>생성일</th>
        <th>미리보기</th>
        <th>관리</th>
      </tr> 
    </thead>
    <tbody>
    
    <c:forEach var="result" items="${resultList}" varStatus="status">
      <tr>
        <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
        <td><c:out value="${result.popupTitleNm}"/></td>
        <td>
			<c:out value="${fn:substring(result.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(result.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(result.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(result.ntceBgnde, 8, 10)}"/>:<c:out value="${fn:substring(result.ntceBgnde, 10, 12)}"/>~
			<br/><c:out value="${fn:substring(result.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(result.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(result.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(result.ntceEndde, 8, 10)}"/>:<c:out value="${fn:substring(result.ntceEndde, 10, 12)}"/>
		</td>
		<td>
			<c:if test="${result.popupListAt eq 'Y'}">
		    	<img src="${_IMG}/btn/use_yes.gif" alt="Y"/>
		    </c:if>
		    <c:if test="${result.popupListAt ne 'Y'}">
		    	<img src="${_IMG}/btn/use_no.gif" alt="N"/>
		    </c:if>
		</td>
		<td>
			<c:if test="${result.stopVewAt eq 'Y'}">
		    	<img src="${_IMG}/btn/use_yes.gif" alt="Y"/>
		    </c:if>
		    <c:if test="${result.stopVewAt eq 'N'}">
		    	<img src="${_IMG}/btn/use_no.gif" alt="N"/>
		    </c:if>
		</td>
        <td>
        	<c:if test="${result.ntceAt eq 'Y'}">
		    	<img src="${_IMG}/btn/use_yes.gif" alt="Y"/>
		    </c:if>
		    <c:if test="${result.ntceAt eq 'N'}">
		    	<img src="${_IMG}/btn/use_no.gif" alt="N"/>
		    </c:if>
        </td>
        <td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
        <td><a href="#" onclick="fn_egov_popupOpen_PopupManage('${result.popupId}','${result.fileUrl}','${result.popupWSize}','${result.popupHSize}','${result.popupHlc}','${result.popupWlc}','${result.stopVewAt}');return false;"><img src="${_IMG}/btn/btn_viewer.gif"/></a></td>
        <td>
	        	<c:url var="viewUrl" value="/mng/uss/ion/pwm/updtPopup.do">
				  <c:param name="popupId" value="${result.popupId}" />
				  <c:param name="siteId" value="${searchVO.siteId}"/>
		       	  <c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		      	  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>					
	        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
	        	<c:url var="delUrl" value="/mng/uss/ion/pwm/deletePopup.do">
				  <c:param name="popupId" value="${result.popupId}" />
				  <c:param name="siteId" value="${searchVO.siteId}"/>
		       	  <c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		      	  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>
	        	<a href="${delUrl}" onclick="fn_egov_delete_PopupManage(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
		    </td>
      </tr>
    </c:forEach>

    <c:if test="${fn:length(resultList) == 0}">
      <tr>
        <td class="listCenter" colspan="9"><spring:message code="common.nodata.msg" /></td>
      </tr>
    </c:if>

    </tbody>    
    </table>
  </div>
 
  <div id="paging">
    <c:url var="pageUrl" value="/mng/uss/ion/pwm/listPopup.do">
    	<c:param name="siteId" value="${searchVO.siteId}"/>
		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
      	<c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
      	<c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
    </c:url>

    <ul>
      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
    </ul>
  </div>
  
</div>        

<div id="bbs_search">
	<form name="listForm" action="<c:url value='/mng/uss/ion/pwm/listPopup.do'/>" method="post">
		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  		<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
          <fieldset>
            <legend class="hdn">찾기 폼</legend>
            <label for="searchCondition" class="hdn">검색항목</label>
            <select name="searchCondition" id="ftext">
	  		  <!--<option selected value=''>--선택하세요--</option>-->
	  		  <option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> >팝업명</option>
	  	  	</select>
            <label for="bbsSearchTxt" class="hdn">팝업명</label>
            <input name="searchKeyword" id="searchKeyword" type="text" size="35" class="inp" value="<c:out value="${searchVO.searchKeyword}"/>" maxlength="35" />
            <input type="image" class="searchBtn vMid" src="${_IMG}/btn/btn_search.gif" alt="검색" />
          </fieldset>
	</form>
</div>

<c:if test="${not empty searchVO.siteId }">
	  <div class="btn_r">
	  	<c:url var="addUrl" value="/mng/uss/ion/pwm/registPopup.do">
			<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		</c:url>
	    <a href="${addUrl}"><img src="${_IMG}/btn/btn_regist.gif" alt="등록"/></a>
	  </div>
  </c:if>

</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	