<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<%
  response.setHeader("Content-Disposition", "attachment; filename=member.xls"); 
  response.setHeader("Content-Description", "JSP Generated Data"); 
%>


<html>
<head>
  <title>회원목록</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css"> 
<!--
body {
  font-size:12px;
  margin-left: 0px; 
  font-family:돋움; 
}
 
img         {border:0;}
 
#page table.report {border-collapse: collapse; width:100%; padding:10px;margin-bottom:20px;border:1px solid #b6cce2;}
#page table.report caption {display:none;}
#page table.report th {background:#edf3fa;border-top:1px solid #5d99d2;border-bottom:1px solid #b6cce2; font-weight:normal;color:#5e8dbf;font-weight:bold; height:23px;text-align:center;border-right:1px solid #dfdfdf;}
#page table.report td {background:#ffffff;border-bottom:1px solid #dfdfdf; font-size:12px; height:21px;border-right:1px solid #dfdfdf;padding-left:5px;{text-align:center;}
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


		<table class="chart_board">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>휴대전화</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listtd"><c:out value="${status.count}" /></td>
				<td class="listtd"><c:out value="${result.userNm}" /></td>
				<td class="listtd"><c:out value="${result.userId}" /></td>
				<td class="listtd"><c:out value="${result.sexdstn}" /></td>
				<td class="listtd"><c:out value="${result.brthdy}" /></td>
				<td class="listtd"><c:out value="${result.emailAdres}" /></td>
				<td class="listtd"><c:out value="${result.moblphonNo}" /></td>
				<td class="listtd"><c:out value="${result.zip}" /></td>
				<td class="listtd"><c:out value="${result.adres}" /> <c:out value="${result.adresDetail}" /></td>
				<td class="listtd"><c:out value="${result.frstRegistPnttm}" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
	      <tr>
	      	<td class="listtd" colspan="11">
	        	<spring:message code="common.nodata.msg" />
	        </td>
	      </tr>
	    </c:if>

		</tbody>
		</table>
		

</body>
</html>