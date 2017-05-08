<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body onload="realNameSubmit()">
<script language="javascript">
function realNameSubmit(){
	var retCd = '${retCd}';
	var realName = '${realName}';
	var dupInfo = '${dupInfo}';

	parent.checkReturnCallFn(retCd, realName, dupInfo);
}	
</script>
</body>
