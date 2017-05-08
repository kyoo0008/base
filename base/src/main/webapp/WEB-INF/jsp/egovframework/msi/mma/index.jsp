<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/mma/images"/>

<c:import url="/mma/tmplatHead.do" charEncoding="utf-8">
	<c:param name="isMain" value="Y"/>
	<c:param name="ctgrymasterId" value="${searchVO.ctgrymasterId}"/>
</c:import>
<script type="text/javascript">
  	$(document).ready(function() {
		$('#slides').slides({
			generateNextPrev: true,
			play: 3500
		});
	});
</script>

<div class="slides_bg">
	<div id="slides">
		<div class="slides_container">
			<c:forEach var="mvp" items="${recomendBestList}" varStatus="status">
				<c:if test="${status.index mod 4 eq 0 }">
				<div>
					<ul>
				</c:if>
						<li>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>"><c:choose><c:when test="${not empty mvp.thumbFilePath}"><img src="${mediaMovieImageWebUrl}${mvp.thumbFilePath}" alt="<c:out value="${mvp.mvpSj}"/>" onerror="this.src='${_IMG}/common/no_img.png'"/></c:when><c:otherwise><img src="${_IMG}/common/no_img.png" alt="movie" /></c:otherwise></c:choose></a>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="hot_title"><c:out value="${mvp.mvpSj}"/></a>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="hot_con"><fmt:formatDate value="${mvp.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/> (<c:out value="${mvp.wrterNm}"/>)</a>
						</li>
				<c:if test="${status.last or status.index mod 4 eq 3 }">
					<ul>
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>

<div id="content_box">
		<div id="content">
			<c:forEach var="cate" items="${mltmdCateList}" varStatus="cate_status">
			<c:choose><c:when test="${cate_status.index mod 2 eq 0 }"><c:set var="section" value="01"/><c:set var="css_class" value="movie"/></c:when><c:otherwise><c:set var="section" value="02"/><c:set var="css_class" value="class"/></c:otherwise></c:choose>
				<div class="section_${section}">
					<h3><c:out value="${cate.ctgryNm}"/></h3>
					<div class="${css_class}">
						<ul>
							<c:forEach var="mvp" items="${cate.mvpInfoList}" varStatus="mvp_status">
								<c:if test="${(section eq '01' and mvp_status.count <= 3) or (section eq '02' and mvp_status.count <= 4)}">
									<li <c:choose><c:when test="${section eq '01' and mvp_status.index mod 2 eq 1 }">class="margin"</c:when><c:when test="${section eq '02' and !mvp_status.first and mvp_status.last}">class="margin_no"</c:when></c:choose>>
										<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>"><c:choose><c:when test="${not empty mvp.thumbFilePath}"><img src="${mediaMovieImageWebUrl}${mvp.thumbFilePath}" alt="<c:out value="${mvp.mvpSj}"/>" onerror="this.src='${_IMG}/common/no_img.png'"/></c:when><c:otherwise><img src="${_IMG}/common/no_img.png" alt="movie" /></c:otherwise></c:choose></a>
										<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="${css_class}_tit"><c:out value="${fn:length(mvp.mvpSj) > 10 ? fn:substring(mvp.mvpSj, 0, 10) : mvp.mvpSj}"/>..<c:if test="${section eq '01'}"> <img src="${_IMG}/common/btn_go.png" alt="go" /></c:if></a>
										<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="${css_class}_con"><fmt:formatDate value="${mvp.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
						<a href="<c:url value="/mma/MltmdMvpInfoList.do?searchCate=${cate.ctgryId}"/>" class="btn_more">+ 더보기</a>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div id="nav">
			<h3>인기동영상</h3>
			<div class="hot_movie_02">
				<ul>
					<c:forEach var="mvp" items="${inqireBestList}" varStatus="status">
						<li>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>"><c:choose><c:when test="${not empty mvp.thumbFilePath}"><img src="${mediaMovieImageWebUrl}${mvp.thumbFilePath}" alt="<c:out value="${mvp.mvpSj}"/>" onerror="this.src='${_IMG}/common/no_img.png'"/></c:when><c:otherwise><img src="${_IMG}/common/no_img.png" alt="movie" /></c:otherwise></c:choose></a>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="hot_movie_tit02"><c:out value="${mvp.mvpSj}"/></a>
							<a href="<c:url value="/mma/selectMltmdMvpInfo.do?searchCate=${mvp.ctgryId}&amp;mltmdMvpId=${mvp.mltmdMvpId}"/>" class="hot_movie_con02"><c:out value="${fn:length(mvp.mvpCn) > 50 ? fn:substring(mvp.mvpCn, 0, 50) : mvp.mvpCn}"/></a>
						</li>
					</c:forEach>
				</ul>
			</div>
			
			
			<c:forEach var="bbs" items="${bbsList}" varStatus="status">
				<div id="bbs_list">
					<div id="bbs">								
						<h3 id="hbbs1"><a href="#bbs1"><c:out value="${bbs.bbsNm}"/></a></h3>
						<div id="bbs1" class="bbs_cont">
							<ul>
								<c:forEach var="ntt" items="${bbs.nttList}">
									<li><a href="<c:url value="/mma/cop/bbs/selectBoardArticle.do?bbsId=${ntt.bbsId}&amp;nttNo=${ntt.nttNo}"/>"><c:out value="${ntt.nttSj}"/></a></li>
								</c:forEach>
							</ul>
							<a href="<c:url value="/mma/cop/bbs/selectBoardList.do?bbsId=${bbs.bbsId}"/>" class="btn_more">+더보기</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	
	</div>

<c:import url="/mma/tmplatBottom.do" charEncoding="utf-8">
	<c:param name="isMain" value="Y"/>
</c:import>