<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${param.tmplatCours}"/>

<script type="text/javascript">
//<![CDATA[
	<c:forEach items="${popupList}" var="resultInfo" varStatus="status">
		if(fnGetCookiePopup('${resultInfo.popupId}') == null ){
		 	fn_egov_popupOpen_PopupManage('${resultInfo.popupId}',
		 			'${resultInfo.fileUrl}',
		 			'${resultInfo.popupWSize}',
	    	    	'${resultInfo.popupHSize}',
	    	    	'${resultInfo.popupHlc}',
	    	    	'${resultInfo.popupWlc}',
	    	    	'${resultInfo.stopVewAt}');
		}
	</c:forEach>
	//]]>	
</script>