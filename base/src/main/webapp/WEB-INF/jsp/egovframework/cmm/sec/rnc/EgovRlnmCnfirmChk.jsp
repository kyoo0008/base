<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>

<body onload="realNameSubmit()">
<script language="javascript">
function realNameSubmit(){
	var retCd = '${retCd}';
	var realName = '${realName}';
	var dupInfo = '${dupInfo}';
	
	opener.checkReturnCallFn(retCd, realName, dupInfo);
	self.close();
}	
</script>
</body>