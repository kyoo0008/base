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
<c:set var="_IMG" value="/template/web/smart_001/image"/>

<c:set var="_PREFIX" value="/cop/bbs"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>

<c:if test="${type == 'head'}">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="comment" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
function fn_egov_insert_commentList() {
	if (!validateComment(document.frm)){
		return;
	}
	
	if (confirm('<spring:message code="common.regist.msg" />')) {
		
		jQuery(".boardreply3rewrite").hide();
		jQuery(".boardreply3rewrite").html("");
		
		document.frm.action = "<c:url value='${_PREFIX}/insertComment.do'/>";
		document.frm.submit();
	}				
}

function fn_egov_updt_commentList() {
	if (!validateComment(document.frm)){
		return;
	}
	
	if (confirm('<spring:message code="common.update.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.action = "<c:url value='${_PREFIX}/updateComment.do'/>";
		document.frm.submit();
	}
}

function fn_egov_selectCommentForupdt(commentNo, index) {
	document.frm.commentNo.value = commentNo;
	document.frm.action = "<c:url value='${_PREFIX}/selectBoardArticle.do'/>";
	document.frm.submit();
}

function fn_egov_deleteCommentList(commentNo, index) {

	if (confirm('<spring:message code="common.delete.msg" />')) {
		jQuery(".boardreply3rewrite").hide();
		jQuery(".boardreply3rewrite").html("");
		
		document.frm.modified.value = "true";
		document.frm.commentNo.value = commentNo;
		document.frm.action = "<c:url value='${_PREFIX}/deleteComment.do'/>";
		document.frm.submit();
	}
	
	return false;
}

function fn_egov_select_commentList(pageNo) {
	document.frm.subPageIndex.value = pageNo; 
	document.frm.commentNo.value = '';
	document.frm.action = "<c:url value='${_PREFIX}/selectBoardArticle.do'/>";
	document.frm.submit();
}


</script>
</c:if>

<c:if test="${type == 'masterBody'}"> 

<script type="text/javascript">
function checkForm(form) {
	if(form.commentCn.value == "") {
		alert("댓글을 입력하세요");
		return false;
	}
	
	if (confirm('<spring:message code="common.regist.msg" />')) {
		return true;
	}
	return false;
}

function addComment(commentNo, num, ordrCode, ordrCodeDp) {
	jQuery(".boardreply3rewrite").hide();
	jQuery(".boardreply3rewrite").html("");
	jQuery("#replyComment"+num).html(
			"<div>"+
			"<form name='commentVO' action='${_PREFIX}/insertReplyComment.do' method='post'>"+
				"<input type='hidden' name='pageIndex' value='${param.pageIndex}'/>" +
				"<input type='hidden' name='bbsId' value='${param.bbsId}' />" +				
				"<input type='hidden' name='ordrCode' value='${param.boardOrdrCode}' />" +
				"<input type='hidden' name='ordrCodeDp' value='${param.boardOrdrCodeDp}' />" +
				"<input name='menuId' type='hidden' value='${param.menuId}' />" +
				"<input name='trgetId' type='hidden' value='${param.trgetId}' />" +
				"<input name='searchCnd' type='hidden' value='${param.searchCnd}'/>" +
				"<input name='searchWrd' type='hidden' value='${param.searchWrd}'/>" +
				"<input name='searchCate' type='hidden' value='${param.searchCate}'/>" +
				"<input name='subPageIndex' type='hidden' value='${searchVO.subPageIndex}' />" +
				"<input name='modified' type='hidden' value='false'/>" +
				"<input name='confirmPassword' type='hidden'/>" +
				"<input type='hidden' name='nttNo' value='" + ${param.nttNo} + "'/>"+
				"<input type='hidden' name='commentNo' value='" + commentNo + "'/>"+
				"<input type='hidden' name='commentOrdrCode' value='" + ordrCode + "'/>"+
				"<input type='hidden' name='commentOrdrCodeDp' value='" + ordrCodeDp + "'/>"+
				"<textarea name='commentCn' rows='0' cols='0'></textarea>"+
				"<input type='image' src='${_IMG}/sub/board/btn_reply_ok.gif' alt='덧글달기' align='absmiddle' onclick='return checkForm(document.commentVO);'/>"+
			"</form>"+
			"</div>"
	);
	jQuery("#replyComment"+num).show();
	return false;
}
</script>

	<div class="boardreply3"> 
		<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>"/>
		<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>"/>
		<input name="modified" type="hidden" value="false"/>
		<input name="confirmPassword" type="hidden"/>
	
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="boardreply3<c:choose><c:when test="${result.ordrCodeDp ne 0 }">relist${result.ordrCodeDp}</c:when><c:otherwise>list</c:otherwise></c:choose>">
				<span class="breply2name"><c:out value="${result.wrterNm}" /></span>
				<span class="breply2date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/>
					<c:if test="${SE_CODE >= brdMstrVO.registAuthor}">
						<a href="#reply_txt" title="답변쓰기 열림" onclick="return addComment(${result.commentNo}, ${status.count}, '${result.ordrCode }', ${result.ordrCodeDp });"><img src="${_IMG}/sub/board/btn_reply_re.gif" alt="답변쓰기" /></a>
					</c:if>
					<c:if test="${not empty USER_INFO.id and result.frstRegisterId eq USER_INFO.id}">
						<a href="#reply_del" title="덧글삭제하기" onclick="return fn_egov_deleteCommentList('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');""><img src="${_IMG}/sub/board/btn_sdelete2.gif" alt="삭제" /></a>
					</c:if>
				</span>
				<p class="breply2txt">
					<c:set var="cn" value="${fn:escapeXml(result.commentCn)}"/>
					<c:set var="cn" value="${fn:replace(cn , crlf , '<br>')}"/>
					<c:out value="${cn}" escapeXml="false" />
				</p>
			</div>
			<div id="replyComment${status.count }" style="display:none" class="boardreply3rewrite"></div>
		</c:forEach>
	</div>
	
	<div class="paging2">
	    <c:url var="pageUrl" value="${_PREFIX}/selectBoardArticle.do">
	    	<c:if test="${not empty param.nttNo}"><c:param name="nttNo" value="${param.nttNo}" /></c:if>
	    	<c:if test="${not empty param.menuId}"><c:param name="menuId" value="${param.menuId}" /></c:if>
	    	<c:if test="${not empty param.bbsId}"><c:param name="bbsId" value="${param.bbsId}" /></c:if>
	    	<c:if test="${not empty param.trgetId}"><c:param name="trgetId" value="${param.trgetId}" /></c:if>
	    	<c:if test="${not empty param.searchCate}"><c:param name="searchCate" value="${param.searchCate}" /></c:if>
			<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
			<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>			
			<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
	    </c:url>						
	    
	    <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
	    <ui:pagination paginationInfo="${paginationInfo}" type="smart_001_sub" jsFunction="${pagingParam}" />
	    
	</div>


		<c:if test="${empty USER_INFO.id and SE_CODE >= brdMstrVO.registAuthor}">
			<div class="boardreply3write">
				<strong>댓글쓰기</strong>
				<textarea name="commentCn" rows="0" cols="0" readonly="readonly">덧글을 작성하시려면 로그인이 필요합니다.</textarea><img src="${_IMG}/sub/board/btn_reply_ok.gif" alt="입력" /><br />
				<span class="writeinfo" style="margin-left:110px;">현재 0 byte/ 최대 100byte (한글 50자, 영문 100자)</span>
		  	</div>
		</c:if>
		<c:if test="${not empty USER_INFO.id and SE_CODE >= brdMstrVO.registAuthor}">
			<div class="boardreply3write">
				<strong>댓글쓰기</strong>
				<textarea name="commentCn" rows="0" cols="0"></textarea><a href="javascript:fn_egov_insert_commentList()"><img src="${_IMG}/sub/board/btn_reply_ok.gif" width="46" height="46" alt="입력"/></a><br />
				<span class="writeinfo" style="margin-left:110px;">현재 0 byte/ 최대 100byte (한글 50자, 영문 100자)</span>
		  	</div>
		</c:if>

  
  <c:if test="${not empty subMsg}">
  <script type="text/javascript">
    alert("<c:out value='${subMsg}'/>");
  </script>
  </c:if>
</c:if>