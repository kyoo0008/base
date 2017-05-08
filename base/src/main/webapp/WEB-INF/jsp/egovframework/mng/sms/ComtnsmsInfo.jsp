<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="egovframework.com.cmm.service.Globals"  %>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:set var="_PREFIX" value="/mng/sms"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SMS_MANAGE"/>
	<c:param name="depth1" value="SMS_SEND"/>
	<c:param name="depth2" value="SMS"/>
	<c:param name="title" value="SMS발송"/>
</c:import>	

<script type="text/javascript">
	
	var initClick = false;
	
	<c:if test='${not empty smsMessage}'>
		alert("<spring:message code="${smsMessage}" />");
	</c:if>

	function smsSend(se) {

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

		if(se == "Y"){
			if(frm.sendDate.value == "" || frm.sendTime.value == "") {
				alert("예약 시간을 설정하여 주십시오.");
				return false;
			}
			if(confirm("예약 전송 하시겠습니까?")) {
				frm.reservationDateString.value = frm.sendDate.value+" "+frm.sendTime.value;
				frm.reservationAt.value = 'Y';
				return true;
			}
		}else{
			if(confirm("전송 하시겠습니까?")) {
				return true;
			}
		}
		

		return false;
	}
	
	function addPhone(val) {
		var frm = document.smsForm;
		var phone = val;
		if(phone == "") {
			alert("전화번호를 입력하세요");
			return;
		}
		
		var text_box01 = document.getElementById("text_box01");

		var new_row = document.createElement( 'li' );
		var html = "<span>" + phone  + "</span>&nbsp;<img src='${MNG_IMG}/sms/sms_del.gif' alt='번호삭제' onclick='delPhone(this)'/><input type='hidden' name='recptnTelno' value='" + phone + "'/>";
		new_row.innerHTML = html;
		text_box01.appendChild(new_row);
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
</script>

<div id="contents">


		<style type="text/css">
		#page {height:100%; width:100%;}
		
		.sms_list_Box{float:left;width:50%;}
		.sms_list{height:380px;padding-right:20px;overflow-y:scroll;}
		
		.sms {float:left;width:222px; height:411px;padding-top:60px;margin-left:50px;font-size:12px;color:#999999;background:url('${MNG_IMG}/sms/phone_bg.jpg') no-repeat;}
		.phone_text01 {width:145px; height:145px;;margin:0 18px 0 48px;border:0px solid red;overflow-y:scroll;}
		#lblByte{text-align:center;margin-bottom:5px;}

		#text_box01 {position:relative;width:180px;height:115px;font-size:12px;line-height:1.5em;background:transparent;border:0px solid red;padding-left:20px;background:padding-top:10px;overflow-y:scroll;scrollbar-face-color:#8f8f82;scrollbar-3dlight-color:#8f8f82;scrollbar-highlight-color:#8f8f82;
		scrollbar-shadow-color:#50504b;scrollbar-darkshadow-color:#8f8f82;scrollbar-arrow-color:#000000;scrollbar-track-color:#45453f;padding-top:10px;}
		#text_box01 li{width:160px;}
		#text_box01 li img{vertical-align:middle;}

		
		#send_people{margin:5px 0 8px;height:18px;text-align:center;padding:0 20px;}
		.sms_input1 {float:left;width:70px;height:18px;border:1px solid #000000;background:#4f4f4f;color:#fff;}
		.sms_input2 {float:left;width:100px;height:18px;background:#4f4f4f;color:#fff;}
		.send_sms {width:222px; height:25px;text-align:center;margin-top:10px;}
		.btn_choice{margin:20px 0;text-align:right;padding-right:16px;}

		.pl20{padding-left:20px;}
		.pt10{padding-top:10px;}
		.pt20{padding-top:20px;}

		</style>
		<script type="text/javascript" src="${CMMN_JS }/egovframework/cmm/sym/cal/EgovCalPopup.js"></script>
		<div id="page">

			<div class="sms_list_Box">
				<!-- iframe name="smsUserList" src="${_PREFIX}/selectSmsuserList.do" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="500" scrolling="no"></iframe -->
			</div>

			<div class="sms">
					<form name="smsForm" method="post" action="<c:url value="${_PREFIX}/insertSmsManage.do"/>">
					<input type="hidden" name="trnsmitTelno" value="<%=Globals.PHONE%>"/>
					<input type="hidden" name="reservationDateString"/>
					<input type="hidden" name="reservationAt" value="N"/>
							<fieldset>
							<legend>문자보내기 입력폼</legend>

								<textarea class="phone_text01" name="trnsmitCn" onclick='DoClear(this)' onselect='DoClear(this)' onkeydown='CalByte3(this)' onchange='CalByte3(this)' onkeyup='CalByte3(this)'>내용을 입력하세요.</textarea>
								<div id="lblByte"><strong>0</strong>/80Byte</div>

								<div class="pl20 pt20"><img src="${MNG_IMG}/sms/sms_number_01.gif" alt="받는번호" /></div>									
								
								<ul id="text_box01"></ul>
						
								<div id="send_people">
									<input type="text" name="sendDate" id="sendDate" size="10" maxlength="10" onclick="fn_egov_NormalCalendar(document.smsForm, document.smsForm.sendDate);" readonly="readonly" class="sms_input1"/>
									<select name="sendTime" class="sms_input2">
										<option value="00:00:00">오전 12:00</option>
										<option value="00:30:30">오전 12:30</option>
										<option value="01:00:00">오전 01:00</option>
										<option value="01:30:00">오전 01:30</option>
										<option value="02:00:00">오전 02:00</option>
										<option value="02:30:00">오전 02:30</option>
										<option value="03:00:00">오전 03:00</option>
										<option value="03:30:00">오전 03:30</option>
										<option value="04:00:00">오전 04:00</option>
										<option value="04:30:00">오전 04:30</option>
										<option value="05:00:00">오전 05:00</option>
										<option value="05:30:00">오전 05:30</option>
										<option value="06:00:00">오전 06:00</option>
										<option value="06:30:00">오전 06:30</option>
										<option value="07:00:00">오전 07:00</option>
										<option value="07:30:00">오전 07:30</option>
										<option value="08:00:00">오전 08:00</option>
										<option value="08:30:00">오전 08:30</option>
										<option value="09:00:00">오전 09:00</option>
										<option value="09:30:00">오전 09:30</option>
										<option value="10:00:00">오전 10:00</option>
										<option value="10:30:00">오전 10:30</option>
										<option value="11:00:00">오전 11:00</option>
										<option value="11:30:00">오전 11:30</option>
										<option value="12:00:00">오후 12:00</option>
										<option value="12:30:00">오후 12:30</option>
										<option value="13:00:00">오후 01:00</option>
										<option value="13:30:00">오후 01:30</option>
										<option value="14:00:00">오후 02:00</option>
										<option value="14:30:00">오후 02:30</option>
										<option value="15:00:00">오후 03:00</option>
										<option value="15:30:00">오후 03:30</option>
										<option value="16:00:00">오후 04:00</option>
										<option value="16:30:00">오후 04:30</option>
										<option value="17:00:00">오후 05:00</option>
										<option value="17:30:00">오후 05:30</option>
										<option value="18:00:00">오후 06:00</option>
										<option value="18:30:00">오후 06:30</option>
										<option value="19:00:00">오후 07:00</option>
										<option value="19:30:00">오후 07:30</option>
										<option value="20:00:00">오후 08:00</option>
										<option value="20:30:00">오후 08:30</option>
										<option value="21:00:00">오후 09:00</option>
										<option value="21:30:00">오후 09:30</option>
										<option value="22:00:00">오후 10:00</option>
										<option value="22:30:00">오후 10:30</option>
										<option value="23:00:00">오후 11:00</option>
										<option value="23:30:00">오후 11:30</option>
									</select>
								
								</div>

								<div class="send_sms">
									<input type="image" onclick="return smsSend('Y');" src="${MNG_IMG}/sms/sms_send02.gif" alt="예약전송" />
									<input type="image" onclick="return smsSend('N');" src="${MNG_IMG}/sms/sms_send01.gif" alt="전송" />
								</div>
							</fieldset>
						</form>					
			</div>


		</div>

	</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	