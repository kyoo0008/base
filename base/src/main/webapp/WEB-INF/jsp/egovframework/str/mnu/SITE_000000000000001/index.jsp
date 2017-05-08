<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response)%>"/>
<c:set var="_IMG" value="/template/web/smart_001/image"/>
<c:set var="_JS" value="/template/web/smart_001/js"/>
<c:set var="_C_JS" value="/template/common/js"/>
<c:import url="/msi/tmplatHead.do" charEncoding="utf-8">
	<c:param name="isMainSite">Y</c:param>
	<c:param name="siteId" value="SITE_000000000000001"/>
</c:import>

<c:set var="GROUP_TY" value="${param.searchGroupTy}"/>
<c:if test="${not empty USER_INFO.id and !(empty GROUP_TY eq 'H' or GROUP_TY eq 'MY' or GROUP_TY eq 'A' or GROUP_TY eq 'AS' or USER_INFO.userTy eq 'M')}">
	<c:set var="GROUP_TY" value="${USER_INFO.userTy}"/>
</c:if>
<c:if test="${GROUP_TY eq 'D'}"><c:set var="GROUP_TY" value="T"/></c:if>
<c:if test="${GROUP_TY eq 'H'}"><c:set var="GROUP_TY" value=""/></c:if>

<c:choose>
	<c:when test="${GROUP_TY eq 'S'}">	
		<div id="main_content2">
       <p class="arrow_left"><a class="prev"><img src="${_IMG}/main/left_arrow.png" width="70" height="73" alt="PREVIOUS" style="cursor:pointer;" /></a></p>
<hr />
       <div class="arrow_center">
        <div class="student_notice">
        
         <div class="news_tab mt10" id="newsList2">
          	<c:import url="/msi/ctn/mainBoardService.do" charEncoding="utf-8">
				<c:param name="tmplatCours" value="${_IMG}"/>
				<c:param name="linkMenuId" value="MNU_0000000000000222" />
				<c:param name="viewType" value="data" />
				<c:param name="tableId" value="BBSMSTR_000000000839" />
				<c:param name="itemCount" value="5" />
				<c:param name="cssSeqNum" value="2" />
				<c:param name="cssMoreSeqNum" value="" />
			</c:import>
         </div>
         <script type="text/javascript">initTabMenu("newsList2");</script>
         
        </div>
<hr />
        <div class="student_icon">
          <p class="box_top"></p>
		  <!--아이콘모음 1페이지 시작-->
		  <div class="box">		  
	          <c:import url="/msi/ctn/mpmService.do" charEncoding="utf-8">
			  	<c:param name="recordCountPerPage" value="12"/>
			  	<c:param name="groupTy" value="${GROUP_TY}"/>
			  </c:import>
		  </div>
		  <!--아이콘모음 1페이지 끝-->
        </div>
       </div>
<hr />
       <p class="arrow_right"><a class="next"><img src="${_IMG}/main/right_arrow.png" width="70" height="73" alt="NEXT" style="cursor:pointer;" /></a></p>     
     </div>


	</c:when>
	<c:when test="${GROUP_TY eq 'P' or GROUP_TY eq 'T'}">
		<!-- main내용1 시작 -->
	    <div id="main_content3">
       <p class="arrow_left"><a class="prev"><img src="${_IMG}/main/left_arrow.png" width="70" height="73" alt="PREVIOUS" style="cursor:pointer;" /></a></p>
<hr />
       <div class="arrow_center">
        <div class="parent_icon">
           <p class="box_top_p"></p>
		   <!--아이콘모음 1페이지 시작-->
		   <div class="box_p">
	           <c:import url="/msi/ctn/mpmService.do" charEncoding="utf-8">
			   	<c:param name="recordCountPerPage" value="9"/>
			   	<c:param name="groupTy" value="${GROUP_TY}"/>
			   </c:import>
		   </div>
		   <!--아이콘모음 1페이지 끝-->
        </div>
<hr />
        <div class="teacher_notice">
        
         <div class="news_tab1 mt10" id="newsList3">
          <c:import url="/msi/ctn/mainBoardService.do" charEncoding="utf-8">
				<c:param name="tmplatCours" value="${_IMG}"/>
				<c:param name="linkMenuId" value="MNU_0000000000000222" />
				<c:param name="viewType" value="data" />
				<c:param name="tableId" value="BBSMSTR_000000000839" />
				<c:param name="itemCount" value="5" />
				<c:param name="cssSeqNum" value="3" />
				<c:param name="cssMoreSeqNum" value="1" />
			</c:import>
          </div>
          <script type="text/javascript">initTabMenu("newsList3");</script>
                    
        </div>
        </div>
       <p class="arrow_right"><a class="next"><img src="${_IMG}/main/right_arrow.png" width="70" height="73" alt="NEXT" style="cursor:pointer;" /></a></p>    
     </div>

	</c:when>
	<c:when test="${GROUP_TY eq 'A'}">
	<%/*
		<div id="main_content6">
<hr />
       <div class="arrow_center_noicon">
         <p class="ammmenu_top"></p>
         <div class="ammmenu_center">

		  <div class="box_h">
			  <c:import url="/msi/ctn/mpmService.do" charEncoding="utf-8">
			  	<c:param name="recordCountPerPage" value="18"/>
			  	<c:param name="groupTy" value="${GROUP_TY}"/>
			  </c:import>
		  </div>
        </div>
        <p class="ammmenu_bottom"></p>
       </div>
<hr />
     </div>
     */%>
	</c:when>	
	<c:when test="${empty GROUP_TY or GROUP_TY eq 'MY'}">
		<div id="main_content1">
       <p class="arrow_left"><a class="prev"><img src="${_IMG}/main/left_arrow.png" width="70" height="73" alt="PREVIOUS" style="cursor:pointer;" /></a></p>
<hr />
       <div class="arrow_center">
         <hr />
        <div class="home_icon">
          <p class="box_top_h"></p>          
		  <!--아이콘모음 1페이지 시작-->
		  <div class="box_h">
			  <c:import url="/msi/ctn/mpmService.do" charEncoding="utf-8">
			  	<c:param name="recordCountPerPage" value="18"/>
			  	<c:param name="groupTy" value="${GROUP_TY}"/>
			  </c:import>
		  </div>
		  <!--아이콘모음 1페이지 끝-->
        </div>
       </div>
<hr />
       <p class="arrow_right"><a class="next"><img src="${_IMG}/main/right_arrow.png" width="70" height="73" alt="NEXT" style="cursor:pointer;" /></a></p>
     </div>
	
	</c:when>	
</c:choose>


<script type="text/javascript">
	<c:if test="${fn:length(popupMainLIst) ne 0}">
		if(fnGetCookiePopup('mainPopupList') == null ) {
			var openWindows = window.open("<c:url value="/uss/ion/pwm/popupMainList.do"/>","mainPopupList","width=418,height=300,top=0,left=0,toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=no");
			if (openWindows.focus) {openWindows.focus();}
		}
	</c:if>

	<c:forEach items="${popupList}" var="resultInfo" varStatus="status">
		if(fnGetCookiePopup('${resultInfo.popupId}') == null ){
		 	fn_egov_popupOpen_PopupManage('${resultInfo.popupId}',
		 			'${resultInfo.fileUrl}',
		 			'${resultInfo.popupWsize}',
	    	    	'${resultInfo.popupHsize}',
	    	    	'${resultInfo.popupHlc}',
	    	    	'${resultInfo.popupWlc}',
	    	    	'${resultInfo.stopVewAt}');
		}
	</c:forEach>
	
	var schdulPopWindows = null; 
	<c:forEach items="${schdulPopupList}" var="resultInfo" varStatus="status">
		if(fnGetCookiePopup('${resultInfo.schdulId}') == null ){
			schdulPopWindows = window.open("<c:url value="/evt/selectComtnschdulinfoPop.do"/>?schdulId=${resultInfo.schdulId}","${resultInfo.schdulId}","width=450,height=300,top=0,left=0,toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=no");
			if (schdulPopWindows.focus) {schdulPopWindows.focus();}
		}
	</c:forEach>
</script>


<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8">
	<c:param name="isMainSite">Y</c:param>
	<c:param name="siteId" value="SITE_000000000000001"/>
</c:import>