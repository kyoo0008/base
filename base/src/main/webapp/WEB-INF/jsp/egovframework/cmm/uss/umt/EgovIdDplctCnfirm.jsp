<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/member/css"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="address_html" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/login.css" type="text/css" charset="utf-8" /> 
<title>아이디중복확인</title>
<style type="text/css">
	body{background:none;}
</style>
<script type="text/javascript">

function fnCheckId(){
	var userId = document.checkForm.checkId.value;
	if(!fnCheckUserIdLength(userId) || !fnCheckSpace(userId) || !fnCheckNotKorean(userId) || !(fnCheckEnglish(userId) && fnCheckDigit(userId) && !fnCheckTksu(userId))){
    	alert("아이디는 띄어쓰기 없는 영문+숫자 조합 8~20자 내에서 입력해야 합니다.");
    	return false;
	}
	
}
function fnReturnId(){
	var retVal="";
    if (document.checkForm.usedCnt.value == 0){
	    retVal = document.checkForm.resultId.value;
        opener.fn_egov_return_IdCheck(retVal);
        window.close();
    }else if (document.checkForm.usedCnt.value == 1){
        alert("이미사용중인 아이디입니다.");
        return;
    }else{
    	alert("먼저 중복확인을 실행하십시오");
        return;
    }
}
function fnClose(){

    window.close();
}

function fnCheckUserIdLength(str) {
    if (str.length < 8 || str.length > 20 ){
            return false;
    }
    return true;
}

function fnCheckSpace(str){
		for (var i=0; i < str .length; i++) {
		    ch_char = str .charAt(i);
		    ch = ch_char.charCodeAt();
		        if(ch == 32) {
		            return false;
		        }
		}
	    return true;
	}

function fnCheckNotKorean(koreanStr){                  
    for(var i=0;i<koreanStr.length;i++){
        var koreanChar = koreanStr.charCodeAt(i);
        if( !( 0xAC00 <= koreanChar && koreanChar <= 0xD7A3 ) && !( 0x3131 <= koreanChar && koreanChar <= 0x318E ) ) { 
        }else{
            //hangul finding....
            return false;
        }
    }
    return true;
}

function fnCheckTksu(str) { 
	for (var i=0; i < str .length; i++) {
	    ch_char = str .charAt(i);
	    ch = ch_char.charCodeAt();
	        if( !(ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126) ) {
	            
	        } else {
	        	return true;
	        }
	}
    return false;
    
}

function fnCheckEnglish(str){
		for(var i=0;i<str.length;i++){
			var EnglishChar = str.charCodeAt(i);
			if( !( 0x61 <= EnglishChar && EnglishChar <= 0x7A ) && !( 0x41 <= EnglishChar && EnglishChar <= 0x5A ) ) {
				
			} else {
        	return true;
        }
		}
		return false;
}

function fnCheckDigit(str) {  
	for (var i=0; i < str .length; i++) {
	    ch_char = str .charAt(i);
	    iValue = parseInt(ch_char);
        if(isNaN(iValue)) {
           
        } else {
        	return true;
        }
	}
    return false;
    
}

</script>
</head>

 <body>

		<div class="pop_tit">
			<h1>아이디중복확인</h1>
		</div>

	
		<div class="pop_con">
			
			<form name="checkForm" action="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do'/>" method="post" onsubmit="return fnCheckId();">
				<input type="hidden" name="resultId" value="<c:out value="${checkId}"/>" />
		        <input type="hidden" name="usedCnt" value="<c:out value="${usedCnt}"/>" />
				<fieldset>
					<legend>아이디중복확인</legend>
					
					<div class="pop_gbox">
						
						<c:choose>
			                <c:when test="${usedCnt eq -1}">
			                	<div class="id_ok">
									<span class="orange">중복확인을 실행하십시오</span>
								</div>
			                </c:when>
			                <c:when test="${usedCnt eq 0}">
			                	<div class="id_ok">
									<span class="orange">사용 가능한 아이디입니다.</span>
									<input type="image" onclick="fnReturnId(); return false;" src="${_IMG}/login/btn_use.gif" alt="사용하기" />
								</div>
			                </c:when>
			                <c:otherwise>
			                	<div class="id_no">
									<p><span style="color:#ee8342;">이미 사용중인 아이디</span>입니다.</p>
									<p>다른 아이디를 입력해주세요.</p>
								</div>
			                </c:otherwise>
		                </c:choose>

					</div>


				<div class="id_chk">
						<input type="text" class="inp" id="checkId" name="checkId" value="<c:out value="${checkId}"/>" />
						<span class="btn_s"><button type="submit">중복확인</button></span>
				</div>
				</fieldset>
			</form>
		</div>

		<button class="pop_mclose" onclick="window.close(); return false;">닫기</button>




 </body>
</html>
