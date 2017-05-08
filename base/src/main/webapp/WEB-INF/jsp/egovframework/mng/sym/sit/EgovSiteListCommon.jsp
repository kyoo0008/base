<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<script type="text/javaScript">

function fnDelete(url) {
    if(confirm('<spring:message code="common.delete.msg" />')){
    	document.location.href = url;	
    }
}

$(document).ready( function() {
	
	$('#searchBlngEduInstCd').change( function() {
		$('#searchSchlGrdCd').val('').attr("selected", true);
		if($(this).val() == 'ZZZZZZZZZZZZZZZZZZZZ') {
			$('#searchSchlGrdCd').attr('disabled', true);
			$('#searchSchlGrdCd').change();
		} else {
			$('#searchSchlGrdCd').attr('disabled', false);
		}
		$("#siteId").empty().append("<option value=''>사이트선택(0)</option>");
	});
	
	$('#searchSchlGrdCd').change( function() {
		$("#siteId").empty().append("<option value=''>사이트선택(0)</option>");
		var searchBlngEduInstCd = "";//$('#searchBlngEduInstCd option:selected').val();
		var searchSchlGrdCd = $('#searchSchlGrdCd option:selected').val();
		if(searchSchlGrdCd == "") return;
		var url = "${pageContext.request.contextPath}/mng/sym/sit/selectSiteListForAjax.do?searchBlngEduInstCd=" + searchBlngEduInstCd + "&searchSchlGrdCd=" + searchSchlGrdCd;
		
		$.getJSON(url, function(data) {
			$("#siteId").empty().append("<option value=''>사이트선택(" + data.length + ")</option>");
			$.each(data, function(idx, site){
				$("#siteId").append("<option value='" + site.siteId + "' " + ((site.siteId == '${orgCodeVO.siteId}') ? 'selected=selected': '') + ">"+ site.siteNm + "</option>");
			});
		})
		.success(function() {})
		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
		.complete(function() {});
	});
	
	$('#chkSave').change( function() {
		var searchBlngEduInstCd = $('#searchBlngEduInstCd option:selected').val();
		var searchSchlGrdCd = $('#searchSchlGrdCd option:selected').val();
		var siteId = $('#siteId option:selected').val();
		var saveAt = ($('#chkSave').is(":checked") ? $('#chkSave').val() : "N");
		
		if($('#siteId option:selected').val() == "" && saveAt == "Y") {
			alert("선택된 사이트가 없습니다.");
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/mng/sym/sit/saveSiteInfoForAjax.do?searchBlngEduInstCd=" + searchBlngEduInstCd + "&searchSchlGrdCd=" + searchSchlGrdCd + "&siteId=" + siteId + "&saveAt=" + saveAt;
		
		$.getJSON(url, function(data) {
			if(data.saveAt == 'Y') {
				$('#searchBlngEduInstCd').attr('disabled', true);
				$('#searchSchlGrdCd').attr('disabled', true);
				$('#siteId').attr('disabled', true);
			} else {
				$('#searchBlngEduInstCd').attr('disabled', false);
				if($('#searchBlngEduInstCd option:selected').val() != 'ZZZZZZZZZZZZZZZZZZZZ') {
					$('#searchSchlGrdCd').attr('disabled', false);
				}
				$('#siteId').attr('disabled', false);
			}
		})
		.success(function() {})
		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
		.complete(function() {});
	});
		
	$('#btnSiteSearch').click( function() {
		/*
		if($('#siteId option:selected').val() == "") {
			alert("선택된 사이트가 없습니다.");
			return false;
		}
		*/
	});
	
	/*
	$('#searchBlngEduInstCd').change();	
	if($('#searchBlngEduInstCd option:selected').val() != 'ZZZZZZZZZZZZZZZZZZZZ') {
		$('#searchSchlGrdCd').change();
	}
	*/
	$('#searchSchlGrdCd').change();
	
	<c:if test="${orgCodeVO.initMode ne 'SELECT' }">
		if('${orgCodeVO.saveAt}' == 'Y') {
			$('#chkSave').attr("checked", true);
			
			$('#searchBlngEduInstCd').attr('disabled', true);
			$('#searchSchlGrdCd').attr('disabled', true);
			$('#siteId').attr('disabled', true);
		}
	</c:if>
});
</script>


		<select id="searchBlngEduInstCd" name="searchBlngEduInstCd" style="display:none">
			<option value="">지역별</option>
			<c:forEach var="result" items="${areaList}" varStatus="status">
				<option value="${result.orgCd}" <c:if test="${result.orgCd eq orgCodeVO.searchBlngEduInstCd}">selected="selected"</c:if> >${result.schlShrNm}</option>
			</c:forEach>
			<option value="ZZZZZZZZZZZZZZZZZZZZ" <c:if test="${'ZZZZZZZZZZZZZZZZZZZZ' eq orgCodeVO.searchBlngEduInstCd}">selected="selected"</c:if>>기타</option>
		</select>
		
		<select name="searchSchlGrdCd" id="searchSchlGrdCd">
			  <%-- <option value="">급별</option> --%>
			  <c:forEach var="result" items="${schlGrdList}" varStatus="status">
	  		  	<option value="${result.code}" <c:if test="${orgCodeVO.schlGrdCd eq result.code}">selected="selected"</c:if> ><c:out value="${result.codeNm}"/></option>
	  		  </c:forEach>
	  	</select>
	  	<select id="siteId" name="siteId" class="inp_s">
	  		<option value=''>사이트선택(0)</option>
		</select>
		<c:if test="${orgCodeVO.initMode ne 'SELECT' }">
			<input type="checkbox" id="chkSave" name="chkSave" value="Y"/><label for="chkSave" style="color:#3268c8;font-size:11px;font-weight:bold">저장</label>
			<c:if test="${orgCodeVO.initMode ne 'SELECT_HIDE' }">
				<input id="btnSiteSearch" name="btnSiteSearch" type="image" src="${_IMG}/board/btn_search2.gif" alt="검색" />
			</c:if>
		</c:if>
	