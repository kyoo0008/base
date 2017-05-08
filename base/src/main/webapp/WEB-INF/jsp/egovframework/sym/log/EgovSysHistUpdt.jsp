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
  * @Class Name : EgovSysHistUpdt.jsp
  * @Description : 시스템 이력 정보 수정 화면
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
	function fn_egov_update_sysHist(){
		document.history.action = "<c:url value='/sym/log/UpdateSysHistory.do'/>";
		document.history.submit();	
	}
	
	function fn_egov_select_sysHist(){
		document.history.action = "<c:url value='/sym/log/SelectSysHistoryList.do'/>";
		document.history.submit();	
	}	

	function fn_egov_check_file(flag) {
		if(flag=="Y") {
			document.getElementById('file_upload_posbl').style.display = "block";
			document.getElementById('file_upload_imposbl').style.display = "none";			
		} else {
			document.getElementById('file_upload_posbl').style.display = "none";
			document.getElementById('file_upload_imposbl').style.display = "block";
		}
	}	
</script>
<title>시스템 이력 수정</title>
</head>
<body>
<form:form commandName="history" name="history" method="post" enctype="multipart/form-data" >
<input name="pageIndex" type="hidden" value="1" />
<input type="hidden" name="posblAtchFileNumber" value="3" />
<input type="hidden" name="histId" value="<c:out value='${history.histId}'/>" />
<input type="hidden" name="returnUrl" value="<c:url value='/sym/log/ModifySysHistory.do'/>"/>

	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%" class="title_left">
	   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;시스템 이력수정</td>
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
				<option value='<c:out value="${result.code}"/>' <c:if test="${history.histSeCode == result.code}">selected</c:if>><c:out value="${result.codeNm}"/></option>
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
	      <textarea name="histCn" class="textarea"  cols="50" rows="8"  style="width:450px;"><c:out value='${history.histCn}'/></textarea>
	      <form:errors path="histCn" />
	    </td>
	  </tr>
	 <tr> 
	    <th width="20%" height="23" align="center">등록일자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${history.frstRegisterPnttm}"/>
	    </td>
	  </tr>
	  <c:if test="${history.atchFileId != ''}">
		  <tr> 
		    <th height="23"><spring:message code="sym.log.atchFileList" /></th>
		    <td colspan="6">
				<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${history.atchFileId}" />
				</c:import>
		    </td>
		  </tr>
	  </c:if>	
	  	<c:if test="${history.atchFileId == ''}">
	  		<input type="hidden" name="fileListCnt" value="0" />
	  	</c:if> 
		  <tr> 
		    <th width="20%"  height="23"><spring:message code="sym.log.atchFile" /></th>
		    <td width="80%" colspan="3">
		    <div id="file_upload_posbl"  style="display:none;" >	
	            <table width="680px" cellspacing="0" cellpadding="0" border="0" align="center" class="UseTable">
				    <tr>
				        <td><input name="file_1" id="egovComFileUploader" type="file" /></td>
				    </tr>
				    <tr>
				        <td>
				        	<div id="egovComFileList"></div>
				        </td>
				    </tr>
	   	        </table>		  
			</div>
			<div id="file_upload_imposbl"  style="display:none;" >
	            <table width="680px" cellspacing="0" cellpadding="0" border="0" align="center" class="UseTable">
				    <tr>
				        <td><spring:message code="common.imposbl.fileupload" /></td>
				    </tr>
	   	        </table>				
			</div>		    
		  </tr>
     <script type="text/javascript">
	    var existFileNum = document.history.fileListCnt.value;	    
		var maxFileNum = document.history.posblAtchFileNumber.value;

		if(existFileNum=="undefined" || existFileNum ==null){
			existFileNum = 0;
		}
		if(maxFileNum=="undefined" || maxFileNum ==null){
			maxFileNum = 0;
		}		
		var uploadableFileNum = maxFileNum - existFileNum;
		if(uploadableFileNum<0) {
			uploadableFileNum = 0;
		}				
		if(uploadableFileNum != 0){
			fn_egov_check_file('Y');
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		}else{
			fn_egov_check_file('N');
		}			
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
      <a href="javascript:fn_egov_update_sysHist()">수정</a> 
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