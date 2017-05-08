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
				<c:when test="${not empty USER_INFO.id}">
					location.href = url;
				</c:when>
				<c:otherwise>
					if (confirm('로그인 하시겠습니까?')) {
						location.href = "<%=egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper.getRedirectLoginUrl(null)%>";	
					}
				</c:otherwise>
			</c:choose>
	    }
		
		</script>
		
		<div id="bbs_search">
			<form name="frm" method="post" action="<c:url value='${_PREFIX}/selectBoardList.do'/>">
			  	<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
				<input name="pageIndex" type="hidden" value="1" />
				<input name="menuId" type="hidden" value="<c:out value='${searchVO.menuId}'/>" />
				<input name="searchCate" type="hidden" value="${searchVO.searchCate}" />
				<fieldset>
					<legend>검색조건입력폼</legend>
					<c:if test="${!empty brdMstrVO.ctgrymasterId}">
				        <c:forEach var="ctgryLevel" begin="1" end="${boardCateLevel}" step="1" varStatus="status">
							<c:choose>
								<c:when test="${status.first}">
									<select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})">
										<option value="">선택</option>
										<c:forEach var="cate" items="${boardCateList}">
											<c:if test="${cate.ctgryLevel eq 1 }">
												<option value="${cate.ctgryId}">${cate.ctgryNm}</option>
											</c:if>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise><select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})" class="search_sel"><option value="">선택</option></select></c:otherwise>
							</c:choose>
						</c:forEach>
						<script type="text/javascript">
							fnCtgryInit('${searchVO.searchCateList}');
						</script>
				      </c:if>
					<label for="ftext" class="hdn">분류검색</label>
					<select name="searchCnd" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
		          		<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
		          		<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
					</select>
					<label for="inp_text" class="hdn">검색어입력</label>
					<input name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" type="text" class="inp_s" id="inp_text" />
					<input type="image" src="${_IMG}/sub/btn_search.gif" alt="검색" />
				</fieldset>
			</form>
		</div>
				
				<p class="total">총 게시물 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
							
		  	
		  	<c:choose>
				<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA02'}">
					<div class="board_blue_bar">
			            <ul class="photo_list">
			            <c:forEach var="result" items="${resultList}" varStatus="status">
							<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do">
							  <c:param name="nttNo" value="${result.nttNo}" />
							  <c:if test="${not empty searchVO.menuId}"><c:param name="menuId" value="${searchVO.menuId}" /></c:if>
							  <c:if test="${not empty searchVO.bbsId}"><c:param name="bbsId" value="${searchVO.bbsId}" /></c:if>
						      <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
						      <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
				  			  <c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
				  			  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				  			  <c:if test="${fn:length(searchVO.searchCateList) ne 0}">
						  		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
						  			<c:if test="${not empty searchCate}">
						  				<c:param name="searchCateList" value="${searchCate}" />
						  			</c:if>
						  		</c:forEach>
						  	  </c:if>
						    </c:url>
						    
						    <c:set var="isViewEnable" value=""/>
						    <c:choose>
								<c:when test="${SE_CODE eq '10'}"><c:set var="isViewEnable" value="Y"/></c:when>
								<c:when test="${result.othbcAt eq 'N' and USER_INFO.id ne result.frstRegisterId}"><c:set var="isViewEnable" value="N"/></c:when>
								<c:when test="${SE_CODE < brdMstrVO.inqireAuthor}"><c:set var="isViewEnable" value="N"/></c:when>
								<c:otherwise><c:set var="isViewEnable" value="Y"/></c:otherwise>
							</c:choose>
			              <li>
			                <table class="photo_list_box">
			                  <tr>
			                    <td>
			                    	<c:if test="${isViewEnable eq 'Y'}"><a href="<c:out value="${viewUrl}"/>"></c:if>
			                    	<c:choose>
			                    		<c:when test="${empty result.atchFileNm}">
			                    			<img src="${_IMG}/sub/board/photo_img_blank.gif" width="210" height="130" alt="${result.nttSj}"/>
			                    		</c:when>
			                    		<c:otherwise>
			                    			<img src='<c:url value='/cmm/fms/getBbsThumbImage.do'/>?siteId=<c:out value="${brdMstrVO.siteId}"/>&bbsId=<c:out value="${searchVO.bbsId}"/>&atchFileNm=<c:out value="${result.atchFileNm}"/>' alt="${result.nttSj}" width="210" height="130"/>
			                    		</c:otherwise>
			                    	</c:choose>
			                    	<c:if test="${isViewEnable eq 'Y'}"></a></c:if>
			                    </td>
			                  </tr>
			                  <tr>
			                    <td class="photo_list_title">
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
									<c:if test="${result.othbcAt eq 'N'}"><img src="${_IMG}/sub/board/ico_board_lock.gif" width="14" height="13" alt="잠긴글" /></c:if>
									<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
										<c:choose>
											<c:when test="${result.commentCount eq 0}"><span class="boardrenumno">[<c:out value="${result.commentCount}" />]</span></c:when>
											<c:otherwise><span class="boardrenum">[<c:out value="${result.commentCount}" />]</span></c:otherwise>
										</c:choose>
									</c:if>
			                    </td>
			                  </tr>
			                  <tr>
			                    <td class="eng_11"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
			                  </tr>
			                </table>
			              </li>
			            </c:forEach>
						</ul>
						<c:if test="${fn:length(resultList) == 0}">
							<table class="boardscn_list" ><tr><td><spring:message code="common.nodata.msg" /></td></tr></table>
					    </c:if>
					</div>
				</c:when>				
				<c:otherwise>
					<div class="bss_list">
						<ul>
							<li class="list_tit">
								<span class="num"><spring:message code="cop.nttNo"/></span>
								<c:if test="${not empty brdMstrVO.ctgrymasterId}">
									<span class="cate"><spring:message code="cop.category.view" /></span>
								</c:if>
								<span class="tit"><spring:message code="cop.nttSj" /></span>
								<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
					          		<span class="state"><spring:message code="cop.processSttus" /></span>
					          	</c:if>
								<span class="writer"><spring:message code="cop.ntcrNm" /></span>
								<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
									<span class="file"><spring:message code="cop.listAtchFile" /></span>
								</c:if>	
								<span class="date"><spring:message code="cop.frstRegisterPnttm" /></span>
								<span class="hits"><spring:message code="cop.inqireCo" /></span>
							</li>
							<c:forEach var="result" items="${noticeList}" varStatus="status">
								<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do">
								  <c:param name="nttNo" value="${result.nttNo}" />
								  <c:if test="${not empty searchVO.menuId}"><c:param name="menuId" value="${searchVO.menuId}" /></c:if>
								  <c:if test="${not empty searchVO.bbsId}"><c:param name="bbsId" value="${searchVO.bbsId}" /></c:if>
							      <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
							      <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
					  			  <c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
					  			  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					  			  <c:if test="${fn:length(searchVO.searchCateList) ne 0}">
							  		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
							  			<c:if test="${not empty searchCate}">
							  				<c:param name="searchCateList" value="${searchCate}" />
							  			</c:if>
							  		</c:forEach>
							  	  </c:if>
							    </c:url>
								<li class="bss_notice">
									<span class="num">*</span>
									<c:if test="${not empty brdMstrVO.ctgrymasterId}">
										<span class="cate"><c:out value="${result.ctgryNm}" /></span>
									</c:if>
									<span class="tit">
										<a href="<c:out value="${viewUrl}"/>" class="notice_ti"><c:out value="${result.nttSj}" /></a><c:if test="${brdMstrVO.commentUseAt eq 'Y'}">[<c:out value="${result.commentCount}" />]</c:if>
									</span>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
						          		<span class="state">
						          			<c:choose>
												<c:when test="${result.processSttusCode eq 'QA01'}"><img src="${_C_IMG}/page/board/btn_receipt.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA03'}"><img src="${_C_IMG}/page/board/btn_comp.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA02'}"><img src="${_C_IMG}/page/board/btn_disp.gif" alt="${result.processSttusNm}"/>
												</c:when>
											</c:choose>
						          		</span>
						          	</c:if>						
									<span  class="writer"><c:out value="${result.ntcrNm}"/></span>
									<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
										<span class="file"><c:choose><c:when test="${not empty result.atchFileId}"><img src="${_IMG}sub/file_img.gif" alt="첨부파일" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
									</c:if>
									<span class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></span>
									<span class="hits"><c:out value="${result.inqireCo}"/></span>
								</li>
							</c:forEach>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do">
								  <c:param name="nttNo" value="${result.nttNo}" />
								  <c:if test="${not empty searchVO.menuId}"><c:param name="menuId" value="${searchVO.menuId}" /></c:if>
								  <c:if test="${not empty searchVO.bbsId}"><c:param name="bbsId" value="${searchVO.bbsId}" /></c:if>
							      <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
							      <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
					  			  <c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
					  			  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					  			  <c:if test="${fn:length(searchVO.searchCateList) ne 0}">
							  		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
							  			<c:if test="${not empty searchCate}">
							  				<c:param name="searchCateList" value="${searchCate}" />
							  			</c:if>
							  		</c:forEach>
							  	  </c:if>
							    </c:url>
								<li>
									<span class="num"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></span>
									<c:if test="${not empty brdMstrVO.ctgrymasterId}">
										<span class="cate"><c:out value="${result.ctgryNm}" /></span>
									</c:if>
									<span class="tit">
										<c:if test="${result.ordrCodeDp gt 0}">
										  <c:forEach begin="1" end="${result.ordrCodeDp}" step="1">&nbsp;</c:forEach><img src="${_IMG}/sub/board/ico_reply_arr.gif" width="14" height="10" alt="따라붙은글" />
								        </c:if>
								        <c:choose>
											<c:when test="${SE_CODE eq '10'}"><a href="<c:out value="${viewUrl}"/>" class="notice_ti"><c:out value="${result.nttSj}" /></a></c:when>
											<c:when test="${result.othbcAt eq 'N' and USER_INFO.id ne result.frstRegisterId}">
												<c:out value="${result.nttSj}" />
											</c:when>
											<c:when test="${SE_CODE < brdMstrVO.inqireAuthor}">
												<c:out value="${result.nttSj}" />
											</c:when>
											<c:otherwise><a href="<c:out value="${viewUrl}"/>"><c:out value="${result.nttSj}" /></a></c:otherwise>
										</c:choose>
										<c:if test="${result.othbcAt eq 'N'}"><img src="${_IMG}/sub/board/ico_board_lock.gif" width="14" height="13" alt="잠긴글" /></c:if>
										<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
											<c:choose>
												<c:when test="${result.commentCount eq 0}"><span class="boardrenumno">[<c:out value="${result.commentCount}" />]</span></c:when>
												<c:otherwise><span class="boardrenum">[<c:out value="${result.commentCount}" />]</span></c:otherwise>
											</c:choose>
										</c:if>
									</span>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
						          		<span class="state">
						          			<c:choose>
												<c:when test="${result.processSttusCode eq 'QA01'}"><img src="${_C_IMG}/page/board/btn_receipt.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA03'}"><img src="${_C_IMG}/page/board/btn_comp.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA02'}"><img src="${_C_IMG}/page/board/btn_disp.gif" alt="${result.processSttusNm}"/>
												</c:when>
											</c:choose>
						          		</span>
						          	</c:if>						
									<span  class="writer"><c:out value="${result.ntcrNm}"/></span>
									<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
										<span class="file"><c:choose><c:when test="${not empty result.atchFileId}"><img src="${_IMG}sub/file_img.gif" alt="첨부파일" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
									</c:if>
									<span class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></span>
									<span class="hits"><c:out value="${result.inqireCo}"/></span>
								</li>
							</c:forEach>
							
							<c:if test="${fn:length(resultList) == 0}">
						    	<li class="empty"><spring:message code="common.nodata.msg" /></li>
						    </c:if>
						</ul>
					</div>
					
					<c:if test="${brdMstrVO.registAuthor eq '02' or SE_CODE >= brdMstrVO.registAuthor or SE_CODE >= 10}">	
						<c:url var="addBoardArticleUrl" value="${_PREFIX}/addBoardArticle.do">
							<c:param name="menuId" value="${searchVO.menuId}" />
							<c:param name="bbsId" value="${searchVO.bbsId}" />
							<c:param name="registAction" value="regist" />
						</c:url>
						<p class="basicright" style="margin-top:10px;">
							<a href="<c:out value="${addBoardArticleUrl}"/>" onclick="fn_egov_addNotice(this.href);return false;" title="글쓰기화면 이동"><img src="${_IMG}/sub/board/btn_write2.gif" alt="글쓰기" /></a>
						</p>
					</c:if>
			 					
					<div id="paging">
					    <c:url var="pageUrl" value="${_PREFIX}/selectBoardList.do">
					      <c:if test="${not empty searchVO.menuId}"><c:param name="menuId" value="${searchVO.menuId}" /></c:if>
					      <c:if test="${not empty searchVO.bbsId}"><c:param name="bbsId" value="${searchVO.bbsId}" /></c:if>
					      <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
					      <c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
			  			  <c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			  			  <c:if test="${fn:length(searchVO.searchCateList) ne 0}">
					 		<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
					 			<c:if test="${not empty searchCate}">
					  				<c:param name="searchCateList" value="${searchCate}" />
					  			</c:if>
					  		</c:forEach>
						  </c:if>
						 </c:url>
					   
					   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
					   <ui:pagination paginationInfo="${paginationInfo}" type="imageRenderer" jsFunction="${pagingParam}" />
					   
					</div>
		  		</c:otherwise>
		  	</c:choose>
		  	
		
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>