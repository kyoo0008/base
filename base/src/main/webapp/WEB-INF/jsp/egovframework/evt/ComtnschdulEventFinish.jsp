<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_PREFIX" value="/evt"/>
<c:choose>
	<c:when test="${comtnschdulinfoVO.schdulClCode eq '2'}"><c:set var="EVT_TYPE" value="이벤트"/></c:when>
	<c:otherwise><c:set var="EVT_TYPE" value="설문조사"/></c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="keywords" content="<c:out value="${siteInfo.siteNm}"/>" />
<meta name="subject" content="<c:out value="${siteInfo.siteNm}"/>" />
<meta name="description" content="여기는 <c:out value="${siteInfo.siteNm}"/> 사이트입니다." />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="author" content="onmakers" />
<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
<title><c:url value='${EVT_TYPE}'/> 참여 결과</title>
</head>
<body>

<div class="popbox">

	<div class="popboxtop">
		<h3 class="popboxh3"><c:url value='${EVT_TYPE}'/> 결과</h3>
		<p class="popboxclose"><a href="#" onclick="window.close(); return false;" title="팝업창닫기"><img src="${_IMG}/calendar/popbox_close.gif" alt="닫기" /></a></p>
	</div>

          <h5 class="t_title">&nbsp;&nbsp;&nbsp;<c:url value='${EVT_TYPE}'/> 처리결과 메세지</h5>
          <table width="95%" align="center" summary="커뮤니티 메세지">
            <tr>
              <td class="bold">
				<div  class="boardSearch">

              		<c:choose>
					<c:when test="${comtnschdulinfoVO.isError}">
						<br/><br/><b><c:url value='${comtnschdulinfoVO.errorMessage}'/></b><br/><br/>
					</c:when>
					<c:otherwise>
						<br/><br/><c:url value='${EVT_TYPE}'/>에 참여 하여 주셔서 감사합니다.<br/><br/>			
					</c:otherwise>
					</c:choose>
				</div>
              </td>
            </tr>
          </table>

</div>
</body>
</html>
