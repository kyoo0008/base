<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
org.springframework.web.util.UrlPathHelper helper = new org.springframework.web.util.UrlPathHelper();
String currentUrl = helper.getOriginatingRequestUri(request) + ((helper.getOriginatingQueryString(request) != null) ? "?" + helper.getOriginatingQueryString(request) : "");
%>
<c:set var="CURR_URL" value="<%=currentUrl%>"/>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:set var="_FILE_CURR_COUNT" value="0"/>
<c:set var="_FILE_CURR_SIZE" value="0"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>파일다운로드</title>
</head>
<body>
<div class="file_box">	
	<c:if test="${updateFlag=='Y'}">
		<div class="file_top">
			<a href="#" class="file_btn" id="btnAddFile_${param.editorId}" style="display:none"><img src="${CMMN_IMG }/btn_add_file.gif" alt="파일첨부"/></a>
			<p class="file_info">
				<strong class="blue">갯수 : </strong><span id="lblCurrCount_${param.editorId}">0</span>/<span id="lblMaxCount_${param.editorId}">0</span> ,
				<strong class="blue">크기 : </strong><span id="lblCurrSize_${param.editorId}">0MB</span>/<span id="lblMaxSize_${param.editorId}">0MB</span>
			</p>
		</div>
	</c:if>
	<table class="file_list_chart" summary="첨부파일 목록을 나타낸표입니다">
		<caption>첨부파일목록</caption>
		<colgroup>
			<col width="*" />
			<col width="150" />
			<c:if test="${updateFlag=='Y'}">
				<col width="30" />
			</c:if>
		</colgroup>
		<thead>			
			<tr>
				<th>파일명</th>
				<c:choose>
					<c:when test="${updateFlag=='Y'}">
						<th class="size">크기</th>
						<th class="del">삭제</th>
					</c:when>
					<c:otherwise>
						<th class="size" colspan="2">크기</th>
					</c:otherwise>
				</c:choose>
			</tr>
		</thead>
		<tbody id="multiFileList_${param.editorId}">
		<tr id="tr_file_empty_${param.editorId}" <c:if test="${fn:length(fileList) ne '0'}">style="display:none"</c:if>>
			<c:choose>
				<c:when test="${updateFlag=='Y'}">
					<td colspan="3" align="center">첨부된 파일이 없습니다.</td>
				</c:when>
				<c:otherwise>
					<td colspan="2" align="center">첨부된 파일이 없습니다.</td>
				</c:otherwise>
			</c:choose>			
		</tr>
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">       
			<tr id="${fileVO.atchFileId}_${fileVO.fileSn}" class="db">
				<c:choose>
	  		       <c:when test="${updateFlag eq 'Y'}">
		  		       	<c:url var="delUrl" value='/cmm/fms/deleteFileInfs.do'>
		  		       		<c:param name="atchFileId" value="${fileVO.atchFileId}"/>
							<c:param name="fileSn" value="${fileVO.fileSn}"/>
							<c:param name="returnUrl" value="${CURR_URL}"/>
		  		       	</c:url>
						<td><img src='${CMMN_IMG }/ico_file.gif' alt='파일'/> <c:out value="${fileVO.orignlFileNm}"/></td>
						<td class="size"><c:out value="${fileVO.fileMgByByteConvert}"/></td>
						<td class="del"><a href="<c:out value="${delUrl}"/>" onclick="fn_egov_editor_file_del('${param.editorId}', '${param.estnAt}', '${param.bbsId}', '<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>');return false;">
								<img src="${CMMN_IMG }/btn_sdelete.gif"/>
							</a>
						</td>
						<c:set var="_FILE_CURR_COUNT" value="${_FILE_CURR_COUNT + 1}"/>
						<c:set var="_FILE_CURR_SIZE" value="${_FILE_CURR_SIZE + fileVO.fileMg}"/>
	  		       </c:when>
	  		       <c:otherwise>
	  			       <c:url var="downLoad" value="/cmm/fms/FileDown.do">
							<c:param name="atchFileId" value="${fileVO.atchFileId}"/>
							<c:param name="fileSn" value="${fileVO.fileSn}"/>
							<c:choose>
								<c:when test="${not empty param.bbsId}"><c:param name="bbsId" value="${param.bbsId}"/></c:when>
								<c:otherwise><c:param name="bbsId" value="00000000000000000000"/></c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty param.trgetId}"><c:param name="trgetId" value="${param.trgetId}"/></c:when>
							</c:choose>
							<c:choose>
								<c:when test="${not empty param.nttNo}"><c:param name="nttId" value="${param.nttNo}"/></c:when>
							</c:choose>
	  			       </c:url>
						<td>
							<a href="<c:out value='${downLoad}'/>" onclick="fn_egov_downFile(this.href);return false;">
								<img src='${CMMN_IMG }/ico_file.gif' alt='파일'/> <c:out value="${fileVO.orignlFileNm}"/>
							</a>
						</td>	  			       	
						<td class="size" colspan="2"><c:out value="${fileVO.fileMgByByteConvert}"/></td>					
	  		       </c:otherwise>
				</c:choose>
			</tr>
        </c:forEach>
		</tbody>
	</table>
</div>

<input type="hidden" id="fileGroupId_${param.editorId}" name="fileGroupId_${param.editorId}" value="${param.param_atchFileId}"/>
<input type="hidden" id="fileCurrCount_${param.editorId}" name="fileCurrCount_${param.editorId}" value="${_FILE_CURR_COUNT}"/>
<input type="hidden" id="fileCurrSize_${param.editorId}" name="fileCurrSize_${param.editorId}" value="${_FILE_CURR_SIZE}"/>
</body>
</html>  