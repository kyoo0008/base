<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="HPG_IMG" value="/template/homepage/011/images"/>
<c:set var="HPG_CSS" value="/template/homepage/011/css"/>
<c:set var="_PREFIX" value="/evt"/>
<%!
public static String nl2br(String str) {
	str = str.replaceAll("\r\n", "<br>");
	str = str.replaceAll("\r", "<br>");
	str = str.replaceAll("\n", "<br>");
	return str;
}
%>
			
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" type="text/css" href="${HPG_CSS}/default.css" charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="${HPG_CSS}/page.css" charset="utf-8" />
		<title>이벤트 신청자정보</title>

		<script type="text/javascript">
		
		function checkForm(form) {			
		
			if(form.adhrncNm.value == "") {
				alert("참가자 이름을 입력해주세요");
				form.adhrncNm.focus();
				return false;
			}
			if(form.adhrncCttpc.value == "") {
				alert("참가자 연락처를 입력해주세요");
				form.adhrncCttpc.focus();
				return false;
			}
			if(form.adhrncZip.value == "") {
				alert("참가자 우편번호를 입력해주세요");
				form.adhrncZip.focus();
				return false;
			}
			if(form.adhrncAdres.value == "") {
				alert("참가자 주소를 입력해주세요");
				form.adhrncAdres.focus();
				return false;
			}
			if(form.adhrncEmail.value == "") {
				alert("참가자 이메일을 입력해주세요");
				form.adhrncEmail.focus();
				return false;
			}
			if(confirm('이벤트에 참여 하시겠습니까?')) {
				return true;
			}else {
				return false;
			}
		}	
		
		</script>
		<style type="text/css">
			.event_cont{background:url('${EventFileStoreWebPath}${comtnschdulinfoVO.middleStreFileNm}') 0 0 repeat-y;width:480px;padding:20px 50px}
		</style>
	</head>

<body>

<div id="content">
		<img src="<c:url value='${EventFileStoreWebPath}${comtnschdulinfoVO.upendStreFileNm}'/>" alt="이벤트 상단" />
		<div class="event_cont">
			<form:form commandName="comtneventadhrncVO" name="comtneventadhrncVO" action="${_PREFIX}/addComtnschdulEventUser.do">
			<input type="hidden" name="schdulId" value="<c:url value='${searchVO.schdulId}'/>" />
			<input type="hidden" name="schdulClCode" value="<c:url value='${comtnschdulinfoVO.schdulClCode}'/>" />
			<input type="hidden" name="userId" value="tmpId" />
				<fieldset>
					<legend>참가자 기본정보</legend>
						<table class="chart2" summary="이벤트 사용자 정보를 입력하는 표입니다." >
							<colgroup>
								<col width="120"/>
								<col width=""/>
							</colgroup>
							<tbody>
									<tr>
										<th>참가자 이름</th>
										<td>
											<input type="text" name="adhrncNm" value="테스터" class="inp"/>
										</td>			
									</tr>
									<tr>
										<th>참가자 연락처</th>
										<td>
											<input type="text" name="adhrncCttpc" value="000-0000-0000" class="inp"/>
										</td>			
									</tr>
									<tr>
										<th>우편번호</th>

										<td>
											<input type="text" name="adhrncZip" value="000-000" class="inp"/>
										</td>			
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<input type="text" name="adhrncAdres" value="대전광역시 중구 문화로 234번길 54 충청남도교육연구정보원" class="inp wid350"/>
										</td>			
									</tr>

									<tr>
										<th>이메일</th>
										<td>
											<input type="text" name="adhrncEmail" value="test@test.com" class="inp wid350"/>
										</td>			
									</tr>
							</tbody>
						</table>
									
						<div class="btn_c">
							<input type="image" src="${HPG_IMG}/page/popup/btn_confirm02.gif" alt="확인" onclick="return checkForm(document.comtneventadhrncVO);"/>
						</div>
				</fieldset>
			</form:form>
		</div>
		<div><img src="<c:url value='${EventFileStoreWebPath}${comtnschdulinfoVO.lptStreFileNm}'/>" alt="" /></div>
	</div>

</body>
</html>