<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>
<%@page import="egovframework.com.evt.service.ComtnschdulinfoVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmexVO"%>
<%@page import="egovframework.com.evt.service.ComtneventcnsrVO"%>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/web/smart_001/css"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/web/smart_001/image"/>
<c:set var="_PREFIX" value="/evt"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="keywords" content="충남, 교육청, 연구정보원, 충남교육청 연구정보원" />
<meta name="subject" content="스마트 충남" />
<meta name="description" content="여기는 스마트 충남 포털 사이트입니다." />
<meta name="copyright" content="Copyright ⓒ 2011 SmartCNE. All Rights Reserved." />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="author" content="onmakers" />
<link rel="stylesheet" type="text/css" href="${_CSS}/styles.css" />
<script type="text/javascript" src="${_JS}/jquery/jquery-1.9.1.min.js"></script>
<title>설문조사 참여 결과</title>
<style type="text/css">
	html{height:100%; }
</style>
<script type="text/javascript" >
var nextExists = true;
var recordCountPerPage = 3;

function getCmyMainNavi(id) {
	
	$.getJSON('${_PREFIX}/selectCommunitySbjctList.do?qesitmId='+id, function(data) {
		document.getElementById(id).style.display="none";

		$.each(data, function(index, entry) {
			var html = "<tr>";
				html += "<td>"+entry.essayCnsr+"</td>";
				html += "</tr>";
			
	       	$('#evtTable_'+id).append(html);
	    });
	});
}

function getMoreClick(id) {
	if(nextExists) {
		getCmyMainNavi(id);
	}
}
</script>
</head>
<body style="height:100%;">


 <div id="popsubboxtop">
	<h1>설문조사결과</h1>
	<div class="popsubboxclose"><a href="#" onclick="window.close(); return false;" title="팝업창닫기"><img src="${_IMG}/sub/common/popup3_close.gif" alt="닫기" /></a></div>	
</div>

<div id="popsubboxcon">
	<div id="popsubboxcon2">
		<div id="popsubboxcontxt">
              <p class="poll_result_man_j">총참여인원 : <span class="total"><fmt:formatNumber value="${comtnschdulinfoVO.totalCo}" type="number"/></span> 명</p>
              <!-- 참여인원 끝-->
              <c:forEach var="question" items="${comtnschdulinfoVO.questionList}" varStatus="q">

				<c:choose>
				 <c:when test="${question.qesitmTyCode eq '1'}">
				
              <table summary="설문조사결과" class="poll_result_t_j" >
                <caption>설문조사결과</caption>
                <tr>
                  <th width="71" scope="col">문제<c:out value="${q.count}"/></th>
                  <td colspan="3" class="per_re">
                  <c:out value="${question.qesitmSj}"/>
                  	<c:if test="${question.qesitmCn ne null}">
					<br/> - <c:out value="${question.qesitmCn}"/>
					</c:if>
                  </td>
				</tr>
				<c:forEach var="example" items="${question.exampleList}" varStatus="e">
                <tr>
				<c:if test="${i eq 0}">
				<th rowspan="4" scope="col">결과</th>
				</c:if>
              <td width="146" class="poll_result_sub"><c:out value="${e.count}"/>. <c:out value="${example.exCn}"/></td>
              <td width="270"><c:out value="${example.userSta}"/></td>
              <td width="82" class="per"><fmt:formatNumber value="${example.qesitUserCo}" type="number"/>명 <fmt:formatNumber value="${example.qesitUserCo div comtnschdulinfoVO.totalCo}" type="percent" maxFractionDigits="1"/></td>
                </tr>
                </c:forEach>
              </table>
			</c:when>
			<c:otherwise>
			<table summary="설문조사결과" class="poll_result_t_j">
                <caption>설문조사결과</caption>
                <tr>
                  <th width="71" scope="col">문제<c:out value="${q.count}"/></th>
                  <td colspan="2" class="per_re"><c:out value="${question.qesitmSj}"/></td>
                </tr>

                <tr>
                  <td class="poll_result_sub">답안<c:out value="${a.count}"/></td>
                  <td class="per_img">
                  <table class="com_board_main" id="evtTable_<c:out value='${question.qesitmId}'/>" summary="설문조사주관식 목록">
					<caption>주관식 답안</caption>
					</table>
                  <p id="<c:out value="${question.qesitmId}"/>"><a style='cursor:pointer' onclick="getMoreClick('<c:out value="${question.qesitmId}"/>');"><img src='${_IMG}/sub/smartcn/poll_view.gif' alt='펼처보기' /></a></p>
                  </td>
                </tr>
              </table>
				</c:otherwise>
				</c:choose>
			</c:forEach>
            </div>
          </div>
</div>
</body>
</html>