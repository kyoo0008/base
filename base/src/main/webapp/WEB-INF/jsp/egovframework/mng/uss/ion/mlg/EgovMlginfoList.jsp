<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="/template/manage/images"/>
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MILEAGE_MANAGE"/>
	<c:param name="depth1" value="MILEAGE_SETUP"/>
	<c:param name="title" value="마일리지설정"/>		
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

      
      <div id="board">      
             
        
        
      
        <p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <div id="board_list">
          <table width="100%" summary="" class="chart_board">
          <caption class="hdn"> </caption>
          <colgroup>
            <col class="co1"/>
            <col class="co3"/>
            <col class="co3"/>
            <col class="co6"/>
            <col class="co6"/>
            <col class="co6"/>
          </colgroup>
          <thead>
            <tr>
              <th class="first">번호</th>
              <th>마일리지코드</th>
              <th>마일리지명</th>
              <th>점수</th>
              <th>제한회수</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
      
          <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr>
              <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
              <td><c:out value="${result.mlgCode}"/></td>        
              <td><c:out value="${result.mlgNm}"/></td>
              <td><c:out value="${result.mlgScore}"/></td>
              <td><c:out value="${result.lmttCo}"/></td>
              <td>
	        	<c:url var="viewUrl" value="/mng/uss/ion/mlg/updateMlginfoView.do">
				  <c:param name="mlgCode" value="${result.mlgCode}" />
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>						
	        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
	        	<c:url var="delUrl" value="/mng/uss/ion/mlg/deleteMlginfo.do">
				  <c:param name="updateMlgCode" value="${result.mlgCode}" />
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>
	        	<a href="${delUrl}" onclick="fnDelete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
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
        </div>
       
        <div id="paging">
          <c:url var="pageUrl" value="/mng/uss/ion/mlg/selectMlginfoList.do">
	        <c:param name="searchCondition" value="${param.searchCondition}" />
	        <c:param name="searchKeyword" value="${param.searchKeyword}" />
          </c:url>
          <ul>
          <c:if test="${not empty paginationInfo}">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
          </c:if>
          </ul>
        </div>
        
        <div class="btn_r">
        	<c:url var="addUrl" value="/mng/uss/ion/mlg/addMlginfoRegistView.do">
	        </c:url>
	          
          <a href="${addUrl}"><img src="${_IMG}/btn/btn_regist.gif" alt="등록"/></a>
        </div>
      </div>        
              
      
      <div id="bbs_search">
           <form name="listForm" action="<c:url value='/mng/uss/ion/mlg/selectMlginfoList.do'/>" method="post">
            <fieldset>
              <legend class="hdn">찾기 폼</legend>
              <label for="searchCondition" class="hdn">검색항목</label>
              <select name="searchCondition" id="ftext">
		  		  <option selected value=''>--선택하세요--</option>
		  		  <option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> >마일리지코드</option>
		  		  <option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if> >마일리지명</option>
		  	  </select>
              <input name="searchKeyword" id="searchKeyword" type="text" size="35" class="inp" value="<c:out value="${searchVO.searchKeyword}"/>" maxlength="35" />
              <input type="image" class="searchBtn vMid" src="${_IMG}/btn/btn_search.gif" alt="검색"/>
            </fieldset>
            </form>     
          </div>   
      <!-- contents end -->
	
	
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	