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
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/web/smart_001/image"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/web/smart_001/css"/>
<c:set var="_JS" value="${pageContext.request.contextPath}/template/web/smart_001/js"/>
<c:set var="_C_LIB" value="${pageContext.request.contextPath}/lib"/>

<c:set var="_PREFIX" value="${pageContext.request.contextPath}/cop/bbs"/>
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
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>

<c:if test="${!IS_MOBILE}">
	<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
	<script type="text/javascript" src="${_C_JS}/egovframework/cmm/fms/EgovMultiFile.js" ></script>
</c:if>
<script type="text/javascript" src="${_C_JS}/board.js" ></script>
<script type="text/javascript" src="${_C_JS}/egovframework/cmm/sym/cal/EgovCalPopup.js" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	
<c:if test="${!empty brdMstrVO.ctgrymasterId}">

var boardCateLevel = ${boardCateLevel};
var boardCateList = new Array(${fn:length(boardCateList)});
<c:forEach var="cate" items="${boardCateList}" varStatus="status">
	boardCateList[${status.index}] = new ctgryObj('${cate.upperCtgryId}', '${cate.ctgryId}', '${cate.ctgryNm}', ${cate.ctgryLevel});
</c:forEach>

</c:if>
		
	<c:if test="${!IS_MOBILE}">
		function fn_egov_regist() {
	
			
			if (!fn_egov_bbs_basic_regist(document.board)){
				return false;
			}
			
			<c:if test="${!empty brdMstrVO.ctgrymasterId}">
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
	</c:if>
		
	$(document).ready( function() {		
		fn_egov_bbs_editor('nttCn');
	});
</script>


	
       	 
	<form:form commandName="board" name="board" method="post" action="${_ACTION}" enctype="multipart/form-data" onsubmit="return fn_egov_regist()">
       <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
       <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
       <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${brdMstrVO.posblAtchFileNumber}'/>" />
       <input type="hidden" name="bbsId" value="<c:out value='${brdMstrVO.bbsId}'/>" />
       <input name="menuId" type="hidden" value="<c:out value='${searchVO.menuId}'/>" />
       <input type="hidden" name="registAction" value="${searchVO.registAction}"/>
       <c:choose>
        	<c:when test="${searchVO.registAction eq 'updt' }">
        		<input type="hidden" name="returnUrl" value="<c:url value='${_PREFIX}/forUpdateBoardArticle.do'/>"/>
        	</c:when>
        	<c:when test="${searchVO.registAction eq 'reply' }">
        		<input type="hidden" name="returnUrl" value="<c:url value='${_PREFIX}/addReplyBoardArticle.do'/>"/>
        	</c:when>
        </c:choose>
       
       <form:hidden path="nttNo"/>
       <form:hidden path="ctgryId"/>
       <form:hidden path="ordrCode"/>
       <form:hidden path="ordrCodeDp"/>
       
	<div class="sub_smartcn_gap">
       	 
        <table summary=" <c:out value="${brdMstrVO.bbsNm}"/> 쓰기입니다." class="board_write2">
          <caption><c:out value="${brdMstrVO.bbsNm}"/></caption>
          <colgroup><col style="width:110px;" /><col /></colgroup>
          
          <c:choose>
				<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA11' and searchVO.registAction eq 'reply'}">
					<input type="hidden" name="nttSj" value="dummy"/>
					<tr>
						<th>진행처리상태</th>
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
		            <th scope="row"><spring:message code="cop.nttSj" /></th>
		            <td><form:input path="nttSj" cssClass="commin" cssStyle="width:530px;"/><br/><form:errors path="nttSj" /></td>
		          </tr>
		          <c:if test="${!empty brdMstrVO.ctgrymasterId and searchVO.registAction ne 'reply'}">
			          <tr>
			            <th scope="row"><spring:message code="cop.category.view" /></th>
			            <td>
			            	<c:forEach var="ctgryLevel" begin="1" end="${boardCateLevel}" step="1" varStatus="status">
								<c:choose>
									<c:when test="${status.first}">
										<select name="regCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})">
											<option value="">선택</option>
											<c:forEach var="cate" items="${boardCateList}">
												<c:if test="${cate.ctgryLevel eq 1 }">
													<option value="${cate.ctgryId}">${cate.ctgryNm}</option>
												</c:if>
											</c:forEach>
										</select>
									</c:when>
									<c:otherwise><select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})"><option value="">선택</option></select></c:otherwise>
								</c:choose>
							</c:forEach>
							<script type="text/javascript">
								fnCtgryInit('${board.ctgryPathById}');
							</script>
			            </td>
			          </tr>
		          </c:if>		    	
		          <c:if test="${SE_CODE >= 10}">
		          	<tr>
			          	<th scope="row"><spring:message code="cop.noticeAt" /></th>
			            <td>
			           		<spring:message code="button.yes" /> : <form:radiobutton path="noticeAt"  value="Y"/>&nbsp;<spring:message code="button.no" /> : <form:radiobutton path="noticeAt"  value="N"/>
				            <br/><form:errors path="noticeAt" />
						</td>
					</tr>
				  </c:if>
				  <c:if test="${brdMstrVO.othbcUseAt eq 'Y'}">
				  	<tr>
						<th scope="row"><spring:message code="cop.publicAt" /></th>
			            <td style="border: 1px solid #d0d0d0;">
			           		<spring:message code="cop.public" /> : <form:radiobutton path="othbcAt"  value="Y"/>&nbsp;
				                <spring:message code="cop.private" /> : <form:radiobutton path="othbcAt"  value="N"/>
				                <br/><form:errors path="othbcAt" />
						</td>
					</tr>
				  </c:if>
				</c:otherwise>
			</c:choose>	 
		          <tr>
		            <td colspan="2" style="border: none;">
		            	<div class="commediter"><form:textarea path="nttCn" rows="30" cssStyle="width:100%;"/><br/><form:errors path="nttCn" /></div>
		            </td>
		          </tr>
		          <c:if test="${not empty board.atchFileId}">
					<tr>
						<th><label for="egovComFileUploader"><spring:message code="cop.atchFileList" /></label></th>
						<td>
							<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
						    	<c:param name="param_atchFileId" value="${board.atchFileId}" />
							</c:import>
						</td>
					</tr>
				  </c:if>
				  <c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
					<tr>
						<th><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></th>
						<td>
							<input name="file_1" id="egovComFileUploader" type="file" class="inp" />
	            			<div id="egovComFileList"></div>
	            			<script type="text/javascript">
						    	    var existFileNum = document.board.fileListCnt;	    
						      		var maxFileNum = document.board.posblAtchFileNumber.value;
						      
						      		if (existFileNum=="undefined" || existFileNum ==null) {
						      			existFileNum = 0;
						      		} else {
						      			existFileNum = existFileNum.value;
						      		}
						      		
						      		if (maxFileNum=="undefined" || maxFileNum ==null) {
						      			maxFileNum = 0;
						      		}		
						      		var uploadableFileNum = maxFileNum - existFileNum;
						      		if (uploadableFileNum<0) {
						      			uploadableFileNum = 0;
						      		}				
						      		if (uploadableFileNum != 0) {
						      			//fn_egov_check_file('Y');
						      			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
						      			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
						      		} else {
						      			//fn_egov_check_file('N');
						      		}			
							</script>
						</td>
					</tr>
				  </c:if>
        </table>
 	
	<p class="center" style="margin:20px 0;">
		<c:choose>
			<c:when test="${searchVO.registAction eq 'regist' and SE_CODE >= brdMstrVO.registAuthor}">
				<input type="image" src="${_IMG}/sub/board/btn_regi2.gif" alt="등록하기" style="margin-right:3px;"/>
			</c:when>
			<c:when test="${searchVO.registAction eq 'updt' and SE_CODE >= brdMstrVO.registAuthor}">
				<input type="image" src="${_IMG}/sub/board/btn_modify.gif" alt="수정하기" style="margin-right:3px;"/>
			</c:when>
			<c:when test="${searchVO.registAction eq 'reply' and SE_CODE >= brdMstrVO.registAuthor}">
				<input type="image" src="${_IMG}/sub/board/btn_replywrite.gif" alt="답변하기" style="margin-right:3px;"/>
			</c:when>
		</c:choose>	
		<c:url var="selectBoardListUrl" value="${_PREFIX}/selectBoardList.do">
		    <c:param name="menuId" value="${searchVO.menuId}" />
	        <c:param name="bbsId" value="${brdMstrVO.bbsId}" />
	        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
			<c:param name="searchCnd" value="${searchVO.searchCnd}" />
			<c:param name="searchWrd" value="${searchVO.searchWrd}" />
			<c:param name="searchCate" value="${searchVO.searchCate}" />
		</c:url>
		<a href="<c:out value="${selectBoardListUrl}"/>"><img src="${_IMG}/sub/board/btn_cancel02.gif" alt="취소하기" style="margin-right:3px;"/></a>
	</p>
	
	
	
	</div>
	
	</form:form>

<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>