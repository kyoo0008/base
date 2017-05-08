<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_MODE" value=""/>

<c:choose>
	<c:when test="${empty searchVO.linkSiteId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="ETC_MANAGE"/>
	<c:param name="depth1" value="ETC_SITE"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="링크사이트관리"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="linkSite" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">
function fn_egov_regist(form){

	if(!validateLinkSite(document.linkSite)){ 			
		return false;
	}
	
	if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
		return false;					
	}
}

</script>
<div id="cntnts">
    	<c:choose>
    		<c:when test="${_MODE eq 'REG'}">
    			<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/sit/SiteInfoRegist.do"/>
    		</c:when>
			<c:otherwise>
				<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/sit/SiteInfoUpdt.do"/>
			</c:otherwise>
		</c:choose>
		
        <form:form commandName="linkSite" name="linkSite" action="${actionUrl}"  method="post" onsubmit="return fn_egov_regist();"> 
        
      	<form:hidden path="linkSiteId"/>
      	<form:hidden path="siteId"/>
      	<form:hidden path="sysTyCode"/>
      	
      	<input type="hidden" name="searchCondition" value="<c:out value="${searchVO.searchCondition}"/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
        <input type="hidden" name="searchCate" value="<c:out value='${searchVO.searchCate}'/>" />
        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
    

        <fieldset>
          <table class="chart2" summary="사이트 정보 등록페이지입니다.">
          <caption> </caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label for="linkSiteNm">사이트명</label>
              </th>
              <td>
                <form:input path="linkSiteNm" size="70" maxlength="50" cssClass="inp_long" />
                <div><form:errors path="linkSiteNm"/></div>         
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="linkSiteUrl">사이트 URL</label>
              </th>
              <td>
                <form:input path="linkSiteUrl" size="70" maxlength="100" cssClass="inp_long" />
                <div><form:errors path="linkSiteUrl"/></div>               
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="linkSiteDc">사이트 설명</label>
              </th>
              <td>
                <form:textarea path="linkSiteDc" cols="90" rows="10" cssClass="inp_long" />   
                <div><form:errors path="linkSiteDc"/></div>                                
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="siteThemaClCode">사이트주제분류</label>
              </th>
              <td>
                <form:select path="siteThemaClCode">
                  <form:option value="" label="-- 선택 --"/>
                  <form:options items="${resultList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="siteThemaClCode"/></div>
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="actvtyAt1">활성여부</label>
              </th>
              <td>
              	<spring:message code="button.yes" /> : <form:radiobutton path="actvtyAt"  value="Y" />&nbsp;
          	    <spring:message code="button.no" /> : <form:radiobutton path="actvtyAt"  value="N"  />       
              </td>         
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }" class="vMid" alt="등록" />
            <c:url var="listUrl" value="/mng/uss/ion/sit/SiteListInqire.do">
            	<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
            	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
				<c:if test="${not empty param.searchCate}"><c:param name="searchCate" value="${param.searchCate}" /></c:if>
	      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
      </form:form>

</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	