<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="step" value="2"/>
</c:import>
<%

//날짜 생성
java.util.Calendar today = java.util.Calendar.getInstance();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
String day = sdf.format(today.getTime());

java.util.Random ran = new java.util.Random();
//랜덤 문자 길이
int numLength = 6;
String randomStr = "";

for (int i = 0; i < numLength; i++) {
    //0 ~ 9 랜덤 숫자 생성
    randomStr += ran.nextInt(10);
}

//reqNum은 최대 30byte 까지 사용 가능
String reqNum = day + randomStr;		

String id       = "FHB001";                            // 가상식별실명확인 회원사 아이디
String srvNo    = "001001";                            // 가상식별실명확인 서비스번호
String exVar    = "0000000000000000";                  // 복호화용 임시필드

/**
*
* reqNum 값은 최종 결과값 복호화를 위한 SecuKey로 활용 되므로 중요합니다.
* reqNum 은 실명 확인 요청시 항상 새로운 값으로 중복 되지 않게 생성 해야 합니다.
* 쿠키 또는 Session및 기타 방법을 사용해서 reqNum 값을 
* vname_result_seed.jsp에서 가져 올 수 있도록 해야 함.
* 샘플을 위해서 쿠키를 사용한 것이므로 참고 하시길 바랍니다.
*
*/
session.setAttribute("reqNum", reqNum);

//01. 암호화 모듈 선언
com.sci.v2.comm.secu.SciSecuManager seed  = new com.sci.v2.comm.secu.SciSecuManager();

//02. 1차 암호화
String encStr = "";
String reqInfo      = id+"/"+srvNo+"/"+reqNum+"/"+exVar;  // 데이터 암호화
encStr              = seed.getEnc(reqInfo, "");

//03. 위변조 검증 값 생성
com.sci.v2.comm.secu.hmac.SciHmac hmac = new com.sci.v2.comm.secu.hmac.SciHmac();
String hmacMsg = hmac.HMacEncript(encStr);

//03. 2차 암호화
reqInfo  = seed.getEnc(encStr + "/" + hmacMsg + "/" + "0000000000000000", "");  //2차암호화
%>
<script type="text/javaScript" language="javascript" defer="defer">

var CBA_window; 
function openCBAWindow(){ 
    CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
    document.reqForm.action = 'https://name.siren24.com/vname/jsp/vname_j10.jsp';                     // 가상식별 실명확인서비스 URL
    document.reqForm.target = 'CbaWindow';
    document.reqForm.submit();
}

function checkReturnCallFn(retCd, niceNm, dupeInfo) {
	if (retCd == '1') {
		document.getElementById("userNm").value = niceNm;
		document.getElementById("credtId").value = dupeInfo;
		document.mberForm.submit();
	} else {//응답실패 
		alert("응답에 실패하였습니다.");
	}
}
<%
egovframework.com.utl.cas.service.EgovSessionCookieUtil.setSessionAttribute(request, "dupInfo", day);
egovframework.com.utl.cas.service.EgovSessionCookieUtil.setSessionAttribute(request, "realName", "테스터");
egovframework.com.utl.cas.service.EgovSessionCookieUtil.setSessionAttribute(request, "birthDate", "20010101");
egovframework.com.utl.cas.service.EgovSessionCookieUtil.setSessionAttribute(request, "sex", "1");
egovframework.com.utl.cas.service.EgovSessionCookieUtil.setSessionAttribute(request, "foreigner", "1");
%>
$(document).ready( function() {
	  $('#authSci').click(function() {
		  document.mberForm.submit();
	      return false;
	  });
	  
	  $('#authPin').click(function() {
		  document.mberForm.submit();
	      return false;
	  });
	});
/*
$(document).ready( function() {
	  $('#authSci').click(function() {
		  openCBAWindow();
	      return false;
	  });
	  
	  $('#authPin').click(function() {
		  document.reqForm.action = '/sec/rnc/EgovGpinCnfirm.do';                     // I-PIN 인증창 연결
		  document.reqForm.target = 'chkFrame';
		  document.reqForm.submit();
	      return false;
	  });
	});
*/	
</script>

<form:form commandName="reqForm" name="reqForm" method="post">
	<input type="hidden" name="reqInfo"     value = "<%=reqInfo%>" />
    <input type="hidden" name="retUrl"      value = "22http://${siteInfo.siteUrl}/sec/rnc/EgovRlnmCnfirmChk.do" />
    <input type='hidden' name='userSeCode' value="<c:out value="${searchVO.userSeCode}"/>"/>
    <input type="hidden" name="siteId" value="${searchVO.siteId}"/>
</form:form>

<form:form commandName="mberForm" name="mberForm" method="post" action="/uss/umt/user/EgovUserInsertView.do">
	<input type='hidden' name='userSeCode' value="<c:out value="${searchVO.userSeCode}"/>"/>
	<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
	<input type="hidden" name="userNm"	id="userNm"/>
	<input type="hidden" name="credtId" id="credtId"/>
	<input type="hidden" name="grade" value="${user.grade }" />
</form:form>
<iframe src="#" frameborder="0" name="chkFrame" width="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
				<h2 class="icon1">가입인증</h2>
				<p class="mB20">별도의 회원가입을 하지않아도 됩니다<br /> 본 사이트를 이용하기 위한 아이디 및 비밀번호는 학교에서 별도로 제공 됩니다.</p>

				<h3 class="icon2">실명인증</h3>
				<div class="confirm_box">
					<ul>
						<li class="blue">* 주민등록번호 입력 없이 생년월일로 회원가입이 가능합니다.</li>
						<li>* 이름, 생년월일, 성별은 추후 변경할 수 없습니다.</li>
					</ul>

					<a href="https://name.siren24.com/vname/jsp/vname_j10.jsp" id="authSci" target="_blank" class="btn2" ><span>실명인증</span></a>
				</div>

				<h3 class="icon2">공공 아이핀(I-PIN)인증</h3>
				<div class="confirm_box">
					<p class="blue mB20">회원가입 시 개인정보보호를 위해 주민등록번호 외 본인확인 할 수 있는 공공 아이핀(I-PIN)을 운영중입니다.</p>
					
					<ul>
						<li>- 주민등록번호 입력 없이 생년월일로 회원가입이 가능합니다.</li>
						<li>- 이름, 생년월일, 성별은 추후 변경할 수 없습니다.</li>
					</ul>

					<a href="${pageContext.request.contextPath}/sec/rnc/EgovGpinCnfirm.do" id="authPin" target="_blank" class="btn2"><span>공공아이핀(I-PIN)인증</span></a>
				</div>

<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>