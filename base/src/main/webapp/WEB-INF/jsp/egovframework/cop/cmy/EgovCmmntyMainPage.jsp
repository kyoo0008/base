<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ page import="egovframework.com.cmm.service.Globals" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8">
	<c:param name="trgetId"><c:out value="${searchVO.cmmntyId}" /></c:param>
</c:import>
<%
 /**
  * @Class Name : CmmntyMainPage.do
  * @Description : EgovCmmntyMainPage.jsp
  * @Modification Information 커뮤니티 메인페이지
  * 
  * @author 이호영
  * @since 2012.01.15
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function fn_egov_loadArticleList(bbsId, bbsAttrbCode) {
	}
	
	function fn_egov_loadArticle(bbsId, nttNo) {
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function fn_egov_loadArticleList(bbsId, bbsAttrbCode) {
		if (bbsId == '') {
			return;
		}
		
		document.frm.bbsId.value = bbsId;
		document.frm.action = "/cop/cmy/bbs/selectBoardList.do";
		document.frm.submit();	
	}
	
	function fn_egov_loadArticle(bbsId, nttNo) {
		document.frm.nttNo.value = nttNo;
		document.frm.bbsId.value = bbsId;
		document.frm.action = "/cop/cmy/bbs/selectBoardArticle.do";
		document.frm.submit();	
	}
//-->
</script>
</c:otherwise>
</c:choose>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.emplyrId}">
	<c:set var="SE_CODE" value="${USER_INFO.authorCode}" />
</c:if>
		<div class="cm_list_box">
			<div class="cm_list cm_notice">
				<h3>전체 최근 게시물</h3>
				<ul>
					<c:forEach var="articleNewLResult" items="${bbsNewList}" varStatus="status">
						<li>
							<span><c:out value="${articleNewLResult.bbsNm}"/></span> 
							<c:if test="${articleNewLResult.ordrCodeDp gt 0}">
							  <c:forEach begin="1" end="${articleNewLResult.ordrCodeDp}" step="1">&nbsp;</c:forEach><img src="${_IMG}/board/ico_reply.gif" alt="따라붙은글" />
					        </c:if>
					        <c:url var="viewUrl" value="${_PREFIX}/bbs/selectBoardArticle.do">
							  <c:param name="nttNo" value="${articleNewLResult.nttNo}" />
							  <c:param name="trgetId" value="${searchVO.cmmntyId}" />
							  <c:param name="bbsId" value="${articleNewLResult.bbsId}" />
						    </c:url>
							<c:choose>
								<c:when test="${SE_CODE eq '10'}"><a href="<c:out value="${viewUrl}"/>"><c:out value="${articleNewLResult.nttSj}" /></a></c:when>
								<c:when test="${articleNewLResult.othbcAt eq 'N' and USER_INFO.emplyrId ne articleNewLResult.frstRegisterId}"><c:out value="${articleNewLResult.nttSj}" /></c:when>
								<c:when test="${SE_CODE < articleNewLResult.searchAuth}"><c:out value="${articleNewLResult.nttSj}" /></c:when>
								<c:otherwise><a href="<c:out value="${viewUrl}"/>"><c:out value="${articleNewLResult.nttSj}" /></a></c:otherwise>
							</c:choose>
						</li>
					</c:forEach>
					<c:if test="${fn:length(bbsNewList) == 0}">
						<li class="empty">등록된 내용이 없습니다.</li>
					</c:if>
				</ul>
			</div>
		</div>
		
		<div class="cm_list_box">
			<c:forEach var="bbs" items="${bbsList}">
				<div class="cm_list">
					<h3><c:out value="${bbs.bbsNm}" /></h3>
					<ul>
						<c:forEach var="article" items="${bbs.ariticleList}" varStatus="status">
							<li>
								<c:if test="${article.ordrCodeDp gt 0}">
								  <c:forEach begin="1" end="${article.ordrCodeDp}" step="1">&nbsp;</c:forEach><img src="${_IMG}/board/ico_reply.gif" alt="따라붙은글" />
						        </c:if>
						        <c:url var="viewUrl" value="${_PREFIX}/bbs/selectBoardArticle.do">
								  <c:param name="nttNo" value="${article.nttNo}" />
								  <c:param name="trgetId" value="${searchVO.cmmntyId}" />
								  <c:param name="bbsId" value="${article.bbsId}" />
							    </c:url>
								<c:choose>
									<c:when test="${SE_CODE eq '10'}"><a href="<c:out value="${viewUrl}"/>"><c:out value="${article.nttSj}" /></a></c:when>
									<c:when test="${article.othbcAt eq 'N' and USER_INFO.emplyrId ne article.frstRegisterId}"><c:out value="${article.nttSj}" /></c:when>
									<c:when test="${SE_CODE < article.searchAuth}"><c:out value="${article.nttSj}" /></c:when>
									<c:otherwise><a href="<c:out value="${viewUrl}"/>"><c:out value="${article.nttSj}" /></a></c:otherwise>
								</c:choose>
								<span><fmt:formatDate value="${article.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></span>
							</li>
						</c:forEach>
						<c:if test="${fn:length(bbs.ariticleList) == 0}">
							<li class="empty">등록된 내용이 없습니다.</li>
						</c:if>
					</ul>
					<a href="${_PREFIX}/bbs/selectBoardList.do?bbsId=<c:out value="${bbs.bbsId}"/>&trgetId=<c:out value="${searchVO.cmmntyId}"/>" class="more">전체보기</a>
				</div>
			</c:forEach>
		</div>
		
	

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>