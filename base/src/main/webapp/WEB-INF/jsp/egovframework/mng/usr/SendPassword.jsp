<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body onload="resultPassSubmit()">
<script language="javascript">
function resultPassSubmit(){

	<c:if test='${not empty message}'>
	alert("${message}");
	</c:if>
	
	parent.location.reload();
}	
</script>
</body>
