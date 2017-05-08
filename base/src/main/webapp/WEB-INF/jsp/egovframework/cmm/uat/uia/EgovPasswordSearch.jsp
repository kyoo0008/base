<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="02"/>
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

	<script type="text/javascript">
		<c:if test="${not empty message}">
			alert("<c:out value="${message}"/>");
		</c:if>
		
		function fnSearchId(form) {
			
			if ($('#id').val() =="") {
				alert("아이디를 입력하세요");
				return false;
			}
		}
		
		var CBA_window; 
		function openCBAWindow(){ 
		    CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
		    document.reqForm.action = 'https://name.siren24.com/vname/jsp/vname_j10.jsp';                     // 가상식별 실명확인서비스 URL
		    document.reqForm.target = 'CbaWindow';
		    document.reqForm.submit();
		}

		function checkReturnCallFn(retCd, niceNm, dupeInfo) {
			if (retCd == '1') {
				document.getElementById("ihidNum").value = dupeInfo;
				document.mberForm.submit();
			} else {//응답실패 
				alert("응답에 실패하였습니다.");
			}
		}
		
		$(document).ready( function() {
			  $('#authSci').click(function() {
				  document.mberForm.ihidNum.value = "20121123111910";
				  document.mberForm.submit();
			      return false;
			  });
			  
			  $('#authPin').click(function() {
				  document.mberForm.ihidNum.value = "20121123111910";
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
	</form:form>

	<form:form commandName="mberForm" name="mberForm" method="post" action="${pageContext.request.contextPath}/uat/uia/egovPasswordSearch.do">
		<input type="hidden"  name="id" value="<c:out value="${result.userId}"/>"/>
		<input type="hidden"  name="ihidNum" value=""/>
	</form:form>
	<iframe src="#" frameborder="0" name="chkFrame" width="0" height="0" marginwidth="0" marginheight="0" scrolling="no" title="내용없음"></iframe>
	
    <div id="sub_content">
				<h2><img src="${_IMG}/login/tit_pw_re.gif" alt="비밀번호재발급" /></h2>
			
				<!-- pw_re_box  start -->
				<div class="<c:out value="${empty result.userId ? 'pw_re_box' : 'pw_re_box2'}"/>">
					<form action="<c:url value="/uat/uia/egovPasswordSearchView.do"/>" method="post" onsubmit="return fnSearchId(this)">
						<fieldset>
							<legend>비밀번호 재발급 폼</legend>
							
							<div class="pwid_chk">
								<label for="id">아이디</label>
								<input type="text" id="id" name="id" value="<c:out value="${result.userId}"/>" class="inp"  />
							</div>
								
							<div class="btn_c">
								<span class="btn"><button type="submit">확인</button></span>
								<span class="btn2"><button type="reset">취소</button></span>
							</div>
							
							<c:if test="${not empty result.userId}">
								<div class="ipin_box">
									<div class="check">
										<span>실명인증</span>
										<p>회원가입 시 실명확인을 통해 가입하는 회원님께 실명확인을 통해 아이디를 확인하실 수 있습니다.</p>
										<input id="authSci" type="image" src="${_IMG}/login/btn_re2_chk.gif" alt="실명확인" />
									</div>
									<div class="ipin">
										<span>공공 아이핀(I-PIN) 인증</span>
										<p>회원가입 시 아이핀으로 가입하신 회원님께 아이핀인증을 통해 아이디를 확인하실 수 있습니다.</p>
										<input id="authPin" type="image" src="${_IMG}/login/btn_re2_ipin.gif" alt="공공 아이핀(I-PIN) 인증" />
									</div>
								</div>
							</c:if>

						</fieldset>
					</form>
				</div>
				<!-- //pw_re_box end -->
			</div>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>