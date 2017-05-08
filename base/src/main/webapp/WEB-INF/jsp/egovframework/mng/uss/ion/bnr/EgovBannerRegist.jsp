<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="CMMN_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="title" value="배너관리"/>
<c:set var="_MODE" value=""/>

<c:choose>
	<c:when test="${empty searchVO.bannerId}">
		<c:set var="_MODE" value="REG"/>
	</c:when>
	<c:otherwise>
		<c:set var="_MODE" value="UPT"/>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${searchVO.bannerTyCode eq 'BAN001'}"><c:set var="title" value="팝업존관리"/></c:when>
	<c:when test="${searchVO.bannerTyCode eq 'BAN002'}"><c:set var="title" value="배너존관리"/></c:when>
	<c:when test="${searchVO.bannerTyCode eq 'BAN003'}"><c:set var="title" value="퀵메뉴관리"/></c:when>
	<c:when test="${searchVO.bannerTyCode eq 'BAN004'}"><c:set var="title" value="메인배너관리(Type1)"/></c:when>
	<c:when test="${searchVO.bannerTyCode eq 'BAN005'}"><c:set var="title" value="메인배너관리(Type2)"/></c:when>
	<c:when test="${searchVO.bannerTyCode eq 'BAN006'}"><c:set var="title" value="서브배너관리"/></c:when>
</c:choose>
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="ETC_MANAGE"/>
	<c:param name="depth1" value="ETC_SHORTCUT"/>
	<c:param name="title" value="${title}"/>
</c:import>

<script type="text/javascript" src="${CMMN_JS }/egovframework/cmm/sym/cal/EgovCalPopup.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="banner" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

function fn_egov_regist() {
    
       if(!validateBanner(document.banner)){           
           return false;
       }
       
       <c:if test="${_MODE eq 'REG'}">
       if($.trim($('#imageFile').val()) == ""){
    	   alert("배너이미지를 첨부하세요");
           return false;
       }
       </c:if>

       <c:if test="${banner.bannerTyCode eq 'BAN001'}">
       	var ntceBgndeYYYMMDD = $.trim($('#ntceBgndeYYYMMDD').val().replace(/-/g, ''));
		var ntceEnddeYYYMMDD = $.trim($('#ntceEnddeYYYMMDD').val().replace(/-/g, ''));

		if(ntceBgndeYYYMMDD == "") {
			alert("게시시작일자를 선택하세요");
			return false;
		}

		if(ntceEnddeYYYMMDD == "") {
			alert("게시종료일자를  선택하세요");
			return false;
		}
		
		var iChkBeginDe = Number( ntceBgndeYYYMMDD );
		var iChkEndDe = Number( ntceEnddeYYYMMDD );

		if(iChkBeginDe > iChkEndDe || iChkEndDe < iChkBeginDe ){
			alert("게시시작일자는 게시종료일자 보다 클수 없고,\n게시종료일자는 게시시작일자 보다 작을수 없습니다. ");
			return false;
		}

		$('#ntceBgnde').val(ntceBgndeYYYMMDD + $('#ntceBgndeHH').val() +  $('#ntceBgndeMM').val());
		$('#ntceEndde').val(ntceEnddeYYYMMDD + $('#ntceEnddeHH').val() +  $('#ntceEnddeMM').val());
		
	</c:if>	
       
    if(!confirm("<spring:message code="${_MODE eq 'REG' ? 'common.regist.msg' : 'common.update.msg'}" />")){
		return false;					
	}
}

function onPreview(what) {
	var URL 	=	'';
	var winNM	=	'Preview';
	var OPT		=	'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=no,resizable=0,top=30,left=30,copyhistory=0 width=1024 height=859';		
	var imgwin = window.open(URL,winNM,OPT);	

	imgwin.focus();
	 imgwin.document.open();
	 imgwin.document.write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>\n");  
	 imgwin.document.write("<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n");
	 imgwin.document.write("<title>크게보기</title>\n");   // 새창으로 페이지 제목
	 imgwin.document.write("<sc"+"ript>\n"); 
	 imgwin.document.write("function resize() {\n");
	 imgwin.document.write("pic = document.il;\n"); 
	 imgwin.document.write("if (eval(pic).height) { var name = navigator.appName\n");
	 imgwin.document.write("  if (name == 'Microsoft Internet Explorer') { myHeight = eval(pic).height + 60;  myWidth = eval(pic).width + 10;\n");
	 imgwin.document.write("  } else { myHeight = eval(pic).height + 56; myWidth = eval(pic).width + 8; }\n"); 
	 imgwin.document.write("  clearTimeout();\n"); 
	 imgwin.document.write("  var height = screen.height;\n");
	 imgwin.document.write("  var width = screen.width;\n"); 
	 imgwin.document.write("  var leftpos = width / 2 - myWidth / 2;\n"); //hjhj
	 imgwin.document.write("  var toppos = height / 2 - myHeight / 2; \n"); 
	 imgwin.document.write("  self.moveTo(leftpos, toppos);\n"); 
	 imgwin.document.write("  self.resizeTo(myWidth, myHeight);\n");
	 imgwin.document.write("}else setTimeOut(resize(), 100);}\n"); 
	 imgwin.document.write("</sc"+"ript>\n"); 
	 imgwin.document.write("</head><body style='margin:0px;padding:0px'>\n");
	 imgwin.document.write("<img border=0 src="+what+" xwidth='100' xheight='9' name='il' onload='resize();' alt='이미지를 클릭하시면 창이 닫힙니다.' title='이미지를 클릭하시면 창이 닫힙니다.' onclick='javascript:window.close()' />\n");
	 imgwin.document.write("</body></html>\n"); 
	 imgwin.document.close();
}
</script>



<div id="cntnts">

	<c:choose>
		<c:when test="${_MODE eq 'REG' }">
			<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/bnr/addBanner.do"/>
		</c:when>
		<c:otherwise>
			<c:set var="actionUrl" value="${pageContext.request.contextPath}/mng/uss/ion/bnr/updtBanner.do"/>
		</c:otherwise>
	</c:choose>
	<form:form commandName="banner" name="banner" method="post" action="${actionUrl}" enctype="multipart/form-data" onsubmit="return fn_egov_regist();"> 
        
        <form:hidden path="siteId"/>
      	<form:hidden path="sysTyCode"/>
      	
        <form:hidden path="bannerId"/>
        <form:hidden path="ntceBgnde"/>
		<form:hidden path="ntceEndde"/>		
		<form:hidden path="bannerTyCode"/>
		
		<input type="hidden" name="searchCondition" value="<c:out value="${searchVO.searchCondition}"/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
        <input type="hidden" name="searchCate" value="<c:out value='${searchVO.searchCate}'/>" />
        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
  		
        <fieldset>
          <legend class="hdn">배너 입력 폼</legend>
        
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
			<caption> </caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
          	
            <tr>
              <th><em>*</em> <label for="bannerNm">배너명</label></th>
              <td>
              	<form:input path="bannerNm" size="60" maxlength="50" cssClass="inp_long"/> 
                <br/><form:errors path="bannerNm" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="linkUrl">링크URL</label></th>
              <td>
              	<form:input path="linkUrl" size="60" maxlength="255" cssClass="inp_long"/>  
                <br/><form:errors path="linkUrl" />
              </td>         
            </tr>
            <c:if test="${searchVO.bannerTyCode eq 'BAN002'}">
            <tr>
              <th><em>*</em> <label id="idBannerThemaClCode" for="bannerThemaClCode">배너주제분류</label>
              </th>
              <td>
                <form:select path="bannerThemaClCode">
                  <form:option value="" label="-- 선택 --"/>
                  <form:options items="${codeList}" itemValue="code" itemLabel="codeNm"/>
                </form:select>
                <div><form:errors path="bannerThemaClCode"/></div>
              </td>         
            </tr>
            </c:if>
            <tr>
              <th><em>*</em> <label for="popupTrgetAt">새창여부</label></th>
              <td>
              	<spring:message code="button.yes" /> : <form:radiobutton path="popupTrgetAt"  value="Y" />&nbsp;
          	    <spring:message code="button.no" /> : <form:radiobutton path="popupTrgetAt"  value="N"  />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="imageFile">배너이미지</label></th>
              <td>
                <input type="file" name="imageFile" id="imageFile" class="input300 inp" title="배너이미지"/>
                <c:if test="${not empty banner.bannerImageFile}">
                	<br/><img src="${pageContext.request.contextPath}${BannerFileStoreWebPath}${searchVO.siteId}/${banner.bannerImageFile}"/>
                </c:if>
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="bannerDc">배너설명</label></th>
              <td>
              	<form:input path="bannerDc" size="60" maxlength="200" cssClass="inp_long"/> 
                <br/><form:errors path="bannerDc" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="sortOrdr">정렬순서</label></th>
              <td>
              	<form:input path="sortOrdr" size="2" cssClass="inp"/> 
                <br/><form:errors path="sortOrdr" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="reflctAt">반영여부</label></th>
              <td>
              	<spring:message code="button.yes" /> : <form:radiobutton path="reflctAt"  value="Y" />&nbsp;
          	    <spring:message code="button.no" /> : <form:radiobutton path="reflctAt"  value="N"  />
              </td>         
            </tr>
			<tr>
			<c:if test="${banner.bannerTyCode eq 'BAN001'}">
				<th>
					<em>*</em> <label id="IdNtceEnddeHH">게시 기간</label>
				</th>
				<td width="80%">
					<input type="text" name="ntceBgndeYYYMMDD" id="ntceBgndeYYYMMDD" size="10" maxlength="10"  class="inp" value="<c:out value="${fn:substring(banner.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(banner.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(banner.ntceBgnde, 6, 8)}"/>" readonly="readonly" />
					<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.banner, document.banner.ntceBgndeYYYMMDD);">
						<img src="${CMMN_IMG }/egovframework/cmm/sym/cal/bu_icon_carlendar.gif"  align="middle" style="border:0px" alt="게시기간 시작달력" title="게시기간 시작달력"/>
					</a>
					<form:select path="ntceBgndeHH">
						<form:options items="${ntceBgndeHH}" itemValue="code" itemLabel="codeNm"/>
					</form:select>H
					<form:select path="ntceBgndeMM">
						<form:options items="${ntceBgndeMM}" itemValue="code" itemLabel="codeNm"/>
					</form:select>M
					<span>&nbsp;&nbsp;~&nbsp;&nbsp;</span>
					<input type="text" name="ntceEnddeYYYMMDD" id="ntceEnddeYYYMMDD" size="10" maxlength="10" class="inp" value="<c:out value="${fn:substring(banner.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(banner.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(banner.ntceEndde, 6, 8)}"/>" readonly="readonly" />
					<a href="#" onclick="javascript:fn_egov_NormalCalendar(document.banner, document.banner.ntceEnddeYYYMMDD);">
						<img src="${CMMN_IMG }/egovframework/cmm/sym/cal/bu_icon_carlendar.gif" align="middle" style="border:0px" alt="게시기간 종료달력" title="게시기간 종료달력"/>
					</a>
					<form:select path="ntceEnddeHH">
						<form:options items="${ntceEnddeHH}" itemValue="code" itemLabel="codeNm"/>
					</form:select>H
					<form:select path="ntceEnddeMM">
						<form:options items="${ntceEnddeMM}" itemValue="code" itemLabel="codeNm"/>
					</form:select>M
				</td>
			</c:if>
			</tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
            <input type="image" src="${_IMG}/btn/${_MODE eq 'REG' ? 'btn_regist.gif' : 'btn_modify.gif' }" class="vMid" alt="등록" />
            <c:url var="listUrl" value="/mng/uss/ion/bnr/selectBannerList.do">
            	<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
				<c:param name="bannerTyCode" value="${searchVO.bannerTyCode}"/>
				<c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
            	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
	</form:form>
      
</div>      


<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	