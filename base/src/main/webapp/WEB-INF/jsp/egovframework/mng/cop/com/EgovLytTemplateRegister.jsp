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
<c:set var="_EDITOR_ID" value="nttCn"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${empty searchVO.lytTmplatId}">
		<c:set var="_MODE" value="REG"/>
		<c:set var="_ACTION" value="${_PREFIX}/insertLytTemplate.do"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
		<c:set var="_ACTION" value="${_PREFIX}/updateLytTemplate.do"/>
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
			<c:param name="menu" value="SYSTEM_MANAGE"/>
			<c:param name="depth1" value="TMPLAT_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="템플릿관리"/>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="lytTmplatVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_regist(){

	var form = document.lytTmplatVO;
    if (!validateLytTmplatVO(form)) {                    
        return false;        
    }
    
    if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
    	return false;
    }
}

function fn_egov_selectTemplate() {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectLytTemplateList.do?";
	url = url + "selectMode=Y";
	url = url + "&searchTmplatLcasCode=" + $('#tmplatLcasCode').val();
	url = url + "&searchTmplatMlsfcCode=" + $('#tmplatMlsfcCode').val();
	
	var win = window.open(url ,'lytTemplate',' scrollbars=yes, resizable=yes, left=0, top=0, width=880,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_updateTemplate(id, nm, fileNm) {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectLytCopyTemplate.do?";
	url += "lytTmplatId=" + id;
	
	$.getJSON(url, function(data) {
  		$('#cssSourc').val(data.cssSourc);
  		$('#scriptSourc').val(data.scriptSourc);
  		$('#mobileCssSourc').val(data.mobileCssSourc);
  		$('#mobileScriptSourc').val(data.mobileScriptSourc);
  		
	})
	.success(function() {})
	.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
	.complete(function() {});
}

function fnTabView(idx) {
	
	$('#tabLink01').removeClass('active');
	$('#tabLink02').removeClass('active');
	$('#tabLink' + idx).addClass('active');
	
	$('#tab01').hide();
	$('#tab02').hide();    		
	$('#tab' + idx).show();
	
}

$(document).ready( function() {
	
	$('#tab02').hide();
	$('#tmplatNm').focus();
	
});

</script>

<style type="text/css">
<!--
.conf_top{overflow:hidden;}
.tab_menu{right:0;z-index:1000;}
.tab_menu li{float:left;background:#f8f8f8;width:150px;height:30px;text-align:center;border:1px solid #ccc;}
.tab_menu li a{display:block;padding:8px 0px;height:30px;}
.tab_menu li a:hover, .tab_menu li a.active{background:url('${_IMG}/tab_over.gif') 0 0 repeat;padding:8px 0px;height:15px;font-weight:bold;color:#32688c;}
.cont{position:relative;width:100%;border-top:1px solid #ccc;padding:0px 0;z-index:1001;}
.cont table{width:100%;}
-->
</style>  

<div id="cntnts">
    
        <form:form commandName="lytTmplatVO" name="lytTmplatVO" action="${_ACTION}" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist();"> 
        <form:hidden path="lytTmplatId"/>
        <input name="selectMode" type="hidden" value="<c:out value='${searchVO.selectMode}'/>"/>
        <input name="searchTmplatLcasCode" type="hidden" value="<c:out value='${searchVO.searchTmplatLcasCode}'/>"/>
        <input name="searchTmplatMlsfcCode" type="hidden" value="<c:out value='${searchVO.searchTmplatMlsfcCode}'/>"/>
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
    
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
              <th><em>*</em> <label for="tmplatLcasCode"><spring:message code="cop.tmplatLcasCode" /></label></th>
              <td>
                <form:select path="tmplatLcasCode">
                  <form:option value="">선택</form:option>
                  <form:options items="${lcasList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="tmplatLcasCode"/></div>         
              </td>
            </tr>
            <tr>
              <th><em>*</em> <label for="tmplatMlsfcCode"><spring:message code="cop.tmplatMlsfcCode" /></label></th>
              <td>
                <form:select path="tmplatMlsfcCode">
                  <form:option value="">선택</form:option>
                  <form:options items="${mlsfcList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="tmplatMlsfcCode"/></div>         
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
					<c:when test="${not empty lytTmplatVO.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}${lytTmplatVO.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}${lytTmplatVO.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>
				</c:if>
              </td>
            </tr>
            <tr>
				<th><label>HTML</label></th>
				<td>
					<div class="conf_top">
				    	<ul class="tab_menu">
							<li><a href="#tab1" id="tabLink01" onclick="fnTabView('01');return false;" class="active">WEB</a></li>
						</ul>
					</div>
					
					<div id="tab01" class="cont">
						<table>
							<caption>등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<tr>
						              <th><label for="cssSourc">스타일시트</label></th>
						              <td>
						                <form:textarea path="cssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="cssSourc"/></div>         
						              </td>
						            </tr>
						            <tr>
						              <th><label for="scriptSourc">자바스크립트</label></th>
						              <td>
						                <form:textarea path="scriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="scriptSourc"/></div>         
						              </td>
						            </tr>
								</tbody>
						</table>
					</div>
					<div id="tab02" class="cont" style="visibility:hidden;height:0px;position:absolute;top:0;left:0;z-index:-1;">
						<table>
							<caption>등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<th><label for="mobileCssSourc">스타일시트</label></th>
						              <td>
						                <form:textarea path="mobileCssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="mobileCssSourc"/></div>         
						              </td>
						            </tr>
						            <tr>
						              <th><label for="mobileScriptSourc">자바스크립트</label></th>
						              <td>
						                <form:textarea path="mobileScriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="mobileScriptSourc"/></div>         
						              </td>
						            </tr>
								</tbody>
						</table>
					</div>
				</td>
			</tr>            
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }"/>
          	<c:url var="listUrl" value="/mng/cop/com/selectLytTemplateList.do">
          		<c:param name="selectMode" value="${searchVO.selectMode}" />
          		<c:param name="searchTmplatLcasCode" value="${searchVO.searchTmplatLcasCode}" />
          		<c:param name="searchTmplatMlsfcCode" value="${searchVO.searchTmplatMlsfcCode}" />
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