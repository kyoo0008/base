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
		<c:param name="trgetId" value="${searchVO.trgetId}"/>
		<c:if test="${fn:length(searchVO.searchCateList) ne 0}">
			<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
				<c:if test="${not empty searchCate}">
					<c:param name="searchCateList" value="${searchCate}" />
				</c:if>
			</c:forEach>
		</c:if>
	  	<c:if test="${not empty searchVO.bbsId}"><c:param name="bbsId" value="${searchVO.bbsId}" /></c:if>
	  	<c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
	  	<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.emplyrId}">
	<c:set var="SE_CODE" value="${USER_INFO.authorCode}" />
</c:if>
		
		<script type="text/javascript" src="${_C_JS}/jquery/jquery.form.js" ></script>
		<script type="text/javascript" src="${_C_JS}/board.js" ></script>
		<script type="text/javascript">
		
		<c:if test="${!empty brdMstrVO.ctgrymasterId}">		
			var boardCateLevel = ${boardCateLevel};
			var boardCateList = new Array(${fn:length(boardCateList)});
			<c:forEach var="cate" items="${boardCateList}" varStatus="status">
				boardCateList[${status.index}] = new ctgryObj('${cate.upperCtgryId}', '${cate.ctgryId}', '${cate.ctgryNm}', ${cate.ctgryLevel});
			</c:forEach>		
		</c:if>
		
		function fn_egov_addNotice(url) {
	    	<c:choose>
				<c:when test="${not empty USER_INFO.emplyrId}">
					location.href = url;
				</c:when>
				<c:otherwise>
					if (confirm('로그인 하시겠습니까?')) {
						location.href = "<%=egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper.getRedirectLoginUrl()%>";	
					}
				</c:otherwise>
			</c:choose>
	    }
		
		$(document).ready(function(){
			$('#btnBbsWrite').click(function() {fn_egov_addNotice(this.href);return false;});
			fnCtgryInit('${searchVO.searchCateList}');
		});
		</script>		

<div class="cm_sub_box">
	<h2><c:out value="${brdMstrVO.bbsNm}"/></h2>
	<div class="cm_sub_cont">
		<div id="bbs_cm_wrap">
		<div class="total">총 게시물 <strong>${paginationInfo.totalRecordCount}</strong>건 ㅣ 현재페이지 <strong>${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</div>							
		  	
		<c:choose>
		<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA02'}">
			<div class="list_photo">
	            <ul>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	            	<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
					  	<c:param name="nttNo" value="${result.nttNo}" />
					  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
				    </c:url>
				    <c:set var="isViewEnable" value=""/>
				    <c:choose>
						<c:when test="${SE_CODE >= 10}"><c:set var="isViewEnable" value="Y"/></c:when>
						<c:when test="${result.othbcAt eq 'N' and USER_INFO.emplyrId ne result.frstRegisterId}"><c:set var="isViewEnable" value="N"/></c:when>
						<c:when test="${SE_CODE < brdMstrVO.inqireAuthor}"><c:set var="isViewEnable" value="N"/></c:when>
						<c:otherwise><c:set var="isViewEnable" value="Y"/></c:otherwise>
					</c:choose>
					<li>	                
						<div class="ph_img">
							<c:if test="${isViewEnable eq 'Y'}"><a href="<c:out value="${viewUrl}"/>"></c:if>
	                    	<c:choose>
	                    		<c:when test="${empty result.atchFileNm}">
	                    			<img src="${_IMG}/board/noimg.gif" width="200" height="140" alt="${result.nttSj}"/>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<img src='<c:url value='/cmm/fms/getImage.do'/>?thumbYn=Y&siteId=<c:out value="${brdMstrVO.siteId}"/>&appendPath=<c:out value="${searchVO.bbsId}"/>&atchFileNm=<c:out value="${result.atchFileNm}"/>' alt="${result.nttSj}" width="200" height="140"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	<c:if test="${isViewEnable eq 'Y'}"></a></c:if>
						</div>
						<div class="ph_cont">
							<span>
								<c:if test="${isViewEnable eq 'Y'}"><a href="<c:out value="${viewUrl}"/>"></c:if>
	                    		<c:choose>
								<c:when test="${fn:length(result.nttSj) > 15}">
									<c:out value='${fn:substring(result.nttSj, 0, 15)}'/>...
								</c:when>
								<c:otherwise>
									<c:out value="${result.nttSj}" />
								</c:otherwise>
								</c:choose>
	                    		<c:if test="${isViewEnable eq 'Y'}"></a></c:if>								 
	                    		<c:if test="${result.othbcAt eq 'N'}">
	                    			<img src="${_IMG}/board/ico_board_lock.gif" alt="<spring:message code="cop.privateNtt"/>" />
	                    		</c:if>
	                    		<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
									<c:choose>
										<c:when test="${result.commentCount eq 0}"><strong>[<c:out value="${result.commentCount}" />]</strong></c:when>
										<c:otherwise><strong>[<c:out value="${result.commentCount}" />]</strong></c:otherwise>
									</c:choose>
								</c:if>
							</span>
							<span class="ph_date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></span>
						</div>
	                  
	                 
	              </li>
	            </c:forEach>
				</ul>
				<c:if test="${fn:length(resultList) == 0}">
					<table class="boardscn_list" ><tr><td><spring:message code="common.nodata.msg" /></td></tr></table>
			    </c:if>
			</div>
		</c:when>				
		<c:otherwise>
			<table summary="
				<spring:message code="cop.nttNo"/>,
				<c:if test="${not empty brdMstrVO.ctgrymasterId}"><spring:message code="cop.category.view" />,</c:if>
				<spring:message code="cop.nttSj" />
				<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}"><spring:message code="cop.processSttus" />,</c:if>
				<spring:message code="cop.ntcrNm" />,
				<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}"><spring:message code="cop.listAtchFile" />,</c:if>
				<spring:message code="cop.frstRegisterPnttm" />,
				<spring:message code="cop.inqireCo" />
			" class="list_table">
			<caption>${brdMstrVO.bbsNm }</caption>
			<thead>
				<tr>
					<th class="num"><spring:message code="cop.nttNo"/></th>
					<c:if test="${not empty brdMstrVO.ctgrymasterId}">
						<th class="class"><spring:message code="cop.category.view" /></th>							
					</c:if>
					<th class="tit"><spring:message code="cop.nttSj" /></th>
					<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
		          		<th class="state"><spring:message code="cop.processSttus" /></th>
		          	</c:if>
					<th class="writer"><spring:message code="cop.ntcrNm" /></th>
					<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
						<th class="file"><spring:message code="cop.listAtchFile" /></th>
					</c:if>	
					<th class="date"><spring:message code="cop.frstRegisterPnttm" /></th>
					<th class="hits"><spring:message code="cop.inqireCo" /></th>
				</tr>					
			</thead>
			<tbody>
				<c:forEach var="result" items="${noticeList}" varStatus="status">
					<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
					  	<c:param name="nttNo" value="${result.nttNo}" />
					  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
				    </c:url>
				<tr class="notice">
					<c:if test="${SE_CODE >= 100 }">
						<td class="check"></td>
					</c:if>
					<td class="num"><img src="${_IMG}/board/icon_notice.gif" alt="<spring:message code="cop.notice"/>"/></td>
					<c:if test="${not empty brdMstrVO.ctgrymasterId}">
						<td class="class"><c:out value="${result.ctgryNm}" /></td>
					</c:if>
					<td class="tit">
						<a href="<c:out value="${viewUrl}"/>" class="notice_ti"><c:out value="${result.nttSj}" /></a>
						<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">								
							<c:choose>
								<c:when test="${IS_MOBILE }"><em class="boardrenum"><c:out value="${result.commentCount}" /></em></c:when>
								<c:when test="${result.commentCount eq 0}"><em class="boardrenumno">[<c:out value="${result.commentCount}" />]</em></c:when>
								<c:otherwise><em class="boardrenum">[<c:out value="${result.commentCount}" />]</em></c:otherwise>
							</c:choose>								
						</c:if>
					</td>
					<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
		          		<td class="state">
		          			<c:choose>
								<c:when test="${result.processSttusCode eq 'QA01'}"><span class="bbtn_color2"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
								<c:when test="${result.processSttusCode eq 'QA02'}"><span class="bbtn_color3"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
								<c:when test="${result.processSttusCode eq 'QA03'}"><span class="bbtn_color1"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
							</c:choose>
		          		</td>
		          	</c:if>						
					<td  class="writer"><c:out value="${result.ntcrNm}"/></td>
					<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
						<td class="file"><c:choose><c:when test="${not empty result.atchFileId}"><img src="${_IMG}/board/ico_file.gif" alt="<spring:message code="cop.listAtchFile"/>" /></c:when><c:otherwise><c:if test="${not IS_MOBILE }">-</c:if></c:otherwise></c:choose></td>
					</c:if>
					<td class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
					<td class="hits"><c:out value="${result.inqireCo}"/></td>
				</tr>
				</c:forEach>					
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
					  	<c:param name="nttNo" value="${result.nttNo}" />
					  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
				    </c:url>
					<tr>
						<td class="num"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
						<c:if test="${not empty brdMstrVO.ctgrymasterId}">
							<td class="class"><c:out value="${result.ctgryNm}" /></td>
						</c:if>
						<td class="tit">
							<c:if test="${result.ordrCodeDp gt 0}">
							  <img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" /><img src="${_IMG}/board/ico_reply.gif" alt="<spring:message code="cop.replyNtt"/>" />
					        </c:if>
					        <c:choose>
								<c:when test="${SE_CODE eq '10'}"><a href="<c:out value="${viewUrl}"/>" class="notice_ti"><c:out value="${result.nttSj}" /></a></c:when>
								<c:when test="${result.othbcAt eq 'N' and USER_INFO.emplyrId ne result.frstRegisterId}">
									<c:out value="${result.nttSj}" />
								</c:when>
								<c:when test="${SE_CODE < brdMstrVO.inqireAuthor}">
									<c:out value="${result.nttSj}" />
								</c:when>
								<c:otherwise><a href="<c:out value="${viewUrl}"/>"><c:out value="${result.nttSj}" /></a></c:otherwise>
							</c:choose>
							<c:if test="${result.othbcAt eq 'N'}"><img src="${_IMG}/board/ico_board_lock.gif" alt="<spring:message code="cop.privateNtt"/>" /></c:if>
							<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
								<c:choose>
									<c:when test="${IS_MOBILE }"><em class="boardrenum"><c:out value="${result.commentCount}" /></em></c:when>
									<c:when test="${result.commentCount eq 0}"><em class="boardrenumno">[<c:out value="${result.commentCount}" />]</em></c:when>
									<c:otherwise><em class="boardrenum">[<c:out value="${result.commentCount}" />]</em></c:otherwise>
								</c:choose>
							</c:if>
						</td>
						<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
			          		<td class="state">
			          			<c:choose>
									<c:when test="${result.processSttusCode eq 'QA01'}"><span class="bbtn_color2"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
									<c:when test="${result.processSttusCode eq 'QA02'}"><span class="bbtn_color3"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
									<c:when test="${result.processSttusCode eq 'QA03'}"><span class="bbtn_color1"><span><c:out value="${result.processSttusNm}" /></span></span></c:when>
								</c:choose>
			          		</td>
			          	</c:if>						
						<td  class="writer"><c:out value="${result.ntcrNm}"/></td>
						<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
							<td class="file"><c:choose><c:when test="${not empty result.atchFileId}"><img src="${_IMG}/board/ico_file.gif" alt="<spring:message code="cop.listAtchFile"/>" /></c:when><c:otherwise><c:if test="${not IS_MOBILE }">-</c:if></c:otherwise></c:choose></td>
						</c:if>
						<td class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
						<td class="hits"><c:out value="${result.inqireCo}"/></td>
					</tr>
				</c:forEach>
				
				<c:if test="${fn:length(resultList) == 0}">
			    	<tr class="empty"><td colspan="10"><spring:message code="common.nodata.msg" /></td></tr>
			    </c:if>
				
			</tbody>
			</table>
  		</c:otherwise>	  		
	  	</c:choose>
	  	
	  		<c:if test="${brdMstrVO.registAuthor eq '02' or SE_CODE >= brdMstrVO.registAuthor or SE_CODE >= 10}">			
			<div class="btn_r">
				<c:url var="addBoardArticleUrl" value="${_PREFIX}/addBoardArticle.do${_BASE_PARAM}">
					<c:param name="registAction" value="regist" />
				</c:url>
				<a href="<c:out value="${addBoardArticleUrl}"/>" id="btnBbsWrite" class="bbtn2"><span><spring:message code="button.write"/></span></a>
			</div>
			</c:if>	

			<div id="paging">
			    <c:url var="pageUrl" value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}">
				</c:url>
			   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
			   <ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
			   
			</div>
			
			<div class="cm_search_box">
				<form name="frm" method="post" action="<c:url value='${_PREFIX}/selectBoardList.do'/>">
				  	<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
					<input name="trgetId" type="hidden" value="<c:out value='${searchVO.trgetId}'/>" />
					<input name="searchCate" type="hidden" value="${searchVO.searchCate}" />
					<fieldset>
						<legend>검색조건입력폼</legend>
						<c:if test="${!empty brdMstrVO.ctgrymasterId}">
					        <c:forEach var="ctgryLevel" begin="1" end="${boardCateLevel}" step="1" varStatus="status">
								<c:choose>
									<c:when test="${status.first}">
										<label for="ctgry${ctgryLevel}" class="hdn"><spring:message code="cop.category.view" /></label>
										<select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})">
											<option value=""><spring:message code="cop.select" /></option>
											<c:forEach var="cate" items="${boardCateList}">
												<c:if test="${cate.ctgryLevel eq 1 }">
													<option value="${cate.ctgryId}">${cate.ctgryNm}</option>
												</c:if>
											</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<label for="ctgry${ctgryLevel}" class="hdn"><spring:message code="cop.category.view" />${ctgryLevel}</label>
										<select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})" class="search_sel"><option value=""><spring:message code="cop.select" /></option></select>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					      </c:if>
						<label for="ftext" class="hdn">분류검색</label>
						<select name="searchCnd" id="ftext">
							<option value="0" <c:if test="${searchVO.searchCnd eq '0'}">selected="selected"</c:if>><spring:message code="cop.nttSj" /></option>
			          		<option value="1" <c:if test="${searchVO.searchCnd eq '1'}">selected="selected"</c:if>><spring:message code="cop.nttCn" /></option>
			          		<option value="2" <c:if test="${searchVO.searchCnd eq '2'}">selected="selected"</c:if>><spring:message code="cop.ntcrNm" /></option>
						</select>
						<label for="inp_text" class="hdn">검색어입력</label>
						<input name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" type="text" class="inp" id="inp_text" />
						<span class="btn4"><button type="submit">검색</button></span>
					</fieldset>
				</form>
			</div>			  	
			
		</div>
	</div>
</div>
		
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>
