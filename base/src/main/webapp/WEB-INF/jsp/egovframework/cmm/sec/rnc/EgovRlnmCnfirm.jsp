<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="HPG_IMG" value="/template/homepage/011/images"/>
<c:set var="serverName" value="<%=request.getServerName()%>"/>
<c:set var="serverPort" value="<%=request.getServerPort()%>"/>
<c:choose>
 <c:when test="${serverPort == 80}">
  <c:set var="serverPort" value=""/>
 </c:when>
 <c:otherwise>
  <c:set var="serverPort" value=":${serverPort}"/>
 </c:otherwise>
</c:choose>

<c:import url="/hpg/tmplatHead.do" charEncoding="utf-8"/>
<%

	//#######################################################################################
	//#####
	//#####	실명인증키(대체인증키) 서비스 샘플 페이지 소스				한국신용정보(주)
	//#####
	//#####	================================================================================
	//#####
	//#####	* 본 페이지는 귀사의 화면에 맞게 수정하십시오.
	//#####	  단, Head 영역에 설정된 Javascript를 수정하거나 변경하시면 사용할 수 없습니다.
	//#####
	//#######################################################################################


	//========================================================================================
	//=====	▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
	//========================================================================================

	String NiceId = "Nkongju4"; //회원사 ID

	//========================================================================================
	//=====	▣ 반환 결과를 수신할 URL을 설정하십시오. (단, 페이지는 그대로 사용하십시오)
	//=====	   한신정 서비스에 전달되어 사용되므로 반드시 절대 URL 경로를 설정하셔야 합니다.
	//========================================================================================

	//OivsObject oivsObject = new OivsObject();

%>
	<!--	==========================================================	-->
	<!--	한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)	-->
	<!--	==========================================================	-->
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msg.js"></script>
	<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
		
    <script type="text/javaScript" language="javascript" defer="defer">
		<!--
		<c:if test='${not empty message}'>
		alert("${message}");
		</c:if>

		document.onkeydown = onKeyDown;

		function onKeyDown( event )
		{
			var e = event;
			if ( event == null ) e = window.event;

			if ( e.keyCode == 13 ) goIDCheck();
		}

		function validate()
		{
			var NiceId		= document.getElementById( "NiceId" );
			var PingInfo	= document.getElementById( "PingInfo" );
			var ReturnURL	= document.getElementById( "ReturnURL" );

			if ( NiceId.value == "" )
			{
				alert( getCheckMessage( "S60" ) );
				NiceId.focus();
				return false;
			}

			if ( PingInfo.value == "" )
			{
				alert( getCheckMessage( "S61" ) );
				return false;
			}

			if ( ReturnURL.value == "" )
			{
				alert( getCheckMessage( "S64" ) );
				ReturnURL.focus();
				return false;
			}

			return true;
		}

		function goIDCheck()
		{
			if ( validate() == true )
			{
				var strNiceId 		= document.getElementById( "NiceId" ).value;
				var strPingInfo		= document.getElementById( "PingInfo" ).value;
				var strOrderNo		= document.getElementById( "OrderNo" ).value;
				var strInqRsn		= document.getElementById( "InqRsn" ).value;
				var strReturnUrl	= document.getElementById( "ReturnURL" ).value;

				//	거래일련번호가 없는 경우는 새로 생성한다.
				if ( strOrderNo == "" ) strOrderNo = getOrderNo( 20 );

				document.reqForm.SendInfo.value = makeCertKeyInfo( strNiceId, strPingInfo, strOrderNo, strInqRsn, strReturnUrl );
				document.reqForm.ProcessType.value = strRealNameCertKey;

				var popupWindow = window.open( "", "popupCertKey", "top=100, left=200, status=0, width=417, height=490" );
				document.reqForm.target = "popupCertKey";
				document.reqForm.action = strCertKeyServiceUrl;
				document.reqForm.submit();
				popupWindow.focus();
				return true;
			}
		}

		function checkReturnCallFn(retCd, niceNm, dupeInfo) {
			if (retCd == '1') {
				document.getElementById("userNm").value = niceNm;
				document.getElementById("credtId").value = dupeInfo;
				document.certifForm.submit();
			} else {//응답실패 
				alert("응답에 실패하였습니다.");
			}
		}

		function checkCp(form) {
			if (form.jumin1.value == '') {
				alert("보호자 주민번호를 입력해 주시기 바랍니다.");
				form.jumin1.focus();
				return false;
			}
			if (form.jumin2.value == '') {
				alert("보호자 주민번호를 입력해 주시기 바랍니다.");
				form.jumin2.focus();
				return false;
			}
			if (form.telco.value == '') {
				alert("휴대전화 통신사를 선택해 주시기 바랍니다.");
				form.telco.focus();
				return false;
			}
			if (form.cp2.value == '') {
				alert("휴대전화 가운데 자리를 입력해 주시기 바랍니다.");
				form.cp2.focus();
				return false;
			}
			if (form.cp3.value == '') {
				alert("휴대전화 마지막 자리를 입력해 주시기 바랍니다.");
				form.cp3.focus();
				return false;
			}
			form.cp_phone.value = form.cp1.value + form.cp2.value + form.cp3.value;
			form.cp_jumin.value = form.jumin1.value + form.jumin2.value;
			form.cp_telco.value = form.telco.value;
			form.cp_client.value = form.child_jumin1.value + form.child_jumin2.value;

			form.action = "/sec/rnc/RealhpCnfirm.do";
			form.target = "chkFrame";
			form.submit();
		}

		function moveFocus(el1, el2, len) {
		 	var el = document.getElementById(el1);
		    if (el.value.length == len) {
				document.getElementById(el2).focus();
				return;
			}          
		}

		function chkLicenceNum(form) {
			var ipt_num = form.ipt_num.value;
			var rst_num = form.rst_num.value;
			if (rst_num == ipt_num) {
				form.userIhidnum.value=document.getElementById( "child_jumin1" ).value+document.getElementById( "child_jumin2" ).value;
				form.submit();
				return true;
			} else {
				alert("인증번호가 일치하지 않습니다. 다시 입력해 주시기 바랍니다.");
				document.getElementById("ipt_num").value = "";
				document.getElementById("ipt_num").focus();
				return false;
			}
		}

		function displayHpCheck(no) {
			document.getElementById("rst_num").value = no;
			document.getElementById("displayResultBox").style.display = "block";
		}

		function checkIhidnum() {
			document.hpCheckForm.reset();
		}

		function onlyNumber() {
			if((event.keyCode<48)||(event.keyCode>57)) {
				event.returnValue=false;
		    }
		}
		//-->
	</script>

		<form id="reqForm" name="reqForm" method="post" action="">
			<input type="hidden" id="SendInfo" name="SendInfo" />
			<input type="hidden" id="ProcessType" name="ProcessType" />
		</form>
		
		<form id="certifForm" name="certifForm" method="post" action="/uss/umt/user/EgovUserInsertView.do">
			<input type="hidden" name="crtfcSe"	id="crtfcSe" value="nice"/>
			<input type="hidden" name="userNm"	id="userNm"/>
			<input type="hidden" name="credtId" id="credtId"/>
			<input type='hidden' name='menuId' value="<c:out value="${param.menuId}"/>"/>
			<input type='hidden' name='userTyCode' value="<c:out value="${searchVO.userTyCode}"/>"/>
		</form>
				<div id="content">
						<p class="step_tit"><img src="${HPG_IMG }/page/member/join_step02.gif" alt="SETP1 약관동의→STEP2 실명확인 (현재단계) → STEP3 상세정보입력 → STEP4 가입완료" /></p>
						
						<p class="mb20"><img src="${HPG_IMG }/page/member/tit_real_name.gif" alt="실명인증 본인확인 후 게시판에 글을 쓸 수 있습니다." /></p>
						<p class="mb20"><img src="${HPG_IMG }/page/member/txt_real_name.gif" alt="2006년 9월 24일 개정된 주민등록법에 의해 타인의 주민번호를 도용하여 온라인 회원가입을 하는 등 다른사람의 주민번호를 부정 사용하는 자는 3년이하의 징역 또는 1천만원 이하의 벌금이 부과될 수 있습니다." /></p>
						
						<div class="cm_box_top">
							<div class="cm_box_cont">
							<c:choose>
							<c:when test="${searchVO.userTyCode eq 'CHILD'}">
							
							<div>
									<form:form id="hpCheckForm" name="hpCheckForm" method="post" >
										<input type="hidden" id="cp_jumin" name="cp_jumin"/>
										<input type="hidden" id="cp_phone" name="cp_phone"/>
										<input type="hidden" id="cp_telco" name="cp_telco"/>
										<input type="hidden" name="cp_client"/>
									<fieldset>
										<legend>핸드폰인증 입력폼</legend>
										<dl class="hp_certi">
											<dt>주민등록번호(14세 미만 어린이)</dt> 
											<dd>
												<label for="jumin01" class="hdn">주민등록번호 앞자리</label>
												<input type="text" id="child_jumin1" name="child_jumin1" class="inp wid105" maxlength="6" onkeypress="onlyNumber();" onkeyup="moveFocus('child_jumin1','child_jumin2',6)" style="ime-mode:disabled;" /> - 
												<label for="jumin02" class="hdn">주민등록번호 뒷자리</label>
												<input type="password" id="child_jumin2" name="child_jumin2" class="inp wid105" maxlength="7" onkeypress="onlyNumber();" /></dd>
											<dt>주민등록번호(보호자)</dt>
											<dd>
												<label for="jumin1" class="hdn">주민등록번호 앞자리</label>
												<input type="text" id="jumin1" name="jumin1" class="inp wid105" maxlength="6" onkeypress="onlyNumber();" onkeyup="moveFocus('jumin1','jumin2',6)" style="ime-mode:disabled;" /> - 
												<label for="jumin2" class="hdn">주민등록번호 뒷자리</label>
												<input type="password" id="jumin2" name="jumin2" class="inp wid105" maxlength="7" onkeypress="onlyNumber();"/> </dd>
											<dt>휴대전화</dt>
											<dd>
												<label for="telco" class="hdn">통신사 분류</label>
												<select id="telco">
													<option value="SKT">SKT</option>
													<option value="KTF">KT</option>
													<option value="LGT">LG U+</option>
												</select>
												<label for="cp1" class="hdn">핸드폰 앞번호 분류</label>
												<select id="cp1">
													<option value="010">010</option>
													<option value="010">010</option>
													<option value="011">011</option>
													<option value="016">016</option>
													<option value="017">017</option>
													<option value="018">018</option>
													<option value="019">019</option>
												</select>
												-
												<label for="cp2" class="hdn">핸드폰 가운데번호</label>
												<input type="text" id="cp2" name="cp2" class="inp wid80" onkeypress="onlyNumber();" maxlength="4" onkeyup="moveFocus('cp2','cp3',4)" style="width:35px;ime-mode:disabled;" /> - 
												<label for="hp03" class="hdn">핸드폰 뒷번호</label>
												<input type="text" id="cp3" name="cp3" class="inp wid80" onkeypress="onlyNumber();" maxlength="4" style="width:35px;ime-mode:disabled;" /> 
												<input type="image" src="/template/homepage/011/images/page/member/btn_confirm02.gif" alt="핸드폰인증확인" onclick="return checkCp(document.hpCheckForm);" />
											</dd>
										</dl>
									</fieldset>
									</form:form>
								</div>
								
								<div id="displayResultBox" class="real_name_new" style="display:none">
								<form id="realHpCheckForm" name="realHpCheckForm" method="post" action="/uss/umt/user/EgovUserInsertView.do">
									<input type="hidden" name="userIhidnum" id="userIhidnum"/>
									<input type="hidden" name="prtctorIhidnum" id="prtctorIhidnum"/>
									<input type="hidden" name="prtctorMbtlnum" id="prtctorMbtlnum"/>
									<input type="hidden" name="rst_num" id="rst_num"/>
									<input type='hidden' name='menuId' value="<c:out value="${param.menuId}"/>"/>
									<input type='hidden' name='userTyCode' value="<c:out value="${searchVO.userTyCode}"/>"/>
									<fieldset>
									<legend>인증번호폼</legend>
									<label for="name"class="arrow_g">인증번호</label>
									<input type="text" class="inp" id="ipt_num" name="ipt_num" />   
									<input type="image" src="/template/homepage/011/images/page/member/btn_confirm02.gif" alt="확인" onclick="return chkLicenceNum(document.realHpCheckForm);"/>
									</fieldset>
								</form>

								</div>
								
								<div class="real_name_cont">
									<ul>
										<li class="stxt">이름과 주민등록번호를 정확하게 입력해도 실명인증이 안되는 경우에는 실명인증기관에 고객님의 정보가 없는 경우이므로, 아래 실명인증기관을 통해 고객님의 실명정보를 등록해 주셔야 합니다. 실명인증기관에 등록하신 후 24시간(영업일 기준)이 지나면 정상적으로 실명확인이 가능합니다. </li>
										<li class="stxt">내국인, 기업 실명등록 문의 : 한국신용정보(주)(☎1588-2486) </li> 
										<li class="stxt">부정확한 정보기입으로 인해 실명인증이 되지 않는 경우 가입하실 수 없습니다. </li>
										<li class="stxt">개정 "주민등록법"에 의해 타인의 주민등록번호를 부정 사용하는 자는 3년 이하의 징역 또는 1천만원 이하의 벌금이 부과될 수 있습니다.
										- 관련법률: 주민등록법 제21조(벌칙) 제2항 9호(시행일 2006. 09. 24) </li>
										<li class="stxt">반드시 본인의 주민등록번호를 사용해 주시기 바랍니다.</li>			
									</ul>
								</div>

							</c:when>
							<c:otherwise>
								
								<div class="real_name01">
								<form:form id="pageForm" commandName="pageForm" method="post" action="">
								<input type="hidden" id="NiceId" name="NiceId" value="<%= NiceId %>" />
								<input type="hidden" id="PingInfo" name="PingInfo" value="<%= oivsObject.pingInfo %>" />
						  		<input type="hidden" id="ReturnURL" name="ReturnURL" value="http://${serverName}${serverPort}/sec/rnc/EgovRlnmCnfirmChk.do" />
						  		<!--	내/외국인 구분을 설정하십시오. ( '1'-내국인, '2'-외국인 )	-->
						  		<c:choose>
								<c:when test="${searchVO.userTyCode eq 'FRGNR'}">
									<input type="hidden" id="foreigner" name="foreigner" value="2"></input>
								</c:when>
								<c:otherwise>
									<input type="hidden" id="foreigner" name="foreigner" value="1"></input>
								</c:otherwise>
								</c:choose>
						  		<!--	조회사유를 설정하십시오 ( '10'-회원가입, '20'-기존회원 확인, '30'-성인인증, '40'-비회원 확인, '90'-기타 사유 )	-->
								<input type="hidden" id="InqRsn" name="InqRsn" value="10" />
								<!--	거래일련번호를 설정하십시오. (최소 14자리, 20자리미만)	-->
								<input type="hidden" id="OrderNo" name="OrderNo" value="" />
								<input type="hidden" name="sbscrbTy" value="01"/>
								<input type='hidden' name='menuId' value="<c:out value="${param.menuId}"/>"/>
								<input type='hidden' name='userTyCode' value="<c:out value="${searchVO.userTyCode}"/>"/>
									<strong class="org">실명인증이란?</strong>
									<ul  class="list_arrow02">
										<li class="stxt">주민등록번호를 이용한 본인확인절차로 별도의 등록과정이 필요하지 않습니다.</li>
										<li class="stxt"> 보다 많은 사용자들의 원활한 서비스이용과 온라인 상에서의 익명 사용자로 인한 피해등을 방지하기 위해 회원ID에 대한 실명제를 시행하고 있습니다.</li>
										<li class="stxt">실명인증은 한국신용정보에서 주관하는 기관으로 신용정보를 포함한 모든 정보의 안전을 위하여 ISO27001 국제 표준에 의거한 개인정보보안 서비스입니다.</li>

									</ul>
									<img src="${HPG_IMG }/page/member/btn_real_name.gif" alt="실명인증" onclick="javascript:goIDCheck();" style="cursor: pointer" class="fr_btn"/>
								</form:form>
								</div>
								<c:if test="${searchVO.userTyCode eq 'GNRL'}">
								<div class="real_name02">
									<strong class="org">공공 I-PIN 인증</strong>
									<ul>
										<li class="stxt">행정안전부 공공I-PIN센터에서 발급받은 식별 ID 및 비밀번호를 이용하여 본인확인을 하는<br /> 주민번호 대체 수단 서비스입니다.<br />  - 공공I-PIN센터 : http://www.g-pin.go.kr</li>
										<li class="stxt">공인인증서, 신용카드, 휴대폰등으로 본인임을 확인하여 본인에게 비용이 전혀 부담되지 않습니다.</li>
									</ul>

									<a href="/sec/rnc/EgovGpinCnfirm.do" target="chkFrame" class="fr_btn"><img src="${HPG_IMG }/page/member/btn_ipin.gif" alt="공공I-PIN인증"/></a>
								</div>
								</c:if>
							</c:otherwise>
							</c:choose>

							</div>
						</div>
					</div>


<iframe src="#" frameborder="0" name="chkFrame" width="300" height="100" marginwidth="0" marginheight="0" scrolling="no"></iframe>

<c:import url="/hpg/tmplatBottom.do" charEncoding="utf-8"/>