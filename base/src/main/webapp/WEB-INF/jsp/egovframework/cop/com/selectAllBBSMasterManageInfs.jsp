<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>게시판선택</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/jquery/jquery-1.9.1.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/default.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/page.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/com.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/template/manage/js/select_design.js"></script>
<c:set var="_ACTION" value="${pageContext.request.contextPath}/cop/com/selectAllBBSMasterManageInfs.do"/>
</head>
<body>

<div id="wrap">

	
	<div id="container">
		
		<div id="navi">
				<h2 class="naviTit">게시판선택</h2>
			</div>
			
			<div id="contents">


<script type="text/javascript">
	function selectBbsMaster(bbsId, selectCtgryId) {
		if(confirm('"' + $('#txt' + bbsId).text() + '" 게시판으로 선택 하시겠습니까?')) {
			opener.selectBbsMaster(bbsId, $('#' + selectCtgryId).val());
			window.close();
		}
	}
</script>
<div id="cntnts">


<c:if test="${searchVO.selectMode ne 'Y'}">
	<form name="SiteListForm" action="${_ACTION }" method="post">
		<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
		<div id="bbs_search">
			<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
		</div>
	</form>
</c:if>	

<p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
   
  <table class="chart_board">
    <colgroup>
			<col width="65px" />
			<col width="*" />
			<col width="200px" />
			<col width="65px" />
	</colgroup>
    <caption class="hdn">게시판관리</caption>
    <thead>
      <tr>
        <th>번호</th>
        <th>게시판명</th>
        <th>카테고리</th>
        <th>선택</th>
      </tr> 
    </thead>
    <tbody>
    

    <c:forEach var="result" items="${resultList}" varStatus="status">
      <tr>
        <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
        <td class="tit" id="txt${result.bbsId}"><c:out value="${result.bbsNm}"/></td>
        <td class="tit">
        	<c:if test="${not empty result.ctgrymasterId}">
	        	<select name="select${result.bbsId}" id="select${result.bbsId}" style="width:200px;height:21px;display:none;">
					<c:forEach var="cate" items="${result.ctgryList}" varStatus="status">
						<c:if test="${not empty cate.upperCtgryId}">
							<option value="${cate.ctgryId}"><c:forEach begin="1" end="${cate.ctgryLevel}" step="1">&nbsp;</c:forEach>&lt;img src=${_IMG}/btn/folder_${cate.ctgryLevel}.gif&gt; <c:out value="${cate.ctgryNm}"/></option>
						</c:if>
					</c:forEach>		
				</select>
				<script>
					makeSelectBoxGlobal("select${result.bbsId}", "selectBoxSelectedAreaGlobal", "white", "${_IMG}/btn/select_btn.gif", "selectBoxOptionGlobal", "selectBoxSelectedAreaFocusGlobal", "selectBoxOptionOverGlobal");
				</script>
			</c:if>
        </td>
        <td>
        	<c:choose>
	        	<c:when test="${searchVO.bbsId ne result.bbsId}">
	        		<a href="#" onclick="selectBbsMaster('<c:out value="${result.bbsId}"/>', 'select${result.bbsId}');return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a>
	        	</c:when>
	        	<c:otherwise>-</c:otherwise>
        	</c:choose>
        </td>
      </tr>
    </c:forEach>

    <c:if test="${fn:length(resultList) == 0}">
      <tr>
        <td class="listCenter" colspan="4"><spring:message code="common.nodata.msg" /></td>
      </tr>
    </c:if>

    </tbody>    
    </table>
 
  <div id="paging">
    <c:url var="pageUrl" value="/cop/com/selectAllBBSMasterManageInfs.do">
    	<c:param name="siteId" value="${searchVO.siteId}"/>
		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		<c:param name="trgetId" value="${searchVO.trgetId}"/>
		<c:param name="bbsId" value="${searchVO.bbsId}"/>
		<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
		<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>
    </c:url>

    <ul>
      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
    </ul>
  </div>
  
  <div id="bbs_search">
  	<form name="frm" method="post" action="<c:url value="/cop/com/selectAllBBSMasterManageInfs.do"/>">
  		<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  		<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
  		<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
  		<input type="hidden" name="bbsId" value="${searchVO.sysTyCode}"/>
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
  
  
   
        




</div>        

</div>

	</div>
	<!-- container -->


</div> 
<!-- wrap end -->

</body>
</html>	