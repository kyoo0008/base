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
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_PREFIX" value="/evt"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="keywords" content="<c:out value="${siteInfo.siteNm}"/>" />
<meta name="subject" content="<c:out value="${siteInfo.siteNm}"/>" />
<meta name="description" content="여기는 <c:out value="${siteInfo.siteNm}"/> 사이트입니다." />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="author" content="onmakers" />
<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
<title><c:out value='${comtnschdulinfoVO.schdulNm}'/></title>

	<script type="text/javascript">
	  function checkForm() {
		  var msg = "";
		  var form = document.forms.onlineEventCommand;
	
		  var essayAnswerList = document.getElementsByName("essayAnswerList");
		  
		  var typeList = document.getElementsByName("typeList");	  
		  for(var i=0; i<typeList.length; i++) {
			  if(typeList[i].value == "1") {
				  if(!radioCheck(document.getElementsByName("choiceAnswer_" + (i+1)))) {
				  	alert((i+1) + "번 문제의 정답을 선택하세요");
				  	return false;
				  }
			  } 
		  }

		  for(var i=0; i<essayAnswerList.length; i++) {
			  if(essayAnswerList[i].value == "") {
				  alert("주관식 항목을 입력하세요");
				  return false;
			  } 
		  }
		  <c:choose>
			<c:when test="${comtnschdulinfoVO.schdulClCode eq '2'}">
			msg = "[${comtnschdulinfoVO.schdulNm}] 이벤트에 참여 하시겠습니까?";
			</c:when>
			<c:otherwise>
			msg = "[${comtnschdulinfoVO.schdulNm}] 설문조사에 참여 하시겠습니까?";
			</c:otherwise>
		</c:choose>
		  
		if(confirm(msg)) {
			return true;
		}else {
			return false;	
		}
	  }
	
	  function radioCheck(obj) {
		var chk = false;
		for(var i=0; i<obj.length; i++) {
			if(obj[i].checked) {
				chk = true;
				break;
			}
		}
		return chk; 
	  }
	
	</script>
</head>
<body>

<div class="popbox">

	<div class="popboxtop">
		<h3 class="popboxh3">참여하기</h3>
		<p class="popboxclose"><a href="#" onclick="window.close(); return false;" title="팝업창닫기"><img src="${_IMG}/calendar/popbox_close.gif" alt="닫기" /></a></p>
	</div>

	<div class="popboxconall">
	<form:form method="post" commandName="onlineEventCommand" action="${_PREFIX}/addComtnschdulEvent.do">
	<input type="hidden" name="schdulId" value="<c:out value='${comtnschdulinfoVO.schdulId}'/>" />
	<input type="hidden" name="schdulClCode" value="<c:out value='${comtnschdulinfoVO.schdulClCode}'/>" />
		<div class="popboxcon">
			<h4 class="basicbigty1"><b><c:out value='${comtnschdulinfoVO.schdulNm}'/></b></h4>
			<c:forEach var="question" items="${comtnschdulinfoVO.questionList}" varStatus="q">
			<c:choose>
			<c:when test="${question.qesitmTyCode eq '1'}">
			<p>
			<input type="hidden" name="questionIdList" value="<c:out value='${question.qesitmId}'/>" />
			<input type="hidden" name="typeList" value="<c:out value='${question.qesitmTyCode}'/>" />
			<input type="hidden" name="maximumList" value="<c:out value='${question.mxmmAnswerCo}'/>" />
			<b><span>문제 <c:out value="${q.count}"/>.</span> <c:out value='${question.qesitmSj}'/></b>
			</p>
			<c:if test="${question.qesitmCn ne null}">
			<p style="margin-left:10px;"><c:out value='${question.qesitmCn}'/></p>
			</c:if>
			<fieldset>
			<legend>정답선택 </legend>
			<ul style="margin-bottom:30px;">
				<c:forEach var="example" items="${question.exampleList}" varStatus="e">
				<li>
					<span class="popboxspan2" style="width:50px;"></span><input type="radio" id="an_choice1"  name="choiceAnswer_<c:out value="${q.count}"/>" value='<c:out value="${e.count}"/>' class="popradio"/>
					<span class="popboxspan3"><c:out value="${example.exCn}"/></span>
				</li>
				</c:forEach>
			</ul>
			</c:when>
			<c:otherwise>
			</fieldset>
			<p>
			<input type="hidden" name="questionIdList" value="<c:out value='${question.qesitmId}'/>" />
			<input type="hidden" name="typeList" value="<c:out value='${question.qesitmTyCode}'/>" />
			<input type="hidden" name="maximumList" value="<c:out value='${question.mxmmAnswerCo}'/>" />
			<b><span>문제 <c:out value="${q.count}"/>.</span> <c:out value='${question.qesitmSj}'/></b>
			</p>
			<c:if test="${question.qesitmCn ne null}">
			<p style="margin-left:10px;"><c:out value='${question.qesitmCn}'/></p>
			</c:if>
				<fieldset>
				<legend>정답선택</legend>
				<ul style="margin-bottom:30px;">
					<c:choose>
					<c:when test="${question.mxmmAnswerCo eq '1'}">
					<li><label><span class="popboxspan2" style="width:40px;">정답</span></label><input type='text' name='essayAnswerList' class="commin" style="width:200px;"/></li>
					</c:when>
					<c:otherwise>
						<c:forEach var="i" begin="1" end="${question.mxmmAnswerCo}" step="1" >
						<li><label><span class="popboxspan2" style="width:40px;">정답<c:out value="${a.count}"/></span></label><input type='text' name='essayAnswerList' class="commin" style="width:200px;"/></li>
						</c:forEach>
					</c:otherwise>
					</c:choose>
				</ul>
				
				</fieldset>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<p class="center"><input type="image" src="${_IMG}/calendar/btn_ok.gif" class="popsubimg" alt="확인" onclick="return checkForm();"/></p>
		</div>
		</form:form>
	</div>

</div>

</body>
</html>