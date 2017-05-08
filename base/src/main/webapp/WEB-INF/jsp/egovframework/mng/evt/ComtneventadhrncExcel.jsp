<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:url var="imgPath" value="../../images/egovframework" />
<c:url var="jsPath" value="../../js/egovframework" />
<%
  response.setHeader("Content-Disposition", "attachment; filename=selectComtneventadhrncExcel.xls"); 
  response.setHeader("Content-Description", "JSP Generated Data"); 
%>
<html>
<head>
  <title>온라인 설문 및 이벤트</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css"> 
<!--
body {
  font-size:10px;
  margin-left: 0px; 
  font-family:돋움; 
}
 
img         {border:0;}
 
#page table.report {border-collapse: collapse; width:100%; padding:10px;margin-bottom:20px;border:1px solid #b6cce2;}
#page table.report caption {display:none;}
#page table.report th {background:#edf3fa;border-top:1px solid #5d99d2;border-bottom:1px solid #b6cce2; font-weight:normal;color:#5e8dbf;font-weight:bold; height:23px;text-align:center;border-right:1px solid #dfdfdf;}
#page table.report td {background:#ffffff;border-bottom:1px solid #dfdfdf; font-size:10px; height:18px;border-right:1px solid #dfdfdf;padding-left:5px;{text-align:center;}
#page table.report .name {text-align:center;  font-weight:bold;border-right:1px solid #b6cce2;}
#page table.report .num {text-align:center;}
#page table.report .end {border-right:0px;}
     
.tt         {font-size:9pt;COLOR: #575757;}
.align_left     {text-align:left;} 
.align_right    {text-align:right;}
 
-->
</style>

</head>
<body>

<div id="cntnts">
<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:set var="colspan" value="0"/>
	<c:forEach var="resultAnswer" items="${result.userAnswerList}" varStatus="status">
		<c:set var="colspan" value="${colspan + 1}"/>
	</c:forEach>
</c:forEach>

	<table class="chart_board">
		<thead>
			<tr>
				<th>구분</th>
				<th>아이디</th>
				<th>이름</th>
				<!-- <th colspan="${colspan}">제출답안</th>
				<th>점수</th> -->
				<th>제출일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listtd">
					<c:choose>
						<c:when test="${result.userTy eq 'S'}">학생</c:when>
						<c:when test="${result.userTy eq 'T'}">교사</c:when>
						<c:when test="${result.userTy eq 'P'}">일반</c:when>
						<c:when test="${result.userTy eq 'M'}">관리자</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose>
				</td>
				<td class="listtd"><c:out value="${result.userId}" /></td>
				<td class="listtd"><c:out value="${result.adhrncNm}" /></td>
				<!-- <c:forEach var="resultAnswer" items="${result.userAnswerList}" varStatus="status">
					<td class="listtd"><c:out value="${resultAnswer.userCnsr}" /></td>
					<c:set var="userScore" value="${userScore + resultAnswer.userScore}"/>
				</c:forEach>
				<td class="listtd"><c:out value="${userScore}" /></td>-->
				<td class="listtd"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
				<td colspan="30"><spring:message code="common.nodata.msg" /></td>
		</c:if>
		</tbody>
		</table>
	</div>
	
</body>
</html>