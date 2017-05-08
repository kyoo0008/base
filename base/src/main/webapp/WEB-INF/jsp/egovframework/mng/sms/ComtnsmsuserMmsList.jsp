<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="egovframework.com.cmm.service.Globals"  %>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="HPG_IMG" value="/template/homepage/011/images"/>
<c:set var="_PREFIX" value="/mng/sms"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MMS 발송 회원 목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/default.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/admin_layout.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/admin_page.css'/>"/>
<style type="text/css">

		.sms_list{height:380px;padding-right:10px;overflow-y:scroll;}
		.btn_sms_cho{margin:5px;text-align:right;}
</style>
<script type="text/javaScript" language="javascript" defer="defer">

<c:if test='${not empty message}'>
alert("${message}");
</c:if>

	function mmsSend() {

		if(confirm("전송 하시겠습니까?\n\n내용 : \n"+parent.mmsForm.trnsmitCn.value)) {
			listForm.trnMsg.value = parent.mmsForm.trnsmitCn.value;
			listForm.action = 'insertMmsManage.do';
			listForm.submit();
			return true;
		}else{
			return false;
		}
	}

</script>
</head>
<body>

<div id="contents">
		<form:form name="listForm" action="${_PREFIX}/selectMmsuserList.do" method="post">
		<input type="hidden" name="trnTel" value="<%=Globals.PHONE%>"/>
		<input type="hidden" name="trnMsg" value=""/>
        <input name="pageIndex" type="hidden" value="<c:out value="${searchVO.pageIndex}" />"/>
		<div id="bbs_search">

			<fieldset>
				<legend></legend>
				<select name="userSeCode" id="ftext">
					<option value="" <c:if test="${empty searchVO.userSeCode or searchVO.userSeCode == ''}">selected="selected"</c:if>>::그룹전체::</option>
					<option value="02" <c:if test="${searchVO.userSeCode == '02'}">selected="selected"</c:if>>일반회원</option>
					<option value="04" <c:if test="${searchVO.userSeCode == '04'}">selected="selected"</c:if>>일반단체회원</option>
					<option value="03" <c:if test="${searchVO.userSeCode == '03'}">selected="selected"</c:if>>입주작가회원</option>
					<option value="05" <c:if test="${searchVO.userSeCode == '05'}">selected="selected"</c:if>>문화예술단체</option>
		  	  	</select>
		  	  	<select name="sexdstn" id="ftext">
					<option value="" <c:if test="${empty searchVO.sexdstn or searchVO.sexdstn == ''}">selected="selected"</c:if>>::성별전체::</option>
					<option value="1" <c:if test="${searchVO.sexdstn == '1'}">selected="selected"</c:if>>남자</option>
					<option value="2" <c:if test="${searchVO.sexdstn == '2'}">selected="selected"</c:if>>여자</option>
		  	  	</select>
				<input type="image" src="${MNG_IMG}/board/btn_search.gif" alt="검색" />
			</fieldset>
	</div>

	<div class="sms_list">
	
		<p class="total">총 검색된 회원수 ${paginationInfo.totalRecordCount}명 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
	
		<table class="chart_board" summary="">
			<caption></caption>
			<thead>
				<tr>
					<th class="first">번호</th>
					<th>아이디</th>
					<th>이름</th>	
					<th>핸드폰</th>		
					<th>가입일</th>		
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><fmt:formatNumber value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" type="number"/></td>
					<td><c:out value="${result.userId}" /></td>	
					<td><c:out value="${result.userNm}" /></td>
					<td><c:out value="${fn:replace(result.moblphonNo, '-','')}" /></td>
					<td><c:out value="${result.frstRegistPnttm}" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<div id="paging">
		<c:url var="pageUrl" value="${_PREFIX}/selectMmsuserList.do?">
			<c:if test="${not empty searchVO.userSeCode}"><c:param name="userSeCode" value="${searchVO.userSeCode}" /></c:if>
			<c:if test="${not empty searchVO.sexdstn}"><c:param name="sexdstn" value="${searchVO.sexdstn}" /></c:if>
			<c:if test="${not empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
			<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>

		<c:if test="${not empty paginationInfo}">
			<ul>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			</ul>
		</c:if>
		</div>
	</div>
	<div class="btn_sms_cho">
		선택된 그룹에게 일괄 발송 합니다.
	</div>
</form:form>
</div>
</body>
</html>