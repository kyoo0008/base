<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_PREFIX" value="/cop/com"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8"/>
<% 
 /**
  * @Class Name : EgovConfirmInfUpdt.jsp
  * @Description : 승인 정보 수정화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.13   이삼섭          최초 생성
  * @ 2012.01.26   이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.13
  *  @version 1.0
  *  @see
  *   
  */
%>
<script type="text/javascript">
	function fn_egov_regist_updtConfirmInf() {

		var confmMsg = "";
		
		if(document.userFrm.confmSttusCode.value == "AP01"){
			alert("승인 선택을 하여 주십시오.");
			return false;
		}
		if(document.userFrm.confmSttusCode.value == "AP02"){
			confmMsg = "승인허가";
		}else if(document.userFrm.confmSttusCode.value == "AP03"){
			confmMsg = "승인반려";
		}else{
			confmMsg = "승인";
		}
		if (confirm(confmMsg+' 하시겠습니까?')) {
			return true;
		}else{
			return false;
		}
	}

</script>

<div class="com_con_list3">
<form name="userFrm" method="post" action="/cop/com/updateConfirmRequest.do">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="confmNumber" value="<c:out value='${historyVO.confmNumber}' />" />
<input type="hidden" name="trgetJobId" value="<c:out value='${historyVO.trgetJobId}' />" />
<input type="hidden" name="confmRqesterId" value="<c:out value='${historyVO.confmRqesterId}' />" />
<input type="hidden" name="confmRqesterNm" value="<c:out value='${historyVO.confmRqesterNm}' />" />
<input type="hidden" name="confmerId" value="<c:out value='${historyVO.confmerId}' />" />
<input type="hidden" name="confmTyCode" value="<c:out value='${historyVO.confmTyCode}' />" />
<input type="hidden" name="opertId" value="<c:out value='${historyVO.opertId}' />" />
<input type="hidden" name="trgetId" value="<c:out value='${searchVO.trgetId}' />" />
<h5 class="t_title">승인 관리</h5>
          <table  class="com_green_bar" summary="승인 관리 정보가 보여집니다">
	  <tr> 
	    <th width="20%" height="23" class="" nowrap >승인요청자</th>
	    <td width="80%" nowrap>
	      <c:out value="${historyVO.confmRqesterId}" /> (<c:out value="${historyVO.confmRqesterNm}" />)
	    </td>
	  </tr>
	  <tr> 
	    <th width="20%" height="23">자기소개</th>
	    <td width="80%">
	      <c:out value="${historyVO.confmRqesterIntrcn}" />
	    </td>
	  </tr>  
	  <tr> 
	    <th height="23" class="required_text" >승인확인</th>
	    <td>
	     	<select name="confmSttusCode" class="select">
				<c:forEach var="result"  items="${typeList}" varStatus="status">
				<option value='<c:out value="${result.code}"/>' <c:if test="${historyVO.confmSttusCode == result.code }">selected="selected"</c:if> >
				<c:out value="${result.codeNm}"/></option>
			</c:forEach>			  		   
	  	   </select>		    
	    </td>
	  </tr> 
	
	</table>
	
	<p class="btn_group_center"> <input type="image" src="${_IMG}/sub/board/btn_ok.gif" onclick="return fn_egov_regist_updtConfirmInf();" alt="확인" />
	<c:url var="listUrl" value="${_PREFIX}/selectConfirmRequestByTrget.do">
		<c:param name="trgetId" value="${searchVO.trgetId}"/>
		<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}"/></c:if>
		<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}"/></c:if>
		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}"/></c:if>
	</c:url>
	<a href="<c:out value='${listUrl}'/>"><img src="${_IMG}/sub/board/btn_cancel.gif" width="62" height="25" alt="취소" /></a></p>

</form>
</div>


<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>