<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>요청하신 페이지에 에러가 발생하였습니다. (error : ${exception.message})</title>
<link type="text/css" rel="stylesheet" href="/template/common/css/default.css" />
<script language="javascript">
alert('권한이 없습니다.');
location.href = "/";
</script>
</head>

<body>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="100%" align="center" valign="middle">

    <table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center">
        	<a href="/"><img src="/template/common/images/error500.gif" alt="서비스이용이 원할하지 않습니다."/></a>
        </td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>


