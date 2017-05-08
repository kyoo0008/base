<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/bbs"/>
<c:set var="serverName" value="<%=request.getServerName()%>"/>
<c:set var="serverPort" value="<%=request.getServerPort()%>"/>
<c:choose>
	<c:when test="${serverPort == 80}">
		<c:set var="serverPort" value=""/>
	</c:when>
	<c:otherwise>
		<c:set var="serverPort" value=":${serverPort}"/>
	</c:otherwise>
</c:choose>

<% /*URL 정의*/ %>
<c:url var="_BASE_PARAM" value="">
	<c:param name="siteId" value="${searchVO.siteId}"/>
	<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
	<c:param name="bbsId" value="${searchVO.bbsId}" />
	<c:param name="trgetId" value="${searchVO.trgetId}" />
	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
	<c:param name="searchCnd" value="${searchVO.searchCnd}" />
	<c:param name="searchWrd" value="${searchVO.searchWrd}" />
	<c:param name="searchCate" value="${searchVO.searchCate}" />
	<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
		<c:if test="${not empty searchCate}">
			<c:param name="searchCateList" value="${searchCate}" />
		</c:if>
	</c:forEach>
</c:url>
<% /*URL 정의*/ %>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${brdMstrVO.bbsNm}"/>
</c:import>

	<script type="text/javascript">
		function onloading() {
			if ("<c:out value='${msg}'/>" != "") {
				alert("<c:out value='${msg}'/>");
			}
		}
			
		function fn_egov_delete_notice(url) {
			
			if (confirm('<spring:message code="common.delete.msg" />')) {
				document.location.href = url;
			}	
		}
		
		function urlCopy() {
			var addr = "http://${serverName}${serverPort}/hpg/bbs/selectBoardArticle.do?nttNo=${searchVO.nttNo}&menuId=${menuId}&bbsId=${searchVO.bbsId}";
			window.clipboardData.setData('Text', addr);
			alert("페이지 주소가 복사되었습니다.\n" + addr);
		}

	</script>
<div id="cntnts">

	<div class="view_wrap">
		<dl class="view_tit">
			<dt><spring:message code="cop.nttSj" /></dt>
			<dd><strong><c:out value="${board.nttSj}" /></strong> <a href="#" onclick="urlCopy();return false;"><img src="${_IMG}/btn/add_copy.gif" style="vertical-align:middle;margin-left:10px;"/></a></dd>
		</dl>
		
		<table  class="view_writer_chart">
			<caption></caption>
			<colgroup>
				<col width="110px" />
				<col width="*" />
				<col width="110px" />
				<col width="*" />
			</colgroup>
			<tbody>
                <c:if test="${!empty brdMstrVO.ctgrymasterId}">
	                <tr>
		                <th><spring:message code="cop.category.view" /></th>
		                <td colspan="3" class="last"><c:out value="${board.ctgryNm}" /></td>
	                </tr>  
                </c:if>
                <tr>
	                <th><spring:message code="cop.ntcrNm" /></th>
	                <td colspan="3" class="last"><c:out value="${board.ntcrNm}" /> (<c:out value="${board.frstRegisterId}" />)</td>
                </tr>
                <tr>
                	<th><spring:message code="cop.frstRegisterPnttm" /></th>
	                <td><fmt:formatDate value="${board.frstRegisterPnttm}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                <th><spring:message code="cop.inqireCo" /></th>
	                <td class="last"><c:out value="${board.inqireCo}" /></td>
                </tr>
 			</tbody>
		</table>
         <div class="view_cont">
			<c:out value="${board.nttCn}" escapeXml="false" />
		</div>
		
		<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
		<dl class="view_tit02">
			<dt><spring:message code="cop.atchFileList" /></dt>
			<dd>
				<ul class="list">
					<c:if test="${not empty board.atchFileId}">
						<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${board.atchFileId}" />
							<c:param name="imagePath" value="${_IMG }"/>
						</c:import>
					</c:if>
				</ul>
			</dd>
		</dl>
		</c:if>
		
		<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and board.processSttusCode eq 'QA03'}">
			<c:if test="${not empty board.estnData}">
				<div class="view_cont">
					<c:out value="${board.estnParseData.cn}" escapeXml="false" />
				</div>
			</c:if>
			<c:if test="${not empty board.estnAtchFileId}">
				<dl class="view_tit02">
					<dt><spring:message code="cop.atchFileList" /></dt>
					<dd>
						<ul class="list">
							<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${board.estnAtchFileId}" />
								<c:param name="imagePath" value="${_IMG }"/>
							</c:import>
						</ul>
					</dd>
				</dl>
			</c:if>
		</c:if>
	</div>
	
	<div class="btn_r">
		<a href="<c:url value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}"/>"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
      	<c:if test="${brdMstrVO.replyPosblAt eq 'Y'}">
      		<c:url var="addReplyBoardArticleUrl" value="${_PREFIX}/addReplyBoardArticle.do${_BASE_PARAM}">
      			<c:param name="nttNo" value="${board.nttNo}" />
	  			<c:param name="registAction" value="reply" />
			</c:url>
        	<a href="<c:out value="${addReplyBoardArticleUrl}"/>"><img src="${_IMG}/btn/btn_reply.gif" alt="답글"/></a>
      	</c:if>
      	<c:url var="forUpdateBoardArticleUrl" value="${_PREFIX}/forUpdateBoardArticle.do${_BASE_PARAM}">
      		<c:param name="nttNo" value="${board.nttNo}" />
	  		<c:param name="registAction" value="updt" />
		</c:url>
      	<a href="<c:out value="${forUpdateBoardArticleUrl}"/>"><img src="${_IMG}/btn/btn_modify.gif" alt="수정"/></a>
      	<c:url var="deleteBoardArticleUrl" value="${_PREFIX}/deleteBoardArticle.do${_BASE_PARAM}">
      		<c:param name="nttNo" value="${board.nttNo}" />
		</c:url>  
      	<a href="<c:out value="${deleteBoardArticleUrl}"/>" onclick="fn_egov_delete_notice(this.href);return false;"><img src="${_IMG}/btn/btn_del.gif" alt="삭제"/></a>
	</div>
	
	<c:if test="${brdMstrVO.commentUseAt eq 'Y'}"> 
    		<c:import url="${_PREFIX}/selectCommentList.do" charEncoding="utf-8">
    			<c:param name="tmplatId" value="${brdMstrVO.tmplatId}" />
    		</c:import> 
    </c:if>
    
</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	