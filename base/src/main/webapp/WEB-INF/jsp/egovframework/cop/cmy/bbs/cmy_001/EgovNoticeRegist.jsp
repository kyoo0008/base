<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="IS_MOBILE"><%=egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)%></c:set>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>

<c:set var="_PREFIX" value="/cop/cmy/bbs"/>
<c:set var="_EDITOR_ID" value="nttCn"/>
<c:set var="_ACTION" value=""/>

<c:choose>
	<c:when test="${searchVO.registAction eq 'regist' }">
		<c:set var="_ACTION" value="${_PREFIX}/insertBoardArticle.do"/>
	</c:when>
	<c:when test="${searchVO.registAction eq 'updt' }">
		<c:set var="_ACTION" value="${_PREFIX}/updateBoardArticle.do"/>
	</c:when>
	<c:when test="${searchVO.registAction eq 'reply' }">
		<c:set var="_ACTION" value="${_PREFIX}/replyBoardArticle.do"/>
	</c:when>
</c:choose>


<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.emplyrId}">	 
	<c:set var="SE_CODE" value="${USER_INFO.authorCode}" />	
</c:if>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<c:if test="${!IS_MOBILE}">
	<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
</c:if>
<script type="text/javascript" src="${_C_JS}/board.js" ></script>
<script type="text/javascript" src="${_C_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
		
	<c:if test="${!IS_MOBILE}">
		function fn_egov_regist() {
	
			
			if (!fn_egov_bbs_basic_regist(document.board)){
				return false;
			}

			if($('#${_EDITOR_ID}').html().length == 0) {
				alert('<spring:message code="cop.nttCn" />은(는) 필수 입력값입니다');
				return false;
			}
			
			$('#fileGroupId').val($('#fileGroupId_${_EDITOR_ID}').val());
			
			<c:if test="${!empty brdMstrVO.ctgrymasterId and searchVO.registAction ne 'reply'}">
				for(var cmIdx = 1 ; cmIdx <= boardCateLevel ; cmIdx++){
					var cmObj = document.getElementById("ctgry" + cmIdx);
					if(cmObj != null) {
						if(fn_egov_SelectBoxValue("ctgry" + cmIdx) != '') {
							document.board.ctgryId.value = fn_egov_SelectBoxValue("ctgry" + cmIdx);
						}
					}
				}
		    </c:if>
	
		    <c:choose>
		    	<c:when test="${searchVO.registAction eq 'updt'}">
					if (!confirm('<spring:message code="common.update.msg" />')) {
						 return false
					}
				</c:when>
				<c:otherwise>
					if (!confirm('<spring:message code="common.regist.msg" />')) {
						return false;
					}
				</c:otherwise>
			</c:choose>
		}
		
		<c:if test="${!empty brdMstrVO.ctgrymasterId and searchVO.registAction ne 'reply'}">
			var boardCateLevel = ${boardCateLevel};
			var boardCateList = new Array(${fn:length(boardCateList)});
			<c:forEach var="cate" items="${boardCateList}" varStatus="status">
				boardCateList[${status.index}] = new ctgryObj('${cate.upperCtgryId}', '${cate.ctgryId}', '${cate.ctgryNm}', ${cate.ctgryLevel});
			</c:forEach>
		</c:if>
		
	</c:if>
	<c:if test="${!IS_MOBILE}">		
	$(document).ready( function() {
		var adfile_config = {
			storePath:"Board.fileStorePath",
			appendPath:"${brdMstrVO.bbsId}",
			siteId:"${searchVO.siteId}",
			editorId:"${_EDITOR_ID}"
		};
		
		fnCtgryInit('${board.ctgryPathById}');
		
		fn_egov_bbs_editor(adfile_config);
	});
	</c:if>
</script>


<div class="cm_sub_box">
	<h2><c:out value="${brdMstrVO.bbsNm}"/></h2>
	<div class="cm_sub_cont">
		<div id="bbs_cm_wrap">
       	 
			<form:form commandName="board" name="board" method="post" action="${_ACTION}" enctype="multipart/form-data" onsubmit="return fn_egov_regist()">
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
				<input type="hidden" id="posblAtchFileNumber_${_EDITOR_ID}" name="posblAtchFileNumber_${_EDITOR_ID}" value="${brdMstrVO.posblAtchFileNumber}" />
		        <input type="hidden" id="posblAtchFileSize_${_EDITOR_ID}" name="posblAtchFileSize_${_EDITOR_ID}" value="${brdMstrVO.posblAtchFileSize * 1024 * 1024}" />
		        <input type="hidden" id="fileGroupId" name="fileGroupId" value="${board.atchFileId}"/>
				<input type="hidden" name="bbsId" value="<c:out value='${brdMstrVO.bbsId}'/>" />
				<input name="trgetId" type="hidden" value="<c:out value='${searchVO.trgetId}'/>" />
				<input type="hidden" name="registAction" value="${searchVO.registAction}"/>
				       
				<form:hidden path="nttNo"/>
				<form:hidden path="ctgryId"/>
				<form:hidden path="ordrCode"/>
				<form:hidden path="ordrCodeDp"/>
				<form:hidden path="atchFileId"/>
				
				<div class="board_write">
					<dl>
						<c:choose>
						<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and searchVO.registAction eq 'reply'}">
							<input type="hidden" name="nttSj" value="dummy"/>
							<dt><label for="ftext"><spring:message code="cop.processSttus" /></label></dt>
							<dd>
								<select name="processSttusCode" id="ftext" class="select">
									<c:forEach var="resultState" items="${qaCodeList}" varStatus="status">
									<option value='<c:out value="${resultState.code}"/>' <c:if test="${board.processSttusCode eq resultState.code}">selected="selected"</c:if>><c:out value="${resultState.codeNm}"/></option>
									</c:forEach>
								</select>
							</dd>
						</c:when>
						<c:otherwise>
							<dt><label for="nttSj"><spring:message code="cop.nttSj" /></label></dt>
							<dd><form:input path="nttSj" cssClass="inp tit" /></dd>
							<c:if test="${!empty brdMstrVO.ctgrymasterId and searchVO.registAction ne 'reply'}">
							<dt><label for="ctgry1"><spring:message code="cop.category.view" /></label></dt>
							<dd>						
								<c:forEach var="ctgryLevel" begin="1" end="${boardCateLevel}" step="1" varStatus="status">
									<c:choose>
									<c:when test="${status.first}">
										<select name="regCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})">
											<option value=""><spring:message code="cop.select" /></option>
											<c:forEach var="cate" items="${boardCateList}">
												<c:if test="${cate.ctgryLevel eq 1 }">
													<option value="${cate.ctgryId}">${cate.ctgryNm}</option>
												</c:if>
											</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<label for="ctgry${ctgryLevel}" style="visibility:hidden;"><spring:message code="cop.category.view" />${ctgryLevel}</label>
										<select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})"><option value=""><spring:message code="cop.select" /></option></select>
									</c:otherwise>
									</c:choose>
								</c:forEach>
							</dd>
							</c:if>					
							<c:if test="${SE_CODE >= 10}">		          	
				          	<dt><label><spring:message code="cop.noticeAt" /></label></dt>
				            <dd>
				           		<spring:message code="button.yes" var="noticeAtY"/><form:radiobutton path="noticeAt"  value="Y" label="${noticeAtY }"/>&nbsp;
					            <spring:message code="button.no" var="noticeAtN" /><form:radiobutton path="noticeAt"  value="N" label="${noticeAtN}"/> <form:errors path="noticeAt" />
							</dd>					
							</c:if>
							<c:if test="${brdMstrVO.othbcUseAt eq 'Y'}">					
							<dt><label><spring:message code="cop.publicAt" /></label></dt>
							<dd>
								<spring:message code="cop.public" var="othbcAtY"/><form:radiobutton path="othbcAt"  value="Y" label="${othbcAtY }"/>&nbsp;
								<spring:message code="cop.private" var="othbcAtN"/><form:radiobutton path="othbcAt"  value="N" label="${othbcAtN }"/> <form:errors path="othbcAt" />
							</dd>					
							 </c:if>
						</c:otherwise>
						</c:choose>
						
						<dt><label><spring:message code="cop.ntcrNm"/></label></dt>
						<c:choose>
						<c:when test="${searchVO.registAction eq 'updt' }">
							<dd><strong><c:out value="${board.ntcrNm }"/></strong>(<c:out value="${board.frstRegisterId }"/>)</dd>
						</c:when>
						<c:otherwise>
							<dd><strong><c:out value="${USER_INFO.emplyrNm }"/></strong>(<c:out value="${USER_INFO.emplyrId }"/>)</dd>
						</c:otherwise>
						</c:choose>	
			
						<dt class="hdn"><label for="nttCn"><spring:message code="cop.nttCn" /></label></dt>
						<dd class="write_cont">
							<div class="commediter"><form:textarea path="nttCn" rows="10" cssStyle="width:100%;"/><br/><form:errors path="nttCn" /></div>
						</dd>
										
								
						
					</dl>
					<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
						<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
							<c:param name="editorId" value="${_EDITOR_ID}"/>
							<c:param name="estnAt" value="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and searchVO.registAction eq 'reply' ? 'Y' : 'N'}" />
					    	<c:param name="param_atchFileId" value="${board.atchFileId}" />
					    	<c:param name="imagePath" value="${_IMG }"/>
						</c:import>
						<noscript>	
							<label for="egovComFileUploader"><spring:message code="cop.atchFileList" /></label>
							<input name="file_1" id="egovComFileUploader" type="file" class="inp" />
						</noscript>
					</c:if>	
					
				</div>
		 	
				<div class="btn_c">
					<c:choose>
						<c:when test="${searchVO.registAction eq 'regist' and SE_CODE >= brdMstrVO.registAuthor}"><span class="bbtn3"><button type="submit"><spring:message code="button.create"/></button></span></c:when>
						<c:when test="${searchVO.registAction eq 'updt' and SE_CODE >= brdMstrVO.registAuthor}"><span class="bbtn3"><button type="submit"><spring:message code="button.update"/></button></span></c:when>
						<c:when test="${searchVO.registAction eq 'reply' and SE_CODE >= brdMstrVO.registAuthor}"><span class="bbtn3"><button type="submit"><spring:message code="button.reply"/></button></span></c:when>
					</c:choose>	
					<c:url var="selectBoardListUrl" value="${_PREFIX}/selectBoardList.do">
					    <c:param name="trgetId" value="${searchVO.trgetId}" />
				        <c:param name="bbsId" value="${brdMstrVO.bbsId}" />
				        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
						<c:param name="searchCnd" value="${searchVO.searchCnd}" />
						<c:param name="searchWrd" value="${searchVO.searchWrd}" />
						<c:param name="searchCate" value="${searchVO.searchCate}" />
					</c:url>
					<span class="bbtn4"><a href="<c:out value="${selectBoardListUrl}"/>"><spring:message code="button.reset"/></a></span>
				</div>	
			</form:form>
		</div>
	</div>
</div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>
