<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="/template/homepage/011/images"/>
  <c:forEach var="result" items="${resultList}" varStatus="status">
    <c:url var="viewURL" value='/hpg/evt/selectComtnschdulinfo.do'>
    	<c:param name="schdulId" value="${result.schdulId}"></c:param>
    </c:url>
		<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag}></c:if>
			<c:forEach var="colum" items="${searchVO.columInfo}">
				<c:if test="${not empty colum.tag}">
					<${colum.tag}
					<c:choose>
						<c:when test="${colum.tag eq 'a'}"> href="${viewURL}"</c:when>
					</c:choose>						
					<c:if test="${not empty colum.cssClass}"> class="${colum.cssClass}"</c:if>
					>
				</c:if>
						
				<c:choose>
					
					<c:when test="${colum.colname eq 'schdulStreFileNm'}">
						<c:choose>
							<c:when test="${searchVO.viewType eq 'gallery'}">
								<c:choose>
									<c:when test="${empty result.schdulStreFileNm}">
										<img src="${_IMG}/calendar/event_noimg.gif" alt="이미지없음" width="${colum.imgWidth}" />
									</c:when>
									<c:otherwise>
										<img src="/attachfiles/event/<c:out value='${result.schdulStreFileNm}'/>" alt="<c:out value="${result.schdulNm}"/>" width="${colum.imgWidth}" height="${colum.imgHeight}" onerror="this.src='${_IMG}/calendar/event_noimg.gif'"/>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${searchVO.viewType eq 'submain'}">
								<c:choose>
									<c:when test="${empty result.schdulStreFileNm}">
										<span class="photo"><img src="${_IMG}/calendar/event_noimg.gif" alt="이미지없음" width="${colum.imgWidth}" height="${colum.imgHeight}" /></span>
									</c:when>
									<c:otherwise>
										<span class="photo"><img src="/attachfiles/event/<c:out value='${result.schdulStreFileNm}'/>" alt="<c:out value="${result.schdulNm}"/>" width="${colum.imgWidth}" height="${colum.imgHeight}" onerror="this.src='${_IMG}/calendar/event_noimg.gif'"/></span>
									</c:otherwise>
								</c:choose>
							</c:when>
						</c:choose>
					</c:when>
					
					<c:when test="${colum.colname eq 'schdulNm'}">
						<c:choose>
							<c:when test="${searchVO.viewType eq 'submain'}">
								<strong>
									<c:choose>
										<c:when test="${colum.length ne '-1'}">
											<c:choose>
												<c:when test="${fn:length(result.schdulNm) > colum.length}">
													<c:out value='${fn:substring(result.schdulNm, 0, colum.length)}'/>...
												</c:when>
												<c:otherwise>
													<c:out value="${result.schdulNm}" />
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise><c:out value="${result.schdulNm}" /></c:otherwise>
									</c:choose>
								</strong>
									<dl <c:if test="${not empty colum.cssClass}"> class="${colum.cssClass}"</c:if>>
										<dt>이벤트기간 :</dt>
										<dd><c:out value="${fn:substring(result.schdulBgnde, 0,4)}.${fn:substring(result.schdulBgnde, 4,6)}.${fn:substring(result.schdulBgnde, 6,8)}"/> ~ <c:out value="${fn:substring(result.schdulEndde, 0,4)}.${fn:substring(result.schdulEndde, 4,6)}.${fn:substring(result.schdulBgnde, 6,8)}"/></dd>
										<dt><img src="/template/homepage/011/images/sub/sub_main/btn_win_date.gif" alt="당첨일" /></dt>
										<dd><c:out value="${fn:replace(result.presnatnDe,'-','.')}"/></dd>
									</dl>
							</c:when>
						</c:choose>
					</c:when>
				</c:choose>
						
				<c:if test="${not empty colum.tag}"></${colum.tag}></c:if>				
			</c:forEach>
		<c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
  </c:forEach>
  <c:if test="${fn:length(resultList) == 0}">
  	<c:if test="${not empty searchVO.listTag}"><${searchVO.listTag} class="alC"></c:if><spring:message code="info.nodata.msg" /><c:if test="${not empty searchVO.listTag}"></${searchVO.listTag}></c:if>
  </c:if>