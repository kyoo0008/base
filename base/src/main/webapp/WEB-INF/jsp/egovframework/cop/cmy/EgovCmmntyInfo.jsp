<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />

<div class="cm_sub_box">
	<h2>커뮤니티소개</h2>
	<div class="cm_sub_cont">
		<table  class="cm_chart" summary="커뮤니티를 소개하는 표입니다">
		 	<caption>커뮤니티 생성 정보 입력</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
            <tr>
              <th>커뮤니티이름<br /></th>
              <td><c:out value='${cmmntyVO.cmmntyNm}' /></td>
            </tr>
            <tr>
              <th>커뮤니티주소<br /></th>
              <td><strong>${_WEB_FULL_PATH}/cmy/<c:out value='${cmmntyVO.cmmntyAdres}' />.do</strong></td>
            </tr>
            <tr>
              <th>공개유무<br /></th>
              <td>
              	<c:choose>
					<c:when test="${cmmntyVO.othbcAt eq 'Y'}">공개</c:when>
					<c:otherwise>비공개</c:otherwise>
				</c:choose>
              </td>
            </tr>
            <!-- 
            <tr>
              <th>커뮤니티 분류<br /></th>
              <td><c:out value='${cmmntyVO.cmmntySeNm}' /></td>
            </tr>
             -->
            <tr>
              <th>커뮤니티설명</th>
              <td>
              	<c:set var="cmmntyIntrcn" value="${fn:escapeXml(cmmntyVO.cmmntyIntrcn)}"/>
				<c:set var="cmmntyIntrcn" value="${fn:replace(cmmntyIntrcn , crlf , '<br>')}"/>
				<c:out value="${cmmntyIntrcn}" escapeXml="false" />
              </td>
            </tr>
            <tr>
              <th>커뮤니티 개설일</th>
              <td><fmt:formatDate value="${cmmntyVO.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/></td>
            </tr>
            </tbody>
          </table>
	</div>
</div>


<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>