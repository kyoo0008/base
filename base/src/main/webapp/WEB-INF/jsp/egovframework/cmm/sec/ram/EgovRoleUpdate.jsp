<%--
/**
 * @Class Name  : EgovRoleUpdate.java
 * @Description : EgovRoleUpdate jsp
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

<c:set var="registerFlag" value="${empty roleManageVO.roleCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty roleManageVO.roleCode ? '롤 등록' : '롤 수정'}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cmm/sec/ram/com.css' />" rel="stylesheet" type="text/css">
<title></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="roleManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectRoleList() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovRoleList.do'/>";
    varFrom.submit();       
}

function fncRoleInsert() {

    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovRoleInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateRoleManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncRoleUpdate() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovRoleUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateRoleManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncRoleDelete() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/cmm/sec/ram/EgovRoleDelete.do'/>";
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
<form:form commandName="roleManage" method="post" >  

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;<c:out value="${registerFlagName}"/>
  </td>
  <th width="10%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectRoleList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <c:if test="${registerFlag == 'INSERT'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncRoleUpdate()" style="selector-dummy:expression(this.hideFocus=false);">수정</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncRoleDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
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
    <th class="required_text" width="20%" nowrap>롤  코드<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap><input name="roleCode" id="roleCode" type="text" <c:if test="${registerFlag == 'UPDATE'}">readonly</c:if> value="<c:out value='${roleManage.roleCode}'/>" size="30" readOnly /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" nowrap>롤 명<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap><input name="roleNm" id="roleNm" type="text" value="<c:out value='${roleManage.roleNm}'/>" required="true" fieldTitle="롤 명" maxLength="50" char="s" size="30" />&nbsp;<form:errors path="roleNm" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" nowrap>롤 패턴<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap><input name="rolePtn" id="rolePtn" type="text" value="<c:out value='${roleManage.rolePtn}'/>" required="true" fieldTitle="롤  패턴" maxLength="50" char="s" size="50" />&nbsp;<form:errors path="rolePtn" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" nowrap>설명<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap><input name="roleDc" id="roleDc" type="text" value="<c:out value="${roleManage.roleDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" nowrap>롤 타입<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap>
      <select name="roleTyp">
        <c:forEach var="cmmCodeDetail" items="${cmmCodeDetailList}" varStatus="status">
          <option value="<c:out value="${cmmCodeDetail.code}"/>" <c:if test="${cmmCodeDetail.code == roleManage.roleTyp}">selected</c:if> ><c:out value="${cmmCodeDetail.codeNm}"/></option>
        </c:forEach>
      </select>
   </td> 
  </tr>  
  <tr>
    <th class="required_text" width="20%" nowrap>롤 Sort<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"></th>
    <td class="lt_text" nowrap><input name="roleSort" id="roleSort" type="text" value="<c:out value='${roleManage.roleSort}'/>" required="true" fieldTitle="롤 Sort" maxLength="50" char="s" size="30" /></td>
  </tr>  
  <tr>
    <th class="required_text" width="20%" nowrap>등록일자</th>
    <td class="lt_text" nowrap><input name="roleCreatDe" id="roleCreatDe" type="text" value="<c:out value="${roleManage.roleCreatDe}"/>" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="20" readonly/></td>
  </tr>
  <tr>

  </tr>
</table>

<!-- 검색조건 유지 -->
<c:if test="${registerFlag == 'UPDATE'}">
<input type="hidden" name="searchCondition" value="<c:out value='${roleManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${roleManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
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

