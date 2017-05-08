<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovSysHistRegist.jsp
  * @Description : 시스템 이력 정보 등록 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------     --------    ---------------------------
  * @ 2009.03.09   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.09
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
<script type="text/javascript" src=""<c:url value='/js/egovframework/sym/log/EgovSysLog.js' /> ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript">
	function fn_egov_regist_sysHist(){
		document.history.action = "<c:url value='/sym/log/InsertSysHistory.do'/>";
		document.history.submit();	
	}
	
	function fn_egov_select_sysHist(){
		document.history.action = "<c:url value='/sym/log/SelectSysHistoryList.do'/>";
		document.history.submit();	
	}	
</script>
<title>시스템 이력 등록</title>
</head>
<body>
<form:form commandName="history" name="history" method="post" enctype="multipart/form-data" >
<input name="pageIndex" type="hidden" value="1" />
<input type="hidden" name="posblAtchFileNumber" value="3" />

	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%" class="title_left">
	   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;시스템 이력등록</td>
	 </tr>
	</table>
	<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th height="23" class="required_text" ><spring:message code="sym.log.histSeCode" />
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td>
	   	<select name="histSeCode" class="select">
			   <option selected value=''>--선택하세요--</option>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
			</c:forEach>			   			   
		   </select>
		   <form:errors path="histSeCode" />
	    </td>
	  </tr> 		
	</resultMap>
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="sym.log.sysNm" />
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="sysNm" type="text" size="60" value="<c:out value='${history.sysNm}'/>"  maxlength="60" > 
	      <form:errors path="sysNm" />
	    </td>
	  </tr>  
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="sym.log.histCn" />
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap>
	      <textarea name="histCn" class="textarea"  cols="50" rows="8"  style="width:450px;" value="<c:out value='${history.histCn}'/>"></textarea>
	      <form:errors path="histCn" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23"><spring:message code="sym.log.atchFile" /></th>
	    <td width="80%" nowrap>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="UseTable">
			    <tr>
			        <td><input name="file_1" id="egovComFileUploader" type="file" /></td>
			    </tr>
			    <tr>
			        <td>
			        	<div id="egovComFileList"></div>
			        </td>
			    </tr>
   	        </table>		      
	    </td>
	  </tr>
     <script type="text/javascript">
	     var maxFileNum = document.history.posblAtchFileNumber.value;
	     if(maxFileNum==null || maxFileNum==""){
	    	 maxFileNum = 3;
	     }     
		 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );			
     </script>	  
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
      <a href="javascript:fn_egov_regist_sysHist()">등록</a> 
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
</form:form>
</body>
</html>