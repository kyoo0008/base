<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/homepage/011/images"/>
<c:set var="isAuthenticated"><%=EgovUserDetailsHelper.isAuthenticated() %></c:set>
<c:set var="USER_INFO" value="" />
<c:set var="USER_MOBLPHON_NO" value="" />
<c:set var="FREE_SEND_CNT" value="0" />
<c:if test="${isAuthenticated}">
	<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser() %>" />
	<c:set var="USER_MOBLPHON_NO" value="${USER_INFO.mobileNo}" />
	
	<c:set var="FREE_SEND_CNT" value="${freeInfo.lmttCo - freeInfo.mlgScore}" />
</c:if>

<c:set var="INIT_MESSAGE" value="로그인 후에 이용해주세요" />
<c:if test="${isAuthenticated}">
	<c:set var="INIT_MESSAGE" value="남은 무료발송 : ${FREE_SEND_CNT}건" />
</c:if>
									
<%
	org.springframework.web.util.UrlPathHelper helper = new org.springframework.web.util.UrlPathHelper();
%>
<c:set var="CURR_URL" value="<%=helper.getOriginatingRequestUri(request)%>" />
<script type="text/javascript">
	
	var initClick = false;
	
	<c:if test='${not empty param.smsMessage}'>
		alert("<spring:message code="${param.smsMessage}" />");
	</c:if>

	function smsSend() {
		
		<c:if test="${!isAuthenticated}">
			alert("로그인 후에 이용해주세요");
			return false;
		</c:if>
		
		var frm = document.smsForm;
		if(frm.trnsmitCn.value == "" || !initClick) {
			alert("내용을 입력하세요");
			return false;
		}
		
		var text_box01 = document.getElementById("text_box01");
		if(text_box01.childNodes.length == 0) {
			alert("받는 사람을 추가하세요");
			return false;
		}
		
		if(frm.trnsmitTelno.value == "") {
			alert("보내는 사람을 입력하세요");
			return false;
		}

		if(confirm("전송하시겠습니까?")) {
			return true;
		}

		return false;
	}
	
	function addPhone() {
		var frm = document.smsForm;
		var phone = frm.addPhoneNumber.value;
		if(phone == "") {
			alert("전화번호를 입력하세요");
			return;
		}
		
		var text_box01 = document.getElementById("text_box01");

		var new_row = document.createElement( 'li' );
		var html = "<span>" + phone  + "</span><img src='${_IMG}/page/citizen/sms_del.gif' alt='번호삭제' onclick='delPhone(this)'/><input type='hidden' name='recptnTelno' value='" + phone + "'/>";
		new_row.innerHTML = html;
		text_box01.appendChild(new_row);
		
		frm.addPhoneNumber.value = "";
		frm.addPhoneNumber.focus();
	}
	
	function delPhone(obj) {
	  	obj.parentNode.parentNode.removeChild(obj.parentNode);
	}
	
	function DoClear(obj) {
		if(!initClick) {
			obj.value = "";
			initClick  =true;
		}
	}
	 
	function CalByte3(tg){ 
		var curText; 
		var strLen; 
		var byteIs; 
		var lastByte; 
		var thisChar; 
		var escChar; 
		var curTotalMsg; 
		var okMsg; 
	 
		curText = new String(tg.value); 
		strLen = curText.length; 
		byteIs = 0; 
	 
		for(i=0; i<strLen; i++) { 
		thisChar = curText.charAt(i); 
		escChar = escape(thisChar); 
	 
		                // ´,¨, ¸ : 2byte 임에도 브라우져에서 1byte로 계산 
		                if (thisChar == "´" || thisChar == "¨" || thisChar == "¸" || thisChar == "§" ){ 
		                        byteIs++; 
		                } 
	 
		if (escChar.length > 4) { 
		byteIs += 2;  //특수문자 한글인 경우. 
		}else if(thisChar != '\r') {  //개행을 제외한 이외의 경우 
		byteIs += 1; 
		} 
	 
		                if(byteIs > 80){ // 3페이지까지 
		                      alert('(80문자)를 초과하실 수 없습니다.'); 
		                      thisText = curText.substring(0, i); 
		                      tg.value = thisText; 
		                      byteIs = lastByte; 
		                      break; 
		                } 
	 
		                lastByte = byteIs; 
		} 
	 
		curTotalMsg = Math.ceil(byteIs / 80); 
		curEndByte = curTotalMsg * 80; 
	 
		document.getElementById("lblByte").innerHTML = "<strong>" + byteIs  + "</strong>/80Byte";
	}
		
	//콤마표현 없는 정수만입력
	function onlyEditableNumber(obj){
		var str = obj.value;
		str = new String(str);
		var Re = /[^0-9 | -]/g;  
		str = str.replace(Re,''); 
		obj.value = str;
	}

</script>

			<form name="smsForm" method="post" action="<c:url value="/hpg/sms/insertSms.do"/>" onsubmit="return smsSend();">
			<input type="hidden" name="returnUrl" value="${CURR_URL}?menuId=${param.menuId}"/>
								<fieldset>
								<legend>문자보내기 입력폼</legend>
									
									<textarea class="phone_text01" name="trnsmitCn" onclick='DoClear(this)' onselect='DoClear(this)' onkeydown='CalByte3(this)' onchange='CalByte3(this)' onkeyup='CalByte3(this)'>${INIT_MESSAGE}</textarea>
									<p class="phone_text02"><div id="lblByte"><strong>0</strong>/80Byte</div></p>
									<div class="pl20 pt20"><img src="${_IMG}/page/citizen/sms_number_01.gif" alt="받는번호" /></div>
									<input type="text" name="addPhoneNumber"  onkeydown="onlyEditableNumber(this)" onkeyup="onlyEditableNumber(this)" value="" class="sms_input" />
									<div class="sms_btn01"><a href="#1" onclick="addPhone();return false;"><img src="${_IMG}/page/citizen/sms_btn_01.gif" alt="추가" /></a></div>
									
									<ul id="text_box01">		
									</ul>
							
									<div id="send_people">
										<span class="sms_send_p"><img src="${_IMG}/page/citizen/sms_number_02.gif" alt="보내는번호" /></span>
										<input type="text" name="trnsmitTelno" onkeydown="onlyEditableNumber(this)" onkeyup="onlyEditableNumber(this)" value="${USER_MOBLPHON_NO}" class="sms_input2" />
									</div>
 
									<div class="send_sms">
										<input type="image" src="${_IMG}/page/citizen/sms_send.gif" alt="전송하기" />
									</div>
								</fieldset>
							</form>				
