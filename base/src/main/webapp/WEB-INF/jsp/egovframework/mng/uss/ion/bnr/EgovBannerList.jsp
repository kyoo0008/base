<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:set var="title" value="배너관리"/>
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

<script type="text/javascript">
<!--
function fncBannerDelete(url) {
    if(confirm('<spring:message code="common.delete.msg" />')){
    	document.location.href = url;	
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
//-->
</script>

<div id="cntnts">

	<c:if test="${USER_INFO.userSe > 10}">
		<form id="siteForm" name="siteForm" action="<c:url value="/mng/uss/ion/bnr/selectBannerList.do"/>" method="post">
		<input type="hidden" name="bannerTyCode" value="<c:out value='${searchVO.bannerTyCode}'/>"/>
			<div id="bbs_search">
				<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
			</div>
		</form>
	</c:if>
     
      
      <div id="board">      
             
        
        
      
        <p class="total">총 ${paginationInfo.totalRecordCount}건 ㅣ 현재페이지 <strong class="green">${paginationInfo.currentPageNo}</strong>/${paginationInfo.totalPageCount}</p>
              
        <div id="board_list">
          <table width="100%" summary="메인화면에서 배너에 대한 목록으로 배너명, 링크url,배너설명,반영여부를 제공한다." class="chart_board">
          <caption class="hdn">배너 목록</caption>
          <colgroup>
            <col class="co1"/>
            <c:if test="${searchVO.bannerTyCode eq 'BAN002' }">   
            	<col class="co6"/>
            </c:if>
            <col class="co3"/>
            <col class="co3"/>
            <c:if test="${searchVO.bannerTyCode eq 'BAN001' }">   
              <col class="co3"/>
            </c:if>
            <col class="co6"/>
            <col class="co6"/>
          </colgroup>
          <thead>
            <tr>
              <th class="first">번호</th>
              <c:if test="${searchVO.bannerTyCode eq 'BAN002' }">   
              	<th>주제분류</th>
              </c:if>
              <th>배너명</th>
              <th>링크 URL</th>
              <c:if test="${searchVO.bannerTyCode eq 'BAN001' }">
              	<th>게시기간</th>
              </c:if>
              <th>반영여부</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
      
          <c:forEach var="banner" items="${bannerList}" varStatus="status">
            <tr>
              <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
              <c:if test="${searchVO.bannerTyCode eq 'BAN002' }">   
              	<td><c:out value="${banner.bannerThemaClCodeNm}"/></td>
              </c:if>   
              <td><a href="${banner.linkUrl}" target="_blank"><c:out value="${banner.bannerNm}"/></a></td>        
              <td><a href="${banner.linkUrl}" target="_blank"><c:out value="${banner.linkUrl}"/></a></td>
              <c:if test="${searchVO.bannerTyCode eq 'BAN001' }">
                <td>
                  <c:out value="${fn:substring(banner.ntceBgnde, 0, 4)}"/>-<c:out value="${fn:substring(banner.ntceBgnde, 4, 6)}"/>-<c:out value="${fn:substring(banner.ntceBgnde, 6, 8)}"/> <c:out value="${fn:substring(banner.ntceBgnde, 8, 10)}"/>:<c:out value="${fn:substring(banner.ntceBgnde, 10, 12)}"/> 
                  ~
                  <c:out value="${fn:substring(banner.ntceEndde, 0, 4)}"/>-<c:out value="${fn:substring(banner.ntceEndde, 4, 6)}"/>-<c:out value="${fn:substring(banner.ntceEndde, 6, 8)}"/> <c:out value="${fn:substring(banner.ntceEndde, 8, 10)}"/>:<c:out value="${fn:substring(banner.ntceEndde, 10, 12)}"/>
                </td>
              </c:if>
              <td>
              	<c:if test="${banner.reflctAt eq 'Y'}">
		       		<img src="${_IMG}/btn/use_yes.gif" alt="Y"/>
		       	</c:if>
		       	<c:if test="${banner.reflctAt eq 'N'}">
		       		<img src="${_IMG}/btn/use_no.gif" alt="N"/>
		       	</c:if>
              </td>
              <td>
	        	<c:url var="viewUrl" value="/mng/uss/ion/bnr/getBanner.do">
				  <c:param name="bannerId" value="${banner.bannerId}" />
				  <c:param name="siteId" value="${searchVO.siteId}"/>
	       		  <c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
	       		  <c:param name="bannerTyCode" value="${searchVO.bannerTyCode}"/>
	       		  <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>						
	        	<a href="${viewUrl}"><img src="${_IMG}/btn/edit.gif"/></a>
	        	<c:url var="delUrl" value="/mng/uss/ion/bnr/removeBanner.do">
				  <c:param name="bannerId" value="${banner.bannerId}" />
				  <c:param name="siteId" value="${searchVO.siteId}"/>
	       		  <c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
	       		  <c:param name="bannerTyCode" value="${searchVO.bannerTyCode}"/>
	       		  <c:if test="${not empty searchVO.searchCate}"><c:param name="searchCate" value="${searchVO.searchCate}" /></c:if>
				  <c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
				  <c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
	      		  <c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
				</c:url>
	        	<a href="${delUrl}" onclick="fncBannerDelete(this.href);return false;"><img src="${_IMG}/btn/del.gif"/></a>
		    </td>
            </tr>
          </c:forEach>
      
          <c:if test="${fn:length(bannerList) == 0}">
            <tr>
              <td class="listCenter" colspan="7"><spring:message code="common.nodata.msg" /></td>
            </tr>
          </c:if>
      
          </tbody>    
          </table>
        </div>
       
        <div id="paging">
          <c:url var="pageUrl" value="/mng/uss/ion/bnr/selectBannerList.do">
          	<c:param name="siteId" value="${searchVO.siteId}"/>
			<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
          	<c:param name="bannerTyCode" value="${param.bannerTyCode}" />
          	<c:if test="${not empty param.searchCate}"><c:param name="searchCate" value="${param.searchCate}" /></c:if>
	        <c:if test="${not empty param.searchCondition}"><c:param name="searchCondition" value="${param.searchCondition}" /></c:if>
	        <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
          </c:url>
          <ul>
          <c:if test="${not empty paginationInfo}">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pageUrl}" />
          </c:if>
          </ul>
        </div>
        
        
      </div>        
              
      
      <div id="bbs_search">
           <form name="listForm" action="<c:url value='/mng/uss/ion/bnr/selectBannerList.do'/>" method="post">
            <input type="hidden" name="siteId" value="${searchVO.siteId}"/>
  			<input type="hidden" name="sysTyCode" value="${searchVO.sysTyCode}"/>
      		<input type="hidden" name="bannerTyCode" value="<c:out value='${searchVO.bannerTyCode}'/>"/>     
            <fieldset>
              <legend class="hdn">찾기 폼</legend>
              <c:if test="${searchVO.bannerTyCode eq 'BAN002'}">
	              <label for="cate" class="hdn">분류</label>
		          <select id="cate" name="searchCate" title="분류" class="cate_sel inp">
		            <option value="">주제분류</option>
		            <c:forEach var="code" items="${codeList}">
		              <option value="${code.code}" <c:if test="${param.searchCate == code.code}">selected</c:if>>${code.codeNm}</option>
		            </c:forEach>
		          </select>
	          </c:if>
              <label for="searchCondition" class="hdn">검색항목</label>
              <select name="searchCondition" id="ftext">
		  		  <!--<option selected value=''>--선택하세요--</option>-->
		  		  <option value="1" <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if> >배너명</option>
		  	  </select>
              <input name="searchKeyword" id="searchKeyword" type="text" size="35" class="inp" value="<c:out value="${searchVO.searchKeyword}"/>" maxlength="35" />
              <input type="image" class="searchBtn vMid" src="${_IMG}/btn/btn_search.gif" alt="검색"/>
            </fieldset>
            </form>     
	  </div>   
	  
	  <c:if test="${not empty searchVO.siteId }">
	        <div class="btn_r">
	        	<c:url var="addUrl" value="/mng/uss/ion/bnr/addViewBanner.do">
		          	<c:param name="siteId" value="${searchVO.siteId}"/>
					<c:param name="sysTyCode" value="${searchVO.sysTyCode}"/>
					<c:param name="bannerTyCode" value="${searchVO.bannerTyCode}"/>
		        </c:url>
		          
	          <a href="${addUrl}"><img src="${_IMG}/btn/btn_regist.gif" alt="등록"/></a>
	        </div>
        </c:if>
      <!-- contents end -->
	
	
</div>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	