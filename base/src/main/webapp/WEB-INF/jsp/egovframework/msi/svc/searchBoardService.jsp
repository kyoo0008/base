<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${param.tmplatCours}"/>
  <c:forEach var="result" items="${resultList}" varStatus="status">
    <c:url var="viewUrl" value="http://${result.siteUrl}/cop/bbs/selectBoardArticle.do">
		<c:param name="nttNo" value="${result.nttNo}" />
		<c:param name="menuId" value="${result.menuId}" />
		<c:param name="bbsId" value="${result.bbsId}" />
    </c:url>
	
	<div class="mbox${status.count}">
		<h3 class="hdn">말풍선 한마디</h3>
		<div  class="bubble<c:if test="${status.count eq 3 or status.count eq 5}">2</c:if>">
			<div class="txt"><a href="<c:out value="${viewUrl}"/>" target="_blank"><c:out value="${fn:length(result.nttSj) > 50 ? fn:substring(result.nttSj, 0, 50) : result.nttSj}"/></a></div>
		</div>
		<div class="bubble_tail"><img src="${_IMG}/bg_bubble_bottom<c:if test="${status.count eq 3 or status.count eq 5}">02</c:if>.png" alt="" /></div>
	</div>
  </c:forEach>