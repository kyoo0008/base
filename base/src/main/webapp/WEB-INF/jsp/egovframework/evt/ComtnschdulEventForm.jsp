<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
		<title>참여자정보</title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/SmartEditorBasic/js/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		
		function checkForm(form) {			
			oEditors.getById["reqstCn"].exec("UPDATE_IR_FIELD", []);
		
			if(confirm('이벤트 신청을 하시겠습니까?')) {
				return true;
			}else {
				return false;
			}
		}	
		window.resizeTo(700, 700);
		</script>
	</head>

<body>


<c:choose>
	<c:when test="${not empty comtnschdulinfoVO.upendStreFileNm}">
	<table>
		<tr>
			<td>
				<img src="<c:url value='${EventFileStoreWebPath}${comtnschdulinfoVO.upendStreFileNm}'/>" />
			</td>			
		</tr>
		<tr>
			<td background="<c:url value='${EventFileStoreWebPath}${comtnschdulinfoVO.middleStreFileNm}'/>" style="padding-left:30px;padding-right:30px;height:200px;">
	</c:when>
	<c:otherwise>
	<div id="g_pop">
		<h1 class="tit"><img src="${_IMG}/calendar/tit_evt_html.gif" alt="이벤트신청양식(HTML)" /></h1>
	</c:otherwise>
</c:choose>

		<div class="content">
			<form:form method="post" commandName="comtneventformaswperVO" action="addComtnschdulPop.do">
			<input type="hidden" name="schdulId" value="<c:url value='${comtnschdulForm.schdulId}'/>" />
			<input type="hidden" name="reqstId" value="<c:url value='${comtnschdulForm.reqstId}'/>" />

			<textarea name="reqstCn" id="reqstCn" style="width:100%; height:400px; display:none;"><c:out value="${comtnschdulForm.reqstForm}" /></textarea>
				<script>
				var oEditors = [];
					nhn.husky.EZCreator.createInIFrame({
						oAppRef: oEditors,
						elPlaceHolder: "reqstCn",
						sSkinURI: "/template/common/js/SmartEditorBasic/SEditorSkin.html",
						fCreator: "createSEditorInIFrame"
					});

			</script>
										
									
			<div class="btn_c">
				<input type="image" src="${_IMG}/calendar/btn_ok.gif" alt="확인" onclick="return checkForm(document.comtneventformaswperVO);"/>
			</div>

			</form:form>
		</div>


<c:choose>
	<c:when test="${not empty comtnschdulinfoVO.upendStreFileNm}">
		<tr>
			<td>
				<img src="<c:url value='${EventFileStoreWebPath}${comtnschdulinfoVO.lptStreFileNm}'/>" />
			</td>			
		</tr>
	</table>
	</c:when>
	<c:otherwise>

			<a href="" class="g_close"><img src="${_IMG}/calendar/btn_close.gif"  onclick="self.close()" alt="창닫기" /></a>
		</div>
	</c:otherwise>
</c:choose>
</body>
</html>