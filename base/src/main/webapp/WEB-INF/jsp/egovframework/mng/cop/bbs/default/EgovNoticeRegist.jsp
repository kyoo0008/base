<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>
<c:set var="_C_HTML" value="${pageContext.request.contextPath}/template/common/html"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/bbs"/>
<c:set var="_ACTION" value=""/>
<c:set var="_EDITOR_ID" value="nttCn"/>

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


<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${brdMstrVO.bbsNm}"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript" src="${_C_JS}/board.js" ></script>
<script type="text/javascript" src="${_C_JS}/egovframework/cmm/fms/EgovMultiFile.js" ></script>
<script type="text/javascript" src="${_C_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

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
	
	
	$(document).ready( function() {
		var adfile_config = {
			storePath:"Board.fileStorePath",
			appendPath:"${brdMstrVO.bbsId}",
			siteId:"${searchVO.siteId}",
			editorId:"${_EDITOR_ID}"
			};
		
		fn_egov_bbs_editor(adfile_config);
	});
</script>

<div id="cntnts">


	<form:form commandName="board" name="board" method="post" action="${pageContext.request.contextPath}${_ACTION}" enctype="multipart/form-data" onsubmit="return fn_egov_regist()">
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
        <input type="hidden" id="posblAtchFileNumber_${_EDITOR_ID}" name="posblAtchFileNumber_${_EDITOR_ID}" value="${brdMstrVO.posblAtchFileNumber}" />
        <input type="hidden" id="posblAtchFileSize_${_EDITOR_ID}" name="posblAtchFileSize_${_EDITOR_ID}" value="${brdMstrVO.posblAtchFileSize * 1024 * 1024}" />
        <input type="hidden" id="fileGroupId" name="fileGroupId" value="${board.atchFileId}"/>
        <input type="hidden" name="bbsId" value="<c:out value='${brdMstrVO.bbsId}'/>" />
        <input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
        <input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  		<input type="hidden" name="registAction" value="${searchVO.registAction}"/>
  		<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
        
        <form:hidden path="nttNo"/>
        <form:hidden path="ctgryId"/>
        <%-- 
        <form:hidden path="ordrCode"/>
        <form:hidden path="ordrCodeDp"/>
         --%>
        <form:hidden path="atchFileId"/>
                    
		<table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
			<caption> </caption>
			<colgroup>
				<col width="10%" />
				<col width="90%" />
			</colgroup>
			<tbody>
				
				<c:choose>
					<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and searchVO.registAction eq 'reply'}">
						<input type="hidden" name="nttSj" value="dummy"/>
						<tr>
							<th><spring:message code="cop.processSttus" /></th>
							<td>
								<select name="processSttusCode" class="select">
									<c:forEach var="resultState" items="${qaCodeList}" varStatus="status">
										<option value='<c:out value="${resultState.code}"/>' <c:if test="${board.processSttusCode eq resultState.code}">selected="selected"</c:if>><c:out value="${resultState.codeNm}"/></option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th><label for="nttSj"><spring:message code="cop.nttSj" /></label></th>
							<td><form:input path="nttSj" cssClass="inp_long"/><br/><form:errors path="nttSj" /></td>
						</tr>
						<c:if test="${!empty brdMstrVO.ctgrymasterId and searchVO.registAction ne 'reply'}">
						<tr>
							<th><label for="ctgry1"><spring:message code="cop.category.view" /></label></th>
							<td>
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
										<c:otherwise><select name="regCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})"><option value=""><spring:message code="cop.select" /></option></select></c:otherwise>
									</c:choose>
								</c:forEach>
								<script type="text/javascript">
									fnCtgryInit('${board.ctgryPathById}');
								</script>
							</td>
						</tr>
						</c:if>				
						<tr>
							<th><label for="noticeAt"><spring:message code="cop.noticeAt" /></label></th>
							<td>
								<spring:message code="button.yes" /> : <form:radiobutton path="noticeAt"  value="Y"/>&nbsp;
				                <spring:message code="button.no" /> : <form:radiobutton path="noticeAt"  value="N"/>
				                <br/><form:errors path="noticeAt" />
							</td>
						</tr>
						<c:if test="${brdMstrVO.othbcUseAt eq 'Y'}">
						<tr>
							<th><label for="othbcAt"><spring:message code="cop.publicAt" /></label></th>
							<td>
								<spring:message code="cop.public" /> : <form:radiobutton path="othbcAt"  value="Y"/>&nbsp;
				                <spring:message code="cop.private" /> : <form:radiobutton path="othbcAt"  value="N"/>
				                <br/><form:errors path="othbcAt" />
							</td>
						</tr>
						</c:if>
					</c:otherwise>
				</c:choose>
				
				<tr>
					<td colspan="2">
						<form:textarea path="nttCn" rows="30" cssStyle="width:100%"/><br/><form:errors path="nttCn" />
					</td>
				</tr>
				<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
					<tr>
						<th><spring:message code="cop.atchFile" /></th>
						<td>
							<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="editorId" value="${_EDITOR_ID}"/>
								<c:param name="estnAt" value="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and searchVO.registAction eq 'reply' ? 'Y' : 'N'}" />
						    	<c:param name="param_atchFileId" value="${board.atchFileId}" />
						    	<c:param name="imagePath" value="${_IMG }"/>
							</c:import>
							
							<noscript>
								<input name="file_1" id="egovComFileUploader" type="file" class="inp" />
							</noscript>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
 
		<div class="btn_r">
			<c:choose>
				<c:when test="${searchVO.registAction eq 'regist' }">
					<input type="image" src="${_IMG}/btn/btn_regist.gif" alt="등록"/>
				</c:when>
				<c:when test="${searchVO.registAction eq 'updt' }">
					<input type="image" src="${_IMG}/btn/btn_modify.gif" alt="수정"/>
				</c:when>
				<c:when test="${searchVO.registAction eq 'reply' }">
					<input type="image" src="${_IMG}/btn/btn_reply.gif" alt="답변"/>
				</c:when>
			</c:choose>			   
			  <c:url var="selectBoardListUrl" value="${_PREFIX}/selectBoardList.do">
			  	<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		        <c:param name="bbsId" value="${brdMstrVO.bbsId}" />
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
			  <a href="${selectBoardListUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록" /></a>
		</div>
	</form:form>
      
</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	