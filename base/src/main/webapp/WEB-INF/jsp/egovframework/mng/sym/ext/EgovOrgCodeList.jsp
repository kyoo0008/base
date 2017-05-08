<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_IMG" value="/template/manage/images"/>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="기관코드선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="SYSTEM_MANAGE"/>
			<c:param name="depth1" value="SITE_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="기관코드관리"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript">
	
	function fn_egov_selectOrgCode(id, nm) {
		opener.fn_egov_selectOrgCode(id, nm);
		window.close();
	}
</script>
<div id="cntnts">


<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
   
  <table class="chart_board">
    <colgroup>
			<col class="co1"/>
			<col class="co6"/>
			<col class="co3"/>
			<col class="co3"/>
			<c:if test="${searchVO.selectMode eq 'Y'}"><col class="co6"/></c:if>
	</colgroup>
    <caption class="hdn">기관코드관리</caption>
    <thead>
      <tr>
        <th>번호</th>
        <th>급별</th>
        <th>기관코드</th>
        <th>기관명</th>
        <c:if test="${searchVO.selectMode eq 'Y'}"><th>선택</th></c:if>
      </tr> 
    </thead>
    <tbody>
    

    <c:forEach var="result" items="${resultList}" varStatus="status">
      <tr>
        <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
        <td><c:out value="${result.schlGrdNm}"/></td>
        <td><c:out value="${result.orgCd}"/></td>
        <td><c:out value="${result.schlNm}"/></td>
	    <c:if test="${searchVO.selectMode eq 'Y'}"><td><a href="#" onclick="fn_egov_selectOrgCode('<c:out value="${result.orgCd}"/>', '<c:out value="${result.schlNm}"/>');return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td></c:if>
      </tr>
    </c:forEach>

    <c:if test="${fn:length(resultList) == 0}">
      <tr>
        <td class="listCenter" colspan="5"><spring:message code="common.nodata.msg" /></td>
      </tr>
    </c:if>

    </tbody>    
    </table>
 
  
  <div id="paging">
    <c:url var="pageUrl" value="/mng/sym/ext/selectOrgCodeList.do">
		<c:param name="selectMode" value="${searchVO.selectMode}" />
		<c:if test="${not empty param.searchBlngEduInstCd}"><c:param name="searchBlngEduInstCd" value="${param.searchBlngEduInstCd}" /></c:if>
		<c:if test="${not empty param.searchSchlGrdCd}"><c:param name="searchSchlGrdCd" value="${param.searchSchlGrdCd}" /></c:if>
		<c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
		<c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
    </c:url>

    <ul>
      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
    </ul>
  </div>
  
  <div id="bbs_search">
  	<form name="frm" method="post" action="<c:url value="/mng/sym/ext/selectOrgCodeList.do"/>">
  		<input type="hidden" name="selectMode" value="${searchVO.selectMode}"/>
		<label for="ftext" class="hdn">분류검색</label>
		<select name="searchBlngEduInstCd" id="ftext">
			<option value="">지역별(전체)</option>
			<c:forEach var="result" items="${areaList}" varStatus="status">
				<option value="${result.orgCd}" <c:if test="${searchVO.searchBlngEduInstCd eq result.orgCd}">selected="selected"</c:if> ><c:out value="${result.schlShrNm}"/></option>	
			</c:forEach>
		</select>
		<select name="searchSchlGrdCd" id="ftext">
		  <option value="">급별(전체)</option>
  		  <option value="1" <c:if test="${searchVO.searchSchlGrdCd == '1'}">selected="selected"</c:if> >유치원</option>	
  		  <option value="2" <c:if test="${searchVO.searchSchlGrdCd == '2'}">selected="selected"</c:if> >초등학교</option>
  		  <option value="3" <c:if test="${searchVO.searchSchlGrdCd == '3'}">selected="selected"</c:if> >중학교</option>
  		  <option value="4" <c:if test="${searchVO.searchSchlGrdCd == '4'}">selected="selected"</c:if> >고등학교</option>
  		  <option value="5" <c:if test="${searchVO.searchSchlGrdCd == '5'}">selected="selected"</c:if> >특수학교</option>
  	  	</select>
		<select name="searchCondition" id="ftext">
  		  <option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if> >기관명</option>	
  	  	</select>
		<label for="inp_text" class="hdn">검색어입력</label>
		<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp_s" id="inp_text" />
		<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
	</form>
  </div>
  
  
   
        




</div>        

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
	</c:otherwise>
</c:choose>