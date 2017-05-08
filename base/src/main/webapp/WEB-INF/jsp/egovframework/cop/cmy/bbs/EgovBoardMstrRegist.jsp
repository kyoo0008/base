<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_MODE" value=""/>

<c:choose>
	<c:when test="${empty searchVO.bbsId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return false;
		}
		
		/*
		if(!$.isNumeric($('#posblAtchFileSize').val())) {
   			alert("<spring:message code="cop.posblAtchFileSize" />은(는) 숫자만 입력하세요");
   			$('#posblAtchFileSize').focus();
			return false;
   		}
		*/
		if(!$.isNumeric($('#posblAtchFileNumber').val())) {
   			alert("<spring:message code="cop.posblAtchFileNumber" />은(는) 숫자만 입력하세요");
   			$('#posblAtchFileNumber').focus();
			return false;
   		}
		
		
		if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
			return false;					
		}
	}

</script>

<div class="cm_sub_box">
	<c:choose>
	<c:when test="_MODE eq 'REG'">
		<h2>메뉴 등록</h2>
		<c:url var="actionUrl" value="/cop/cmy/bbs/insertBBSMasterInf.do"/>
	</c:when>
	<c:otherwise>
		<h2>메뉴 수정</h2>
		<c:url var="actionUrl" value="/cop/cmy/bbs/updateBBSMasterInf.do"/>
	</c:otherwise>
	</c:choose>
	
	<div class="cm_sub_cont">
        <form:form commandName="boardMaster" name="boardMaster" method="post" action="${actionUrl}" onsubmit="return fn_egov_regist_brdMstr(this);">
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="bbsId" type="hidden" value="<c:out value='${boardMaster.bbsId}'/>" />
        <input name="trgetId" type="hidden" value="<c:out value='${searchVO.trgetId}'/>"/>
        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>

        <table  class="cm_chart" summary="메뉴 <c:out value="${_MODE eq 'REG' ? '등록' : '수정'}"/>">
			<caption>메뉴 <c:out value="${_MODE eq 'REG' ? '등록' : '수정'}"/></caption>
			<colgroup>
				<col width="30%" />
				<col width="70%" />
			</colgroup>
			<tbody>
              <tr>
                <th><label for="bbsNm"><spring:message code="cop.bbsNm" /></label></th>
                <td>
                  <form:input path="bbsNm" size="60" maxlength="50" cssClass="inp wid75"/>
                  <br/><form:errors path="bbsNm" />
                </td>         
              </tr>
              <tr>
              	<th><label for="bbsAttrbCode"><spring:message code="cop.bbsAttrbCode" /></label></th>
               	<td>
        	        <form:select path="bbsAttrbCode">
            	  		<form:option value='' label="--선택하세요--" />
        	      		<form:options items="${attrbList}" itemValue="code" itemLabel="codeNm"/>
              		</form:select>	    
        	  	    <br/><form:errors path="bbsAttrbCode" />
                </td>         
              </tr>
              <tr style="display:none;">
              	<th><label for="tmplatId"><spring:message code="cop.tmplat" /></label></th>
                <td>
        	        <form:select path="tmplatId">
        	      		<form:options items="${tmplatList}" itemValue="tmplatId" itemLabel="tmplatNm"/>
              		</form:select>	    
        	  	    <br/><form:errors path="tmplatId" />
                </td>         
              </tr>

              <!-- 
              <tr>
              	<th><label for="ctgrymasterId"><spring:message code="cop.category.code" /></label></th>
                <td>
        	        <form:select path="ctgrymasterId">
            	  		<form:option value='' label="--없음--" />
        	      		<form:options items="${ctgrymasterList}" itemValue="ctgrymasterId" itemLabel="ctgrymasterNm"/>
              		</form:select>	    
        	  	    <br/><form:errors path="ctgrymasterId" />
                </td>         
              </tr>
               -->
              <tr>
              	<th><spring:message code="cop.replyPosblAt" /></th>
                <td>
          	     	<form:radiobutton path="replyPosblAt" value="Y" /><label for="replyPosblAt1"><spring:message code="button.possible" /></label>
          	     	<form:radiobutton path="replyPosblAt" value="N" /><label for="replyPosblAt2"><spring:message code="button.impossible" /></label>
                	<br/><form:errors path="replyPosblAt" />
                </td>         
              </tr>
              <tr>
                <th><spring:message code="cop.author" /></th>
                <td>
                	<div class="cm_key">
						<label for="inqireAuthor"> <spring:message code="cop.inqireAuthor" /> :</label> 
						<form:select path="inqireAuthor" cssClass="sel85">
	        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
	              		</form:select>
	                	<form:errors path="inqireAuthor" />
	                	
	                	<label for="registAuthor"> <spring:message code="cop.registAuthor" /> :</label> 
						<form:select path="registAuthor" cssClass="sel85">
	        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
	              		</form:select>
	                	<form:errors path="registAuthor" />
	                	
	                	<label for="answerAuthor"> <spring:message code="cop.answerAuthor" /> :</label> 
						<form:select path="answerAuthor" cssClass="sel85">
	        	      		<form:options items="${authList}" itemValue="authorCode" itemLabel="authorNm"/>
	              		</form:select>
	                	<form:errors path="answerAuthor" />
                	</div>
                </td>
              </tr>
              <tr>
                <th><spring:message code="cop.fileAtchPosblAt" /></th>
                <td>
          	     	<form:radiobutton path="fileAtchPosblAt"  value="Y" /><label for="fileAtchPosblAt1"><spring:message code="button.possible" /></label>
          	     	<form:radiobutton path="fileAtchPosblAt"  value="N" /><label for="fileAtchPosblAt2"><spring:message code="button.impossible" /></label> 
          	     	<br/><form:errors path="fileAtchPosblAt" />
                </td>         
              </tr>
              <!-- 
              <tr>
                <th><label for="posblAtchFileSize"><spring:message code="cop.posblAtchFileSize" /></label></th>
                <td>
                	<form:input path="posblAtchFileSize" size="10" cssClass="inp"/>(MByte)
		       		<div><form:errors path="posblAtchFileSize"/></div>
                </td>         
              </tr>
               -->
              <tr>
                <th><label for="posblAtchFileNumber"><spring:message code="cop.posblAtchFileNumber" /></label></th>
                <td>
                	<form:input path="posblAtchFileNumber" size="10" cssClass="inp"/>
		       		<div><form:errors path="posblAtchFileNumber"/></div>
                </td>         
              </tr>
              <tr>
                <th><spring:message code="cop.commentUseAt" /></th>
                <td>
          	     	<form:radiobutton path="commentUseAt" value="Y" /><label for="commentUseAt1"><spring:message code="button.possible" /></label>
          	     	<form:radiobutton path="commentUseAt" value="N" /><label for="commentUseAt2"><spring:message code="button.impossible" /></label>
          	     	<br/><form:errors path="commentUseAt" />
                </td>
              </tr>
              <tr>
                <th><spring:message code="cop.othbcUseAt" /></th>
                <td>
          	     	<form:radiobutton path="othbcUseAt"  value="Y" /><label for="othbcUseAt1"><spring:message code="button.possible" /></label>
          	     	<form:radiobutton path="othbcUseAt"  value="N" /><label for="othbcUseAt2"><spring:message code="button.impossible" /></label>
                	<br/><form:errors path="othbcUseAt" />
                </td>         
              </tr>
              <tr>
                <th><spring:message code="cop.main.publicAt" /></th>
                <td>
          	     	<form:radiobutton path="mainOutptAt" value="Y" /><label for="mainOutptAt1"><spring:message code="button.yes" /></label>
          	     	<form:radiobutton path="mainOutptAt" value="N" /><label for="mainOutptAt2"><spring:message code="button.no" /></label>
                	<br/><form:errors path="mainOutptAt" />
                </td>         
              </tr>
              <tr>
                <th><spring:message code="cop.useAt" /></th>
                <td>
          	    	<form:radiobutton path="svcAt" value="Y" /><label for="svcAt1"><spring:message code="button.use" /></label>
          	     	<form:radiobutton path="svcAt" value="N" /><label for="svcAt2"><spring:message code="button.notUsed" /></label>
          	     	<br/><form:errors path="svcAt" />
                </td>         
              </tr>

            </tbody>
          </table>
  
  		  <div class="btn_c">
			<span  class="btn"><button type="submit">${_MODE eq 'REG' ? '등록' : '수정' }</button></span>
			<c:url var="listUrl" value="${_PREFIX}/selectCmmntyMasterInfs.do">
				<c:param name="trgetId" value="${searchVO.trgetId}"/>
				<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}"/></c:if>
				<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}"/></c:if>
				<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}"/></c:if>
			</c:url>
			<span class="btn2"><button type="button" onclick="location.href='<c:out value='${listUrl}'/>'">취소</button></span>
		  </div>
		</form:form>
            
	</div>
</div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>