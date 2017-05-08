<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="_C_JS" value="/template/common/js"/>
<c:set var="_C_IMG" value="/template/common/images"/>
<c:set var="_IMG" value="${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId }/images"/>

<c:set var="_PREFIX" value="/cop/bbs"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">	 
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />	
</c:if>

<% /*URL 정의*/ %>
<c:url var="_BASE_PARAM" value="">
	<c:param name="nttNo" value="${param.nttNo}" />
	<c:param name="bbsId" value="${param.bbsId}" />
	<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
	<c:if test="${not empty param.searchCate}"><c:param name="searchCate" value="${param.searchCate}" /></c:if>
	<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
	<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>
	<c:if test="${not empty param.tmplatImportAt}"><c:param name="tmplatImportAt" value="${param.tmplatImportAt}"/></c:if>
	<c:param name="menuId" value="${param.menuId}"/>
	<c:param name="trgetId" value="${param.trgetId}" />
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
	jQuery(".commentPopup").hide();
	jQuery(".commentPopup").html("");
	jQuery("#replyComment"+num).html(
			"<div class='comment'>"+
				"<div class='comment_inp'>"+
				"<form name='commentVO' action='${_PREFIX}/insertReplyComment.do' method='post' onsubmit='return fn_egov_insert_commentList(this);'>"+
					"<input type='hidden' name='tmplatImportAt' value='<c:out value="${param.tmplatImportAt}"/>'/>" +
					<c:if test="${not empty param.pageIndex}">"<input type='hidden' name='pageIndex' value='<c:out value="${param.pageIndex}"/>'/>" + </c:if>
					"<input type='hidden' name='bbsId' value='<c:out value="${param.bbsId}"/>' />" +	
					"<input name='menuId' type='hidden' value='<c:out value="${param.menuId}"/>' />" +
					"<input name='trgetId' type='hidden' value='<c:out value="${param.trgetId}"/>' />" +
					"<input name='searchCnd' type='hidden' value='<c:out value="${param.searchCnd}"/>'/>" +
					"<input name='searchWrd' type='hidden' value='<c:out value="${param.searchWrd}"/>'/>" +
					"<input name='searchCate' type='hidden' value='<c:out value="${param.searchCate}"/>'/>" +
					"<input name='subPageIndex' type='hidden' value='<c:out value="${searchVO.subPageIndex}"/>' />" +
					"<input name='modified' type='hidden' value='false'/>" +
					"<input name='confirmPassword' type='hidden'/>" +
					"<input type='hidden' name='nttNo' value='<c:out value="${param.nttNo}"/>'/>"+
					"<input type='hidden' name='commentNo' value='" + commentNo + "'/>"+
					"<input type='hidden' name='ordrCode' value='" + ordrCode + "'/>"+
					"<input type='hidden' name='ordrCodeDp' value='" + ordrCodeDp + "'/>"+
					"<textarea name='commentCn' rows='0' cols='0' maxlength='2000' placeholder='<spring:message code="cop.comment"/>을 입력하세요.'></textarea>"+
					"<span class='bbtn_input'><input type='submit' value='<spring:message code="button.create"/>'/></span>" + 
				"</form>"+
				"</div>"+
				"<p><spring:message code='cop.comment.msg' /></p>"+
			"</div>"
			
	);
	jQuery("#replyComment"+num).show();
	return false;
}
</script>
	<div class="bbs_reply"> 	
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="reply type<c:out value="${result.ordrCodeDp+1 }"/>">
				<strong><c:out value="${result.wrterNm}" /></strong>
				<span class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/>
					<c:if test="${SE_CODE >= brdMstrVO.registAuthor}">
						<a href="#reply_txt" onclick="return addComment(${result.commentNo}, ${status.count}, '${result.ordrCode }', ${result.ordrCodeDp });"><img src="${_IMG}/btn_reply_re.gif" alt="<spring:message code="button.reply"/>" /></a>
					</c:if>
					<c:if test="${not empty USER_INFO.id and result.frstRegisterId eq USER_INFO.id}">
						<c:url var="delUrl" value="${_PREFIX}/deleteComment.do${_BASE_PARAM}">
							<c:param name="commentNo" value="${result.commentNo}" />
							<c:param name="subPageIndex" value="${searchVO.subPageIndex}" />
							<c:param name="modified" value="true" />
						</c:url>
						<a href="<c:out value="${delUrl}"/>" onclick="fn_egov_deleteCommentList(this.href);return false;"><img src="${_IMG}/btn_delete.gif" alt="<spring:message code="button.delete"/>" /></a>
					</c:if>
				</span>
				<p class="reply_cont">
					<c:set var="cn" value="${fn:escapeXml(result.commentCn)}"/>
					<c:set var="cn" value="${fn:replace(cn , crlf , '<br/>')}"/>
					<c:out value="${cn}" escapeXml="false" />
				</p>
			</div>
			<div id="replyComment${status.count }" style="display:none" class="commentPopup"></div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(resultList) ne 0}">
	<div id="paging">				
	    <c:url var="pageUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
	    </c:url>
	    <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
	    <ui:pagination paginationInfo="${paginationInfo}" type="smart_001_sub" jsFunction="${pagingParam}" />	    
	</div>
	</c:if>

	<div class="comment">
		<c:choose>		
		<c:when test="${not empty USER_INFO.id and SE_CODE >= brdMstrVO.registAuthor}">
			<div class="comment_inp">
				<form name="comment" id="comment" method="post" action="<c:url value='${_PREFIX}/insertComment.do'/>" onsubmit="return fn_egov_insert_commentList(this);">
					<c:if test="${not empty param.pageIndex}"><input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/></c:if>
					<input type="hidden" name="bbsId" value="<c:out value='${param.bbsId}'/>" />
					<input type="hidden" name="nttNo" value="<c:out value='${param.nttNo}'/>" />
					
					<input name="searchCnd" type="hidden" value="<c:out value="${param.searchCnd}"/>"/>
					<input name="searchWrd" type="hidden" value="<c:out value="${param.searchWrd}"/>"/>
					<input name="searchCate" type="hidden" value="<c:out value="${param.searchCate}"/>"/>
					<input name="tmplatImportAt" type="hidden" value="<c:out value="${param.tmplatImportAt}"/>"/>
					
					<input type="hidden" name="menuId" value="<c:out value='${param.menuId}'/>"/>
					<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
						<c:if test="${not empty searchCate}">
							<input name="searchCateList" type="hidden" value="<c:out value="${searchCate}"/>"/>
						</c:if>
					</c:forEach>
					
					<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>"/>
					<input name="modified" type="hidden" value="false"/>
					<input name="confirmPassword" type="hidden"/>
		
					<strong><spring:message code="cop.comment.write"/></strong>
					<textarea name="commentCn" rows="0" cols="0" maxlength="2000" placeholder="<spring:message code="cop.comment"/>을 입력하세요."></textarea>
					<span class="bbtn_input"><input type="submit" value="<spring:message code="button.create"/>" /></span>
					<p><spring:message code='cop.comment.msg' /></p>
				</form>
		  	</div>
		</c:when>
		<c:otherwise>
			<div class="comment_inp">
				<strong><spring:message code="cop.comment.write"/></strong>
				<textarea name="commentCn" rows="0" cols="0" readonly="readonly"><spring:message code="cop.comment"/>을 작성하시려면 로그인이 필요합니다.</textarea>
				<span class="bbtn_input"><a href="#"><spring:message code="button.create"/></a></span>
				<p><spring:message code='cop.comment.msg' /></p>
		  	</div>
		</c:otherwise>
		</c:choose>
	</div>
  
  <c:if test="${not empty subMsg}">
  <script type="text/javascript">
    alert("<c:out value='${subMsg}'/>");
  </script>
  </c:if>