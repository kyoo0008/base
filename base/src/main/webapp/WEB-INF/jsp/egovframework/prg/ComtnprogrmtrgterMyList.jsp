<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="SE_CODE" value="1"/>
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<script type="text/javascript">
<!--
$(document).ready(function() {
	
	$(".btn_em").children("a").hover(function() {
		$(this).parent().css("background-position","0 0");
		$(this).css({"color":"white","background-position":"right 0"});
	},function() {
		$(this).parent().css("background-position","0 -59px");
		$(this).css({"color":"#6c6c6c","background-position":"right -59px"});
	});
	
	$(".repPrintBtn").click(function() {
		window.open(this.href, "report_print", "width=600,height=750");
		return false;
	});
	
	$(".cancelBtn").click(function() {
		if(confirm("취소하시겠습니까?")) {			
			return true;			
		}
		return false;
	});
});
 // -->
</script>

	<div id="pbbs_wrap">	  
		<div class="total">총 게시물 <strong>7</strong>건 ㅣ 현재페이지 <strong>1</strong>/1</div>

		  <table class="list_table" summary="이 표는 공지사항 목록으로번호,제목작성자,파일,작성일,조회수 항목으로 구성되어 있습니다">
			<caption>공지사항</caption>
			<thead>
			  <tr>
				<th scope="col">번호</th>
				<th scope="col">프로그램명</th>
				<th scope="col">운영기관</th>
				<th scope="col">강사</th>
				<th scope="col">운영기간</th>
				<th scope="col">보고서작성</th>
				<th scope="col">수료여부</th>
				<th scope="col">이수증출력</th>
				<th scope="col">관리</th>
			  </tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
					<td>${result.prgNm }</td>
					<td>${result.operInsttNm }</td>
					<td>${result.tcherNm }</td>
					<td>${result.operBgnde } ~ ${result.operEndde }</td>
					<td>
						<span class="btn_em">
							<c:url var="reportRegUrl" value="/prg/updateComtnprogrmtrgterReportView.do">
								<c:param name="prgId" value="${result.prgId }"/>						
								<c:param name="menuId" value="${param.menuId }"/>	
							</c:url>
							<a href="${reportRegUrl }" class="reportBtn">작성하기</a>
						</span>
					</td>
					<td>${result.complAt eq 'Y'?"수료":"미수료" }</td>
					<td>
						<c:if test="${result.complAt eq 'Y' }">
						<c:url var="printReportUrl" value="/prg/userCertificatePDF.do">
							<c:param name="prgId" value="${result.prgId }"/>
							<c:param name="userId" value="${result.userId }"/>							
						</c:url>
						<span class="bbtn_em"><a href="${printReportUrl }" class="repPrintBtn">출력</a></span>
						</c:if>
					</td>
					<td>						
						<span class="btn_em">
							<c:url var="delUrl" value="/prg/deleteComtnprogrmtrgter.do">
								<c:param name="prgId" value="${result.prgId }"/>
								<c:param name="userId" value="${result.userId }"/>
								<c:param name="menuId" value="${param.menuId }"/>	
							</c:url>
							<a href="${delUrl }" class="cancelBtn">취소</a>
						</span>
						
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty resultList }">
				<tr>
					<td colspan="10">등록된 체험프로그램이 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		  </table>
	  

	 <div id="paging">
		<c:url var="pageUrl" value="/prg/ComtnprogrmList.do"/>	
		<ul>
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
		</ul>
	</div>

	  <div id="bbs_search">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		  <fieldset>
			<legend>검색조건입력폼</legend>
			<label class="hdn" for="ftext">분류</label>
			<select id="ftext" name="searchCondition">
			  <option value="0" <c:if test="${searchVO.searchCondition eq '0'}">selected="selected"</c:if> >프로그램명</option>
			  <option value="1" <c:if test="${searchVO.searchCondition eq '1'}">selected="selected"</c:if> >운영기관</option>			  
			</select>
			<label class="hdn" for="inp_text">검색어입력</label>
			<input type="text" id="inp_text" class="inp_s" value="${searchVO.searchKeyword}" name="searchKeyword" />
			<span class="bbtn_s"><input type="submit" title="검색(체험프로그램게시물 내)" value="검색" />
			</span>
		  </fieldset>
		</form:form>
	  </div>
	</div>
<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>