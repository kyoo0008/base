<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="STAT_MANAGE"/>
	<c:param name="depth1" value="BBS_STAT"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="게시물통계"/>
</c:import>

<script type="text/javascript" src="${_C_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js"></script>
<script type="text/javaScript" language="javascript">
/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(pdKind){
	var fromDate = document.listForm.fromDate.value;
	var toDate = document.listForm.toDate.value;
	document.listForm.pdKind.value = pdKind;
	
	if (fromDate == "") {
		alert("기간 시작일자를 입력하세요");
		return;
	} else if (toDate == "") {
		alert("기간 종료일자를 입력하세요");
		return;
	}
	document.listForm.action="<c:url value="/mng/sts/selectBbsStats.do"/>";
   	document.listForm.submit();
}

/*********************************************************
 * Excel 처리 
 *********************************************************/
function fnExcel(){
	var fromDate = document.listForm.fromDate.value;
	var toDate = document.listForm.toDate.value;
	
	if (fromDate == "") {
		alert("기간 시작일자를 입력하세요");
		return;
	} else if (toDate == "") {
		alert("기간 종료일자를 입력하세요");
		return;
	}
	document.listForm.action="<c:url value="/mng/sts/selectBbsStatsExcel.do"/>";
   	document.listForm.submit();
}

/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

	if (document.listForm.fromDate.value != "" && document.listForm.toDate.value != "") {
		var fromDate = document.listForm.fromDate.value;
		var toDate = document.listForm.toDate.value;
		document.listForm.fDate.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
		document.listForm.tDate.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
	}
	
}

function getNextWeek(v,t){ 
	var str=new Array(); 
	var b=v.split("-");
	var c=new Date(b[0],b[1]-1,b[2]); 
	var d=c.valueOf()+1000*60*60*24*t;
	var e=new Date(d); 
	
	str[str.length]=e.getYear(); 
	str[str.length]=e.getMonth()+1; 
	str[str.length]=e.getDate(); 
	return str.join(""); 
}

window.onload=function() {
	fnInitAll();
}
</script>


<style type="text/css"> 
#cntnts .list li {display:inline-block; margin:0 15px; padding:2px;}
#cntnts .list li:hover {background:#efefef;}

table.chart { background:url('../images/page/board/bg_board_tit.gif') 0 0 repeat-x;width:100%;border-collapse:collapse;color:#666666;}
table.chart th{letter-spacing:-1.2px;line-height:16px;padding:3px 0;}
table.chart td {border: 1px solid #dfdfdf; padding:3px 5px; text-align:center;}
table.chart th {background:#f6f6f6; border:1px solid #DCDCDC;text-align:center;color:#515151;}
.w_sc {width:100%;overflow-x:auto;overflow-y:hidden;}

#cntnts a.slt {color:#6DB500; font-weight:bold;}
</style>


<div id="cntnts">

<form name="listForm" method="post">
<input type="hidden" name="pdKind" value='<c:out value="${statsVO.pdKind}"/>'/>
<input type="hidden" name="statsKind" value='<c:out value="${statsVO.statsKind}"/>'/>

	<table>
			<tr>
				<td>
				<c:if test="${USER_INFO.userSe > 10}">
				  <c:import url="/mng/sym/sit/selectCommonSiteList.do">
					<c:param name="initMode" value="SELECT_HIDE"/>
				  </c:import>
				</c:if>
				  <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
                  <input type="hidden" name="fromDate" value="${statsVO.fromDate}" size="10"/>
                  <input type="hidden" name="toDate" value="${statsVO.toDate}" size="10"/>
                  <input type="text" name="fDate" class="inp" value="" size="10" readonly="readonly" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.fromDate, document.listForm.fDate);" tabindex="1" />
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.fromDate, document.listForm.fDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a>
                  <input type="text" name="tDate" class="inp" value="" size="10" readonly="readonly" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.toDate, document.listForm.tDate);" tabindex="2" />
                  	<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.listForm, document.listForm.toDate, document.listForm.tDate);">
						<img src="${_C_IMG}/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a> 
				</td>
				<td>
					<ul class="list">
						<li style="float:left"><a href="#" onclick="fnSearch('D');return false;" <c:if test="${statsVO.pdKind eq 'D'}">class="slt"</c:if>>일별</a></li>
						<li style="float:left"><a href="#" onclick="fnSearch('M');return false;" <c:if test="${statsVO.pdKind eq 'M'}">class="slt"</c:if>>월별</a></li>
						<li style="float:left"><a href="#" onclick="fnSearch('Y');return false;" <c:if test="${statsVO.pdKind eq 'Y'}">class="slt"</c:if>>연도별</a></li>
						<li style="float:left"><a href="#" onclick="fnExcel();return false;" class="cho"><img src="${_IMG}/btn/xls.gif"/></a></li>
					</ul>
				</td>
			</tr>
	</table>
	
	
	<div class="w_sc">
	<table class="chart section">
		<colgroup>
			<col width="100px"/>
			<col width="100px"/>
			<col width="*"/>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
		</colgroup>
		<thead>
	      <tr>
	        <th class="first">사이트</th>
	        <th>구분</th>
	        <th>게시판</th>
	        <th>생성</th>
	        <th>조회</th>
	        <th>다운로드</th>
	      </tr> 
	      <c:forEach items="${scrinStats}" var="result" varStatus="status">
	      	<tr>
		      	<td>${result.siteNm}</td>
		      	<td>${result.gbNm }</td>
		      	<td>${result.bbsNm}</td>
		      	<td><font color="red"><b><fmt:formatNumber value="${result.creatCo}" type="number"/></b></font></td>
		      	<td><font color="#6DB500"><b><fmt:formatNumber value="${result.totInqireCo}" type="number"/></b></font></td>
		      	<td><font color="#2356b1"><b><fmt:formatNumber value="${result.dwldCo}" type="number"/></b></font></td>
	      	</tr>
	      </c:forEach>
	      <c:if test="${fn:length(scrinStats) == 0}">
			<tr>
				<td colspan="6" align="center" style="padding-top:5px;padding-bottom:5px;"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
	    </thead>
	    <tbody>
	    </tbody>
	</table>
	<br>
	<br>
	</div>
        
</form>



</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	