<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="egovframework.com.cmm.service.Globals"  %>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="HPG_IMG" value="/template/homepage/011/images"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:set var="_PREFIX" value="/mng/sms"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SMS_MANAGE"/>
	<c:param name="depth1" value="SMS_SEND"/>
	<c:param name="depth2" value="MMS"/>
	<c:param name="title" value="MMS발송"/>
</c:import>	


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
				<!-- iframe name="mmsUserList" src="${_PREFIX}/selectMmsuserList.do" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="500" scrolling="no"></iframe -->
			</div>

			<div class="sms">
					<form name="mmsForm" method="post" action="<c:url value="${_PREFIX}/insertMmsManage.do"/>">
							<fieldset>
							<legend>문자보내기 입력폼</legend>
							<textarea class="phone_text01" name="trnsmitCn" ></textarea>
								<div class="send_sms">
									<br/><br/><br/><a href="#" onclick="return mmsUserList.mmsSend();"><img src="${MNG_IMG}/sms/sms_send01.gif" alt="전송" /></a>
								</div>
							</fieldset>
						</form>					
			</div>

		</div>

	</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	