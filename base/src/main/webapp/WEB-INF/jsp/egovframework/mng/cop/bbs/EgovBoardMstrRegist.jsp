<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_MODE" value=""/>

<c:choose>
	<c:when test="${empty searchVO.bbsId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>

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


<script type="text/javascript" src="<c:url value='/js/egovframework/cop/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}
	
	function fn_egov_regist_brdMstr(){
		
		if($('#siteId').val() == '') {
			alert('<spring:message code="common.site" />를 선택하세요');
			return false;
		}
		
		if (!validateBoardMaster(document.boardMaster)){
			return false;
		}
		
		if($('#sourcId').val() == '') {
			alert('<spring:message code="cop.sourc" />를 선택하세요');
			return false;
		}
		
		if(!$.isNumeric($('#posblAtchFileSize').val())) {
   			alert("<spring:message code="cop.posblAtchFileSize" />은(는) 숫자만 입력하세요");
   			$('#posblAtchFileSize').focus();
			return false;
   		}
		
		if(!$.isNumeric($('#posblAtchFileNumber').val())) {
   			alert("<spring:message code="cop.posblAtchFileNumber" />은(는) 숫자만 입력하세요");
   			$('#posblAtchFileNumber').focus();
			return false;
   		}
		
		if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
			return false;					
		}
	}	
	
	function  isNumber(obj) 
	{ 
	   var  str  =  obj.value; 
	   if(str.length  ==  0) 
	      return  false; 
	   for(var  i=0;  i  <  str.length;  i++) 
	   { 
	      if(!('0'  <=  str.charAt(i)  &&  str.charAt(i)  <=  '9')) 
	         return  false; 
	   } 
	   
	   return  true; 
	} 
	
	/* ********************************************************
	* RADIO BOX VALUE FUNCTION
	******************************************************** */
	function fn_egov_RadioBoxValue(sbName)
	{
		var FLength = document.getElementsByName(sbName).length;
		var FValue = "";
		for(var i=0; i < FLength; i++)
		{
			if(document.getElementsByName(sbName)[i].checked == true){
				FValue = document.getElementsByName(sbName)[i].value;
			}
		}
		return FValue;
	}
	
	function fn_egov_selectSourc() {
		var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsSourcList.do?";
		url = url + "&selectMode=Y";
		
		var win = window.open(url ,'bbsSourc',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
		if(win != null) {
			win.focus();
		}
	}

	function fn_egov_updateSourc(id, nm, fileNm) {
		
		$('#sourcId').val(id);
		$('#sourcNm').text(nm);
		if(fileNm) {
			$('#sourcImage').attr('src', '${fileStoreSourcWebPathByPreFile}/' + fileNm);
		} else {
			$('#sourcImage').attr('src', '${_IMG}/board/no_img.gif');
		}
	}
	
	function fn_egov_selectTemplate() {
		var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsTemplateList.do?";
		url = url + "&selectMode=Y";
		
		var win = window.open(url ,'bbsTemplate',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
		if(win != null) {
			win.focus();
		}
	}

	function fn_egov_updateTemplate(id, nm, fileNm) {
		$('#tmplatId').val(id);
		$('#tmplatNm').text(nm);
		if(fileNm) {
			$('#tmplatImage').attr('src', '${fileStoreTemplateWebPathByPreFile}/' + fileNm);
		} else {
			$('#tmplatImage').attr('src', '${_IMG}/board/no_img.gif');
		}
	}

	function fnImagePreviewBefore(id) {
		if($('#' + tmplatImage).attr('src') != '${_IMG}/board/no_img.gif') {
			fnImagePreview($('#tmplatImage').attr('src'));
		} else {
			alert('이미지가 없습니다.');
		}
	}
</script>
<div id="cntnts">
		<c:choose>
			<c:when test="${_MODE eq 'REG' }">
				<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/cop/bbs/insertBBSMasterInf.do"/>
			</c:when>
			<c:otherwise>
				<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/cop/bbs/UpdateBBSMasterInf.do"/>
			</c:otherwise>
		</c:choose>
        <form:form commandName="boardMaster" name="boardMaster" action="${actionUrl}" method="post" onsubmit="return fn_egov_regist_brdMstr();">
	        
	        <form:hidden path="siteId"/>
    		<form:hidden path="sysTyCode"/>
    
	        <form:hidden path="bbsId"/>	  
	        <form:hidden path="tmplatId"/>   
	        <form:hidden path="sourcId"/>   
	        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	        
	        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
			<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
			<input name="selectMode" type="hidden" value="<c:out value="${searchVO.selectMode}"/>"/>
			
			<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
  			<input type="hidden" name="registSeCode" value="${searchVO.registSeCode}"/>

        <table class="chart2">
		<caption>메뉴 등록폼</caption>
		<colgroup>
			<col class="co1"/>
			<col class="co2"/>
		</colgroup>
			<tbody>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.bbsNm" />
                </th>
                <td>
                  <form:input path="bbsNm" size="60" cssClass="inp_long"/>
                  <br/><form:errors path="bbsNm" />
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.bbsAttrbCode" />
                </th>
                <td>
        	        <form:select path="bbsAttrbCode">
            	  		<form:option value='' label="--선택하세요--" />
        	      		<form:options items="${attrbList}" itemValue="code" itemLabel="codeNm"/>
              		</form:select>	    
        	  	    <br/><form:errors path="bbsAttrbCode" />
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.sourc" />
                </th>
                <td>     
              	<table>
              		<tr>
              			<td align="center">              				
           					<c:choose>
           						<c:when test="${not empty bbsSourcVO.prevewFileNm}">
           							<a href="#" onclick="fnImagePreviewBefore('sourcImage');return false;"><img id="sourcImage" src="${fileStoreSourcWebPathByPreFile}/${bbsSourcVO.prevewFileNm}" width="120" height="107"/></a>
           						</c:when>
           						<c:otherwise>
           							<a href="#" onclick="fnImagePreviewBefore('sourcImage');return false;"><img id="sourcImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
           						</c:otherwise>
           					</c:choose>              				
              			</td>
              		</tr>
              		<tr>
              			<td align="center"><div id="sourcNm"><c:out value="${bbsSourcVO.sourcNm}"/></div></td>
              		</tr>
              		<tr>
              			<td align="center"><a href="#" onclick="fn_egov_selectSourc(); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
              		</tr>
              	</table>  
              </td>     
              </tr>
              <tr>
                <th>
                  <spring:message code="cop.tmplat" />
                </th>
                <td>     
              	<table>
              		<tr>
              			<td align="center">              				
           					<c:choose>
           						<c:when test="${not empty bbsTmplatVO.prevewFileNm}">
           							<a href="#" onclick="fnImagePreviewBefore('tmplatImage');return false;"><img id="tmplatImage" src="${fileStoreTemplateWebPathByPreFile}/${bbsTmplatVO.prevewFileNm}" width="120" height="107"/></a>
           						</c:when>
           						<c:otherwise>
           							<a href="#" onclick="fnImagePreviewBefore('tmplatImage');return false;"><img id="tmplatImage" src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
           						</c:otherwise>
           					</c:choose>              				
              			</td>
              		</tr>
              		<tr>
              			<td align="center"><div id="tmplatNm"><c:out value="${bbsTmplatVO.tmplatNm}"/></div></td>
              		</tr>
              		<tr>
              			<td align="center"><a href="#" onclick="fn_egov_selectTemplate(); return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></td>
              		</tr>
              	</table>  
              </td>     
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.category.code" />
                </th>
                <td>
        	        <form:select path="ctgrymasterId">
            	  		<form:option value='' label="--없음--" />
        	      		<form:options items="${ctgrymasterList}" itemValue="ctgrymasterId" itemLabel="ctgrymasterNm"/>
              		</form:select>	    
        	  	    <br/><form:errors path="ctgrymasterId" />
                </td>         
              </tr>
             
              
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.replyPosblAt" />
                </th>
                <td>
          	     	<spring:message code="button.possible" /> : <form:radiobutton path="replyPosblAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.impossible" /> : <form:radiobutton path="replyPosblAt"  value="N"  />
                	<br/><form:errors path="replyPosblAt" />
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.author" />
                </th>
                <td>
					<spring:message code="cop.inqireAuthor" /> :
					<form:select path="inqireAuthor">
        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
              		</form:select>
                	<br/><form:errors path="inqireAuthor" />
                	
                	<spring:message code="cop.registAuthor" /> :
					<form:select path="registAuthor">
        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
              		</form:select>
                	<br/><form:errors path="registAuthor" />
                	
                	<spring:message code="cop.answerAuthor" /> :
					<form:select path="answerAuthor">
        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
              		</form:select>
                	<br/><form:errors path="answerAuthor" />
                </td>
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.fileAtchPosblAt" />
                </th>
                <td>
          	     	<spring:message code="button.possible" /> : <form:radiobutton path="fileAtchPosblAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.impossible" /> : <form:radiobutton path="fileAtchPosblAt"  value="N"  />
          	     	<br/><form:errors path="fileAtchPosblAt" />
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.posblAtchFileSize" />
                </th>
                <td>
                	<form:input path="posblAtchFileSize" size="10" cssClass="inp"/>(MByte)
		       		<div><form:errors path="posblAtchFileSize"/></div>
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.posblAtchFileNumber" />
                </th>
                <td>
                	<form:input path="posblAtchFileNumber" size="10" cssClass="inp"/>
		       		<div><form:errors path="posblAtchFileNumber"/></div>
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.commentUseAt" />
                </th>
                <td>
          	     	<spring:message code="button.yes" /> : <form:radiobutton path="commentUseAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="commentUseAt"  value="N"  />
          	     	<br/><form:errors path="commentUseAt" />
                </td>
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.othbcUseAt" />
                </th>
                <td>
          	     	<spring:message code="button.yes" /> : <form:radiobutton path="othbcUseAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="othbcUseAt"  value="N"  />
                	<br/><form:errors path="othbcUseAt" />
                </td>         
              </tr>
              <tr>
                <th>
                  <em>*</em> <spring:message code="cop.useAt" />
                </th>
                <td>
          	    	<spring:message code="button.use" /> : <form:radiobutton path="svcAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.notUsed" /> : <form:radiobutton path="svcAt"  value="N"  />
          	     	<br/><form:errors path="svcAt" />
                </td>         
              </tr>

            </tbody>
          </table>
  
  		<c:if test="${not empty searchVO.siteId }">
          <div class="btn_r">
            <input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
            <c:url var="listUrl" value='/mng/cop/bbs/SelectBBSMasterInfs.do'>
            	<c:param name="siteId" value="${searchVO.siteId}"/>
	       		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
            	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
				<c:param name="searchCnd" value="${searchVO.searchCnd}" />
				<c:param name="searchWrd" value="${searchVO.searchWrd}" />
				<c:param name="selectMode" value="${searchVO.selectMode}" />
				<c:param name="trgetId" value="${searchVO.trgetId}" />
				<c:param name="registSeCode" value="${searchVO.registSeCode}" />
            </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
		</c:if>
            
      </form:form>
      
      
</div>        

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
	</c:otherwise>
</c:choose>