<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /** 
  * @Class Name : EgovGroupSearch.java
  * @Description : EgovGroupSearch Search 화면
  * @Modification Information
  * @
  * @  수정일                     수정자               수정내용
  * @ ----------    --------    ---------------------------
  * @ 2009.03.23    lee.m.j     최초 생성
  *
  *  @author lee.m.j
  *  @since 2009.03.23
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cmm/sec/ram/com.css' />" rel="stylesheet" type="text/css">
<title>SYSTEM HISTORY</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var checkCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    returnValue = checkField[i].value;
                }
            }

            if(checkCount > 1) {
                alert("하나 이상의 그룹이 선택되었습니다.");
                return;
            } else if(checkCount < 1) {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        } else {
        	if(checkField.checked == true) {
        		returnValue = checkId.value;
        	} else {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        }

        returnBoolean = true;

    } else {
    	alert("조회 결과가 없습니다.");
    }

    document.listForm.groupId.value = returnValue;

    return returnBoolean;
    
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/cmm/sec/ram/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
    opener.listForm.searchKeyword.value = groupId;
    window.close();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
     // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/cmm/sec/ram/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}
-->
</script>

</head>

<body>
<DIV id="main" style="display:">

<form name="listForm" action="<c:url value='/cmm/sec/ram/EgovGroupSearchList.do'/>" method="post">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="30%"class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;그룹 조회 팝업</td>

  <td>그룹 명 : <input name="searchKeyword" type="text" value="<c:out value="${groupManageVO.searchKeyword}"/>" title="검색" onkeypress="press();" /></td>
  <th width="10%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectGroupList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>     
      <td>&nbsp;&nbsp;</td>      
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectGroupConfirm()"  style="selector-dummy:expression(this.hideFocus=false);">확인</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>           
    </tr>
   </table>
  </th>  
 </tr>
</table>
<table width="100%" cellpadding="8" class="table-line">
 <thead>
  <tr>
    <th class="title" width="3%" nowrap></th>  
    <th class="title" width="15%" nowrap>그룹 ID</th>
    <th class="title" width="25%" nowrap>그룹 명</th>
  </tr>
 </thead>
 <tbody>
 <c:forEach var="group" items="${groupList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>
    <td class="lt_text" nowrap><a href="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
    <td class="lt_text" nowrap><c:out value="${group.groupNm}"/></td>
  </tr>
 </c:forEach>
 </tbody> 

 <!--tfoot>
  <tr class="">
   <td colspan=6 align="center"></td>
  </tr>
 </tfoot -->
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="10"></td>
  </tr>
</table>

<c:if test="${!empty groupManageVO.pageIndex }">
<div align="center">
    <div>
        <ui:pagination paginationInfo = "${paginationInfo}"
            type="default"
            jsFunction="linkPage"
            />
    </div>
</div>
</c:if>
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupIds"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form>

</DIV>
</body>
</html>
