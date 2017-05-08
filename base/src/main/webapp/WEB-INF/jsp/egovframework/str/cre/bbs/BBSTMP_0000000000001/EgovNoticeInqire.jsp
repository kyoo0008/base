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
<c:set var="_IMG" value="${_WEB_FULL_PATH}/template/${siteInfo.lytTmplatId}/${TEMPLATE_PATH}/images"/>
<c:set var="_CSS" value="${_WEB_FULL_PATH}/template/${siteInfo.lytTmplatId}/${TEMPLATE_PATH}/css"/>
<c:set var="_JS" value="${_WEB_FULL_PATH}/template/${siteInfo.lytTmplatId}/${TEMPLATE_PATH}/js"/>
<c:set var="_C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="_C_IMG" value="/template/common/images"/>

<c:set var="_PREFIX" value="/cop/bbs"/>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>

		<c:set var="SE_CODE" value="01" />
		<c:if test="${not empty USER_INFO.id}">
			<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
		</c:if>
		
			<script type="text/javascript">
				function onloading() {
					if ("<c:out value='${msg}'/>" != "") {
						alert("<c:out value='${msg}'/>");
					}
				}
					
				function fn_egov_delete_notice() {
					
					if (confirm('<spring:message code="common.delete.msg" />')) {
						document.frm.action = "<c:url value='${_PREFIX}/deleteBoardArticle.do'/>";
						document.frm.submit();
					}	
				}
			</script>
			<c:if test="${brdMstrVO.commentUseAt eq 'Y'}"> 
		    		<c:import url="${_PREFIX}/selectCommentList.do" charEncoding="utf-8">
						<c:param name="type" value="head" />
						<c:param name="tmplatId" value="${brdMstrVO.tmplatId}" /> 
					</c:import>
		    </c:if>
		
		<form name="frm" method="post" action="">
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
		<input type="hidden" name="nttNo" value="<c:out value='${searchVO.nttNo}'/>" />
		<input name="menuId" type="hidden" value="<c:out value='${searchVO.menuId}'/>" />
		
		<input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
		<input name="searchCate" type="hidden" value="<c:out value="${searchVO.searchCate}"/>"/>
		 
		<input name="frstRegisterId" type="hidden" value="<c:out value="${board.frstRegisterId}" />"/>
		
		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
			<c:if test="${not empty searchCate}">
				<input name="searchCateList" type="hidden" value="<c:out value="${searchCate}"/>"/>
			</c:if>
		</c:forEach>
		
       <div class="sub_smartcn_gap">
       	
		        <table summary=" <c:out value="${brdMstrVO.bbsNm}"/> 보기입니다." class="board_view">
		          <caption><c:out value="${brdMstrVO.bbsNm}"/></caption>
		          <tbody>
				    <tr>
				      <th scope="row" class="bv_left"><spring:message code="cop.nttSj" /></th>
				      <th colspan="5" scope="col" class="bv_right"><c:out value="${board.nttSj}" /></th>
				    </tr>
				    <c:if test="${!empty brdMstrVO.ctgrymasterId}">
					    <tr>
					      <td class="bv_left2"><spring:message code="cop.category.view" /></td>
					      <td colspan="5" class="blue"><c:out value="${board.ctgryNm}" /></td>
					    </tr>
				    </c:if>
				    <tr>
				      <td class="bv_left2"><spring:message code="cop.ntcrNm" /></td>
				      <td class="bv_name"><c:out value="${board.ntcrNm}" /></td>
				      <td class="bv_date"><spring:message code="cop.frstRegisterPnttm" /></td>
				      <td class="bv_num"><fmt:formatDate value="${board.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
				      <td class="bv_date"><spring:message code="cop.inqireCo" /></td>
				      <td class="bv_num"><c:out value="${board.inqireCo}" /></td>
				    </tr>
				    <c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
			          	<tr>
				            <td class="bv_left2"><spring:message code="cop.processSttus" /></td>
				            <td colspan="5" class="blue">
				            	<c:choose>
									<c:when test="${board.processSttusCode eq 'QA01'}"><img src="${_C_IMG}/page/board/btn_receipt.gif" alt="${board.processSttusNm}"/>
									</c:when>
									<c:when test="${board.processSttusCode eq 'QA03'}"><img src="${_C_IMG}/page/board/btn_comp.gif" alt="${board.processSttusNm}"/>
									</c:when>
									<c:when test="${board.processSttusCode eq 'QA02'}"><img src="${_C_IMG}/page/board/btn_disp.gif" alt="${board.processSttusNm}"/>
									</c:when>
								</c:choose>
				             </td>
				        </tr>
		          	</c:if>
		          	<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
					    <tr>
					      <td class="bv_left2"><spring:message code="cop.atchFileList" /></td>
					      <td colspan="5" class="bl_sub">
							<div class="dv_add_file">
								<ul class="file_down">
									<c:if test="${not empty board.atchFileId}">
				            			<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${board.atchFileId}" />
										</c:import>
									</c:if>
								</ul>
					        </div>
							</td>
					    </tr>
				    </c:if>
				    <tr>
				      <td colspan="6" class="bv_txt">
						<div id="board_viewIn">
				        	<c:out value="${board.nttCn}" escapeXml="false" />
				        </div>
						</td>
				    </tr>
				    <c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and board.processSttusCode eq 'QA03'}">
						<c:if test="${not empty board.estnData}">
							<tr>
					        	<td colspan="6" class="bv_txt">
					            	<div id="board_viewIn"><c:out value="${board.estnParseData.cn}" escapeXml="false" /></div>
					        	</td>
					        </tr>
						</c:if>
						<c:if test="${not empty board.estnAtchFileId}">
							<tr>
					            <td class="bv_left2"><spring:message code="cop.atchFileList" /></td>
					            <td colspan="5" class="bl_sub">
					            	<span class="dv_add_file">
						            	<ul class="file_down">
					            			<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${board.estnAtchFileId}" />
											</c:import>
						              	</ul>
					              	</span>
					             </td>
					          </tr>
						</c:if>
					</c:if>
				  </tbody>				  
		        </table>
		        
			
			<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
		    		<c:import url="${_PREFIX}/selectCommentList.do" charEncoding="utf-8">
		    			<c:param name="type" value="masterBody" />
		    			<c:param name="tmplatId" value="${brdMstrVO.tmplatId}" />   
		    			<c:param name="menuId" value="${searchVO.menuId}" />
		    			<c:param name="bbsId" value="${board.bbsId}" />
		    			<c:param name="boardOrdrCode" value="${board.ordrCode}" />
						<c:param name="boardOrdrCodeDp" value="${board.ordrCodeDp + 1}" />
		    			<c:param name="pageIndex" value="${searchVO.pageIndex}" />
						<c:param name="searchCnd" value="${searchVO.searchCnd}" />
						<c:param name="searchWrd" value="${searchVO.searchWrd}" />
						<c:param name="searchCate" value="${searchVO.searchCate}" />
		    		</c:import>
		    </c:if>
		    
				<div class="btn_c">
				
		        	<c:if test="${not empty USER_INFO.id}">
						<c:if test="${board.frstRegisterId eq USER_INFO.id or SE_CODE >= 10}">
							<c:url var="forUpdateBoardArticleUrl" value="${_PREFIX}/forUpdateBoardArticle.do">
					      		<c:param name="menuId" value="${searchVO.menuId}" />
								<c:param name="bbsId" value="${board.bbsId}" />
								<c:param name="nttNo" value="${board.nttNo}" />
								<c:param name="pageIndex" value="${searchVO.pageIndex}" />
								<c:param name="searchCnd" value="${searchVO.searchCnd}" />
								<c:param name="searchWrd" value="${searchVO.searchWrd}" />
								<c:param name="searchCate" value="${searchVO.searchCate}" />
								<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
						  			<c:if test="${not empty searchCate}">
						  				<c:param name="searchCateList" value="${searchCate}" />
						  			</c:if>
						  		</c:forEach>
						  		<c:param name="registAction" value="updt" />
							</c:url>
					      	<a href="<c:out value="${forUpdateBoardArticleUrl}"/>" title="수정하기이동"><img src="${_IMG}/board/edit.gif" alt="수정하기"/></a>
					      	<c:url var="deleteBoardArticleUrl" value="${_PREFIX}/deleteBoardArticle.do">
					      		<c:param name="menuId" value="${searchVO.menuId}" />
								<c:param name="bbsId" value="${board.bbsId}" />
								<c:param name="nttNo" value="${board.nttNo}" />
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
					      	<a href="<c:out value="${deleteBoardArticleUrl}"/>" title="삭제하기" onclick="fn_egov_delete_notice();return false;"><img src="${_IMG}/board/delete.gif" alt="삭제하기" /></a>
				      	</c:if>
				      	<c:if test="${brdMstrVO.replyPosblAt eq 'Y' and SE_CODE >= brdMstrVO.answerAuthor}">
				      		<c:url var="addReplyBoardArticleUrl" value="${_PREFIX}/addReplyBoardArticle.do">
				      			<c:param name="menuId" value="${searchVO.menuId}" />
								<c:param name="bbsId" value="${board.bbsId}" />
								<c:param name="nttNo" value="${board.nttNo}" />
								<c:param name="pageIndex" value="${searchVO.pageIndex}" />
								<c:param name="searchCnd" value="${searchVO.searchCnd}" />
								<c:param name="searchWrd" value="${searchVO.searchWrd}" />
								<c:param name="searchCate" value="${searchVO.searchCate}" />
								<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
						  			<c:if test="${not empty searchCate}">
						  				<c:param name="searchCateList" value="${searchCate}" />
						  			</c:if>
						  		</c:forEach>
						  		<c:param name="registAction" value="reply" />
							</c:url>
				        	<a href="<c:out value="${addReplyBoardArticleUrl}"/>" title="답변쓰기이동"><img src="${_IMG}/board/reply.gif" alt="답변쓰기" /></a>
				      	</c:if>
			      	</c:if>
			      	<c:url var="selectBoardListUrl" value="${_PREFIX}/selectBoardList.do">
						<c:param name="menuId" value="${searchVO.menuId}" />
						<c:param name="bbsId" value="${board.bbsId}" />
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
		        	<a href="<c:out value="${selectBoardListUrl}"/>" title="목록으로이동"><img src="${_IMG}/board/list.gif" alt="목록으로 이동" /></a>
		        </div>
		
	</div>
	</form>

<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>