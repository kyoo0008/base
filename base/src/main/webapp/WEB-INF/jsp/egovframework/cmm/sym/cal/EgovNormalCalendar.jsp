<%
 /**
  * @Class Name  : EgovNormalCalendar.jsp
  * @Description : EgovNormalCalendar 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>일반달력</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/default.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/page.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/template/manage/css/com.css"/>

<script type="text/javaScript" language="javascript">
<!--

/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
	var varParam        = window.dialogArguments;
	var varForm			= document.all["Form"];
	var pForm			= parent.document.all["pForm"];
	if (varParam.sDate) {
		var sDate = varParam.sDate;
		if(sDate.length == 10) {
			if(pForm.init.value != "OK") {
				pForm.init.value  = "OK";
				varForm.action      = "<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>";
				varForm.year.value  = sDate.substr(0,4);
				varForm.month.value = sDate.substr(5,2);
				varForm.submit();
			}
		}
	}
}

/* ********************************************************
 * 연월변경
 ******************************************************** */
function fnChangeCalendar(year, month){
	var varForm			= document.all["Form"];
	varForm.action      = "<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>";
	varForm.year.value  = year;
	varForm.month.value = month;
	varForm.submit();
}

/* ********************************************************
 * 결과연월일 반환 
 ******************************************************** */
function fnReturnDay(day){
	var retVal   = new Object();
	var sYear    = "0000"+document.Form.year.value;
	var sMonth   = "00"+document.Form.month.value;
	var sDay     = "00"+day;
	retVal.year  = sYear.substr(sYear.length-4,4);
	retVal.month = sMonth.substr(sMonth.length-2,2);
	retVal.day   = sDay.substr(sDay.length-2,2);
	retVal.sDate = retVal.year + retVal.month + retVal.day;
	retVal.vDate = retVal.year + "-" + retVal.month + "-" + retVal.day;
	parent.window.returnValue = retVal;
	parent.window.close();
}	
-->	
</script>
<title>Insert title here</title>
</head>

<!-- 
<body onLoad=javascript:fnInit();>
 -->

<body>

<div class="calendarNew">

<form name="Form" action ="<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>" method="post">
<input type="hidden" name="init" value="${init}" />
<input type="hidden" name="year" value="${resultList[0].year}" />
<input type="hidden" name="month" value="${resultList[0].month}" />
<input type="hidden" name="day" />

	<div class="calendarDate">
		<a href="javascript:fnChangeCalendar(${resultList[0].year-1},${resultList[0].month});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon_pre_year2.gif" alt="이전년도"/></a>
		<a href="javascript:fnChangeCalendar(${resultList[0].year},${resultList[0].month-1});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon_pre_month2.gif" alt="이전달"/></a>
		<span>${resultList[0].year}년${resultList[0].month}월</span>
		<a href="javascript:fnChangeCalendar(${resultList[0].year},${resultList[0].month+1});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon_aft_month2.gif" alt="다음달"/></a>
		<a href="javascript:fnChangeCalendar(${resultList[0].year+1},${resultList[0].month});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="${pageContext.request.contextPath}/template/common/images/egovframework/cmm/sym/cal/icon_aft_year2.gif" alt="다음년도"/></a>
	</div>
	
	<table class="calendarList" summary="달력화면">
	<caption>달력안내</caption>
	<colgroup><col style="width:15%;" /><col style="width:14%;" /><col style="width:14%;" /><col style="width:14%;" /><col style="width:14%;" /><col style="width:14%;" /><col style="width:15%;" /></colgroup>
	 <thead>
	  <tr>
	    <th scope="col">일</th>
	    <th scope="col">월</th>
	    <th scope="col">화</th>
	    <th scope="col">수</th>
	    <th scope="col">목</th>   
	    <th scope="col">금</th>
	    <th scope="col">토</th>         
	  </tr>
	 </thead>    
	 <tbody>
		<tr>
	 		<c:forEach var="result" items="${resultList}" varStatus="status">
	 		
				<c:choose>
				<c:when test='${result.day == ""}'>
			 		<c:choose>
			 		<c:when test='${result.weeks != 6}'>
						<td>&nbsp;</td>
					</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
				<c:choose>
			 		<c:when test='${result.day ne null}'>
			 		<c:choose>

			 			<c:when test='${result.restAt == "Y" }'>
						    <td onclick="javascript:fnReturnDay(${result.day});" style="cursor:pointer;cursor:hand;">
						    	<span class="caltxtred">${result.day}</span>
						    </td>
						</c:when>
						<c:otherwise>
						    <td onclick="javascript:fnReturnDay(${result.day});" style="cursor:pointer;cursor:hand;">
						    	${result.day}
						    </td>
						</c:otherwise>

					</c:choose>
					</c:when>
					<c:otherwise>
					<td>&nbsp;</td>
					</c:otherwise>
					</c:choose>
			 		<c:choose>
			 		<c:when test='${result.week == 7}'>
					    <c:out value="</tr>" escapeXml="false"/>
					    <c:out value="<tr>" escapeXml="false"/>
					</c:when>
					</c:choose>
				</c:otherwise>
				</c:choose>
				
			</c:forEach>	
		</tr>
	 </tbody>  
	</table>
</form>
</div>
</body>
</html>