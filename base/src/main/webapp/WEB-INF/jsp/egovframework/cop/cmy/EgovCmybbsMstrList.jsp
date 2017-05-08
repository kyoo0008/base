<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>

<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>

<script type="text/javascript">
	
	function fn_egov_delete_brdMstr(url){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.location.href = url;
		}		
	}
</script>

<div class="cm_sub_box">
	<h2>메뉴관리</h2>
	<div class="cm_sub_cont">          
        <table class="cm_chart1" summary="커뮤니티 생성 정보 입력하는 표입니다">
		  	<caption>커뮤니티 생성 정보 입력</caption>
		  	<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="20%" />
				<col width="10%" />
				<col width="10%" />
				<col width="30%" />
			</colgroup>
	           <thead>
				<tr>
					<th>번호</th>
					<th>메뉴명</th>
					<th>메뉴이동</th>
					<th>사용여부</th>
					<th>메인노출</th>
					<th>관리</th>
				</tr>
			
			</thead>
			<tbody>
	           <c:forEach var="result" items="${resultList}" varStatus="status">
	           <tr>
	             	<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - (status.count - 1)}" /></td>
	             	<td><c:out value="${result.bbsNm}"/></td>
			  	  	<td>
						<c:url var="upUrl" value="/cop/cmy/updateCmmntySortOrdr.do">
							<c:param name="sortTyCode" value="U"/>
							<c:param name="trgetId" value="${searchVO.trgetId}"/>
							<c:param name="bbsId" value="${result.bbsId}"/>
							<c:param name="sortOrdr" value="${result.sortOrdr}"/>
						</c:url>
						<a href="<c:out value='${upUrl}'/>" class="up">위로이동</a>
						<c:url var="downUrl" value="/cop/cmy/updateCmmntySortOrdr.do">
							<c:param name="sortTyCode" value="D"/>
							<c:param name="trgetId" value="${searchVO.trgetId}"/>
							<c:param name="bbsId" value="${result.bbsId}"/>
							<c:param name="sortOrdr" value="${result.sortOrdr}"/>
						</c:url>
			  			<a href="<c:out value='${downUrl}'/>" class="down">아래로이동</a></td>
	             	<td>
					   	<c:choose>
							<c:when test="${result.svcAt eq 'Y'}"><span class="btn9"><span>사용중</span></span></c:when>
							<c:otherwise><span class="btn8"><span>미사용</span></span></c:otherwise>
						</c:choose>
	             	</td>
				  	<td>
				  		<c:choose>
							<c:when test="${result.mainOutptAt eq 'Y'}"><span class="btn9"><span>노출중</span></span></c:when>
							<c:otherwise><span class="btn8"><span>미노출</span></span></c:otherwise>
						</c:choose>
				  	</td>
	             	<td>
						<c:url var="editUrl" value="/cop/cmy/bbs/SelectBBSMasterInf.do">
							<c:param name="trgetId" value="${searchVO.trgetId}"/>
							<c:param name="bbsId" value="${result.bbsId}"/>
						</c:url>
	             		<a href="<c:out value='${editUrl}'/>" class="btn7"><span>메뉴<strong>수정</strong></span></a>
	             		<c:if test="${result.notifyAt ne 'Y'}">
		             		<c:url var="delUrl" value="/cop/cmy/bbs/DeleteBBSMasterInf.do">
								<c:param name="trgetId" value="${searchVO.trgetId}"/>
								<c:param name="bbsId" value="${result.bbsId}"/>
							</c:url>
		             		<a href="<c:out value='${delUrl}'/>" onclick="fn_egov_delete_brdMstr(this.href);return false;" class="btn7"><span>메뉴<strong>삭제</strong></span></a>
	             		</c:if>
	             	</td>
	           </tr>
	           </c:forEach>
	           <c:if test="${fn:length(resultList) == 0}">
				  <tr>
				    <td colspan="6" ><spring:message code="common.nodata.msg" /></td>  
				  </tr>		 
				</c:if>
	         </table>
	         
	         <div class="btn_all">
				<p class="fL">메인 노출 수는 <strong>최대 4개</strong>로 고정입니다.</p>
				<div class="fR">
					<c:url var="addUrl" value="/cop/cmy/bbs/addBBSMaster.do">
						<c:param name="trgetId" value="${searchVO.trgetId}"/>
						<c:param name="bbsId" value="${result.bbsId}"/>
					</c:url>
					<a href="<c:out value='${addUrl}'/>" class="btn"><span>메뉴추가</span></a>
				</div>
			  </div>
		  </div>
		  
	      <div id="paging">
		  	<c:url var="pageUrl" value="${_PREFIX}/selectCmmntyMasterInfs.do">
		  		<c:param name="trgetId" value="${searchVO.trgetId}"/>
				<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
				<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			</c:url>
			<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
			<ui:pagination paginationInfo="${paginationInfo}" type="smart_school" jsFunction="${pagingParam}" />
		  </div>
			
		  <div class="cm_search_box">
		  	<form name="bbsFrm" method="post" action="${_PREFIX}/selectCmmntyMasterInfs.do">
				<input type="hidden" name="bbsId"/>
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<input name="trgetId" type="hidden" value="<c:out value='${searchVO.trgetId}'/>"/>
				<fieldset>
					<label class="hdn" for="ftext">검색 분류선택</label>
					<select name="searchCnd" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >메뉴명</option>
					</select>
					<label class="hdn" for="word">검색어입력</label>		
					<input type="text"  name="searchWrd" id="word" value="<c:out value="${searchVO.searchWrd}"/>" class="inp" />
					<span class="btn4"><button type="submit">검색</button></span>
				</fieldset>
			  
			  </form>
	      </div>
 	</div>
 </div>
<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>