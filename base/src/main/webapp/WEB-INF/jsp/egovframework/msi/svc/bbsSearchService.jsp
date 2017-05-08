<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<c:set var="_IMG" value="/template/web/smart_001/image"/>

<c:set var="_PREFIX" value="/cop/bbs"/>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
	<c:param name="siteId" value="SITE_000000000000001"/>
	<c:param name="pageName" value="검색"/>
	<c:param name="location" value="홈 > 검색"/>
	<c:param name="loginYn" value="${param.loginYn}"/>	
</c:import>

        <div class="rsearch_t_gap">
          <dl class="rsearch_t">
            <dt>검색어<span class="blue_bold"> &quot;<c:out value="${searchVO.searchWrd}"/>&quot;</span>에 대한 홈페이지 검색 결과 입니다.</dt>
            <dd>[총 검색 결과 <span class="blue_bold">${paginationInfo.totalRecordCount}건</span> ]</dd>
          </dl>
        </div>
        <div class="search_result_gap">
          <h3 class="search_r_h3">스마트충남</h3>
          <p class="search_r_total">[검색결과 <span class="blue_bold">${paginationInfo.totalRecordCount}</span>건]</p>
          <ul class="search_result">
          <c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="viewUrl" value="${_PREFIX}/selectBoardArticle.do">
			  <c:param name="nttNo" value="${result.nttNo}" />
			  <c:param name="menuId" value="${result.menuId}" />
			  <c:param name="bbsId" value="${result.bbsId}" />
		    </c:url>
            <li>
              <dl>
                <dt><a href="<c:out value="${viewUrl}"/>"><c:out value="${result.nttSj}" /></a> <fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></dt>
                <dd><a href="<c:out value="${viewUrl}"/>"><c:out value="${fn:replace(fn:substring(result.nttCn, 0, 220), searchVO.searchWrd, repleTxt)}"/></a></dd>
              </dl>
            </li>
		</c:forEach>
          </ul>
          
          	<c:if test="${fn:length(resultList) > 0}">
	          	<div class="paging2">
					<c:url var="pageUrl" value="/msi/sch/bbsSearch.do">
						<c:param name="searchWrd" value="${searchVO.searchWrd}" />
					</c:url>
					<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>			   
					<ui:pagination paginationInfo="${paginationInfo}" type="smart_001" jsFunction="${pagingParam}" />				   
				</div>
			</c:if>
		
          <!-- <p class=" btn_group_right btn_r20"><a href="#" title="전체보기"><img src="../image/sub/board/btn_all_result.gif" width="55" height="19" alt="전체보기" /></a></p> -->
        </div>


<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8">
	<c:param name="siteId" value="SITE_000000000000001"/>
</c:import>	