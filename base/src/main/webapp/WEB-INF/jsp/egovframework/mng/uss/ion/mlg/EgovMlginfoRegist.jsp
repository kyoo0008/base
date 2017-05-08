<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="/template/manage/images"/>
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MILEAGE_MANAGE"/>
	<c:param name="depth1" value="MILEAGE_SETUP"/>
	<c:param name="title" value="마일리지설정"/>		
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="mlgInfo" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist(){

	var varFrom = document.getElementById("mlgInfo");
	if(confirm("<spring:message code="common.regist.msg" />")){
        if (!validateMlgInfo(varFrom)) {
                        
            return;
            
        } else {

        	if(!isNumber(varFrom.mlgScore)) {
        	    alert("점수는 숫자만 입력하세요");
        	    varFrom.mlgScore.focus();
        	    return ;
    	    }
        	
        	if(!isNumber(varFrom.lmttCo)) {
        	    alert("제한회수는 숫자만 입력하세요");
        	    varFrom.lmttCo.focus();
        	    return ;
    	    }
        	varFrom.submit();
            
        } 
    }
}

function  isNumber(obj) 
{ 
   var  str  =  obj.value; 
   if(str.length  ==  0) 
      return  false; 
   for(var  i=0;  i  <  str.length;  i++) 
   { 
      if(!('-' == str.charAt(i) || ('0'  <=  str.charAt(i)  &&  str.charAt(i)  <=  '9'))) 
         return  false; 
   } 
   
   return  true; 
} 

</script>
<div id="cntnts">
    
        <form:form commandName="mlgInfo" action="/mng/uss/ion/mlg/insertMlginfo.do" method="post"> 
        

        <fieldset>
          <table class="chart2" summary="등록페이지입니다.">
          <caption> </caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label id="idmlgCode" for="mlgCode">마일리지코드</label>
              </th>
              <td>
                <form:input path="mlgCode" size="70" maxlength="70" cssClass="inp_long" />
                <div><form:errors path="mlgCode"/></div>         
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label id="idmlgNm" for="mlgNm">마일리지명</label>
              </th>
              <td>
                <form:input path="mlgNm" size="70" maxlength="70" cssClass="inp_long" />
                <div><form:errors path="mlgNm"/></div>               
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label id="idmlgScore" for="mlgScore">점수</label>
              </th>
              <td>
                <form:input path="mlgScore" size="10" maxlength="10" cssClass="inp" />
                <div><form:errors path="mlgScore"/></div>         
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label id="idlmttCo" for="lmttCo">제한회수</label>
              </th>
              <td>
                <form:input path="lmttCo" size="10" maxlength="10" cssClass="inp" /> 
                <font color="red"> ※ 제한이 없을경우 0을 입력하세요  </font>   
                <div><form:errors path="lmttCo"/></div>                           
              </td>         
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<a href="javascript:fn_egov_regist()"><img src="${_IMG}/btn/btn_regist.gif" class="vMid" alt="등록" /></a>
            <c:url var="listUrl" value="/mng/uss/ion/mlg/selectMlginfoList.do">
            	<c:param name="searchCondition" value="${searchVO.searchCondition}" />
				<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
	      		<c:param name="pageIndex" value="${searchVO.pageIndex}" />
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
      </form:form>

</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	