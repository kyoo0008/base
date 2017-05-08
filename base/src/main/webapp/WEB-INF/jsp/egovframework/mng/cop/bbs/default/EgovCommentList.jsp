<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/bbs"/>

<% /*URL 정의*/ %>
<c:url var="_BASE_PARAM" value="">
	<c:param name="nttNo" value="${param.nttNo}" />
	<c:param name="bbsId" value="${param.bbsId}" />
	<c:param name="trgetId" value="${searchVO.trgetId}" />
	<c:param name="pageIndex" value="${param.pageIndex}" />
	<c:param name="searchCnd" value="${param.searchCnd}" />
	<c:param name="searchWrd" value="${param.searchWrd}" />
	<c:param name="searchCate" value="${param.searchCate}" />
	<c:param name="siteId" value="${param.siteId}"/>
	<c:param name="sysTyCode" value="${param.sysTyCode}"/>
	<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
		<c:if test="${not empty searchCate}">
			<c:param name="searchCateList" value="${searchCate}" />
		</c:if>
	</c:forEach>
</c:url>
<% /*URL 정의*/ %>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="comment" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
function fn_egov_insert_commentList(frm) {
	if (!validateComment(frm)){
		return false;
	}
	
	if (!confirm('<spring:message code="common.regist.msg" />')) {
		return false;
	}				
}

function fn_egov_deleteCommentList(url) {

	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.location.href = url;
	}
}

function addComment(commentNo, num, ordrCode, ordrCodeDp) {
	jQuery(".replyComment").html("");
	jQuery("#replyComment"+num).html(
			"<div>"+
			"<form name='commentVO' action='${_PREFIX}/insertReplyComment.do' method='post' onsubmit='return fn_egov_insert_commentList(this);'>"+
				"<input type='hidden' name='siteId' value='${param.siteId}'/>" +
				"<input type='hidden' name='sysTyCode' value='${param.sysTyCode}' />" +			
				"<input type='hidden' name='pageIndex' value='${param.pageIndex}'/>" +
				"<input type='hidden' name='bbsId' value='${param.bbsId}' />" +		
				"<input type='hidden' name='trgetId' value='${param.trgetId}' />" +		
				"<input name='searchCnd' type='hidden' value='${param.searchCnd}'/>" +
				"<input name='searchWrd' type='hidden' value='${param.searchWrd}'/>" +
				"<input name='searchCate' type='hidden' value='${param.searchCate}'/>" +
				<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
		  			<c:if test="${not empty searchCate}">
		  			"<input name='searchCateList' type='hidden' value='${searchCate}'/>" +
		  			</c:if>
		  		</c:forEach>
				"<input name='subPageIndex' type='hidden' value='${searchVO.subPageIndex}' />" +
				"<input name='modified' type='hidden' value='false'/>" +
				"<input type='hidden' name='nttNo' value='" + ${param.nttNo} + "'/>"+
				"<input type='hidden' name='commentNo' value='" + commentNo + "'/>"+
				"<input type='hidden' name='ordrCode' value='" + ordrCode + "'/>"+
				"<input type='hidden' name='ordrCodeDp' value='" + ordrCodeDp + "'/>"+
				"<textarea class='com_cont_w' id='reply_txt' name='commentCn'></textarea>"+
				"<input type='image' src='${_C_IMG}/page/board/btn_comment.gif' alt='덧글달기'/>"+
			"</form>"+
			"</div>"
	);
	return false;
}
</script>

<div class="comment">
	<form name="comment" id="comment" method="post" action="<c:url value='${_PREFIX}/insertComment.do'/>" onsubmit="return fn_egov_insert_commentList(this);">
		<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/>
		<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
		<input type="hidden" name="nttNo" value="<c:out value='${param.nttNo}'/>" />
		
		<input name="searchCnd" type="hidden" value="<c:out value="${param.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${param.searchWrd}"/>"/>
		<input name="searchCate" type="hidden" value="<c:out value="${param.searchCate}"/>"/>
		
		<input type="hidden" name="siteId" value="<c:out value='${param.siteId}'/>"/>
		<input type="hidden" name="sysTyCode" value="<c:out value='${param.sysTyCode}'/>"/>
		<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
			<c:if test="${not empty searchCate}">
				<input name="searchCateList" type="hidden" value="<c:out value="${searchCate}"/>"/>
			</c:if>
		</c:forEach>

		<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>"/>
		<input name="modified" type="hidden" value="false"/>
	
		<div class="com_write">
			<c:if test="${empty sessionUniqId}">
				<p class="com_txt">덧글을 작성하시려면 <strong>로그인</strong>이 필요합니다.</p>
			</c:if>
			<label for="reply_txt" class="hdn">덧글입력</label>
				<textarea name="commentCn" class="com_cont_w" id="reply_txt"></textarea>
				<input type="image" src="${_C_IMG}/sub/board/btn_comment.gif" alt="덧글달기"/>
		</div>
	</form>

	<div class="com_list">
		<c:if test="${fn:length(resultList) > 0}">		
		<p class="reply_total">
			<strong class="org">덧글${paginationInfo.totalRecordCount}개</strong> <img src="${_C_IMG}/sub/board/icon_new.gif" alt="new" />
		</p>
		</c:if>
			
		<c:forEach var="result" items="${resultList}" varStatus="status">					
		<div class="com_cont_box">	
			<c:set var="ml" value="${result.ordrCodeDp * 30}"/>			
			<c:if test="${result.ordrCodeDp > 0 }">				
			<div style="float:left; width:${(result.ordrCodeDp+1) * 20}px;text-align:right;">
				<img src="${_C_IMG}/page/board/icon_re.gif" alt="답글"/>			
			</div>			
			</c:if>		
			<div class="writer_info"><strong class="name"><c:out value="${result.wrterNm}" /></strong> | <span class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
			<ul class="reply_list">
				<li><a href="#reply_txt" class="icon01" onclick="return addComment(${result.commentNo}, ${status.count}, '${result.ordrCode }', ${result.ordrCodeDp });">답글</a></li>
				<!--<li><a href="#link" class="icon02">신고</a></li> -->
				<c:url var="delUrl" value="${_PREFIX}/deleteComment.do${_BASE_PARAM}">
					<c:param name="commentNo" value="${result.commentNo}" />
					<c:param name="subPageIndex" value="${searchVO.subPageIndex}" />
					<c:param name="modified" value="true" />
				</c:url>
				<li><a href="<c:out value="${delUrl}"/>" onclick="fn_egov_deleteCommentList(this.href);return false;" class="icon03">삭제</a></li>
			</ul> 
			<div class="com_cont" style="padding-left:${(result.ordrCodeDp+1) * 20}px;">
				<c:set var="cn" value="${fn:escapeXml(result.commentCn)}"/>
				<c:set var="cn" value="${fn:replace(cn , crlf , '<br>')}"/>
				<c:out value="${cn}" escapeXml="false" />
			</div>
			<div id="replyComment${status.count }" class="replyComment"></div>			
		</div>
		</c:forEach>
	</div>
	<div id="paging">
	    <c:url var="pageUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
	    </c:url>					
	    <ul>
	      <ui:pagination paginationInfo="${paginationInfo}" type="smart_001_sub" jsFunction="${pageUrl}" />
	    </ul>
	</div>
</div>

  
  <c:if test="${not empty subMsg}">
	<script type="text/javascript">
    	alert("<c:out value='${subMsg}'/>");
  	</script>
  </c:if>
