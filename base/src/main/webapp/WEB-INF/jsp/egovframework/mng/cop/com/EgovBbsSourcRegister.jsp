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
	<c:when test="${empty searchVO.bbsSourcId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertBbsSourc.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateBbsSourc.do"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="소스 선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="BOARD_MANAGE"/>
			<c:param name="depth1" value="SOURC_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="소스 관리"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="bbsSourcVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist(){

	var form = document.bbsSourcVO;
    if (!validateBbsSourcVO(form)) {                    
        return false;        
    }
    
    if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
}

function fn_egov_loadOriginSource() {
	
	if(confirm('불러오시겠습니까?')) {
		
		var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsOriginSource.do";
		
		$.getJSON(url, function(data) {
			$('#listSourc').val(data.listSourc);
	  		$('#viewSourc').val(data.viewSourc);
	  		$('#formSourc').val(data.formSourc);
	  		$('#cmSourc').val(data.cmSourc);
		})
		.success(function() {})
		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
		.complete(function() {});
	}
}

function fn_egov_selectSourc() {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsSourcList.do?";
	url = url + "selectMode=Y";
	
	var win = window.open(url ,'bbsSourc',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_updateSourc(id, nm, fileNm) {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectBbsCopySource.do?";
	url += "bbsSourcId=" + id;
	
	$.getJSON(url, function(data) {
  		$('#listSourc').val(data.listSourc);
  		$('#viewSourc').val(data.viewSourc);
  		$('#formSourc').val(data.formSourc);
  		$('#cmSourc').val(data.cmSourc);
	})
	.success(function() {})
	.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
	.complete(function() {});
}


</script>


<div id="cntnts">
    
        <form:form commandName="bbsSourcVO" name="bbsSourcVO" action="${_ACTION}" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist();"> 
        <form:hidden path="bbsSourcId"/>
        <input name="selectMode" type="hidden" value="<c:out value='${searchVO.selectMode}'/>"/>
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
		<input name="searchSourcSeCode" type="hidden" value="<c:out value='${searchVO.searchSourcSeCode}'/>"/>
    
		<fieldset>
        <legend class="hdn">소스 입력 폼</legend>
        
        <a href="#" onclick="fn_egov_loadOriginSource(); return false;"><img src="${_IMG}/btn/btn_basic_sauce.gif" alt="기본소스 불러오기"/></a>
        <a href="#" onclick="fn_egov_selectSourc(); return false;"><img src="${_IMG}/btn/btn_sauce_copy.gif" alt="소스 복사하기"/></a>
        
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
		  <caption> </caption>
          <colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><em>*</em> <label for="sourcSeCode"><spring:message code="cop.sourcSeCode" /></label></th>
              <td>
                <form:select path="sourcSeCode">
                  <form:option value="">선택</form:option>
                  <form:options items="${codeList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="sourcSeCode"/></div>          
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="sourcNm"><spring:message code="cop.sourcNm" /></label></th>
              <td>
                <form:input path="sourcNm" size="70" maxlength="70" cssClass="inp_long" />
                <div><form:errors path="sourcNm"/></div>         
              </td>         
            </tr>
            <tr>
              <th><label for="imagePrevewFileNm">미리보기이미지</label></th>
              <td>
              	<input type="file" name="imagePrevewFileNm" id="imagePrevewFileNm" title="미리보기이미지" class="input300 inp" >
              	<c:if test="${_MODE eq 'UPT'}">
              	<br><c:choose>
					<c:when test="${not empty bbsSourcVO.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}${bbsSourcVO.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}${bbsSourcVO.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>
				</c:if>
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="listSourc"><spring:message code="cop.listSourc" /></label></th>
              <td>
                <form:textarea path="listSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="listSourc"/></div>         
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="viewSourc"><spring:message code="cop.viewSourc" /></label></th>
              <td>
                <form:textarea path="viewSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="viewSourc"/></div>         
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="formSourc"><spring:message code="cop.formSourc" /></label></th>
              <td>
                <form:textarea path="formSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="formSourc"/></div>         
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="cmSourc"><spring:message code="cop.cmSourc" /></label></th>
              <td>
                <form:textarea path="cmSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="cmSourc"/></div>         
              </td>
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
          	<c:url var="listUrl" value="/mng/cop/com/selectBbsSourcList.do">
          		<c:param name="searchSourcSeCode" value="${searchVO.searchSourcSeCode}" />
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