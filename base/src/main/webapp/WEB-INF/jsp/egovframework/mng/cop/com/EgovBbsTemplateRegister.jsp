<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:set var="_MODE" value=""/>
<c:set var="_PREFIX" value="${pageContext.request.contextPath}/mng/cop/com"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${empty searchVO.bbsTmplatId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertBbsTemplate.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateBbsTemplate.do"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="템플릿 선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="BOARD_MANAGE"/>
			<c:param name="depth1" value="TMPLAT_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="템플릿관리"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="bbsTmplatVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist(){

	var form = document.bbsTmplatVO;
    if (!validateBbsTmplatVO(form)) {                    
        return false;        
    }
    
    if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
}

function fn_egov_selectTemplate() {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsTemplateList.do?";
	url = url + "selectMode=Y";
	
	var win = window.open(url ,'bbsTemplate',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_updateTemplate(id, nm, fileNm) {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsCopyTemplate.do?";
	url += "bbsTmplatId=" + id;
	
	$.getJSON(url, function(data) {
  		$('#cssSourc').val(data.cssSourc);
  		$('#scriptSourc').val(data.scriptSourc);
	})
	.success(function() {})
	.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
	.complete(function() {});
}


</script>


<div id="cntnts">
    
        <form:form commandName="bbsTmplatVO" name="bbsTmplatVO" action="${_ACTION}" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist();"> 
        <form:hidden path="bbsTmplatId"/>
        <input name="selectMode" type="hidden" value="<c:out value='${searchVO.selectMode}'/>"/>
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
		<input name="searchTmplatSeCode" type="hidden" value="<c:out value='${searchVO.searchTmplatSeCode}'/>"/>
    
		<fieldset>
        <legend class="hdn">템플릿 입력 폼</legend>
        
        <a href="#" onclick="fn_egov_selectTemplate(); return false;"><img src="${_IMG}/btn/btn_temp_copy.gif" alt="템플릿 복사하기"/></a>
        
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
		  <caption> </caption>
          <colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label for="tmplatSeCode"><spring:message code="cop.tmplatSeCode" /></label></th>
              <td>
                <form:select path="tmplatSeCode">
                  <form:option value="">선택</form:option>
                  <form:options items="${codeList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="tmplatSeCode"/></div>          
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="tmplatNm"><spring:message code="cop.tmplatNm" /></label></th>
              <td>
                <form:input path="tmplatNm" size="70" maxlength="70" cssClass="inp_long" />
                <div><form:errors path="tmplatNm"/></div>         
              </td>         
            </tr>
            <tr>
              <th><label for="imagePrevewFileNm">미리보기이미지</label></th>
              <td>
              	<input type="file" name="imagePrevewFileNm" id="imagePrevewFileNm" title="미리보기이미지" class="input300 inp" >
              	<c:if test="${_MODE eq 'UPT'}">
              	<br><c:choose>
					<c:when test="${not empty bbsTmplatVO.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}${bbsTmplatVO.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}${bbsTmplatVO.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>
				</c:if>
              </td>
            </tr>
            <tr>
              <th><label for="cssSourc">스타일 소스</label></th>
              <td>
                <form:textarea path="cssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="cssSourc"/></div>         
              </td>
            </tr>
            <tr>
              <th><label for="scriptSourc">스크립트 소스</label></th>
              <td>
                <form:textarea path="scriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="scriptSourc"/></div>         
              </td>
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
          	<c:url var="listUrl" value="/mng/cop/com/selectBbsTemplateList.do">
          		<c:param name="searchTmplatSeCode" value="${searchVO.searchTmplatSeCode}" />
          		<c:param name="selectMode" value="${searchVO.selectMode}" />
		        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
				<c:param name="searchCnd" value="${searchVO.searchCnd}" />
				<c:param name="searchWrd" value="${searchVO.searchWrd}" />
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
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