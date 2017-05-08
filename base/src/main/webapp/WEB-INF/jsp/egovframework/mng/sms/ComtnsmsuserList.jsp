<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="HPG_IMG" value="/template/homepage/011/images"/>
<c:set var="_PREFIX" value="/mng/sms"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SMS발송 회원 목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/default.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/admin_layout.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/template/manage/css/admin_page.css'/>"/>
<style type="text/css">

		.sms_list{height:380px;padding-right:10px;overflow-y:scroll;}
		.btn_sms_cho{margin:5px;text-align:right;}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
<c:if test='${not empty message}'>
alert("${message}");
</c:if>

function fnCheckAll() {
	f = document.listForm;

	if ( f.checkAll.checked == true ) {
		f.checkPhone.checked = true;
		for ( i = 0; i < f.checkPhone.length; i++ ){
			f.checkPhone[i].checked = true;
		}
	}else {
		f.checkPhone.checked = false;
		for ( i = 0; i < f.checkPhone.length; i++ ) {
			f.checkPhone[i].checked = false;
		}
	}
}

function fncManageChecked() {
	var checkPhone = document.listForm.checkPhone; 
	var resultCheck = false;
    var checkedCount = 0;

    if(checkPhone) {
        if(checkPhone.length > 1) {
            for(var i=0; i<checkPhone.length; i++) {
                if(checkPhone[i].checked) {
                	checkedCount++;
                    parent.addPhone(checkPhone[i].value);
                }
                
            }
            if(checkedCount > 0) 
            	return true;
            else {
                alert("선택된  항목이 없습니다.");
                return false;
            }
        } else {
        	 if(document.listForm.checkPhone.checked == false) {
                alert("선택 항목이 없습니다.");
                return false;
            }
            else {
                parent.addPhone(checkPhone.value);
                return true;
            }
        } 
    } else {
        alert("조회된 결과가 없습니다.");
        return false;
    }
}
-->
</script>

</head>
<body>

<div id="contents">
		<form:form name="listForm" action="${_PREFIX}/selectSmsuserList.do" method="post">
        <input name="pageIndex" type="hidden" value="<c:out value="${searchVO.pageIndex}" />"/>
		<div id="bbs_search">

			<fieldset>
				<legend></legend>
				<select name="searchSe" id="ftext">
					<option value="" <c:if test="${empty searchVO.searchSe}">selected="selected"</c:if>>전체</option>
					<option value="02" <c:if test="${searchVO.searchSe == '02'}">selected="selected"</c:if>>일반회원</option>
					<option value="04" <c:if test="${searchVO.searchSe == '04'}">selected="selected"</c:if>>일반단체회원</option>
					<option value="03" <c:if test="${searchVO.searchSe == '03'}">selected="selected"</c:if>>입주작가회원</option>
					<option value="05" <c:if test="${searchVO.searchSe == '05'}">selected="selected"</c:if>>문화예술단체</option>
		  	  	</select>
				<select name="searchCondition" id="ftext">
					<option value="0" <c:if test="${searchVO.searchCondition == '0'}">selected="selected"</c:if>>아이디</option>
					<option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>이름</option>
					<option value="2" <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>핸드폰</option>
		  	  	</select>
		  	  	<select name="searchCnd" id="ftext">
					<option value="OR" <c:if test="${searchVO.searchCnd == 'OR' or searchVO.searchCnd == ''}">selected="selected"</c:if>>연관검색</option>
					<option value="AND" <c:if test="${searchVO.searchCnd == 'AND'}">selected="selected"</c:if>>일치검색</option>
		  	  	</select>
				<input type="text" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" class="inp" id="inp_text" />
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
					<th><input name="checkAll" type="checkbox" title="Check All" onclick="javascript:fnCheckAll();"/></th>
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
					<td><input type="checkbox" name="checkPhone" value="<c:out value="${fn:replace(result.moblphonNo, '-','')}" />" /></td>
					<td><c:out value="${result.userId}" /></td>	
					<td><c:out value="${result.userNm}" /></td>
					<td><c:out value="${fn:replace(result.moblphonNo, '-','')}" /></td>
					<td><c:out value="${result.frstRegistPnttm}" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<div id="paging">
		<c:url var="pageUrl" value="${_PREFIX}/selectSmsuserList.do?">
			<c:if test="${not empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
			<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
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
		<a href="#" onclick="fncManageChecked();return false;"><img src="${MNG_IMG}/sms/btn_choice.gif" alt="선택" /></a>
	</div>
</form:form>
</div>
</body>
</html>