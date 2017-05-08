<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovWebLogList.jsp
  * @Description : 웹 로그 정보목록 화면
  * @Modification Information
  * @
  * @  수정일   수정자             수정내용
  * @ -------     --------    ---------------------------
  * @ 2009.03.11   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.11
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
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/cal/EgovCalPopup.js'/>" ></script>
<script type="text/javascript">
	
	function fn_egov_select_webLog(pageNo){
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/sym/log/SelectWebLogList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_inqire_webLog(requstId){
		var url = "/sym/log/InqireWebLog.do?requstId="+requstId;
		
		var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=640,height=320,left=0,top=0"; 
		window.open(url,"p_webLogInqire", openParam);
	}
</script>
<title>웹 로그 목록</title>
</head>
<body>
<form name="frm" action ="<c:url value='/sym/log/SelectWebLogList.do'/>" method="post">
<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />

 <table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td class="title_left">
	   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;웹 로그조회</td>
	  <th>
	   발생일자
	  </th>
	  <td>
	      <input name="searchBgnDe" type="hidden"  value="<c:out value='${searchVO.searchBgnDe}'/>">
	      <input name="searchBgnDeView" type="text" size="10" value=""  readOnly
	      	onClick="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchBgnDe, document.frm.searchBgnDeView);" >
	      <a href="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchBgnDe, document.frm.searchBgnDeView);" 
	    	style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />" alt="달력"
		    width="15" height="15"></a>
	      ~
	      <input name="searchEndDe" type="hidden"  value="<c:out value='${searchVO.searchEndDe}'/>">
	      <input name="searchEndDeView" type="text" size="10" value=""  readOnly
	      	onClick="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchEndDe, document.frm.searchEndDeView);" >
	      <a href="javascript:fn_egov_NormalCalendar(document.frm, document.frm.searchEndDe, document.frm.searchEndDeView);" 
	    	style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />" alt="달력"
		    width="15" height="15"></a>
		</td>
		<td>URL</td>
	  <td>
	    <input name="searchWrd" type="text" size="15" value="<c:out value='${searchVO.searchWrd}'/>"  maxlength="15" > 
	  </td>	
	  <th>
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr> 
	      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif' />" width="8" height="20"></td>
	      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_select_webLog('1')">조회</a> 
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
	    <th class="title" width="5%" nowrap>번호</th>
	    <th class="title" width="15%" nowrap>요청ID</th>
	    <th class="title" width="10%" nowrap>발생일자</th>
	    <th class="title" width="40%" nowrap>URL</th>
	    <th class="title" width="10%" nowrap>요청자</th>             
	    <th class="title" width="15%" nowrap>요청자IP</th> 
	    <th class="title" width="5%" nowrap>상세보기</th> 
	  </tr>
	 </thead>    
	 <tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
	  <tr>
	    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
	    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
	    <td class="lt_text3" nowrap><c:out value="${result.requstId}"/></td>
	    <td class="lt_text3" nowrap><c:out value="${result.occrrncDe}"/></td>
	    <td class="lt_text3" nowrap><c:out value="${result.url}"/></td>    
	    <td class="lt_text3" nowrap><c:out value="${result.rqsterNm}"/></td>  
	    <td class="lt_text3" nowrap><c:out value="${result.rqesterIp}"/></td>  
	    <td class="lt_text3" nowrap>
	    <a href="javascript:fn_egov_inqire_webLog('<c:out value="${result.requstId}"/>');" 
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
				jsFunction="fn_egov_select_webLog"
				/>
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form>	
</body>
</html>