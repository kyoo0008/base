<%--
/**
 * @Class Name  : EgovAuthorInsert.java
 * @Description : EgovAuthorInsert jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j          최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *  
 */
--%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty authorManageVO.authorCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty authorManageVO.authorCode ? '권한 등록' : '권한 수정'}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cmm/sec/ram/com.css' />" rel="stylesheet" type="text/css">
<title></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="authorManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectAuthorList() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/cmm/sec/ram/EgovAuthorList.do'/>";
	varFrom.submit();       
}

function fncAuthorInsert() {

    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovAuthorInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncAuthorUpdate() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/cmm/sec/ram/EgovAuthorUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncAuthorDelete() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/cmm/sec/ram/EgovAuthorDelete.do'/>";
	if(confirm("삭제 하시겠습니까?")){
	    varFrom.submit();
	}
}

</script>
</head>

<body>
<DIV id="main">
<table border="0">
  <tr>
    <td width="700">
<form:form commandName="authorManage" method="post" >

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;<c:out value="${registerFlagName}"/>
  </td>
  <th width="10%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectAuthorList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <c:if test="${registerFlag == 'INSERT'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncAuthorUpdate()" style="selector-dummy:expression(this.hideFocus=false);">수정</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncAuthorDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>           
      </c:if>
    </tr>
   </table>
  </th>  
 </tr>
</table>

<table width="100%" cellpadding="8" class="table-line">
  <tr>
    <th class="required_text" width="20%" nowrap>권한  코드<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td nowrap><input name="authorCode" id="authorCode" type="text" <c:if test="${registerFlag == 'UPDATE'}">readonly</c:if> value="<c:out value='${authorManage.authorCode}'/>" size="40" />&nbsp;<form:errors path="authorCode" /></td>
     
  </tr>
  <tr>  
    <th class="required_text" width="20%" nowrap>권한 명<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td nowrap><input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" required="true" fieldTitle="권한 명" maxLength="50" char="s" size="40" />&nbsp;<form:errors path="authorNm" /></td>
    
  </tr>
  <tr>  
    <th class="required_text" width="20%" nowrap>설명</th>
    <td nowrap><input name="authorDc" id="authorDc" type="text" value="<c:out value="${authorManage.authorDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" /></td>
  </tr>
  <tr>  
    <th class="required_text" width="20%" nowrap>등록일자</th>
    <td nowrap><input name="authorCreatDe" id="authorCreatDe" type="text" value="<c:out value="${authorManage.authorCreatDe}"/>" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="20" readonly/></td>
  </tr>
</table>

<!--
    <button type="button" onclick="javascript:fncSelectAuthorList();">List</button>
    <input type="submit" value="<c:out value='${registerFlag}'/>"/>
 -->
<!-- 검색조건 유지 -->
<c:if test="${registerFlag == 'UPDATE'}">
<input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
</c:if>
</form:form>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly />
    </div>
    
</td>
</tr>
</table>    
</DIV>
</body>
</html>

