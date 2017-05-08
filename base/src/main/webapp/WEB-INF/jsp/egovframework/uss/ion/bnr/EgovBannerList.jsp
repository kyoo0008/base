<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="http://${siteInfo.siteUrl}/template/web/smart_001/image"/>

<script type="text/javascript">
jQuery('.sub_menu_tab_s li').live('click', function() {
	jQuery('.sub_menu_tab_s li').removeClass('smt_on');
	jQuery(this).addClass('smt_on');
});
</script>
	<div class="common_pop_t">
        <p  class="poll_result_title">추천사이트</p>
        <p class="result_close" > <a href="#" onclick="return cfgCommonPopHide()" title="닫기"><img src="${_IMG}/sub/smartcn/poll_result_close.gif" width="22" height="22" alt="닫기" /></a></p>
      </div>
      <div  class="common_pop_bg">
        <ul class="sub_menu_tab_s">
        	<c:forEach var="code" items="${codeList}" varStatus="status">
          		<li <c:if test="${status.first}">class="smt_on"</c:if>><a class="siteToptab" href="#site${status.count}" title="<c:out value="${code.codeNm}"/>"><c:out value="${code.codeNm}"/></a></li>
          </c:forEach>
        </ul>
        <c:forEach var="code" items="${codeList}" varStatus="status">
	        <div id="site${status.count}">
		        <div class="common_pop_con">
			          <ul class="siteset">
			          	<c:forEach var="banner" items="${bannerList}">
			          		<c:if test="${code.code eq banner.bannerThemaClCode}">
				          		<c:if test="${banner.reflctAt eq 'Y'}">
				            		<li><a href="${banner.linkUrl}" target="_blank" title="<c:out value="${banner.bannerNm}"/>" ><img src="http://${siteInfo.siteUrl}${BannerFileStoreWebPath}${siteInfo.siteId}/${banner.bannerImageFile}" width="180" height="50" alt="<c:out value="${banner.bannerNm}"/>" /></a> </li>
				            	</c:if>
				            </c:if>
			            </c:forEach>
			          </ul>
		        </div>
 			</div>
		</c:forEach>
      </div>

      <script type="text/javascript">initLayerTabMenu("common_pop_site", "siteToptab");</script>