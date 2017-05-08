<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="_C_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/bbs"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="siteId" value="${searchVO.siteId}"/>
		<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
		<c:param name="bbsId" value="${searchVO.bbsId}" />
		<c:param name="trgetId" value="${searchVO.trgetId}" />
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
	</c:url>
<% /*URL 정의*/ %>
														    
<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="${brdMstrVO.bbsNm}"/>
</c:import>

<script type="text/javascript" src="${_C_JS}/jquery/jquery-1.9.1.min.js" ></script>
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

//관리자 함수 시작
$(document).ready(function(){
	$("#checkAll").click(function() {	
		$("input:checkbox[name=nttNoArr]").attr("checked", $(this).is(":checked"));
	});
	
	$('#btnManageMove').click(function() {if(checkArticle()) {$('#registAction').val('Move');bbsSelectPop();}return false;});
	$('#btnManageCopy').click(function() {if(checkArticle()) {$('#registAction').val('Copy');bbsSelectPop();}return false;});
	$('#btnManageHide').click(function() {if(checkArticle()) {if(confirm('삭제 하시겠습니까?')) {$('#registAction').val('Hide');} else {return false;}} else {return false;}});
	$('#btnManageRemove').click(function() {if(checkArticle()) {if(confirm('완전삭제 후에는 복구 할 수 없습니다. 완전삭제 하시겠습니까?')) {$('#registAction').val('Remove');} else {return false;}} else {return false;}});
	$('#btnManageRepair').click(function() {if(checkArticle()) {if(confirm('복구 하시겠습니까?')) {$('#registAction').val('Repair');} else {return false;}} else {return false;}});
	
	$("#listForm").ajaxForm({
		url : '${pageContext.request.contextPath}/cop/bbs/manageArticle.do'
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
	var url = "${pageContext.request.contextPath}/cop/com/selectAllBBSMasterManageInfs.do?siteId=${brdMstrVO.siteId}&bbsId=${brdMstrVO.bbsId}&trgetId=${brdMstrVO.trgetId}";
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

</script>

<div id="cntnts">
	<form id="listForm" name="listForm" method="post">
		<input type="hidden" id="registAction" name="registAction"/>
		<input type="hidden" id="bbsId" name="bbsId" value="<c:out value="${brdMstrVO.bbsId}"/>"/>
		<input type="hidden" id="trgetId" name="trgetId"/>
		<input type="hidden" id="ctgryId" name="ctgryId"/>
		<c:url var="_LIST_HIDDEN_URL" value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}">
			<c:param name="pageIndex" value="${searchVO.pageIndex}" />
		</c:url>
		<input type="hidden" id="returnUrl" name="returnUrl" value="<c:out value="${_LIST_HIDDEN_URL}"/>"/>
		
		<p class="total">총 게시물 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
				<c:choose>
					<c:when test="${brdMstrVO.bbsAttrbCode eq 'BBSA02'}">
						<c:if test="${fn:length(resultList) == 0}">
							<p class="btn_c"><spring:message code="common.nodata.msg" /></p>
						</c:if>
						<c:if test="${fn:length(resultList) > 0}">
						<div class="photo_list">
							<ul>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
									  	<c:param name="nttNo" value="${result.nttNo}" />
									  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
								    </c:url>
									<li <c:if test="${result.useAt eq 'N'}">class="deleted"</c:if>>
										<span class="photo">
											<c:choose>
												<c:when test="${empty result.atchFileNm}">
													<a href="${viewUrl}"><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></a>
												</c:when>
												<c:otherwise>
													<a href="${viewUrl}"><img src='<c:url value='/cmm/fms/getImage.do'/>?thumbYn=Y&siteId=<c:out value="${searchVO.siteId}"/>&appendPath=<c:out value="${searchVO.bbsId}"/>&atchFileNm=<c:out value="${result.atchFileNm}"/>' alt="${result.nttSj}" width="120" height="107"/></a>
												</c:otherwise>
											</c:choose>
										</span>
										<c:if test="${result.othbcAt eq 'N'}">
											<c:out value="${result.nttSj}" />
											<img src="${_IMG}/page/board/icon_lock.gif" alt="비밀글" />
										</c:if>
										<c:if test="${result.othbcAt eq 'Y'}">
											<a href="${viewUrl}"><c:out value="${result.nttSj}" /></a>
										</c:if>
										<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
											<strong class="org">[<c:out value="${result.commentCount}" />]</strong>
										</c:if>
									</li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</c:when>
					<c:otherwise>
						<table class="chart_board" summary="${brdMstrVO.bbsNm}에대한 번호, 제목, 작성자, 첨부, 적성일, 조회순으로 나타낸 목록표" >
							<caption class="hdn">${brdMstrVO.bbsNm} 목록</caption>
							<colgroup>
								<col width="65px" />
								<col width="65px" />
								<c:if test="${not empty brdMstrVO.ctgrymasterId}">
									<col width="70px" />
								</c:if>
								<col width="*" />
								<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA01'}">
						        	<col width="70px" />
						        	<col width="70px" />>
						      	</c:if>								
								<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
									<col width="60px" />
								</c:if>
								<col width="70px" />
								<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
					          		<col width="60px" />
					          	</c:if>
								<col width="85px" />
								<col width="70px" />
							</colgroup>
							<thead>
								<tr>
									<th class="first"><input type="checkbox" id="checkAll" value="all"/><label for="checkAll">선택</label></th>
									<th><spring:message code="cop.nttNo"/></th>
									<c:if test="${not empty brdMstrVO.ctgrymasterId}">
										<th><spring:message code="cop.category.view" /></th>
									</c:if>
									<th><spring:message code="cop.nttSj" /></th>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA01'}">
							        	<th><spring:message code="cop.ntceBgnde" /></th>
          								<th><spring:message code="cop.ntceEndde" /></th>
							      	</c:if>
									<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
										<th><spring:message code="cop.listAtchFile" /></th>
									</c:if>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
						          		<th scope="col"><spring:message code="cop.processSttus" /></th>
						          	</c:if>
						          	<th><spring:message code="cop.ntcrNm" /></th>
									<th><spring:message code="cop.frstRegisterPnttm" /></th>
									<th class="last"><spring:message code="cop.inqireCo" /></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${noticeList}" varStatus="status">
								<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
								  	<c:param name="nttNo" value="${result.nttNo}" />
								  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
							    </c:url>
								<tr>
									<td class="check"></td>
									<td>공지</td>									
									<c:if test="${not empty brdMstrVO.ctgrymasterId}">
										<td><c:out value="${result.ctgryNm}" /></td>
									</c:if>
									<td class="tit">
										<c:if test="${result.ordrCodeDp ne 0}">
										  <img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" />
								          <img src="${_C_IMG}/sub/board/icon_re.gif" alt="reply arrow" />
								        </c:if>
										<a href="${viewUrl}" class="notice_ti"><c:out value="${result.nttSj}" /></a>
										<c:if test="${result.othbcAt eq 'N'}">
											<img src="${_C_IMG}/sub/board/icon_lock.gif" alt="비밀글" />
										</c:if>
										<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
											<strong class="org">[<c:out value="${result.commentCount}" />]</strong>
										</c:if>
									</td>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA01'}">
							        	<td><c:out value="${result.ntceBgnde}"/></td>
          								<td><c:out value="${result.ntceEndde}"/></td>
							      	</c:if>									
									<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
										<c:choose>
								          <c:when test="${not empty result.atchFileId}">
								          	<td><img src="${_C_IMG}/sub/board/icon_file.gif" alt="첨부파일" /></td>
								          </c:when>
								          <c:otherwise>
								           	<td>-</td>
								          </c:otherwise>
								        </c:choose>
									</c:if>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
						          		<td>
						          			<c:choose>
												<c:when test="${result.processSttusCode eq 'QA01'}"><img src="${_C_IMG}/page/board/btn_receipt.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA03'}"><img src="${_C_IMG}/page/board/btn_comp.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA02'}"><img src="${_C_IMG}/page/board/btn_disp.gif" alt="${result.processSttusNm}"/>
												</c:when>
											</c:choose>
						          		</td>
						          	</c:if>
									<td><c:out value="${result.ntcrNm}"/></td>
								  	<td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
									<td><c:out value="${result.inqireCo}"/></td>
								</tr>
							</c:forEach>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do${_BASE_PARAM}">
								  	<c:param name="nttNo" value="${result.nttNo}" />
								  	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
							    </c:url>
								<tr <c:if test="${result.useAt eq 'N'}">class="deleted"</c:if>>
									<td class="check"><input type="checkbox" name="nttNoArr" value="${result.nttNo}" title="선택"/></td>
									<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
									<c:if test="${not empty brdMstrVO.ctgrymasterId}">
										<td><c:out value="${result.ctgryNm}" /></td>
									</c:if>
									<td class="tit">
										<c:if test="${result.ordrCodeDp ne 0}">
										  <img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" />
								          <img src="${_C_IMG}/sub/board/icon_re.gif" alt="reply arrow" />
								        </c:if>
										<a href="${viewUrl}" class="notice_ti"><c:out value="${result.nttSj}" /></a>
										<c:if test="${result.othbcAt eq 'N'}">
											<img src="${_C_IMG}/sub/board/icon_lock.gif" alt="비밀글" />
										</c:if>
										<c:if test="${brdMstrVO.commentUseAt eq 'Y'}">
											<strong class="org">[<c:out value="${result.commentCount}" />]</strong>
										</c:if>
									</td>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA01'}">
							        	<td><c:out value="${result.ntceBgnde}"/></td>
          								<td><c:out value="${result.ntceEndde}"/></td>
							      	</c:if>
									<c:if test="${brdMstrVO.fileAtchPosblAt eq 'Y'}">
										<c:choose>
								          <c:when test="${not empty result.atchFileId}">
								          	<td><img src="${_C_IMG}/sub/board/icon_file.gif" alt="첨부파일" /></td>
								          </c:when>
								          <c:otherwise>
								           	<td>-</td>
								          </c:otherwise>
								        </c:choose>
									</c:if>
									<c:if test="${brdMstrVO.bbsAttrbCode eq 'BBSA11'}">
						          		<td>
						          			<c:choose>
												<c:when test="${result.processSttusCode eq 'QA01'}"><img src="${_C_IMG}/page/board/btn_receipt.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA03'}"><img src="${_C_IMG}/page/board/btn_comp.gif" alt="${result.processSttusNm}"/>
												</c:when>
												<c:when test="${result.processSttusCode eq 'QA02'}"><img src="${_C_IMG}/page/board/btn_disp.gif" alt="${result.processSttusNm}"/>
												</c:when>
											</c:choose>
						          		</td>
						          	</c:if>
						          	<td><c:out value="${result.ntcrNm}"/></td>
								  	<td><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
									<td><c:out value="${result.inqireCo}"/></td>
								
							</c:forEach>
							<c:if test="${fn:length(resultList) == 0}">
						      <tr>
						        <td colspan="10"><spring:message code="common.nodata.msg" /></td>
						      </tr>
						    </c:if>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
				<div class="btn_all">
					<div class="fL">
						<input type="image" id="btnManageMove" src="${_IMG}/btn_move.gif" alt="이동" />
						<input type="image" id="btnManageCopy" src="${_IMG}/btn_copy.gif" alt="복사" />
						<input type="image" id="btnManageHide" src="${_IMG}/btn_close.gif" alt="삭제" />
						<input type="image" id="btnManageRemove" src="${_IMG}/btn_del_all.gif" alt="완전삭제" />	
						<input type="image" id="btnManageRepair" src="${_IMG}/btn_repair.gif" alt="복구" />						
					</div>
					<div class="fR">
						<c:url var="addBoardArticleUrl" value="${_PREFIX}/addBoardArticle.do${_BASE_PARAM}">
							<c:param name="registAction" value="regist" />
						</c:url>
						<a href="${addBoardArticleUrl}"><img src="${_IMG}/btn/btn_write.gif" alt="글쓰기" /></a>
					</div>
				</div>
 			</form>
				<div id="paging">
					<c:url var="pageUrl" value="${_PREFIX}/selectBoardList.do${_BASE_PARAM}">
					</c:url>
				    <ul>
				      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
				    </ul>
				</div>
 
				<div id="bbs_search">
					<form name="frm" method="post" action="<c:url value='${_PREFIX}/selectBoardList.do'/>">
						<input type="hidden" name="siteId" value="${searchVO.siteId}"/>
						<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
						<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
						<input type="hidden" name="trgetId" value="${searchVO.trgetId}"/>
						<input name="searchCate" type="hidden" value="${searchVO.searchCate}" />
						<fieldset>
							<legend>검색조건입력폼</legend>
							<c:if test="${!empty brdMstrVO.ctgrymasterId}">
						        <label for="cate" class="hdn"><spring:message code="cop.category.view" /></label>
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
										<c:otherwise><select name="searchCateList" id="ctgry${ctgryLevel}" onchange="fnCtgryChange(${ctgryLevel})"><option value="">선택</option></select></c:otherwise>
									</c:choose>
								</c:forEach>
								
								<script type="text/javascript">
									fnCtgryInit('${searchVO.searchCateList}');
								</script>
						    </c:if>
							<label for="ftext" class="hdn">분류검색</label>
							<select name="searchCnd" id="ftext">
								<!-- option selected value=''>--선택하세요--</option-->
					          	<option value="0" <c:if test="${searchVO.searchCnd eq '0'}">selected="selected"</c:if>>제목</option>
					          	<option value="1" <c:if test="${searchVO.searchCnd eq '1'}">selected="selected"</c:if>>내용</option>
					          	<option value="2" <c:if test="${searchVO.searchCnd eq '2'}">selected="selected"</c:if>>작성자</option>
							</select>
							<label for="inp_text" class="hdn">검색어입력</label>
							<input name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" type="text" class="inp_s" id="inp_text" />
							<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색" />
						</fieldset>
					</form>
				</div>
	


</div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>	