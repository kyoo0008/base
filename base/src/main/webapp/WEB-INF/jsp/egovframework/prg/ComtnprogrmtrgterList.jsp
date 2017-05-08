<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>	 
	<title>체험프로그램 신청자</title>

<script type="text/javascript">
<!--
$(document).ready(function() {
		
	$(".status").css({"position":"absolute","top":"0","right":"0"});
	
});

function changeComplAt(obj, userId, prgId) {
	var targetUrl = obj.href;
	var complAt = $(obj).parent().parent().children(".complAt").val();
	var status = $(obj).parent().parent().children(".status");
	
	$.ajax({
		url:targetUrl,			
		type:"POST",
		data:{"prgId":prgId,"userId":userId,"complAt":complAt},
		success:function(data) {
			$(status).show().text("");
			if($.trim(data) == "Y") {
				$(status).css({"color":"blue"});				
				$(status).text("수료처리").fadeOut(2000,0);				
			}else {
				$(status).css({"color":"gray"});
				$(status).text("미수료처리").fadeOut(2000,0);
			}
		}
	});
	return false;
}
 // -->
</script>
</head>
<body>

<div id="pop_page">
	<div class="pop_top">
		<h1>체험프로그램 신청자</h1>
	</div>

	<div class="pop_cont">
		
		<div id="pbbs_wrap">
			
			<table class="list_table" summary="체험프로그램 신청자 목록" >
			<thead>
				<tr>
					<th>번호</th>
					<th>학교명</th>
					<th>학년</th>
					<th>반</th>				
					<th>신청자명</th>
					<th>보고서</th>
					<th>수료처리</th>						
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
					<td><c:out value="${result.schulNm}"/></td>
					<td><c:out value="${result.grade}"/></td>
					<td><c:out value="${result.gradeClas}"/></td>				
					<td><c:out value="${result.adhrncNm}"/></td>
					<td>
						<c:url var="viewUrl" value="/prg/selectComtnprogrmtrgter.do">
							<c:param name="prgId" value="${result.prgId }"/>
							<c:param name="userId" value="${result.userId }"/>
						</c:url>	
						<span class="btn_em"><a href="${viewUrl }">보기</a></span>
					</td>
					<td>
						<div style="position:relative; width:100%;">
							<select name="complAt" class="complAt" title="수료 미수료 선택" class="vMid">
								<option value="N" ${result.complAt eq "N"?"selected='selected'":"" }>미수료</option>
								<option value="Y" ${result.complAt eq "Y"?"selected='selected'":"" }>수료</option>
							</select>
							<c:url var="acceptUrl" value="/prg/changeCompltAt.do"/>
							<span class="bbtn_sm"><a href="${acceptUrl }" class="complAtBtn" onclick="return changeComplAt(this, '${result.userId}','${result.prgId}');">적용</a></span>
							<span class="status"></span>
						</div>
					</td>						
				</tr>
				</c:forEach>
				<c:if test="${empty resultList }">
				<tr>
					<td colspan="10">신청자가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
			</table>
		
			<div id="paging">
				<c:url var="pageUrl" value="/prg/ComtnprogrmList.do"/>	
				<ul>
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
				</ul>
			</div>
			
			<div id="bbs_search">
				<form:form commandName="searchVO" name="listForm" id="listForm" method="post">								
					<fieldset>
						<legend>검색조건입력폼</legend>
						<input type="hidden" name="trgterId" />						
						<label class="hdn" for="ftext">분류</label>
						<select id="ftext" name="searchCondition">
						  <option value="0">학교명</option>
						  <option value="1">이름</option>
						</select>
						<label class="hdn" for="inp_text">검색어입력</label>
						<input type="text" id="inp_text" class="inp_s" value="" name="searchKeyword" />
						<span class="bbtn_s"><input type="submit" title="검색(체험프로그램게시물 내)" value="검색" /></span>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
