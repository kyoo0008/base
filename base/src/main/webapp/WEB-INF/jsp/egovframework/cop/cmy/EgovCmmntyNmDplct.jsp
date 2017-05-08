<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}"/>
<c:set var="_PREFIX" value="/cop/cmy"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="${_CSS}/style.css" type="text/css" charset="utf-8" />
		<title>커뮤니티이름 중복확인</title>
		<script type="text/javaScript" language="javascript">
			function fn_egov_dplct_cmmnty(form){
				var cName = form.cmmntyNm;
				if (cName.value == "" || cName.length > 50 || cName.length < 3) {
					alert("커뮤니명은 3~50자 이내 입력하실수 있습니다.");
					return false;
				}
			}
			
			function fn_egov_cmmntyNm_used(form){
				var retVal="";
				
			    if (document.checkForm.retrunCnt.value == 0){
				    retVal = document.checkForm.resultNm.value;
			        opener.communityTitleSelect(retVal);
			        window.close();
			        return true;
			    }
			    if (document.checkForm.retrunCnt.value == 1){
			        alert("이미 사용중인 커뮤니티명 입니다.");
			        return false;
			    }
			    
			    alert("먼저 커뮤니티명을 중복확인 하여 주십시오");
			    return false;
		
			}		
		</script>
	</head>

	 <body>


				<div class="pop_tit">
					<h1>커뮤니티이름 중복확인</h1>
				</div>

				<div class="pop_cont">
					
					<c:choose>
		                <c:when test="${cmmntyNmCnt eq -1}">
		                	<div class="cm_name">
								 커뮤니티 명을 입력하신후 중복확인을 실행 하십시오.
							</div>
		                </c:when>
		                <c:when test="${cmmntyNmCnt eq 0}">
		                	<div class="cm_name">
								<strong><c:out value="${cmmntyVO.cmmntyNm}"/></strong> 은(는) 사용 가능한 커뮤니티 이름 입니다.<br />
								현재 커뮤니티 이름를 사용하시려면 사용하기 버튼을 클릭해 주세요.
							</div>
		
							<div class="btn_c">
								<span class="btn"><button type="button" onclick="return fn_egov_cmmntyNm_used();">커뮤니티명 사용하기</button></span>
							</div>
		                </c:when>
		                <c:otherwise>
		                	<div class="cm_name">
								<strong><c:out value="${cmmntyVO.cmmntyNm}"/></strong> 은(는) 사용할수 없는 커뮤니티 명 입니다.<br />
								다른 커뮤니티 명을 선택 하여 주십시오
							</div>
		                </c:otherwise>
	                </c:choose>
	                
					<div class="cm_form">
						<form name="checkForm" action="<c:url value='${_PREFIX}/selectCmmntyNmDplct.do'/>" method="post" onsubmit="return fn_egov_dplct_cmmnty(this);">
							<input type="hidden" name="resultNm" value="<c:out value="${cmmntyVO.cmmntyNm}"/>" />
							<input type="hidden" name="retrunCnt" value="<c:out value="${cmmntyNmCnt}"/>" />
							<fieldset>
								<legend>커뮤니티 이름 중복확인 입력폼</legend>
								<label for="">다른 커뮤니티 이름 중복확인</label>
								<input type="text" name="cmmntyNm" value="<c:out value="${cmmntyVO.cmmntyNm}"/>" class="inp" />
								<span class="btn7"><button type="submit">중복확인</button></span>
							</fieldset>
						</form>
					</div>
				
					<!-- pw_re_box  start -->
					<div class="address_box">

					</div>
					<!-- //pw_re_box end -->

				</div>

				<button class="pop_close" onclick="window.close(); return false;">닫기</button>

	

	 </body>
</html>

