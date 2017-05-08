<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<c:set var="IS_MOBILE"><%=egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)%></c:set>
<c:set var="TEMPLATE_PATH" value="${IS_MOBILE ? 'mbl' : 'web'}"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>

<c:set var="_PREFIX" value="/cop/cmy/bbs"/>

<% /*URL 정의*/ %>
<c:url var="_BASE_PARAM" value="">
	<c:param name="bbsId" value="${board.bbsId}" />
	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
	<c:param name="searchCnd" value="${searchVO.searchCnd}" />
	<c:param name="searchWrd" value="${searchVO.searchWrd}" />
	<c:param name="searchCate" value="${searchVO.searchCate}" />
	<c:param name="trgetId" value="${searchVO.trgetId}"/>
	<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
		<c:if test="${not empty searchCate}">
			<c:param name="searchCateList" value="${searchCate}" />
		</c:if>
	</c:forEach>
</c:url>
<% /*URL 정의*/ %>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.emplyrId}">
	<c:set var="SE_CODE" value="${USER_INFO.authorCode}" />
</c:if>

			<script type="text/javascript">
				$(document).ready(function(){
					$('#btnBbsDelete').click(function() {
						if (confirm('<spring:message code="common.delete.msg" />')) {
							location.href = this.href;
						}	
					});
				});
			</script>
	
<div class="cm_sub_box">
	<h2><c:out value="${brdMstrVO.bbsNm}"/></h2>
	<div class="cm_sub_cont">
		<div id="bbs_cm_wrap">

			<div class="board_view">				
				<dl class="tit_view">
					<dt><spring:message code="cop.nttSj" /></dt>
					<dd><c:out value="${board.nttSj}" /></dd>
				</dl>
				<c:if test="${!empty brdMstrVO.ctgrymasterId}">
				<dl class="info_view">
					<dt><spring:message code="cop.category.view" /></dt>
					<dd><c:out value="${board.ctgryNm}" /></dd>
				</dl>
				</c:if>
				<dl class="info_view2">
					<dt class="writer" ><spring:message code="cop.ntcrNm" /></dt>
					<dd class="writer"><c:out value="${board.ntcrNm}" /></dd>
					<dt><spring:message code="cop.frstRegisterPnttm" /></dt>
					<dd><fmt:formatDate value="${board.frstRegisterPnttm}"  pattern="yyyy.MM.dd"/></dd>
					<dt><spring:message code="cop.inqireCo" /></dt>
					<dd><c:out value="${board.inqireCo}" /></dd>
				</dl>
				<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
				<dl class="file_view">
					<dt><spring:message code="cop.atchFileList" /></dt>
					<dd>						
						<c:if test="${not empty board.atchFileId}">
	            			<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${board.atchFileId}" />									
								<c:param name="imagePath" value="${_IMG }"/>
							</c:import>
						</c:if>						
					</dd>
				</dl>
				</c:if>
				<div class="view_cont">
					<c:out value="${board.nttCn}" escapeXml="false" />
				</div>
				<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and board.processSttusCode eq 'QA03'}">
					<c:if test="${not empty board.estnAtchFileId}">
						<dl class="file_view">
							<dt><spring:message code="cop.atchFileList" /></dt>
							<dd>						
								<c:if test="${not empty board.estnAtchFileId}">
			            			<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${board.estnAtchFileId}" />									
										<c:param name="imagePath" value="${_IMG }"/>
									</c:import>
								</c:if>						
							</dd>
						</dl>						
					</c:if>
					<c:if test="${not empty board.estnData}">
						<div class="view_cont">
							<c:out value="${board.estnParseData.cn}" escapeXml="false" />
						</div>
					</c:if>
				</c:if>
				<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
					<c:import url="${_PREFIX}/selectCommentList.do" charEncoding="utf-8">
		    			<c:param name="imagePath" value="${_IMG}" />
		    		</c:import>
		    	</c:if>
				
			</div>
			<div class="btn_all">
				<div class="fL">
				<c:if test="${not empty USER_INFO.emplyrId}">
					<c:if test="${brdMstrVO.replyPosblAt eq 'Y' and SE_CODE >= brdMstrVO.answerAuthor}">
						<c:url var="addReplyBoardArticleUrl" value="${_PREFIX}/addReplyBoardArticle.do${_BASE_PARAM}">
			      			<c:param name="nttNo" value="${board.nttNo}" />
				  			<c:param name="registAction" value="reply" />
						</c:url>
			        	<a href="<c:out value="${addReplyBoardArticleUrl}"/>" class="bbtn"><span><spring:message code="button.reply"/></span></a>
			      	</c:if>
					<c:if test="${board.frstRegisterId eq USER_INFO.emplyrId or SE_CODE >= 10}">
						<c:url var="forUpdateBoardArticleUrl" value="${_PREFIX}/forUpdateBoardArticle.do${_BASE_PARAM}">
				      		<c:param name="nttNo" value="${board.nttNo}" />
					  		<c:param name="registAction" value="updt" />
						</c:url>
				      	<a href="<c:out value="${forUpdateBoardArticleUrl}"/>" class="bbtn"><span><spring:message code="button.update"/></span></a>
				      	<c:url var="deleteBoardArticleUrl" value="${_PREFIX}/deleteBoardArticle.do${_BASE_PARAM}">
				      		<c:param name="nttNo" value="${board.nttNo}" />
						</c:url>
				      	<a id="btnBbsDelete" href="<c:out value="${deleteBoardArticleUrl}"/>" class="bbtn"><span><spring:message code="button.delete"/></span></a>
			      	</c:if>
			      	
		      	</c:if>
		      	</div>
		      	<div class="fR">
		        	<span class="bbtn"><a href="<c:url value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}"/>"><span><spring:message code="button.list"/></span></a>
	        	</div>
	        </div>
		</div>
	</div>
</div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>