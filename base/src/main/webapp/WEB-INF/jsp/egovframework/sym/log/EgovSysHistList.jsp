<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovSysHistList.jsp
  * @Description : 시스템 이력 정보목록 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------     --------    ---------------------------
  * @ 2009.03.06   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.06
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/sym/log/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/egovframework/sym/log/EgovSysLog.js' />" ></script>
<script type="text/javascript">
function fn_egov_insert_sysHist(){	
	document.frm.action = "<c:url value='/sym/log/AddSysHistory.do'/>";
	document.frm.submit();
}

function fn_egov_select_sysHist(pageNo){
	document.frm.pageIndex.value = pageNo; 
	document.frm.action = "<c:url value='/sym/log/SelectSysHistoryList.do'/>";
	document.frm.submit();	
}

function fn_egov_inqire_sysHist(histId){
	document.frm.histId.value = histId; 
	document.frm.action = "<c:url value='/sym/log/InqireSysHistory.do'/>";
	document.frm.submit();	
}
</script>

<title>시스템 이력 목록</title>
</head>
<body>
<DIV id="main" style="display:">

		
<form name="frm" action ="<c:url value='/sym/log/SelectSysHistoryList.do'/>" method="post">
<input name="histId" type="hidden" />

<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;시스템이력 조회</td>
  <th >
  </th>
  <td width="10%" >
   	<select name="searchCnd" class="select">
		   <option selected value=''>--선택하세요--</option>
		   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >시스템명</option>
		   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >이력구분</option>

	   </select>
	</td>
  <td widht="35%">
    <input name="searchWrd" type="text" size="35" value="<c:out value='${searchVO.searchWrd}'/>"  maxlength="35" > 
  </td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_sysHist('1')">조회</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_insert_sysHist()">등록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>      
    </tr>
   </table>
  </th>  
 </tr>
</table>
<table width="700" cellpadding="8" class="table-line">
 <thead>
  <tr>
    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->  
    <th class="title" width="10%" nowrap>번호</th>
    <th class="title" width="25%" nowrap>이력 ID</th>
    <th class="title" width="15%" nowrap>시스템명</th>
    <th class="title" width="15%" nowrap>이력구분</th>
    <th class="title" width="10%" nowrap>등록자</th>
    <th class="title" width="20%" nowrap>등록일자</th>         
    <th class="title" width="5%" nowrap>상세보기</th> 
  </tr>
 </thead>    
 <tbody>
 <c:forEach var="result" items="${resultList}" varStatus="status">
  <tr>
    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
    <td class="lt_text3" nowrap><c:out value="${result.histId}"/></td>
    <td class="lt_text3" nowrap><c:out value="${result.sysNm}"/></td>
    <td class="lt_text3" nowrap><c:out value="${result.histSeCodeNm}"/></td>
    <td class="lt_text3" nowrap><c:out value="${result.frstRegisterNm}"/></td>
    <td class="lt_text3" nowrap><c:out value="${result.frstRegisterPnttm}"/></td>  
    <td class="lt_text3" nowrap>
    <a href="javascript:fn_egov_inqire_sysHist('<c:out value="${result.histId}"/>');" 
    	style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/sym/log/icon/search.gif'/>"  alt="상세보기"
    	width="15" height="15" align="absmiddle"></a>
    </td>
  </tr>
 </c:forEach>
 </tbody> 

 <!--tfoot>
  <tr class="">
   <td colspan=6 align="center"></td>
  </tr>
 </tfoot -->
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>
	<div align="center">
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="fn_egov_select_sysHist"
				/>
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form>
</DIV>
</body>
</html>