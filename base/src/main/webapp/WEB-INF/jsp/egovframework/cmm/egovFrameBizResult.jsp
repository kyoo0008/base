<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결과</title>
<script type="text/javascript">

	<c:choose>
		<c:when test="${resultType eq 'MY_BCRN'}">
			<c:if test="${not empty resultFunctionValue}">
				if(parent.fn_egov_save_result_action) {
					parent.fn_egov_save_result_action('http://${siteInfo.siteUrl}${MembersFileStoreWebPath}${resultFunctionValue.streFileNm}');
				}
			</c:if>	
		</c:when>
		<c:when test="${resultType eq 'BCRN'}">
			<c:if test="${not empty resultFunctionValue}">
				if(parent.fn_egov_save_result_action) {
					parent.fn_egov_save_result_action('http://${siteInfo.siteUrl}${BackgroundFileStoreWebPath}${resultFunctionValue.imageFileNm}');
				}
			</c:if>	
		</c:when>
		<c:when test="${resultType eq 'MY_MNU'}">
			<c:if test="${not empty resultFunctionValue}">
				if(parent.fn_egov_save_result_cus_action) {
					parent.fn_egov_save_result_cus_action('${resultFunctionValue.indvdlFileId}', 'http://${siteInfo.siteUrl}${MembersFileStoreWebPath}${resultFunctionValue.streFileNm}', '${resultFunctionValue.title}', '${resultFunctionValue.url}', '${resultFunctionValue.dc}');
				}
			</c:if>	
		</c:when>
		<c:when test="${resultType eq 'MNU'}">
			<c:if test="${not empty resultFunctionValue}">
				if(parent.fn_egov_save_result_action) {
					parent.fn_egov_save_result_action('${resultFunctionValue.trgetId}');
				}
			</c:if>	
		</c:when>
	</c:choose>
	
	<c:if test="${not empty resultMessage}">
		alert('<spring:message code="${resultMessage}" />');
		//parent.fn_egov_save_result_action('${resultValue}');
		//top.document.location.reload();
	</c:if>
</script>
</head>
<body>

</body>
</html>