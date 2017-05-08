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
<c:set var="_IMG" value="${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId }/images"/>
<c:set var="_C_CSS" value="/template/common/css"/>
<c:set var="_C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="_C_IMG" value="/template/common/images"/>

<c:set var="_PREFIX" value="/cop/bbs"/>

<% /*URL 정의*/ %>
<c:url var="_BASE_PARAM" value="">
	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
	<c:param name="bbsId" value="${board.bbsId}" />
	<c:param name="menuId" value="${searchVO.menuId}"/>
	<c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
	<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
	<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
	<c:if test="${not empty searchVO.tmplatImportAt}"><c:param name="tmplatImportAt" value="${searchVO.tmplatImportAt}"/></c:if>	
	<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
		<c:if test="${not empty searchCate}">
			<c:param name="searchCateList" value="${searchCate}" />
		</c:if>
	</c:forEach>
</c:url>
<% /*URL 정의*/ %>

<c:choose>
	<c:when test="${searchVO.tmplatImportAt ne 'N'}">
		<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
			<c:param name="BBS_TMPLATID" value="${brdMstrVO.tmplatId }"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta http-equiv="Content-Script-Type" content="text/javascript" />
			<meta http-equiv="Content-Style-Type" content="text/css" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge" />	
			<link charset="utf-8" href="${_C_CSS}/default.css" type="text/css" rel="stylesheet"/>
			<script type="text/javascript" src="${_C_JS}/jquery/jquery-1.7.min.js"></script>
			<script type="text/javascript" src="${_C_JS}/common.js"></script>
			<link charset="utf-8" href="${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId}/style.css" type="text/css" rel="stylesheet"/>
			<script type="text/javascript" src="${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId}/script.js"></script>
		</head>
		<body>
	</c:otherwise>
</c:choose>

		<c:set var="SE_CODE" value="01" />
		<c:if test="${not empty USER_INFO.id}">
			<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
		</c:if>
		
			<script type="text/javascript" src="${_C_JS}/board.js" ></script>
			<script type="text/javascript">
				$(document).ready(function(){
					$('#btnBbsDelete').click(function() {
						if (confirm('<spring:message code="common.delete.msg" />')) {
							location.href = this.href;
						}
						return false;
					});
				});
			</script>
			
<c:choose>
	<c:when test="${IS_MOBILE }">
	<div id="bbs_mbl">
	</c:when>
	<c:otherwise>
	<div id="bbs_wrap">
	</c:otherwise>
</c:choose>
	
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
				<dl class="info_view3">
					<dt class="link_address" >링크주소</dt>
					<dd class="link_address"><c:out value="${board.tmp01}" /></dd>
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
					<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA02'}">
						<c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="atchFileId" value="${board.atchFileId}" />
							<c:param name="bbsId" value="${board.bbsId }"/>
							<c:param name="siteId" value="${brdMstrVO.siteId}"/>		
						</c:import>
					</c:if>
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
		    			<c:param name="sourcId" value="${brdMstrVO.sourcId}" />
		    		</c:import>
		    	</c:if>
			</div>
			<div class="btn_all">
				<div class="fL">
				<c:if test="${not empty USER_INFO.id}">
					<c:if test="${brdMstrVO.replyPosblAt eq 'Y' and SE_CODE >= brdMstrVO.answerAuthor}">
						<c:url var="addReplyBoardArticleUrl" value="${_PREFIX}/addReplyBoardArticle.do${_BASE_PARAM}">
			      			<c:param name="nttNo" value="${board.nttNo}" />
				  			<c:param name="registAction" value="reply" />
						</c:url>
						<span class="bbtn"><a href="<c:out value="${addReplyBoardArticleUrl}"/>" title="<spring:message code="button.reply"/>(<c:out value="${brdMstrVO.bbsNm }"/>)"><spring:message code="button.reply"/></a></span>
			      	</c:if>
					<c:if test="${board.frstRegisterId eq USER_INFO.id or SE_CODE >= 10}">
						<c:url var="forUpdateBoardArticleUrl" value="${_PREFIX}/forUpdateBoardArticle.do${_BASE_PARAM}">
				      		<c:param name="nttNo" value="${board.nttNo}" />
					  		<c:param name="registAction" value="updt" />
						</c:url>
						<span class="bbtn"><a href="<c:out value="${forUpdateBoardArticleUrl}"/>" title="<spring:message code="button.update"/>(<c:out value="${brdMstrVO.bbsNm }"/>)"><spring:message code="button.update"/></a></span>
				      	<c:url var="deleteBoardArticleUrl" value="${_PREFIX}/deleteBoardArticle.do${_BASE_PARAM}">
				      		<c:param name="nttNo" value="${board.nttNo}" />
						</c:url>
						<span class="bbtn"><a id="btnBbsDelete" href="<c:out value="${deleteBoardArticleUrl}"/>" title="<spring:message code="button.delete"/>(<c:out value="${brdMstrVO.bbsNm }"/>)"><spring:message code="button.delete"/></a></span>
			      	</c:if>
			      	
		      	</c:if>
		      	</div>
		      	<div class="fR">
		        	<span class="bbtn"><a href="<c:url value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}"/>" title="<spring:message code="button.list"/>(<c:out value="${brdMstrVO.bbsNm }"/>)"><spring:message code="button.list"/></a></span>
	        	</div>
		</div>
</div>

<c:choose>
	<c:when test="${searchVO.tmplatImportAt ne 'N'}">
		<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		</body>
		</html>
	</c:otherwise>
</c:choose>