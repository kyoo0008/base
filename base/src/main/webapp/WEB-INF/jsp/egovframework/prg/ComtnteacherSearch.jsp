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
	<c:choose>
	<c:when test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
	<!--
	function selectTeacher(userId, userNm) {
		window.opener.updateTeacher(userId, userNm);
		//alert(userId);
	}
	//-->
	</script>
	</c:otherwise>
	</c:choose>
</head>

<body>

	 <c:if test="${SE_CODE >= 8 }">
		<div id="pop_page">
			<div class="pop_top">
				<h1>강사검색</h1>
			</div>

			<div class="pop_cont">
				
				<div id="pbbs_wrap">
					<div id="bbs_search">
						<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
						  <fieldset>
							<legend>검색조건입력폼</legend>
							<label for="ftext2" class="hdn">분류검색</label>
							<select name="searchCondition" id="ftext2">
								<option value="">검색항목</option>
								<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
								<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이름</option>								
					  	  	</select>
					  	  	<select name="searchCnd" id="ftext">
					  	  		<option value="OR" <c:if test="${searchVO.searchCnd == 'OR' or searchVO.searchCnd == ''}">selected="selected"</c:if>>연관검색</option>
								<option value="AND" <c:if test="${searchVO.searchCnd == 'AND'}">selected="selected"</c:if>>일치검색</option>
							</select>
							<label for="inp_text" class="hdn">검색어입력</label>
							<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp_s" id="inp_text" />
							<span class="bbtn_s"><input type="submit" title="검색(강사검색)" value="검색" /></span>
						  </fieldset>
						</form:form>
					  </div>

					<table class="list_table" summary="강사검색 결과  목록" >
						<caption>강사검색 결과  목록</caption>
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="id">${result.userId }</td>
								<td class="name">${result.userNm }</td>
								<td><button class="tBtn" onclick="selectTeacher('${result.userId }','${result.userNm }');">선택</button></td>
							</tr>							
						</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div id="paging">
					<c:url var="pageUrl" value="/prg/selectTeacherSearch.do">
					</c:url>			
					<c:if test="${not empty paginationInfo}">
						<ul>
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
						</ul>
					</c:if>
				</div>
				
			</div>
		</div>
	</c:if>
</body>
</html>
