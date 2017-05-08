<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_C_IMG" value="/template/common/images"/>
  <c:forEach var="result" items="${resultList}" varStatus="status">
    <c:url var="viewURL" value='/cop/bbs/selectBoardArticle.do'>
    	<c:param name="menuId" value="${searchVO.linkMenuId}"></c:param>
    	<c:param name="bbsId" value="${result.bbsId}"></c:param>
    	<c:param name="nttNo" value="${result.nttNo}"></c:param>
    </c:url>
		<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag}></c:if>
			<c:forEach var="colum" items="${searchVO.columInfo}">
				<c:if test="${not empty colum.tag}">
					<${colum.tag}
					<c:choose>
						<c:when test="${colum.tag eq 'a'}"> href="<c:out value="${viewURL}"/>" <c:if test="${not empty param.viewScript}">onclick="<c:out value="${param.viewScript}"/>(this.href, '<c:out value="${param.menuNm}"/>');return false;"</c:if></c:when>
					</c:choose>						
					<c:if test="${not empty colum.cssClass}"> class="${colum.cssClass}"</c:if>
					>
				</c:if>
						
				<c:choose>
					<c:when test="${colum.colname eq 'nttSj'}">
						<c:if test="${result.ordrCodeDp gt 0}">
							<img src="${_C_IMG}/sub/board/blank_bg.gif" width="${result.ordrCodeDp * 19}" height="0" alt="${result.ordrCodeDp} Depth" /><img src="${_C_IMG}/sub/board/icon_re.gif" alt="따라붙은글" />
						</c:if>
						<c:choose>
							<c:when test="${colum.length ne '-1'}">
								<c:choose>
									<c:when test="${fn:length(result.nttSj) > colum.length}">
										<c:out value='${fn:substring(result.nttSj, 0, colum.length)}'/>...
									</c:when>
									<c:otherwise>
										<c:out value="${result.nttSj}" />
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise><c:out value="${result.nttSj}" /></c:otherwise>
						</c:choose>
						<c:if test="${result.othbcAt eq 'N'}"><img src="${_C_IMG}/sub/board/icon_lock.gif" alt="비밀글" /></c:if>
					</c:when>
					<c:when test="${colum.colname eq 'atchFileId'}">
						<c:choose>
							<c:when test="${searchVO.viewType eq 'data'}">
								<c:choose>
						          <c:when test="${!empty result.atchFileId}">
						            <img src="${_C_IMG}/sub/board/icon_file.gif" alt="첨부파일" />
						          </c:when>
						          <c:otherwise>
						            -   
						          </c:otherwise>
						        </c:choose>
							</c:when>
							<c:when test="${searchVO.viewType eq 'gallery'}">
								<c:choose>
									<c:when test="${empty result.atchFileNm}">
										<span><img src="${_C_IMG}/sub/board/no_img.gif" alt="이미지없음" width="${colum.imgWidth}" height="${colum.imgHeight}"/></span>
									</c:when>
									<c:otherwise>
										<span><img src="<c:url value='/cmm/fms/getImage.do'/>?thumbYn=Y&siteId=<c:out value="${siteInfo.siteId}"/>&appendPath=<c:out value="${result.bbsId}"/>&atchFileNm=<c:out value="${result.atchFileNm}"/>" alt="${result.nttSj}" <c:if test="${not empty colum.imgWidth}">width="${colum.imgWidth}"</c:if> <c:if test="${not empty colum.imgWidth}">height="${colum.imgHeight}"</c:if>/></span>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${fn:length(result.nttSj) > colum.length}">
										<strong><c:out value='${fn:substring(result.nttSj, 0, colum.length)}'/>...</strong>
									</c:when>
									<c:otherwise>
										<strong><c:out value="${result.nttSj}" /></strong>
									</c:otherwise>
								</c:choose>
							</c:when>
						</c:choose>
					</c:when>
					<c:when test="${colum.colname eq 'frstRegisterPnttm'}"><fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose>
						
				<c:if test="${not empty colum.tag}"></${colum.tag}></c:if>				
			</c:forEach>
		<c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
  </c:forEach>
  <c:if test="${fn:length(resultList) == 0}">
  	<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag} class="alC"></c:if><spring:message code="info.nodata.msg" /><c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
  </c:if>