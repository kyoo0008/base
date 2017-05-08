<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>
<%@page import="egovframework.com.evt.service.ComtnschdulinfoVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmexVO"%>
<%@page import="egovframework.com.evt.service.ComtneventcnsrVO"%>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/web/smart_001/css"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/web/smart_001/image"/>
<c:set var="_PREFIX" value="/mng/evt"/>
<% 
 /**
  * @Class Name : ComtnschdulEventPop.jsp
  * @Description : 통합캘린더 설문조사 참여정보 보기
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2012.02.10   이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
  *
  *  @author 이호영
  *  @since 2012.02.10
  *  @version 1.0
  *  @see
  *   
  */
%>
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
<title>설문조사결과</title>
<style type="text/css">
	html{height:100%; }
</style>
</head>
<body style="height:100%;">
<div id="popsubboxtop">
	<h1>설문조사결과</h1>
	<div class="popsubboxclose"><a href="#" onclick="window.close(); return false;" title="팝업창닫기"><img src="${_IMG}/sub/common/popup3_close.gif" alt="닫기" /></a></div>	
</div>
<div id="popsubboxcon">
	<div id="popsubboxcon2">
		<div id="popsubboxcontxt">
			<!--팝업내용 시작-->

				<c:forEach var="result" items="${resultList}" varStatus="status">
			
			
				<c:choose>
				<c:when test="${result.qesitmTyCode eq '1'}">
				<!--객관식 결과 시작-->
				<table summary="설문조사결과" class="poll_result_t_j" >
				<caption>설문조사결과</caption>
				<colgroup><col style="width:100px;" /><col style="width:30px;" /><col style="width:280px;" /><col style="width:90px;" /></colgroup>
				<tr>
					<th scope="col">객관식문제</th>
					<td colspan="3" class="per_re"> <c:url value='${result.qesitmSj}'/></td>
				</tr>
				<tr>
					<th rowspan="4" scope="col">선택답안</th>
					<td class="poll_result_sub"><b><c:out value="${result.choiceCnsr}"/></b></td>
					<td class="per"><c:out value="${result.exCn}"/></td>
				</tr>

				</table>
				<!--객관식 결과 끝-->
				</c:when>
				<c:otherwise>
				<!--주관식 결과 시작-->
				<table summary="설문조사결과" class="poll_result_t_j" >
				<caption>설문조사결과 목록2</caption>
				<colgroup><col style="width:100px;" /><col style="width:70px;" /><col/></colgroup>
				<tr>
				<th scope="col">주관식문제</th>
				<td colspan="2" class="per_re"><c:url value='${result.qesitmSj}'/></tr>
				<tr>
				<th rowspan="4" scope="col">결과</th>
				<td class="poll_result_sub">입력답안</td>
				<td class="per_img">
					<!--설문조사 펼침 시작-->
					<ul>
						<li><c:out value="${result.essayCnsr}"/></li>
					</ul>
				</td>
				</tr>

				</table>
				<!--주관식 결과 끝-->
				</c:otherwise>
			</c:choose>
			
			<br/>
			</c:forEach>
		</div>
	</div>
</div>
</body>
</html>

