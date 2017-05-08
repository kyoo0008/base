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

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_HTML" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}"/>

<% /*URL 정의*/ %>
	<c:url var="_BASE_PARAM" value="">
		<c:param name="menuId" value="${searchVO.menuId}"/>
	  	<c:if test="${not empty searchVO.searchTy}"><c:param name="searchTy" value="${searchVO.searchTy}" /></c:if>
	  	<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
	</c:url>
<% /*URL 정의*/ %>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
	<c:param name="BBS_TMPLATID" value="${siteInfo.cmyTmplatId }"/>
</c:import>

<c:set var="SE_CODE" value="01" />
<c:if test="${not empty LOGIN_USER_INFO.id}">
	<c:set var="SE_CODE" value="${LOGIN_USER_INFO.userSe}" />
</c:if>

<link rel="stylesheet" type="text/css" href="${_HTML}/style.css" />
<script type="text/javascript" src="${_HTML}/script.js" ></script>
<script type="text/javascript">
	function fn_egov_addCmy(a) {
		<c:if test="${empty LOGIN_USER_INFO.id}">
			if (confirm('로그인 하시겠습니까?')) {
				a.target="_self";
				a.href = "<%=egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper.getRedirectLoginUrl()%>";	
			} else {
				return false;
			}
		</c:if>
   }
</script>		

<c:choose>
	<c:when test="${IS_MOBILE }">
	<div id="bbs_mbl">
	</c:when>
	<c:otherwise>
	<div id="bbs_wrap">
	</c:otherwise>
</c:choose>
	<!-- <img src="${_IMG}/cmm_img.jpg" alt="U-SCHOOL PORTAL COMMUNITY U-스쿨포털커뮤니티에 오신 것을 환영합니다. 즐거운 학습·교류를 위해 제공하는 서비스입니다."/> -->
	<div class="join_list_box">
		<form name="frmGo99" action="/goUrl.jsp" method="post" target="_blank" onsubmit="goUrl(99); return false;">
			<label for="join_list"><span><c:choose><c:when test="${empty LOGIN_USER_INFO.id}">손님</c:when><c:otherwise><c:out value="${LOGIN_USER_INFO.name}"/></c:otherwise></c:choose></span>님 가입목록</label>
			<select id="sLink99">
				<c:choose>
					<c:when test="${fn:length(USER_SBSCRB) == 0}"><option value="">-가입목록이 없습니다.-</option></c:when>
					<c:otherwise>
						<option value="">-가입목록-</option>
						<c:forEach var="resultMycmyList" items="${USER_SBSCRB}" varStatus="status">
							<option value="/cmy/<c:out value='${resultMycmyList.cmmntyAdres}' />.do"><c:out value="${resultMycmyList.cmmntyNm}"/></option>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</select>
			<input type="image" src="${_IMG}/btn/join_list_btn.gif" alt="go"/>
		</form>
	</div>
	<div id="bbs_search">
		<form name="frm" method="post" action="<c:url value='/cop/cmy/selectCmmntyInfs.do'/>">
		  	<input type="hidden" name="searchTy" value="<c:out value='${searchVO.searchTy}'/>" />
			<input name="menuId" type="hidden" value="<c:out value='${searchVO.menuId}'/>" />
			<select name="searchCnd">
				<option value="0"<c:if test="${searchVO.searchCnd eq '0'}"> selected="selected"</c:if>>커뮤니티명</option>
				<option value="1"<c:if test="${searchVO.searchCnd eq '1'}"> selected="selected"</c:if>>매니저</option>
				<option value="2"<c:if test="${searchVO.searchCnd eq '2'}"> selected="selected"</c:if>>커뮤니티명+매니저</option>
			</select>
			<label class="hdn" for="inp_text">검색어입력</label>
			<input name="searchWrd" id="inp_text" value="<c:out value="${searchVO.searchWrd}"/>" type="text"/>
			<input type="image" src="${_IMG}/btn/c_srch_btn.gif" alt="검색" class="srch_btn"/>
		</form>
	</div>		
	<form id="listForm" name="listForm" method="post">
		<div class="bss_list">
			<div class="total">개설된 커뮤니티 : ${paginationInfo.totalRecordCount}개 page <strong>${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</div>
			<table class="list_table" summary="커뮤니티 게시판입니다.">
			<caption>커뮤니티</caption>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><a href='${_WEB_FULL_PATH}/cmy/<c:out value="${result.cmmntyAdres}"/>.do' target="_blank">
						<c:choose>
							<c:when test="${empty result.atchFileIcon}"><img src='${_IMG}/school_img.gif' width='88' height='58' alt='<c:out value="${result.cmmntyNm}"/> 대표이미지'/></c:when>
							<c:otherwise><img src='${CmmntyFileStoreWebPath}${result.atchFileIcon}' width='88' height='58' alt='<c:out value="${result.cmmntyNm}"/> 대표이미지'/></c:otherwise>
						</c:choose>
						</a></td>
						<td class="info">
							<span class="title"><c:out value="${result.cmmntyNm}"/></span>
							<span class="sub"><c:out value="${result.cmmntyIntrcn}"/></span>
							<a href='${_WEB_FULL_PATH}/cmy/<c:out value="${result.cmmntyAdres}"/>.do' class="site" target="_blank">${_WEB_FULL_PATH}/cmy/<c:out value="${result.cmmntyAdres}"/>.do</a>
						</td>
						<td>
							<ul>
								<li><span>매니저 : </span><c:out value="${result.frstRegisterNm}"/></li>
								<li><span>회원수 : </span><c:out value="${result.userCo}"/></li>
							</ul>
						</td>
					</tr>
				</c:forEach>				
				<c:if test="${fn:length(resultList) == 0}">
			    	<tr class="empty"><td colspan="10"><spring:message code="common.nodata.msg" /></td></tr>
			    </c:if>				
			</tbody>
			</table>	
			
			<c:url var="addCmyUrl" value="/cop/cmy/selectCmmntyStplat.do${_BASE_PARAM}">
			</c:url>
			<div class="btn_r">
            	<a href="<c:out value="${addCmyUrl}"/>" onclick="return fn_egov_addCmy(this);" id="mk_cmm">커뮤니티만들기</a>
			</div>		
		</div>
	</form>
	
		<div id="paging"> 
		    <c:url var="pageUrl" value="/cop/cmy/selectCmmntyInfs.do${_BASE_PARAM}">
			</c:url>
		   <c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
		   <ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
		   
		</div>

			
</div> <!-- #bbsWrap end -->
		
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>