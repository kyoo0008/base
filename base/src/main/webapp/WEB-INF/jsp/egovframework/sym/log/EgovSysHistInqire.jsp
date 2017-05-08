<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovSysHistInqire.jsp
  * @Description : 시스템 이력 정보 상세조회 화면
  * @Modification Information
  * @
  * @  수정일      수정자          수정내용
  * @ -------        --------       ---------------------------
  * @ 2009.03.11  이삼섭          최초 생성
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
<script type="text/javascript">
function fn_egov_update_sysHist(){	
	document.frm.action = "<c:url value='/sym/log/ModifySysHistory.do'/>";
	document.frm.submit();
}

function fn_egov_delete_sysHist(){	
	document.frm.action = "<c:url value='/sym/log/DeleteSysHistory.do'/>";
	document.frm.submit();
}

function fn_egov_select_sysHist(){
	document.frm.action = "<c:url value='/sym/log/SelectSysHistoryList.do'/>";
	document.frm.submit();	
}
</script>

<title>시스템 이력 상세보기</title>
</head>
<body>
<form name="frm" action ="<c:url value='/sym/log/SelectSysHistoryList.do'/>" method="post">
<input name="pageIndex" type="hidden" value="1" />
<input type="hidden" name="histId" value="<c:out value='${result.histId}'/>" />
	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;시스템 이력정보</td>
	 </tr>
	</table>
	<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th height="23" class="" >이력 구분</th>
	    <td>&nbsp;&nbsp;
	    <c:out value="${result.histSeCodeNm}"/>
	    </td>
	  </tr> 
	 <tr> 
	    <th width="20%" height="23" align="center">시스템명</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	    <c:out value="${result.sysNm}"/>
	    </td>
	  </tr>  
	  <tr> 
	    <th width="20%" height="23" align="center">이력내용</th>
	    <td width="80%" nowrap>
	      <textarea name="histCn" class="textarea"  cols="40" rows="8"  style="width:450px;"><c:out value="${result.histCn}"/></textarea>
	    </td>
	  </tr>
	 <tr> 
	    <th width="20%" height="23" align="center">등록일자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.frstRegisterPnttm}"/>
	    </td>
	  </tr>
	  <c:if test="${result.atchFileId != ''}">
		  <tr> 
		    <th height="23"><spring:message code="sym.log.atchFileList" /></th>
		    <td colspan="6">
				<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${result.atchFileId}" />
				</c:import>
		    </td>
		  </tr>
	  </c:if>	
	</table>
	<table width="700" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr> 
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_update_sysHist()">수정</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>   
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_delete_sysHist()">삭제</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>   
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_sysHist()">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>   
	</tr>
	</table>
</form>
</body>
</html>