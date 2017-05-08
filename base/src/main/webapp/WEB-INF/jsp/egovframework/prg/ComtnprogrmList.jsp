<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ComtnprogrmList.jsp
  * @Description : Comtnprogrm List 화면
  * @Modification Information
  * 
  * @author (주)청암IT
  * @since 2013.02.20
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="SE_CODE" value="1"/>
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<c:set var="CMMN_JS" value="/template/common/js"/>
<link type="text/css" href="${CMMN_JS }/jquery/calendar/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="${CMMN_JS }/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${CMMN_JS }/jquery/calendar/ui.datepicker.js" charset="utf-8"></script>
<script type="text/javascript">
<!--
	$(document).ready(function() {
		<c:if test="${SE_CODE >= 8}">
		$(".delBtn").click(function() {
			if(confirm('삭제 하시겠습니까?')) {
				return true;
			}
			return false;
		});
		
		$(".copyBtn").click(function() {
			if(confirm('복사 하시겠습니까?')) {
				return true;
			}
			return false;
		});
		</c:if>
		$("#searchOperBgnde").datepicker({				
			changeMonth: true,
			changeYear: true		
		});
		$("#searchOperEndde").datepicker({				
			changeMonth: true,
			changeYear: true		
		});
	});
 // -->
</script>
<div id="pbbs_wrap">
	<c:if test="${SE_CODE >= 8}">
	<div class="box_prg_tab">
		<c:url var="viewAllUrl" value="/prg/ComtnprogrmList.do">
			<c:param name="menuId" value="${param.menuId }"/>						
		</c:url>
		<c:url var="viewMyUrl" value="/prg/ComtnprogrmList.do">
			<c:param name="menuId" value="${param.menuId }"/>
			<c:param name="searchMyId" value="${USER_INFO.id}"/>
		</c:url>	
		<c:choose>
			<c:when test="${empty searchVO.searchMyId }">
				<div class="on">			
					<span class="tab1">전체보기</span>
				</div>
				<div class="">			
					<a class="tab2" href="${viewMyUrl }">MY 프로그램</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="">			
					<a class="tab1" href="${viewAllUrl }">전체보기</a>
				</div>
				<div class="on">			
					<span class="tab2">MY 프로그램</span>
				</div>
			</c:otherwise>
		</c:choose>		
	</div>
	</c:if>
	<table class="list_table">
		<colgroup>
			<col width="30px"/>
			<c:if test="${SE_CODE >= 8}">
				<col width=""/>
				<col width="100px"/>
				<col width="75px"/>
				<col width="85px"/>
				<col width="90px"/>
				<col width="90px"/>
				<col width="140px"/>
			</c:if>
		</colgroup>
		<tr>
			<th scope="col" class="">번호</th>
			<th scope="col" class="">프로그램명</th>
			<th scope="col" class="">운영기관</th>
			<th scope="col" class="">강사</th>
			<th scope="col" class="">운영기간</th>
			<th scope="col" class="">진행상태</th>
			<th scope="col" class="">신청자수/정원</th>
			<c:if test="${SE_CODE >= 8}">
			<th scope="col" class="">관리</th>
			</c:if>
			<%-- <th>분류</th> --%>
			<%-- <th>강의장소</th> --%>
			<%-- <th>정원</th> --%>
			<%-- <th>예비인원</th> --%>
			<%-- <th>소요시간</th> --%>
			<%-- <th>학습주제</th> --%>	
			<%-- <th>접수기간</th> --%>
			<%-- <th>등록일</th> --%>			
		</tr>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<c:url var="viewUrl" value="/prg/selectComtnprogrm.do">
				<c:param name="prgId" value="${result.prgId }"/>
				<c:param name="menuId" value="${param.menuId }"/>
				<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
				<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
				<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
				<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
				<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>
			</c:url>
			<td class=""><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>			
			<td class=""><a href="${viewUrl }"> <c:out value="${result.prgNm}"/></a></td>
			<td class=""><c:out value="${result.operInsttNm}"/></td>
			<td class=""><c:out value="${result.tcherNm}"/></td>
			<td class=""><c:out value="${result.operBgnde}"/> ~ <c:out value="${result.operEndde}"/></td>
			<td class="">
				<c:set var="bttnColor" value=""/>
				<c:set var="sttusNm" value=""/>
				<c:choose>
				<c:when test="${result.sttusSeCode eq 'ST01'}"><c:set var="bttnColor" value="bbtn_color1"/><c:set var="sttusNm" value="접 수 중"/></c:when>
				<c:when test="${result.sttusSeCode eq 'ST02'}"><c:set var="bttnColor" value="bbtn_color3"/><c:set var="sttusNm" value="접수마감"/></c:when>
				<c:when test="${result.sttusSeCode eq 'ST10'}"><c:set var="bttnColor" value="bbtn_color2"/><c:set var="sttusNm" value="접수대기"/></c:when>				
				</c:choose>
				<span class="${bttnColor}"> <%--bbtn_color1,bbtn_color2,bbtn_color3 --%>
					<span><c:out value="${sttusNm}"/></span>&nbsp;
				</span>
			</td>			
			<td>${result.trgterCnt} / ${result.psncpaNmpr}</td>
			<c:if test="${SE_CODE >= 8}">
			<td>
				<c:if test="${USER_INFO.id eq result.frstRegisterId or SE_CODE >= 10}">
				<c:url var="modifyUrl" value="/prg/updateComtnprogrmView.do">
					<c:param name="prgId" value="${result.prgId }"/>
					<c:param name="menuId" value="${param.menuId }"/>
					<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
					<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
					<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
					<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
					<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>
				</c:url>
				<span class="btn_em"><a href="${modifyUrl }">수정</a></span>
				<c:url var="delUrl" value="/prg/deleteComtnprogrm.do">
					<c:param name="prgId" value="${result.prgId }"/>
					<c:param name="menuId" value="${param.menuId }"/>
					<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
					<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
					<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
					<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
					<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>
				</c:url> 
				<span class="btn_em"><a href="${delUrl }" class="delBtn">삭제</a></span>
				<c:url var="copyUrl" value="/prg/addComtnprogrmCopyView.do">
					<c:param name="prgId" value="${result.prgId }"/>
					<c:param name="menuId" value="${param.menuId }"/>
					<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
					<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
					<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
					<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
					<c:if test="${not empty searchVO.searchMyId}"><c:param name="searchMyId" value="${searchVO.searchMyId}"/></c:if>
				</c:url> 
				<span class="btn_em"><a href="${copyUrl }" class="copyBtn">복사</a></span>	
				</c:if>		
			</td>
			</c:if>
			<%-- <td><c:out value="${result.prgSeCode}"/></td> --%>
			<%-- <td><c:out value="${result.lctrePlace}"/></td> --%>
			<%-- <td><c:out value="${result.psncpaNmpr}"/></td> --%>
			<%-- <td><c:out value="${result.preparNmpr}"/></td> --%>
			<%-- <td><c:out value="${result.reqreTime}"/></td> --%>
			<%-- <td><c:out value="${result.lrnThema}"/></td> --%>									
			<%-- <td><c:out value="${result.rceptBgnde}"/> ~ <c:out value="${result.rceptEndde}"/></td> --%>		
			<%-- <td><c:out value="${result.frstRegisterPnttm}"/></td> --%>
		</tr>
		</c:forEach>
	</table>

	<div id="paging">
		<c:url var="pageUrl" value="/prg/ComtnprogrmList.do">
			<c:param name="prgId" value="${result.prgId }"/>
			<c:param name="menuId" value="${param.menuId }"/>
			<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
			<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
			<c:param name="searchOperBgnde" value="${searchVO.searchOperBgnde }"/>
			<c:param name="searchOperEndde" value="${searchVO.searchOperEndde }"/>
		</c:url>	
		<ul>
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
		</ul>
	</div>

	<div id="bbs_search">
	<form:form commandName="searchVO" name="listForm" id="listForm" method="get">
	<fieldset>
		<legend>검색조건입력폼</legend>
		<input type="hidden" name="menuId" value="${param.menuId }"/> 
		<input type="hidden" name="prgId" />
		<input type="hidden" name="searchMyId" value="${searchVO.searchMyId }"/>
		<div class="cateSearch">
			<label for="searchOperBgnde">시작일</label>
			<input type="text" name="searchOperBgnde" id="searchOperBgnde" value="${searchVO.searchOperBgnde }" maxlength="10" size="10" class="inp"/> ~
			<label for="searchOperEndde">종료일</label>
			<input type="text" name="searchOperEndde" id="searchOperEndde" value="${searchVO.searchOperEndde }" maxlength="10" size="10" class="inp"/>
			<label for="ftext" class="hdn">분류검색</label>
			<select name="searchCondition" id="ftext">
				<!-- option selected value=''>--선택하세요--</option-->
	          	<option value="0" <c:if test="${searchVO.searchCondition eq '0'}">selected="selected"</c:if>>프로그램명</option>
	          	<option value="1" <c:if test="${searchVO.searchCondition eq '1'}">selected="selected"</c:if>>운영기관</option>
	          	<option value="2" <c:if test="${searchVO.searchCondition eq '1'}">selected="selected"</c:if>>강사명</option>          	
			</select>
			<label for="inp_text" class="hdn">검색어입력</label>
			<input name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" type="text" class="inp" id="inp_text" maxlength="50" size="30" />
			<input type=image src="${_IMG}/common/btn_search.gif" alt="검색" />
		</div>
	</fieldset>
	</form:form>
	</div>
	
	<c:if test="${SE_CODE >= 8}"> <%-- 교사 :08 --%>
 	<div class="btn_r">
	 	<c:url var="addUrl" value="/prg/addComtnprogrmView.do">
	 		<c:param name="menuId" value="${param.menuId }"/>
		</c:url>	
		<span class="bbtn_confirm2"><a href="${addUrl}">등록</a></span>	    
  	</div> 
  	</c:if>
</div> 	
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>
