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
<c:set var="_C_CSS" value="${pageContext.request.contextPath}/template/common/css"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>

<c:set var="_PREFIX" value="${pageContext.request.contextPath}/cop/bbs"/>
<c:set var="C_PREFIX" value="/cop/bbs"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="menuId" value="${searchVO.menuId}"/>
		<c:param name="bbsId" value="${searchVO.bbsId}" />
		<c:if test="${fn:length(searchVO.searchCateList) ne 0}">
			<c:forEach var="searchCate" items="${searchVO.searchCateList}" varStatus="statusCate">
				<c:if test="${not empty searchCate}">
					<c:param name="searchCateList" value="${searchCate}" />
				</c:if>
			</c:forEach>
		</c:if>
	  	<c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
	  	<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
		<c:if test="${not empty searchVO.tmplatImportAt}"><c:param name="tmplatImportAt" value="${searchVO.tmplatImportAt}"/></c:if>
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
			<link charset="utf-8" href="${pageContext.request.contextPath}${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId}/style.css" type="text/css" rel="stylesheet"/>
			<script type="text/javascript" src="${pageContext.request.contextPath}${BbsFileStoreWebPathByWebFile}${brdMstrVO.tmplatId}/script.js"></script>
		</head>
		<body>
	</c:otherwise>
</c:choose>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
		
		<script type="text/javascript" src="${_C_JS}/jquery/jquery.form.js" ></script>
		<script type="text/javascript" src="${_C_JS}/board.js" ></script>
		<c:if test="${(SE_CODE >= 10) and (not IS_MOBILE) }">
			<script type="text/javascript" src="${_C_JS}/boardAdmin.js" ></script>
		</c:if>
		<script type="text/javascript">
		
		<c:if test="${!empty brdMstrVO.ctgrymasterId}">		
			var boardCateLevel = ${boardCateLevel};
			var boardCateList = new Array(${fn:length(boardCateList)});
			<c:forEach var="cate" items="${boardCateList}" varStatus="status">
				boardCateList[${status.index}] = new ctgryObj('<c:out value='${cate.upperCtgryId}'/>', '<c:out value='${cate.ctgryId}'/>', '<c:out value='${cate.ctgryNm}'/>', <c:out value='${cate.ctgryLevel}'/>);
			</c:forEach>		
		</c:if>
		
		function fn_egov_addNotice(url) {
	    	<c:choose>
				<c:when test="${not empty USER_INFO.id}">
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
			fnCtgryInit('<c:out value="${searchVO.searchCateList}"/>');
			
			
			$(".fileDown").click(function() {
				var obj = this;				
				$.ajax({
					url:this.href,
					type:'GET',
					dataType:"html",
					cash:false
				}).done(function(html){					
					var data = html;
					$(obj).after("<div class='listFile' style='position:absolute;top:0;right:0;width:270px;text-align:left;line-height:20px;z-index:100;'>"+
							data + 
								"<button class='btnX' style='position:absolute;bottom:12px;right:2px;border:1px;' onclick='return false;'>X</button></div>");
					$(".file_box").css("background","white");
					$(".btnX").click(function() {
						$(".listFile").hide();
					});
				});
				
				return false;
			});
			
			
		});
		<c:if test="${(SE_CODE >= 10) and (not IS_MOBILE) }">
		//관리자 함수 시작
		$(document).ready(function(){
			$("#checkAll").click(function() {	
				$("input:checkbox[name=nttNoArr]").attr("checked", $(this).is(":checked"));
			});
			
			$('#btnManageMove').click(function() {if(checkArticle()) {$('#registAction').val('Move');bbsSelectPop();}return false;});
			$('#btnManageCopy').click(function() {if(checkArticle()) {$('#registAction').val('Copy');bbsSelectPop();}return false;});
			$('#btnManageHide').click(function() {if(checkArticle()) {if(confirm('<spring:message code="button.delete"/> 하시겠습니까?')) {$('#registAction').val('Hide');} else {return false;}} else {return false;}});
			$('#btnManageRemove').click(function() {if(checkArticle()) {if(confirm('<spring:message code="button.deleteDatabase"/> 후에는 <spring:message code="button.repair"/>할 수 없습니다. <spring:message code="button.deleteDatabase"/> 하시겠습니까?')) {$('#registAction').val('Remove');} else {return false;}} else {return false;}});
			$('#btnManageRepair').click(function() {if(checkArticle()) {if(confirm('<spring:message code="button.repair"/> 하시겠습니까?')) {$('#registAction').val('Repair');} else {return false;}} else {return false;}});
			
			$("#listForm").ajaxForm({
				url : '/cop/bbs/manageArticle.do'
				, dataType : 'json'
		        , beforeSubmit : function($form, options) {
		        	if(checkArticle()) {
		        		cfgCommonPopShow();
		        	} else {
		        		return false;
		        	}
		        }
		        , success : function(data) {   
		        	cfgCommonPopHide();
		        	alert(data.message);
		        	document.location.href = $('#returnUrl').val();
				}
		        , error : function() {
		        	alert('문제가 발생하여 요청처리를 완료하지 못하였습니다.');
		        	cfgCommonPopHide();
		        }
		        , resetForm : true
		   });		   
		});

		function checkArticle() {
			if($("input:checkbox[name=nttNoArr]:checked").length == 0) {
				alert('게시글을 선택해주세요');
				return false;
			}
			return true;
		}

		function bbsSelectPop() {
			var url = "/cop/com/selectAllBBSMasterManageInfs.do?siteId=${brdMstrVO.siteId}&bbsId=${brdMstrVO.bbsId}";
			var win = window.open(url ,'bbsSelectPop',' scrollbars=yes, resizable=yes, left=0, top=0, width=700,height=650');
			if(win != null) {
				win.focus();
			}
		}

		function selectBbsMaster(bbsId, ctgryId) {
			$('#trgetId').val(bbsId);
			$('#ctgryId').val(ctgryId);
			$('#listForm').submit();
		}

		function cancleBbsMaster() {
			cfgCommonPopHide();
		}

		function cfgCommonPopShow() {
			$('#wrap').append("<div id='layer_blind_box' style='position:absolute; position:fixed; top:0; left:0; width:100%; height:100%; background:#000; z-index:50;'></div>");
			$('#layer_blind_box').css('opacity', 0.3);
		}

		function cfgCommonPopHide() {
				$('#layer_blind_box').remove();
		};
		//관리자 함수끝 
		</c:if>
		</script>		

<c:choose>
	<c:when test="${IS_MOBILE }">
	<div id="bbs_mbl">
	</c:when>
	<c:otherwise>
	<div id="bbs_wrap">
	</c:otherwise>
</c:choose>
	<form id="listForm" name="listForm" method="post" action="<c:out value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}"/>">
		<input type="hidden" id="registAction" name="registAction"/>
		<input type="hidden" id="siteId" name="siteId" value="<c:out value="${brdMstrVO.siteId}"/>"/>
		<input type="hidden" id="bbsId" name="bbsId" value="<c:out value="${brdMstrVO.bbsId}"/>"/>
		<input type="hidden" id="trgetId" name="trgetId"/>
		<input type="hidden" id="ctgryId" name="ctgryId"/>
		<c:url var="_LIST_HIDDEN_URL" value="${C_PREFIX}/selectBoardList.do${_BASE_PARAM}">
			<c:param name="pageIndex" value="${searchVO.pageIndex}" />
		</c:url>
		<input type="hidden" id="returnUrl" name="returnUrl" value="<c:out value="${_LIST_HIDDEN_URL}"/>"/>
		
		<div class="total">총 게시물 <strong>${paginationInfo.totalRecordCount}</strong>건 ㅣ 현재페이지 <strong>${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</div>							
		  	
		<c:choose>
		<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA02'}">
			<%--갤러리형 목록 --%>
			<div class="list_photo">
	            <ul>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	            	<c:url var="viewUrl" value="${C_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
					  	<c:param name="nttNo" value="${result.nttNo}" />
					  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
				    </c:url>
				    <c:set var="isViewEnable" value=""/>
				    <c:choose>
						<c:when test="${SE_CODE eq '10'}"><c:set var="isViewEnable" value="Y"/></c:when>
						<c:when test="${result.othbcAt eq 'N' and USER_INFO.id ne result.frstRegisterId}"><c:set var="isViewEnable" value="N"/></c:when>
						<c:when test="${SE_CODE < brdMstrVO.inqireAuthor}"><c:set var="isViewEnable" value="N"/></c:when>
						<c:otherwise><c:set var="isViewEnable" value="Y"/></c:otherwise>
					</c:choose>
					<li <c:if test="${result.useAt eq 'N'}">class="deleted"</c:if>>	                
						<div class="ph_img">
							<c:if test="${isViewEnable eq 'Y'}"><a href="<c:out value="${viewUrl}"/>"></c:if>
	                    	<c:choose>
	                    		<c:when test="${empty result.atchFileNm}">
	                    			<img src="${_IMG}/noimg.gif" width="200" height="140" alt="<c:out value="${result.nttSj}"/>"/>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<img src='<c:url value='/cmm/fms/getImage.do'/>?thumbYn=Y&amp;siteId=<c:out value="${brdMstrVO.siteId}"/>&amp;appendPath=<c:out value="${searchVO.bbsId}"/>&amp;atchFileNm=<c:out value="${result.atchFileNm}"/>' alt="<c:out value="${result.nttSj}"/>" width="200" height="140"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	<c:if test="${isViewEnable eq 'Y'}"></a></c:if>
						</div>
						<div class="ph_cont">
							<span>
								<c:if test="${SE_CODE >= 10 and (not IS_MOBILE)}">
									<input type="checkbox" name="nttNoArr" value="${result.nttNo}" title="<spring:message code="cop.select"/>"/>
								</c:if>
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
	                    			<img src="${_IMG}/ico_board_lock.gif" alt="<spring:message code="cop.privateNtt"/>" />
	                    			<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
										<c:choose>
											<c:when test="${result.commentCount eq 0}"><strong>[<c:out value="${result.commentCount}" />]</strong></c:when>
											<c:otherwise><strong>[<c:out value="${result.commentCount}" />]</strong></c:otherwise>
										</c:choose>
									</c:if>	                    				                    		
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
			<%-- 일반 게시판 목록 --%>
			<div id="${brdMstrVO.tmplatId }" class="bss_list">
				<%-- 주의 : 컬럼이 추가시 summary에 작성을 해야한다. --%>
				<table summary="이 표는 ${brdMstrVO.bbsNm } 목록으로
					<spring:message code="cop.nttNo"/>,
					<c:if test="${not empty brdMstrVO.ctgrymasterId}"><spring:message code="cop.category.view" />,</c:if>
					<spring:message code="cop.nttSj" />
					<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}"><spring:message code="cop.processSttus" />,</c:if>
					<spring:message code="cop.ntcrNm" />,
					<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}"><spring:message code="cop.listAtchFile" />,</c:if>
					<spring:message code="cop.frstRegisterPnttm" />,
					<spring:message code="cop.inqireCo" /> 항목으로 구성되어 있습니다
				" class="list_table">
				<caption><c:out value="${brdMstrVO.bbsNm}" /></caption>
				<thead>
					<tr>
						<c:if test="${SE_CODE >= 10 }">
						<th class="check" scope="col"><input type="checkbox" id="checkAll" value="all"/><label for="checkAll"><spring:message code="cop.select"/></label></th>
						</c:if>
						<th class="num" scope="col"><spring:message code="cop.nttNo"/></th>
						<%-- <c:if test="${not empty brdMstrVO.ctgrymasterId}">
							<th class="class" scope="col"><spring:message code="cop.category.view" /></th>							
						</c:if> --%>
						<th class="tit" scope="col"><spring:message code="cop.nttSj" /></th>
						<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
			          		<th class="state" scope="col"><spring:message code="cop.processSttus" /></th>
			          	</c:if>
						<th class="writer" scope="col"><spring:message code="cop.ntcrNm" /></th>
						<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
							<th class="file" scope="col"><spring:message code="cop.listAtchFile" /></th>
						</c:if>	
						<th class="date" scope="col"><spring:message code="cop.frstRegisterPnttm" /></th>
						<th class="hits" scope="col"><spring:message code="cop.inqireCo" /></th>
					</tr>					
				</thead>
				<tbody>
					<c:forEach var="result" items="${noticeList}" varStatus="status">
						<c:url var="viewUrl" value="${C_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
						  	<c:param name="nttNo" value="${result.nttNo}" />
						  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
					    </c:url>
					<tr class="notice">
						<c:if test="${SE_CODE >= 10 }">
							<td class="check"></td>
						</c:if>
						<td class="num"><img src="${_IMG}/icon_notice.gif" alt="<spring:message code="cop.notice"/>"/></td>
						<%-- <c:if test="${not empty brdMstrVO.ctgrymasterId}">
							<td class="class">[ <c:out value="${result.ctgryNm}" /> ]</td>
						</c:if> --%>
						<td class="tit">
							<c:if test="${(not empty brdMstrVO.ctgrymasterId) and (not empty result.ctgryNm)}">
								[<c:out value="${result.ctgryNm}" />]
							</c:if>
							<a href="<c:out value="${viewUrl}"/>" class="notice_ti"><c:out value="${result.nttSj}" /></a>
							<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">								
								<c:choose>
									<c:when test="${IS_MOBILE }"><em class="boardrenum"><c:out value="${result.commentCount}" /></em></c:when>
									<c:when test="${result.commentCount eq 0}"><%-- <em class="boardrenumno">[<c:out value="${result.commentCount}" />]</em> --%></c:when>
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
							<td class="file">
								<c:choose>
									<c:when test="${not empty result.atchFileId}">
										<div style="position:relative;">
											<a href="/cmm/fms/selectFileInfs.do?param_atchFileId=${result.atchFileId}&isSmall=1" class="fileDown"><img src="${_IMG}/ico_file.gif" alt="<spring:message code="cop.listAtchFile"/>" /></a>
										</div>	
									</c:when>
									<c:otherwise>
										<c:if test="${not IS_MOBILE }">-</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</c:if>
						<td class="date"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
						<td class="hits"><c:out value="${result.inqireCo}"/></td>
					</tr>
					</c:forEach>					
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:url var="viewUrl" value="${C_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
						  	<c:param name="nttNo" value="${result.nttNo}" />
						  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
					    </c:url>
						<tr <c:if test="${result.useAt eq 'N'}">class="deleted"</c:if>>
							<c:if test="${SE_CODE >= 10 and (not IS_MOBILE)}">
								<td class="check"><input type="checkbox" name="nttNoArr" value="${result.nttNo}" title="<spring:message code="cop.select"/>"/></td>
							</c:if>
							<td class="num"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
							<td class="tit">
								<c:if test="${(not empty brdMstrVO.ctgrymasterId) and (not empty result.ctgryNm)}">
									[<c:out value="${result.ctgryNm}" />]
								</c:if>
								<c:if test="${result.ordrCodeDp gt 0}">
								  <img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" /><img src="${_IMG}/ico_reply.gif" alt="<spring:message code="cop.replyNtt"/>" />
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
								<c:if test="${result.othbcAt eq 'N'}"><img src="${_IMG}/ico_board_lock.gif" alt="<spring:message code="cop.privateNtt"/>" /></c:if>
								<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
									<c:choose>
										<c:when test="${IS_MOBILE }"><em class="boardrenum"><c:out value="${result.commentCount}" /></em></c:when>
										<c:when test="${result.commentCount eq 0}"><%-- <em class="boardrenumno">[<c:out value="${result.commentCount}" />]</em> --%></c:when>
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
								<td class="file">
									<c:choose>
										<c:when test="${not empty result.atchFileId}">											
											<div style="position:relative;">
												<a href="/cmm/fms/selectFileInfs.do?param_atchFileId=${result.atchFileId}&isSmall=1" class="fileDown"><img src="${_IMG}/ico_file.gif" alt="<spring:message code="cop.listAtchFile"/>" /></a>
											</div>											
										</c:when>
										<c:otherwise><c:if test="${not IS_MOBILE }">-</c:if></c:otherwise>
									</c:choose>
								</td>
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
			</div>
			
		</c:otherwise>
  	</c:choose>
	  	
			<c:if test="${brdMstrVO.registAuthor eq '02' or SE_CODE >= brdMstrVO.registAuthor or SE_CODE >= 10}">			
			<div class="btn_all">
				<c:if test="${(SE_CODE >= 10) and (not IS_MOBILE) }">
				<div class="fL">
					<span class="bbtn"><button type="submit" id="btnManageMove"><spring:message code="button.move"/></button></span>
					<span class="bbtn"><button type="submit" id="btnManageCopy"><spring:message code="button.copy"/></button></span>
					<span class="bbtn"><button type="submit" id="btnManageHide"><spring:message code="button.delete"/></button></span>
					<span class="bbtn"><button type="submit" id="btnManageRemove"><spring:message code="button.deleteDatabase"/></button></span>
					<span class="bbtn"><button type="submit" id="btnManageRepair"><spring:message code="button.repair"/></button></span>
				</div>
				</c:if>
				<div class="fR">
					<c:url var="addBoardArticleUrl" value="${C_PREFIX}/addBoardArticle.do${_BASE_PARAM}">
						<c:param name="registAction" value="regist" />
					</c:url>
					<span  class="bbtn_confirm2"><a href="<c:out value="${addBoardArticleUrl}"/>" id="btnBbsWrite" title="<spring:message code="button.write"/>(<c:out value="${brdMstrVO.bbsNm }"/>)"><spring:message code="button.write"/></a></span>
				</div>				
			</div>
			</c:if>	
	</form>
			<div id="paging">
				<c:url var="pageUrl" value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}"/>
				<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
				<ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />			   
			</div>
			
  		
			<div id="bbs_search">
				<form name="frm" method="post" action="<c:url value='${C_PREFIX}/selectBoardList.do'/>">
				  	<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
					<input name="menuId" type="hidden" value="<c:out value='${searchVO.menuId}'/>" />
					<input name="searchCate" type="hidden" value="<c:out value='${searchVO.searchCate}'/>" />
					<input name="tmplatImportAt" type="hidden" value="<c:out value='${searchVO.tmplatImportAt}'/>" />
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
													<option value="${cate.ctgryId}"><c:out value='${cate.ctgryNm}'/></option>
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
						<label for="ftext" class="hdn"><spring:message code="cop.category.view" /></label>
						<select name="searchCnd" id="ftext">
							<option value="0" <c:if test="${searchVO.searchCnd eq '0'}">selected="selected"</c:if>><spring:message code="cop.nttSj" /></option>
			          		<option value="1" <c:if test="${searchVO.searchCnd eq '1'}">selected="selected"</c:if>><spring:message code="cop.nttCn" /></option>
			          		<option value="2" <c:if test="${searchVO.searchCnd eq '2'}">selected="selected"</c:if>><spring:message code="cop.ntcrNm" /></option>
						</select>
						<label for="inp_text" class="hdn">검색어입력</label>
						<input name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" type="text" class="inp_s" id="inp_text" />
						<span class="bbtn_s"><input type="submit" value="검색" title="검색(<c:out value="${brdMstrVO.bbsNm }"/> 게시물 내)" /></span>
					</fieldset>
				</form>
			</div>			  	
			
</div> <!-- #bbsWrap end -->

<c:choose>
	<c:when test="${searchVO.tmplatImportAt ne 'N'}">
		<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		</body>
		</html>
	</c:otherwise>
</c:choose>