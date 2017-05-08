<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
			<c:param name="title" value="템플릿 선택"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/top.do" charEncoding="utf-8">
			<c:param name="menu" value="SYSTEM_MANAGE"/>
			<c:param name="depth1" value="TMPLAT_MANAGE"/>
			<c:param name="depth2" value=""/>
			<c:param name="title" value="템플릿관리"/>
		</c:import>
	</c:otherwise>
</c:choose>


<script type="text/javascript" language="javascript">
function fn_egov_delete(url){
 
    if(confirm("삭제하시겠습니까?")){
    	document.location.href = url;
    }
}

/* 아이디 중복체크 */
$("#userIdCheck").click(function () {
	if($("#userId").val().length > 0) {
		$.ajax({
			type:"post",
			dataType:"json",
			url:"/mbr/checkIdDplct.json",
			data:"userId="+$("#userId").val(),
			success: function(data) {
				if(data.checkIdDplct == "0") {
					$("input[name=checkedId]").val($("#userId").val());
					alert("사용 할 수 있습니다.");
				}else {
					alert("이미 사용중입니다.");
				}
			},
			error:function() {
				//alert("error");
			}
		});
	}else {
		alert("아이디를 입력하세요");
	}
	return false;
});

function fn_egov_view_HisManage(id) {
	var url = "${pageContext.request.contextPath}/mng/cop/com/selectLytTemplateHistoryList.do?";
	url = url + "lytTmplatId=" + id;
	/*
	$.ajax({
		type:"get",
		dataType:"json",
		url:"${pageContext.request.contextPath}/mng/cop/com/selectLytTemplateHistoryList.json?lytTmplatId=id",
				
		success: function(data) {
			alert("성공");
		},
		error:function() {
			//alert("error");
		}
	});
	*/
	var win = window.open(url ,'his',' scrollbars=yes, resizable=yes, left=0, top=0, width=760,height=650');
	if(win != null) {
		win.focus();
	}
}

function fn_egov_selectTemplate(id, nm, se, fileNm) {
	opener.fn_egov_updateTemplate(id, nm, se, fileNm);
	window.close();
}
</script>


<div id="cntnts">


<p class="total">총  ${paginationInfo.totalRecordCount}개 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <table class="chart_board">
           <colgroup>
				<col class="co1"/>
				<col class="co6"/>
				<c:if test="${searchVO.selectMode ne 'Y'}"><col class="co6"/></c:if>
				<col class="co6"/>
				<col class="co3"/>
				<col class="co6"/>
				<c:if test="${USER_INFO.userSe > 10}"><col class="co6"/></c:if>
				<col class="co6"/>
			</colgroup>
          <thead>
            <tr>
			    <th>번호</th>
			    <th>미리보기</th>
			    <c:if test="${searchVO.selectMode ne 'Y'}"><th><spring:message code="cop.tmplatLcasCode" /></th></c:if>		
			    <th><spring:message code="cop.tmplatMlsfcCode" /></th>	    
			    <th><spring:message code="cop.tmplatNm" /></th>
			    <th>등록일/수정일</th>    
			    <c:if test="${USER_INFO.userSe > 10}"><th>관리</th></c:if>
			    <th>
				    <c:choose>
						<c:when test="${searchVO.selectMode eq 'Y'}">선택</c:when>
						<c:otherwise>복원</c:otherwise>
					</c:choose>
				</th>
			  </tr>
          </thead>
          <tbody>
	
	  
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
		    <td>
		    	<c:choose>
					<c:when test="${not empty result.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}${result.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}${result.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>		    	
		    </td>
		    <c:if test="${searchVO.selectMode ne 'Y'}">
		    	<td><c:out value="${result.tmplatLcasCodeNm}"/></td>
		    </c:if>
		    <td><c:out value="${result.tmplatMlsfcCodeNm}"/></td>
		    <td><c:out value="${result.tmplatNm}"/></td>
			<td>
				<fmt:formatDate value="${result.frstRegisterPnttm}"  pattern="yyyy-MM-dd"/><br/>	
				<fmt:formatDate value="${result.lastUpdusrPnttm}"  pattern="yyyy-MM-dd"/>
			</td>
			<c:if test="${USER_INFO.userSe > 10}">
				<td>				
		        	<c:url var="viewUrl" value="/mng/cop/com/selectLytTemplate.do">
						<c:param name="lytTmplatId" value="${result.lytTmplatId}" />
						<c:param name="selectMode" value="${searchVO.selectMode}" />
						<c:param name="searchTmplatLcasCode" value="${searchVO.searchTmplatLcasCode}" />
						<c:param name="searchTmplatMlsfcCode" value="${searchVO.searchTmplatMlsfcCode}" />
						<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
						<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>							
		        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
		        	<c:url var="delUrl" value="/mng/cop/com/deleteLytTemplate.do">
		        		<c:param name="lytTmplatId" value="${result.lytTmplatId}" />
		        		<c:param name="selectMode" value="${searchVO.selectMode}" />
		        		<c:param name="searchTmplatLcasCode" value="${searchVO.searchTmplatLcasCode}" />
		        		<c:param name="searchTmplatMlsfcCode" value="${searchVO.searchTmplatMlsfcCode}" />
						<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}" /></c:if>
						<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}" /></c:if>
			      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
					</c:url>	
		        	<a href="${delUrl}" onclick="fn_egov_delete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
			    </td>
		    </c:if>
		    <td>
		    <c:choose>
				<c:when test="${searchVO.selectMode eq 'Y'}"><a href="#" onclick="fn_egov_selectTemplate('<c:out value="${result.lytTmplatId}"/>', '<c:out value="${result.tmplatNm}"/>', '<c:out value="${result.tmplatLcasCode}"/>', '<c:out value="${result.prevewFileNm}"/>');return false;"><img src="${_IMG}/btn/btn_select.gif" alt="선택"/></a></c:when>
				<c:otherwise><a href="#" onclick="fn_egov_view_HisManage('<c:out value="${result.lytTmplatId}"/>');return false;"><img src="${_IMG}/btn/btn_search02.gif" alt="찾기"/></a></c:otherwise>
			</c:choose> 
		    </td>
		  </tr>
		 </c:forEach>	  
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td colspan="8" ><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>
 
	 </tbody>  
	</table>
	
			
  	
  			<div id="paging">
			    <c:url var="pageUrl" value="/mng/cop/com/selectLytTemplateList.do?">
			    	<c:param name="selectMode" value="${searchVO.selectMode}" />
			    	<c:param name="searchTmplatLcasCode" value="${searchVO.searchTmplatLcasCode}" />
			    	<c:param name="searchTmplatMlsfcCode" value="${searchVO.searchTmplatMlsfcCode}" />
            		<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
            		<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>
			    </c:url>
			
			    <ul>
			      <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
			    </ul>
		    </div>
		    
		    <div id="bbs_search">
		    	<form name="frm" action ="<c:url value="/mng/cop/com/selectLytTemplateList.do"/>" method="post">
			    	<input type="hidden" name="selectMode" value="${searchVO.selectMode}"/>
			    	<input type="hidden" name="searchTmplatLcasCode" value="sit"/>
					<%-- 
					<label for="ftext" class="hdn">분류검색</label>
					<select name="searchTmplatLcasCode" id="searchTmplatLcasCode" class="searchCate inp">
        				<option value=""><spring:message code="cop.tmplatLcasCode" /></option>
        		  		<c:forEach var="result" items="${lcasList}" varStatus="status">
        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${searchVO.searchTmplatLcasCode == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
        		  		</c:forEach>
        	  		</select>
        	  		--%>
        	  		
        	  		<input type="hidden" name="searchTmplatMlsfcCode" value="1"/>
        	  		<%-- 
        	  		<select name="searchTmplatMlsfcCode" id="searchTmplatMlsfcCode" class="searchCate inp">
        				<option value=""><spring:message code="cop.tmplatMlsfcCode" /></option>
        		  		<c:forEach var="result" items="${mlsfcList}" varStatus="status">
        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${searchVO.searchTmplatMlsfcCode == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
        		  		</c:forEach>
        	  		</select>
        	  		--%>
					<select name="searchCnd" id="searchCnd">
		                <option selected value=''>분류검색</option>
		                <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> ><spring:message code="cop.tmplatNm" /></option>	                             
		            </select>
					<label for="inp_text" class="hdn">검색어입력</label>
					<input name="searchWrd" type="text" size="25" class="inp" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35"  class="inp_s" id="inp_text"/>
					<input type=image src="${_IMG}/btn/btn_search.gif" alt="검색"/>
				</form>
		  </div>
		  
		  <c:if test="${USER_INFO.userSe > 10}">
		  	<div class="btn_r">
				<c:url var="addUrl" value="/mng/cop/com/addLytTemplate.do">
					<c:param name="selectMode" value="${searchVO.selectMode}" />
					<c:param name="searchTmplatLcasCode" value="${searchVO.searchTmplatLcasCode}" />
					<c:param name="searchTmplatMlsfcCode" value="${searchVO.searchTmplatMlsfcCode}" />
				</c:url>
		    	<a href="${addUrl}"><img src="${_IMG}/btn/btn_creat.gif" alt="생성"/></a>
		  	</div>
		  </c:if>

</div>        


<c:choose>
	<c:when test="${searchVO.selectMode eq 'Y'}">
		<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>
	</c:when>
	<c:otherwise>
		<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
	</c:otherwise>
</c:choose>
