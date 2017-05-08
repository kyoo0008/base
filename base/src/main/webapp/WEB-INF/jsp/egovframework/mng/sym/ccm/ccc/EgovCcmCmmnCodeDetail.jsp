<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/sym/ccm"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SYSTEM_MANAGE"/>
	<c:param name="depth1" value="CODE_MANAGE"/>
	<c:param name="title" value="공통코드 관리"/>
</c:import>


<div id="cntnts">

	<table class="chart2">
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
		  <tr> 
		    <th><em>*</em> 분류코드</th>
		    <td>${result.clCode}</td>
		  </tr>
		  <tr>
		    <th><em>*</em> 분류코드명</th>
		    <td>${result.clCodeNm}</td>    
		  </tr> 
		  <tr> 
		    <th>분류코드설명</th>
		    <td><textarea class="textarea" cols="90" rows="10"  style="width:450px;" disabled="true">${result.clCodeDc}</textarea></td>
		  </tr> 
		  <tr> 
		    <th><em>*</em> 사용여부</th>
		    <td>
				<select name="useAt" disabled="true">
					<option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
					<option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>				
				</select>
		    </td>    
		  </tr>     
		</table>
		
		<div class="btn_r">
		<c:url var="listUrl" value="${_PREFIX}/EgovCcmCmmnClCodeList.do">
			<c:param name="searchCondition" value="${searchVO.searchCondition}"/>
			<c:param name="searchKeyword" value="${searchVO.searchKeyword}"/>
			<c:param name="pageIndex" value="${searchVO.pageIndex}"/>
		</c:url>
		<input type="image" src="/template/common/images/sub/board/btn_drawing.gif" alt="저장" onclick="return fn_egov_save(this.form);"/>
		<a href="<c:out value="${listUrl}"/>"><img src="<c:url value='/template/common/images/sub/board/btn_cancel.gif'/>" alt="취소"/></a>	
	</div>

</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>