<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>
<%@page import="egovframework.com.evt.service.ComtnschdulinfoVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmVO"%>
<%@page import="egovframework.com.evt.service.ComtneventqesitmexVO"%>
<%@page import="egovframework.com.evt.service.ComtneventcnsrVO"%>

<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="MNG_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>

<c:set var="registerFlag" value="${empty comtnschdulinfoVO.schdulId ? '등록' : '수정'}"/>
<c:set var="_EDITOR_ID" value="schdulCn"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="EVENT_MANAGE"/>
	<c:param name="depth1" value="EVENT_LIST"/>
	<c:param name="validator" value="comtnschdulinfoVO"/>
	<c:param name="title" value="통합캘린더관리"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript">
	function commonWork() {
		var stdt = document.getElementById("schdulBgndeDate");
		var endt = document.getElementById("schdulEnddeDate");
	
		if(endt.value != '' && stdt.value > endt.value) {
			alert("종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			endt.value = "";
			endt.focus();
		}
	}
	function checkForm(form) {			

		var essayAnswerList = document.getElementsByName("answerList");
		form.schdulBgnde.value = form.schdulBgndeDate.value.replace(/-/gi, '') + form.schdulBgndeTime.value;
		form.schdulEndde.value = form.schdulEnddeDate.value.replace(/-/gi, '') + form.schdulEnddeTime.value;
		$('#fileGroupId').val($('#fileGroupId_${_EDITOR_ID}').val());
		if(!validateComtnschdulinfoVO(form)) {				
			return false;
		}

		if(form.schdulBgndeDate.value == "") {
			alert("시작일자를 선택하여 주십시오");
			form.schdulBgndeDate.focus();
			return false;
		}
		if(form.schdulEnddeDate.value == "") {
			alert("종료일자를 선택하여 주십시오");
			form.schdulEnddeDate.focus();
			return false;
		}

		for(var i=0; i<essayAnswerList.length; i++) {
			  if(essayAnswerList[i].value == "") {
				  //alert("정답 항목을 입력하세요");
				  //return false;
				  essayAnswerList[i].value = "-1";
			  } 
		  }
		
		<c:choose>
		<c:when test="${registerFlag == '수정'}">
		if(confirm('<spring:message code="common.update.msg" />')) {
		</c:when>
		<c:otherwise>
		if(confirm('<spring:message code="common.regist.msg" />')) {
		</c:otherwise>
		</c:choose>
				
		
			return true;
		}else {
			return false;
		}
	}

	function dateChange(val) {	
		document.getElementById("schdulEnddeTime").value = val;
	}

	$(function() {
	var Today = new Date();
	var setYear = parseInt(Today.getFullYear()-10)+":"+parseInt(Today.getFullYear()+10);
		$('#schdulBgndeDate').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: setYear
		});	
		$('#schdulEnddeDate').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: setYear
		});	
		$('#presnatnDe').datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: setYear
		});	
	});


	function gAdd() {
		var divQuestion = document.getElementById("divQuestion");
		
		var new_row = document.createElement( 'div' );
		new_row.style.cssText="padding-bottom:10px";
		new_row.innerHTML = gHtml;
		
		divQuestion.appendChild(new_row);
		
		questionIndexNumberRename();
	}

	function jAdd() {
		var divQuestion = document.getElementById("divQuestion");
			
		var new_row = document.createElement( 'div' );
		new_row.style.cssText="padding-bottom:10px";
		new_row.innerHTML = jHtml;
			
		divQuestion.appendChild(new_row);
		
		questionIndexNumberRename();
	}

	//콤마표현 없는 정수만입력
	function onlyEditableNumber(obj){
		var str = obj.value;
		str = new String(str);
		var Re = /[^0-9 | -]/g;  
		str = str.replace(Re,''); 
		obj.value = str;
	}

	  var gHtml = "<table class='chart2' summary='문제등록 객관식문제' >";
	  gHtml = gHtml + "<colgroup><col width='150'/><col width=''/></colgroup>";
	  gHtml = gHtml + "<tr><th class='alL'> 객관식문제 <span id='questionNumber'></span> <img style='cursor:hand' src='${_IMG}/del.gif' onclick='delQuestion(this)' alt='삭제'></th><td><input type='hidden' name='questionIdList' value=''><input type='hidden' name='typeList' value='1'><input type='hidden' id='maximumList' name='maximumList' value='1'></td></tr>";
	  gHtml = gHtml + "<tr><th class='alle'> 질문</th><td><input size='105' maxlength='100' type='text' name='questionTitleList' class='inp_long'></td></tr>";
	  gHtml = gHtml + "<tr><th class='alle'> 본문</th><td><textarea cols='80' rows='5' name='questionContentsList' class='com_cont_l'></textarea></td></tr>";
	  gHtml = gHtml + "<tr><th class='alle'> 답안항목</th><td><div><div><span>1</span> <input type='hidden' name='exampleIdList' value=''><input size='70' maxlength='500' type='text' name='exampleList' class='inp_long'><img style='cursor:hand' src='${_IMG}/dd_s.gif' onclick='addExample(this)' alt='추가'><img style='cursor:hand' src='${_IMG}/del.gif' onclick='delExample(this)' alt='삭제'></div></div></td></tr>";
	  gHtml = gHtml + "<tr><th class='alle'> 정답</th><td><input type='hidden' name='answerIdList' value=''><input size='10' type='text' name='answerList' class='inp' onkeydown='onlyEditableNumber(this)' onkeyup='onlyEditableNumber(this)' value='' ></td></tr>";
	  gHtml = gHtml + "</table>";

	  var jHtml = "<table class='chart2' summary='문제등록 주관식문제'>";
	  jHtml = jHtml + "<colgroup><col width='150'/><col width=''/></colgroup>";
	  jHtml = jHtml + "<tr><th class='alL'> 주관식문제 <span id='questionNumber'></span> <img style='cursor:hand' src='${_IMG}/del.gif' onclick='delQuestion(this)' alt='삭제'></th><td><input type='hidden' name='questionIdList' value=''><input type='hidden' name='typeList' value='2'><input type='hidden' id='maximumList' name='maximumList' value='1'></td></tr>";
	  jHtml = jHtml + "<tr><th class='alle'> 질문</th><td><input size='105' maxlength='100' type='text' name='questionTitleList' class='inp_long'></td></tr>";
	  jHtml = jHtml + "<tr><th class='alle'> 본문</th><td><textarea cols='80' rows='5' name='questionContentsList' class='com_cont_l'></textarea></td></tr>";
	  jHtml = jHtml + "<tr><th class='alle'> 정답</th><td><div><div><span>1</span> <input type='hidden' name='exampleIdList' value=''><input size='70' maxlength='500' type='text' name='exampleList' class='inp_long'><img style='cursor:hand' src='${_IMG}/dd_s.gif' onclick='addExample(this)' alt='추가'><img style='cursor:hand' src='${_IMG}/del.gif' onclick='delExample(this)' alt='삭제'></div></div></td></tr>";
	  jHtml = jHtml + "</table>";
	  
	  var exmapleHtml = "<span>1</span> <input type='hidden' name='exampleIdList' value=''><input size='70' maxlength='500' type='text' name='exampleList' class='inp_long'><img style='cursor:hand' src='/template/manage/images/dd_s.gif' onclick='addExample(this)' alt='추가'><img style='cursor:hand' src='/template/manage/images/del.gif' onclick='delExample(this)' alt='삭제'>";
	  
	  function questionIndexNumberRename() {
		  var questionNumber = document.getElementsByName("questionNumber");
		  for(var i=0; i<questionNumber.length; i++) {
			  questionNumber[i].innerText = i + 1;
		  }
	  }
	  
	  function delQuestion(obj) {
		  var divQuestion = document.getElementById("divQuestion");
		  divQuestion.removeChild(obj.parentNode.parentNode.parentNode.parentNode.parentNode);
		  questionIndexNumberRename();
	  }
	  
	  function addExample(obj) {
		  var new_row = document.createElement( 'div' );
		  new_row.innerHTML = exmapleHtml;
		  obj.parentNode.parentNode.insertBefore(new_row, obj.parentNode.nextSibling);
		  exampleIndexNumberRename(obj.parentNode.parentNode);
	  }
	  
	  function delExample(obj) {
		  if(obj.parentNode.parentNode.childNodes.length > 1) { 
			var parentDiv = obj.parentNode.parentNode;
		  	obj.parentNode.parentNode.removeChild(obj.parentNode);
		  	exampleIndexNumberRename(parentDiv);
		  }
	  }

	  function exampleIndexNumberRename(obj) {
		  var ins = obj.getElementsByTagName("SPAN");
		  for(var i=1; i<=ins.length; i++) {
			  ins[i-1].innerText = i;
		  }
		  var input = obj.parentNode.parentNode.parentNode.firstChild.getElementsByTagName("INPUT");
		  for(var i=0; i<input.length; i++) {
			  if(input[i].name == "maximumList") {
				  input[i].value = ins.length;
				  break;
			  }
		  }
	  }

	function fClCode(val){
		location.href="?siteId=<c:out value='${comtnschdulinfoVO.siteId}'/>&searchSe=<c:out value='${searchVO.searchSe}'/>&schdulId=<c:out value='${comtnschdulinfoVO.schdulId}'/>&schdulBgnde=<c:out value='${comtnschdulinfoVO.schdulBgnde}'/>&schdulClCode="+val;
	}
	
	$(document).ready( function() {
   		var adfile_config = {
			storePath:"Event.fileStorePath",
			appendPath:"",
			siteId:"${searchVO.siteId}",
			editorId:"${_EDITOR_ID}"
		};
   		
   		$('#' + adfile_config.editorId).tinymce({
   			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
   			language : "ko", 
   			theme : "advanced",
   			skin : "o2k7",
   			skin_variant : "silver",
   			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
   			theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
   			theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
   			theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
   			theme_advanced_toolbar_location : "top",
   			theme_advanced_toolbar_align : "left",
   			theme_advanced_statusbar_location : "bottom",
   			theme_advanced_resizing : true,
   			content_css : "/template/manage/css/default.css",
   			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
   			convert_urls : false,
   			adfile_external_param : adfile_config,
   			setup : function(ed) {  
   				ed.addButton('img', {            
   					title : '이미지 삽입/편집',
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_01.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvImage');            
   					}        
   				});
   				ed.addButton('attach', {            
   					title : '파일 첨부',            
   					image : '${pageContext.request.contextPath}/lib/tiny_mce/img/icon_03.gif',
   					onclick : function() {                
   						ed.execCommand('mceAdvFile');            
   					}        
   				});    
   			}
   		});
   		
   		$('#schdulClCode').change(function() {
   			var schdulClCode = $(this).val();
   			if(schdulClCode == '' || schdulClCode == '1') {
   				$('#divQuestion').hide();
   				$('#divQuestionBtn').hide();
   			} else {
   				$('#divQuestion').show();
   				$('#divQuestionBtn').show();
   			}
   		});
   		
   		$('#schdulClCode').change();
	
		$('#schdulNm').focus();
   		
   	});
</script>
</head>
<body>

<form:form commandName="comtnschdulinfoVO" name="comtnschdulinfoVO" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/mng/evt/processComtnschdulinfo.do" onsubmit="return checkForm(this)">	
	
	<form:hidden path="siteId"/>
    <form:hidden path="sysTyCode"/>
    <form:hidden path="atchFileId"/>
	<form:hidden path="schdulId"/>
	<input name="searchSe" type="hidden" value="<c:out value='${searchVO.searchSe}'/>"/>	  
	<input type="hidden" id="posblAtchFileNumber_${_EDITOR_ID}" name="posblAtchFileNumber_${_EDITOR_ID}" value="100" />
	<input type="hidden" id="posblAtchFileSize_${_EDITOR_ID}" name="posblAtchFileSize_${_EDITOR_ID}" value="${2048 * 1024 * 1024}" />
	<input type="hidden" id="fileGroupId" name="fileGroupId" value="${comtnschdulinfoVO.atchFileId}"/>
	
<div id="cntnts">

	<table class="chart2">
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
		<tr>
			<th><em>*</em> 유형</th>
			<td>
				<form:select path="schdulClCode">
					<form:options items="${codeList}" itemValue="code" itemLabel="codeNm"/>
				</form:select>
				&nbsp;<form:errors path="schdulClCode" />
			</td>
		</tr>
		<tr>
			<th><em>*</em> 제목</th>
			<td>
				<form:input path="schdulNm" cssClass="inp_long"/>
				&nbsp;<form:errors path="schdulNm" />
			</td>
		</tr>
		<tr>
			<th>시작일자</th>
			<td>
				<form:hidden path='schdulBgnde'/><form:errors path="schdulBgnde" />
				<c:if test="${comtnschdulinfoVO.schdulBgnde ne '' and comtnschdulinfoVO.schdulBgnde ne null}">
					<c:set var="schdulBgndeDate" value="${fn:substring(comtnschdulinfoVO.schdulBgnde, 0,4)}-${fn:substring(comtnschdulinfoVO.schdulBgnde, 4,6)}-${fn:substring(comtnschdulinfoVO.schdulBgnde, 6,8)}"/>
					<c:set var="schdulBgndeTime" value="${fn:substring(comtnschdulinfoVO.schdulBgnde, 8,14)}" />
				</c:if>
				<input type="text" name="schdulBgndeDate" id="schdulBgndeDate" class="inp" value="${schdulBgndeDate}"/>
				<select name="schdulBgndeTime">
					<option value="000000"<c:if test="${'000000' eq schdulBgndeTime}"> selected</c:if>>오전 12:00</option>
					<option value="003000"<c:if test="${'003000' eq schdulBgndeTime}"> selected</c:if>>오전 12:30</option>
					<option value="010000"<c:if test="${'010000' eq schdulBgndeTime}"> selected</c:if>>오전 01:00</option>
					<option value="013000"<c:if test="${'013000' eq schdulBgndeTime}"> selected</c:if>>오전 01:30</option>
					<option value="020000"<c:if test="${'020000' eq schdulBgndeTime}"> selected</c:if>>오전 02:00</option>
					<option value="023000"<c:if test="${'023000' eq schdulBgndeTime}"> selected</c:if>>오전 02:30</option>
					<option value="030000"<c:if test="${'030000' eq schdulBgndeTime}"> selected</c:if>>오전 03:00</option>
					<option value="033000"<c:if test="${'033000' eq schdulBgndeTime}"> selected</c:if>>오전 03:30</option>
					<option value="040000"<c:if test="${'040000' eq schdulBgndeTime}"> selected</c:if>>오전 04:00</option>
					<option value="043000"<c:if test="${'043000' eq schdulBgndeTime}"> selected</c:if>>오전 04:30</option>
					<option value="050000"<c:if test="${'050000' eq schdulBgndeTime}"> selected</c:if>>오전 05:00</option>
					<option value="053000"<c:if test="${'053000' eq schdulBgndeTime}"> selected</c:if>>오전 05:30</option>
					<option value="060000"<c:if test="${'060000' eq schdulBgndeTime}"> selected</c:if>>오전 06:00</option>
					<option value="063000"<c:if test="${'063000' eq schdulBgndeTime}"> selected</c:if>>오전 06:30</option>
					<option value="070000"<c:if test="${'070000' eq schdulBgndeTime}"> selected</c:if>>오전 07:00</option>
					<option value="073000"<c:if test="${'073000' eq schdulBgndeTime}"> selected</c:if>>오전 07:30</option>
					<option value="080000"<c:if test="${'080000' eq schdulBgndeTime}"> selected</c:if>>오전 08:00</option>
					<option value="083000"<c:if test="${'083000' eq schdulBgndeTime}"> selected</c:if>>오전 08:30</option>
					<option value="090000"<c:if test="${'090000' eq schdulBgndeTime}"> selected</c:if>>오전 09:00</option>
					<option value="093000"<c:if test="${'093000' eq schdulBgndeTime}"> selected</c:if>>오전 09:30</option>
					<option value="100000"<c:if test="${'100000' eq schdulBgndeTime}"> selected</c:if>>오전 10:00</option>
					<option value="103000"<c:if test="${'103000' eq schdulBgndeTime}"> selected</c:if>>오전 10:30</option>
					<option value="110000"<c:if test="${'110000' eq schdulBgndeTime}"> selected</c:if>>오전 11:00</option>
					<option value="113000"<c:if test="${'113000' eq schdulBgndeTime}"> selected</c:if>>오전 11:30</option>
					<option value="120000"<c:if test="${'120000' eq schdulBgndeTime}"> selected</c:if>>오후 12:00</option>
					<option value="123000"<c:if test="${'123000' eq schdulBgndeTime}"> selected</c:if>>오후 12:30</option>
					<option value="130000"<c:if test="${'130000' eq schdulBgndeTime}"> selected</c:if>>오후 01:00</option>
					<option value="133000"<c:if test="${'133000' eq schdulBgndeTime}"> selected</c:if>>오후 01:30</option>
					<option value="140000"<c:if test="${'140000' eq schdulBgndeTime}"> selected</c:if>>오후 02:00</option>
					<option value="143000"<c:if test="${'143000' eq schdulBgndeTime}"> selected</c:if>>오후 02:30</option>
					<option value="150000"<c:if test="${'150000' eq schdulBgndeTime}"> selected</c:if>>오후 03:00</option>
					<option value="153000"<c:if test="${'153000' eq schdulBgndeTime}"> selected</c:if>>오후 03:30</option>
					<option value="160000"<c:if test="${'160000' eq schdulBgndeTime}"> selected</c:if>>오후 04:00</option>
					<option value="163000"<c:if test="${'000000' eq schdulBgndeTime}"> selected</c:if>>오후 04:30</option>
					<option value="170000"<c:if test="${'163000' eq schdulBgndeTime}"> selected</c:if>>오후 05:00</option>
					<option value="173000"<c:if test="${'173000' eq schdulBgndeTime}"> selected</c:if>>오후 05:30</option>
					<option value="180000"<c:if test="${'180000' eq schdulBgndeTime}"> selected</c:if>>오후 06:00</option>
					<option value="183000"<c:if test="${'183000' eq schdulBgndeTime}"> selected</c:if>>오후 06:30</option>
					<option value="190000"<c:if test="${'190000' eq schdulBgndeTime}"> selected</c:if>>오후 07:00</option>
					<option value="193000"<c:if test="${'193000' eq schdulBgndeTime}"> selected</c:if>>오후 07:30</option>
					<option value="200000"<c:if test="${'200000' eq schdulBgndeTime}"> selected</c:if>>오후 08:00</option>
					<option value="203000"<c:if test="${'203000' eq schdulBgndeTime}"> selected</c:if>>오후 08:30</option>
					<option value="210000"<c:if test="${'210000' eq schdulBgndeTime}"> selected</c:if>>오후 09:00</option>
					<option value="213000"<c:if test="${'213000' eq schdulBgndeTime}"> selected</c:if>>오후 09:30</option>
					<option value="220000"<c:if test="${'220000' eq schdulBgndeTime}"> selected</c:if>>오후 10:00</option>
					<option value="223000"<c:if test="${'223000' eq schdulBgndeTime}"> selected</c:if>>오후 10:30</option>
					<option value="230000"<c:if test="${'230000' eq schdulBgndeTime}"> selected</c:if>>오후 11:00</option>
					<option value="233000"<c:if test="${'233000' eq schdulBgndeTime}"> selected</c:if>>오후 11:30</option>
					<option value="235959"<c:if test="${'233000' eq schdulBgndeTime}"> selected</c:if>>오후 12:00</option>
				</select>
				&nbsp;<form:errors path="schdulBgnde" />
			</td>
		</tr>	
		<tr>
			<th>종료일자</th>
			<td>
				<form:hidden path='schdulEndde'/><form:errors path="schdulEndde" />
				<c:if test="${comtnschdulinfoVO.schdulEndde ne '' and comtnschdulinfoVO.schdulEndde ne null}">
					<c:set var="schdulEnddeDate" value="${fn:substring(comtnschdulinfoVO.schdulEndde, 0,4)}-${fn:substring(comtnschdulinfoVO.schdulEndde, 4,6)}-${fn:substring(comtnschdulinfoVO.schdulEndde, 6,8)}"/>
					<c:set var="schdulEnddeTime" value="${fn:substring(comtnschdulinfoVO.schdulEndde, 8,14)}" />
				</c:if>
				<input type="text" name="schdulEnddeDate" id="schdulEnddeDate" class="inp" value="${schdulEnddeDate}"/>
				<select name="schdulEnddeTime">
					<option value="000000"<c:if test="${'000000' eq schdulEnddeTime}"> selected</c:if>>오전 12:00</option>
					<option value="003000"<c:if test="${'003000' eq schdulEnddeTime}"> selected</c:if>>오전 12:30</option>
					<option value="010000"<c:if test="${'010000' eq schdulEnddeTime}"> selected</c:if>>오전 01:00</option>
					<option value="013000"<c:if test="${'013000' eq schdulEnddeTime}"> selected</c:if>>오전 01:30</option>
					<option value="020000"<c:if test="${'020000' eq schdulEnddeTime}"> selected</c:if>>오전 02:00</option>
					<option value="023000"<c:if test="${'023000' eq schdulEnddeTime}"> selected</c:if>>오전 02:30</option>
					<option value="030000"<c:if test="${'030000' eq schdulEnddeTime}"> selected</c:if>>오전 03:00</option>
					<option value="033000"<c:if test="${'033000' eq schdulEnddeTime}"> selected</c:if>>오전 03:30</option>
					<option value="040000"<c:if test="${'040000' eq schdulEnddeTime}"> selected</c:if>>오전 04:00</option>
					<option value="043000"<c:if test="${'043000' eq schdulEnddeTime}"> selected</c:if>>오전 04:30</option>
					<option value="050000"<c:if test="${'050000' eq schdulEnddeTime}"> selected</c:if>>오전 05:00</option>
					<option value="053000"<c:if test="${'053000' eq schdulEnddeTime}"> selected</c:if>>오전 05:30</option>
					<option value="060000"<c:if test="${'060000' eq schdulEnddeTime}"> selected</c:if>>오전 06:00</option>
					<option value="063000"<c:if test="${'063000' eq schdulEnddeTime}"> selected</c:if>>오전 06:30</option>
					<option value="070000"<c:if test="${'070000' eq schdulEnddeTime}"> selected</c:if>>오전 07:00</option>
					<option value="073000"<c:if test="${'073000' eq schdulEnddeTime}"> selected</c:if>>오전 07:30</option>
					<option value="080000"<c:if test="${'080000' eq schdulEnddeTime}"> selected</c:if>>오전 08:00</option>
					<option value="083000"<c:if test="${'083000' eq schdulEnddeTime}"> selected</c:if>>오전 08:30</option>
					<option value="090000"<c:if test="${'090000' eq schdulEnddeTime}"> selected</c:if>>오전 09:00</option>
					<option value="093000"<c:if test="${'093000' eq schdulEnddeTime}"> selected</c:if>>오전 09:30</option>
					<option value="100000"<c:if test="${'100000' eq schdulEnddeTime}"> selected</c:if>>오전 10:00</option>
					<option value="103000"<c:if test="${'103000' eq schdulEnddeTime}"> selected</c:if>>오전 10:30</option>
					<option value="110000"<c:if test="${'110000' eq schdulEnddeTime}"> selected</c:if>>오전 11:00</option>
					<option value="113000"<c:if test="${'113000' eq schdulEnddeTime}"> selected</c:if>>오전 11:30</option>
					<option value="120000"<c:if test="${'120000' eq schdulEnddeTime}"> selected</c:if>>오후 12:00</option>
					<option value="123000"<c:if test="${'123000' eq schdulEnddeTime}"> selected</c:if>>오후 12:30</option>
					<option value="130000"<c:if test="${'130000' eq schdulEnddeTime}"> selected</c:if>>오후 01:00</option>
					<option value="133000"<c:if test="${'133000' eq schdulEnddeTime}"> selected</c:if>>오후 01:30</option>
					<option value="140000"<c:if test="${'140000' eq schdulEnddeTime}"> selected</c:if>>오후 02:00</option>
					<option value="143000"<c:if test="${'143000' eq schdulEnddeTime}"> selected</c:if>>오후 02:30</option>
					<option value="150000"<c:if test="${'150000' eq schdulEnddeTime}"> selected</c:if>>오후 03:00</option>
					<option value="153000"<c:if test="${'153000' eq schdulEnddeTime}"> selected</c:if>>오후 03:30</option>
					<option value="160000"<c:if test="${'160000' eq schdulEnddeTime}"> selected</c:if>>오후 04:00</option>
					<option value="163000"<c:if test="${'000000' eq schdulEnddeTime}"> selected</c:if>>오후 04:30</option>
					<option value="170000"<c:if test="${'163000' eq schdulEnddeTime}"> selected</c:if>>오후 05:00</option>
					<option value="173000"<c:if test="${'173000' eq schdulEnddeTime}"> selected</c:if>>오후 05:30</option>
					<option value="180000"<c:if test="${'180000' eq schdulEnddeTime}"> selected</c:if>>오후 06:00</option>
					<option value="183000"<c:if test="${'183000' eq schdulEnddeTime}"> selected</c:if>>오후 06:30</option>
					<option value="190000"<c:if test="${'190000' eq schdulEnddeTime}"> selected</c:if>>오후 07:00</option>
					<option value="193000"<c:if test="${'193000' eq schdulEnddeTime}"> selected</c:if>>오후 07:30</option>
					<option value="200000"<c:if test="${'200000' eq schdulEnddeTime}"> selected</c:if>>오후 08:00</option>
					<option value="203000"<c:if test="${'203000' eq schdulEnddeTime}"> selected</c:if>>오후 08:30</option>
					<option value="210000"<c:if test="${'210000' eq schdulEnddeTime}"> selected</c:if>>오후 09:00</option>
					<option value="213000"<c:if test="${'213000' eq schdulEnddeTime}"> selected</c:if>>오후 09:30</option>
					<option value="220000"<c:if test="${'220000' eq schdulEnddeTime}"> selected</c:if>>오후 10:00</option>
					<option value="223000"<c:if test="${'223000' eq schdulEnddeTime}"> selected</c:if>>오후 10:30</option>
					<option value="230000"<c:if test="${'230000' eq schdulEnddeTime}"> selected</c:if>>오후 11:00</option>
					<option value="233000"<c:if test="${'233000' eq schdulEnddeTime}"> selected</c:if>>오후 11:30</option>
					<option value="235959"<c:if test="${'235959' eq schdulEnddeTime}"> selected</c:if>>오후 12:00</option>
				</select>
				&nbsp;<form:errors path="schdulEndde" />
			</td>
		</tr>	
		<tr>
			<th>일정내용</th>
			<td class="editor">
				<textarea id="schdulCn" name="schdulCn" cols="4" rows="5" style="width:100%;height:300px;">${comtnschdulinfoVO.schdulCn }</textarea>
				<form:errors path="schdulCn" cssClass="error" />
				<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
                	<c:param name="editorId" value="${_EDITOR_ID}"/>
					<c:param name="estnAt" value="N" />
			    	<c:param name="param_atchFileId" value="${comtnschdulinfoVO.atchFileId}" />
			    	<c:param name="imagePath" value="${_IMG }"/>
				</c:import>
			</td>
		</tr>
		<c:if test="${comtnschdulinfoVO.schdulClCode ne '1'}">
			<tr style="display:none;">
				<th>디자인상단이미지</th>
				<td>
					<input type="file" name="upendDesignFile" id="upendDesignFile" title="디자인상단이미지" class="inp_long"/>
					<c:if test="${not empty comtnschdulinfoVO.upendStreFileNm}">
		     			<a href="<c:url value='${comtnschdulinfoVO.upendFileNmByWebPath}'/>" target="_blank" alt="디자인상단이미지"/><img src="${_IMG}/btn/use_yes.gif" alt="보기" /></a>
		     		</c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>디자인중간이미지</th>
				<td>
					<input type="file" name="middleDesignFile" id="middleDesignFile" title="디자인중간이미지" class="inp_long"/>
					<c:if test="${not empty comtnschdulinfoVO.middleStreFileNm}">
		     			<a href="<c:url value='${comtnschdulinfoVO.middleFileNmByWebPath}'/>" target="_blank" alt="디자인중간이미지"/><img src="${_IMG}/btn/use_yes.gif" alt="보기" /></a>
		     		</c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>디자인하단이미지</th>
				<td>
					<input type="file" name="lptDesignFile" id="lptDesignFile" title="디자인하단이미지" class="inp_long"/>
					<c:if test="${not empty comtnschdulinfoVO.lptStreFileNm}">
		     			<a href="<c:url value='${comtnschdulinfoVO.lptFileNmByWebPath}'/>" target="_blank" alt="디자인하단이미지"/><img src="${_IMG}/btn/use_yes.gif" alt="보기" /></a>
		     		</c:if>
				</td>
			</tr>
		</c:if>

		<tr>
			<th>진행상태</th>
			<td>
			진행<form:radiobutton path="useAt" cssClass="txt" value="Y"/>&nbsp;&nbsp;&nbsp;
			마감<form:radiobutton path="useAt" cssClass="txt" value="C"/>&nbsp;&nbsp;&nbsp;
			보류<form:radiobutton path="useAt" cssClass="txt" value="R"/>&nbsp;&nbsp;&nbsp;
			&nbsp;<form:errors path="useAt" />
			</td>
		</tr>

		<c:if test="${comtnschdulinfoVO.schdulClCode ne '1'}">
		<!-- 
		<tr>
			<th>당첨자수</th>
			<td>
				<form:input path="przwnerNmpr" cssClass="inp"/>
				<form:errors path="przwnerNmpr" />
			</td>
		</tr>
		<tr>
			<th>이벤트발표일자</th>
			<td>
				<form:input path="presnatnDe" cssClass="inp"/>
				<form:errors path="presnatnDe" />
			</td>
		</tr>
		<tr>
			<th>팝업창노출여부</th>
			<td>
				예<form:radiobutton path="popupAt" cssClass="txt" value="Y"/>&nbsp;&nbsp;&nbsp;
				아니오<form:radiobutton path="popupAt" cssClass="txt" value="N"/>
			</td>
		</tr>
		 -->
		</c:if>
		
		<!-- tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="atchFile" id="atchFile" title="첨부파일" />
			</td>
		</tr -->
	</table>
  </div>
	<div id="divQuestion" style="width:100%;display:none">
              <c:forEach var="question" items="${comtnschdulItem.questionList}" varStatus="status">
              	<c:choose>
              		<c:when test="${question.qesitmTyCode eq 1}">
	              		<div style='width:100%;padding-bottom:10px'>
	              			  <table class="chart2" summary="문제등록 객관식문제" >
	              			  <colgroup><col width="150"/><col width=""/></colgroup>
							  <tr><th class='alL'> 객관식문제 <span id='questionNumber'>${status.index + 1}</span> <img style="cursor:hand" src="${_IMG}/del.gif" onclick='delQuestion(this)' alt='삭제'></th><td><input type='hidden' name='questionIdList' value='${question.qesitmId}'><input type='hidden' name='typeList' value='1'><input type='hidden' id='maximumList' name='maximumList' value='${question.mxmmAnswerCo}'></td></tr>
							  <tr><th class='alle'> 질문</th><td><input type='text' size='105' maxlength='100' name='questionTitleList' value="<c:out value="${question.qesitmSj}"/>" class='inp_long'></td></tr>
							  <tr><th class='alle'> 본문</th><td><textarea name='questionContentsList' cols='80' rows='5' class='com_cont_l'><c:out value="${question.qesitmCn}"/></textarea></td></tr>
							  <tr><th class='alle'> 답안항목</th>
								  <td>
								  	<div>
								  		<c:forEach var="example" items="${question.exampleList}" varStatus="i">
								  			<div><span>${i.index + 1}</span> <input type='hidden' name='exampleIdList' value='${example.exId}'><input size='70' maxlength='500' type='text' name='exampleList' class='inp_long' value="<c:out value="${example.exCn}"/>"><img style='cursor:hand' src='${_IMG }/dd_s.gif' onclick='addExample(this)' alt='추가'><img style='cursor:hand' src='/template/manage/images/del.gif' onclick='delExample(this)' alt='삭제'></div>
								  		</c:forEach>
								  	</div>
								  </td>
							  </tr>
							  <tr><td colspan='2' height='1'></td></tr>
							  <tr><th class='alle'> 정답</th><td><input type='hidden' name='answerIdList' value='${question.answerList[0].cnsrId}'><input size='10' type='text' name='answerList' class='inp' value="<c:out value="${question.answerList[0].choiseCnsr eq -1 ? '' : question.answerList[0].choiseCnsr}"/>" onkeydown="onlyEditableNumber(this)" onkeyup="onlyEditableNumber(this)" /></td></tr>
							  </table>
	              		</div>
              		</c:when>
              		<c:otherwise>
	              		<div style='width:100%;padding-bottom:10px'>
	              			  <table class="chart2" summary="문제등록 주관식문제">
	              			  <colgroup><col width="150"/><col width=""/></colgroup>
							  <tr><th class='alL'>  주관식문제 <span id='questionNumber'>${status.index + 1}</span> <img style="cursor:hand" src="/template/manage/images/del.gif" onclick='delQuestion(this)' alt='삭제'></th><td><input type='hidden' name='questionIdList' value='${question.qesitmId}'><input type='hidden' name='typeList' value='2'><input type='hidden' id='maximumList' name='maximumList' value='${question.mxmmAnswerCo}'></td></tr>
							  <tr><th class='alle'> 질문</th><td><input type='text' size='105' maxlength='100' name='questionTitleList' class='inp_long' value="<c:out value="${question.qesitmSj}"/>"></td></tr>
							  <tr><th class='alle'> 본문</th><td><textarea name='questionContentsList' cols='80' rows='5' class='com_cont_l'><c:out value="${question.qesitmCn}"/></textarea></td></tr>
							  <tr><th class='alle'> 정답</th>
							  	<td>
							  		<div>
							  			<c:forEach var="answer" items="${question.answerList}" varStatus="i">
							  				<div><span>${i.index + 1}</span> <input type='hidden' name='exampleIdList' value='${answer.cnsrId}'><input size='70' maxlength='500' type='text' name='exampleList' class='inp_long' value="<c:out value="${answer.sbjctCnsr}"/>"><img style='cursor:hand' src='/template/manage/images/dd_s.gif' onclick='addExample(this)' alt='추가'><img style='cursor:hand' src='/template/manage/images/del.gif' onclick='delExample(this)' alt='삭제'></div>
							  			</c:forEach>
							  		</div>
							  	</td>
							  </tr>
							  <tr><td colspan='2' height='1'></td></tr>				  
							  </table>
	              		</div>
              		</c:otherwise>
              	</c:choose>
              </c:forEach>
	</div>
	
	<div id="divQuestionBtn" align="center"style="width:100%;display:none"><br />
		<img style="cursor:hand" src="${_IMG}/multi_btn.gif" onclick="gAdd()" alt="객관식 추가" />
		<img style="cursor:hand" src="${_IMG}/subjec_btn.gif" onclick="jAdd()" alt="주관식 추가" />
	</div>

	<div class="btn_r">
		<c:url var="listUrl" value="/mng/evt/selectSchdulinfoList.do">
			<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:if test="${not empty searchVO.searchSe}"><c:param name="searchSe" value="${searchVO.searchSe}" /></c:if>
			<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
			<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
			<c:param name="pageIndex" value="${searchVO.pageIndex}"/>
		</c:url>
		<input type="image" src="${pageContext.request.contextPath}/template/common/images/sub/board/btn_drawing.gif" alt="저장"/>
		<a href="<c:out value="${listUrl}"/>"><img src="${pageContext.request.contextPath}/template/common/images/sub/board/btn_cancel.gif" alt="취소"/></a>	
	</div>


</form:form>


<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>

