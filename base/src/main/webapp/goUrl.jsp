<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>세종진로진학</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<c:if test="${not empty param.sLink}">
  <meta http-equiv="refresh" content="0; url=${param.sLink}"/>
</c:if>
</head>
<body>
  <c:if test="${empty param.sLink}">
    <span>사이트를 선택하세요</span>
  </c:if>
</body>
</html>
