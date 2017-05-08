<%--
/**
 * @Class Name  : EgovAuthorUpdate.java
 * @Description : EgovAuthorUpdate jsp
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

<c:set var="registerFlag" value="${empty groupManageVO.groupId ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty groupManageVO.groupId ? '그룹 등록' : '그룹 수정'}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cmm/sec/ram/com.css' />" rel="stylesheet" type="text/css">
<title></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectGroupList() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovGroupList.do'/>";
    varFrom.submit();       
}

function fncGroupInsert() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovGroupInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupUpdate() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovGroupUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupDelete() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovGroupDelete.do'/>";
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
<form:form commandName="groupManage" method="post" >

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;<c:out value="${registerFlagName}"/>
  </td>
  <th width="10%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectGroupList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <c:if test="${registerFlag == 'INSERT'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncGroupUpdate()" style="selector-dummy:expression(this.hideFocus=false);">수정</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncGroupDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
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
    <th class="required_text" width="25%" nowrap>그룹 ID<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td nowrap><input name="groupId" id="groupId" type="text" readonly value="<c:out value='${groupManage.groupId}'/>" size="40" /></td>
  </tr>
  <tr>    
    <th class="required_text" width="25%" nowrap>그룹 명<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td nowrap><input name="groupNm" id="groupNm" type="text" value="<c:out value='${groupManage.groupNm}'/>" required="true" fieldTitle="그룹 명" maxLength="50" char="s" size="40" />&nbsp;<form:errors path="groupNm" /></td>
  </tr>
  <tr>    
    <th class="required_text" width="20%" nowrap>설명</th>
    <td nowrap><input name="groupDc" id="groupDc" type="text" value="<c:out value="${groupManage.groupDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" /></td>
  </tr>
  <tr>    
    <th class="required_text" width="20%" nowrap>등록일자</th>
    <td nowrap><input name="groupCreatDe" id="groupCreatDe" type="text" value="<c:out value="${groupManage.groupCreatDe}"/>" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="20" readonly/></td>
  </tr>
</table>

<!-- 검색조건 유지 -->
<c:if test="${registerFlag == 'UPDATE'}">
<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
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

