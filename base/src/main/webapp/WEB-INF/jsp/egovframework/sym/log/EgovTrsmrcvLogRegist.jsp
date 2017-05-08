<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovTrsmrcvLogRegist.jsp
  * @Description : 송수신 로그 등록 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------     --------    ---------------------------
  * @ 2009.03.09   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.09
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/sym/log/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src=""<c:url value='/js/egovframework/sym/log/EgovSysLog.js' /> ></script>
<script type="text/javascript">
	function fn_egov_regist_TrsmrcvLog(pTrsmrcvSeCode){
		document.frm.trsmrcvSeCode.value = pTrsmrcvSeCode; 
		document.frm.action = "<c:url value='/sym/log/InsertTrsmrcvLog.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_select_TrsmrcvLog(pageNo){
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/sym/log/SelectTrsmrcvLogList.do'/>";
		document.frm.submit();	
	}	
</script>
<title>송수신  테스트</title>
</head>
<body>
<form name="frm" action ="" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input name="trsmrcvSeCode" type="hidden" />

	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%" class="title_left">
	   <img src="<c:url value='/images/egovframework/sym/log/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;송수신테스트</td>
	 </tr>
	</table>
	<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
	<!-- 
	  <tr> 
	    <th height="23" class="required_text" >송수신구분
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td>
	   	<select name="trsmrcvSeCode" class="select">
			   <option selected value=''>--선택하세요--</option>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
			</c:forEach>			   			   
		   </select>
	    </td>
	  </tr> 
	 -->		
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >연계ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="integId" type="text" size="60" value="INT1" maxlength="4" > 
	    </td>
	  </tr>  
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >제공기관ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="provdInsttId" type="text" size="60" value="PI01" maxlength="4" > 
	    </td>
	  </tr>  
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >제공시스템ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="provdSysId" type="text" size="60" value="PS01" maxlength="4" > 
	    </td>
	  </tr>  
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >제공서비스ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="provdSvcId" type="text" size="60" value="PV01" maxlength="4" > 
	    </td>
	  </tr>  
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >요청기관ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="requstInsttId" type="text" size="60" value="RI01" maxlength="4" > 
	    </td>
	  </tr>  
	 <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >요청시스템ID
	    <img src="<c:url value='/images/egovframework/sym/log/icon/required.gif' />" width="15" height="15"></th>
	    <td width="80%" nowrap >
	      <input name="requstSysId" type="text" size="60" value="RS01" maxlength="4" > 
	    </td>
	  </tr>  
	</table>
	<table width="700" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr> 
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S01')">전송요청</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S02')">전송완료</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S03')">전송실패</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S04')">수신요청</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S05')">수신완료</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_TrsmrcvLog('S06')">수신실패</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/sym/log/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_TrsmrcvLog('1')">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/sym/log/btn/bu2_right.gif'/>" width="8" height="20"></td>         
	</tr>
	</table>
</form>	
</body>
</html>