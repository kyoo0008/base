<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인증서 등록</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/epki/epkiwctl.js"></script>
<script type="text/javascript">

	 	//EPKIWCtl 설치 확인 및 객체 생성
		SetupObjEWC(true);

		//EPKIWCtl 공통 속성 지정
		if(CheckObjEWC())
			InitObjEWC();
	
	 	// 인증서 실행
		function RequestVerifyVID_NO()
		{
			<c:if test="${not empty serverCert}">
				var strRequestData;
				var frm = document.hiddenForm;
				// 서버 kmCert 설정(Base64 인코딩 문자열)
				ObjEWC.SetProperty("ServerCert", "${serverCert}");
				
				strRequestData = ObjEWC.RequestSession("SEED", "${sessionId}");
		
				if(strRequestData != ""){	
					frm.requestData.value = strRequestData;
					frm.target = "frmDn";
					frm.action = "<c:url value='/uat/uia/EgovUserRegistDn.do'/>";
					frm.submit();
				}
			</c:if>
			<c:if test="${empty serverCert}">
				alert("시스템에 문제가있어 진행할 수 없습니다.");
				window.close();
			</c:if>
		}
</script>
</head>
<body onload="RequestVerifyVID_NO()">
<form name="hiddenForm" action="<c:url value='/uat/uia/EgovUserRegistDn.do'/>" method="post">
	<input type="hidden" name="requestData"/>
	<input type="hidden" name="closeYn" value="Y"/>
	<input type="hidden" name="userId" value="${resultVO.id}"/>
</form>
<iframe name="frmDn" style="width:0px; height:0px;"></iframe>
</body>
</html>