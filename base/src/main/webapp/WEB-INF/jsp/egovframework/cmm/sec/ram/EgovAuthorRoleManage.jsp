<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%

/**
 * @Class Name : EgovAuthorRoleManage.java
 * @Description : EgovAuthorRoleManage.jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j     최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.21
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

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var checkRegYn = document.listForm.regYn;
    var returnValue = "";
    var returnRegYns = "";
    var checkedCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkedCount++;
                    checkField[i].value = checkId[i].value;
                
	                if(returnValue == "") {
	                    returnValue = checkField[i].value;
	                    returnRegYns = checkRegYn[i].value;
	                }
	                else { 
	                    returnValue = returnValue + ";" + checkField[i].value;
	                    returnRegYns = returnRegYns + ";" + checkRegYn[i].value;
	                }
                }
            }

            if(checkedCount > 0) 
            	returnBoolean = true;
            else {
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
        	 if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
            	returnBoolean = false;
            }
            else {
            	returnValue = checkId.value;
                returnRegYns = checkRegYn.value;

                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue;
    document.listForm.regYns.value = returnRegYns;

    return returnBoolean;

}

function fncSelectAuthorRoleList() {
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = "1";
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorList(){
   // document.listForm.searchCondition.value = "1";
   // document.listForm.pageIndex.value = "1";
    document.listForm.searchKeyword.value = "";
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddAuthorRoleInsert() {
	if(fncManageChecked()) {
	    if(confirm("등록하시겠습니까?")) {
            document.listForm.action = "<c:url value='/cmm/sec/ram/EgovAuthorRoleInsert.do'/>";
            document.listForm.submit();
	    }
	} else return;
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorRoleList();
    }
}
-->
</script>

</head>

<body>
<DIV id="main" style="display:">
<table border="0">
  <tr>
    <td width="700">
<form name="listForm" action="<c:url value='/cmm/sec/ram/EgovAuthorRoleList.do'/>" method="post">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="20%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;권한 롤 관리</td>

  <td width="60%">권한코드 : <input name="searchKeyword" type="text" size="30" value="<c:out value="${authorRoleManageVO.searchKeyword}"/>" title="검색"  onkeypress="press();" readOnly /></td>
  <th width="20%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectAuthorList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectAuthorRoleList()" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncAddAuthorRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
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
    <th class="title" width="3%" nowrap><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>  
    <th class="title" width="10%" nowrap>롤 ID</th>
    <th class="title" width="20%" nowrap>롤 명</th>
    <th class="title" width="10%" nowrap>롤 타입</th>
    <th class="title" width="10%" nowrap>롤 Sort</th>
    <th class="title" width="30%" nowrap>롤 설명</th>
    <th class="title" width="12%" nowrap>등록일자</th>
    <th class="title" width="5%" nowrap>등록여부</th>
  </tr>
 </thead>
 <tbody>
 <c:forEach var="authorRole" items="${authorRoleList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${authorRole.roleCode}"/>" /></td>
    <td class="lt_text" nowrap><c:out value="${authorRole.roleCode}"/></td>
    <td class="lt_text" nowrap><c:out value="${authorRole.roleNm}"/></td>
    <td class="lt_text3" nowrap><c:out value="${authorRole.roleTyp}"/></td>
    <td class="lt_text3" nowrap><c:out value="${authorRole.roleSort}"/></td>
    <td class="lt_text3" nowrap><c:out value="${authorRole.roleDc}"/></td>
    <td class="lt_text3" nowrap><c:out value="${authorRole.creatDt}"/></td>
    <td class="lt_text3" nowrap>
        <select name="regYn">
            <option value="Y" <c:if test="${authorRole.regYn == 'Y'}">selected</c:if> >등록</option>
            <option value="N" <c:if test="${authorRole.regYn == 'N'}">selected</c:if> >미등록</option>
        </select>
    </td>
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

<c:if test="${!empty authorRoleManageVO.pageIndex }">
<div align="center">
    <div>
        <ui:pagination paginationInfo = "${paginationInfo}"
            type="default"
            jsFunction="linkPage"
            />
    </div>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly />
    </div>     
</div>
</c:if>
<input type="hidden" name="roleCodes"/>
<input type="hidden" name="regYns"/>
<input type="hidden" name="pageIndex" value="<c:out value='${authorRoleManageVO.pageIndex}'/>"/>
<input type="hidden" name="authorCode" value="<c:out value="${authorRoleManageVO.searchKeyword}"/>"/>
<input type="hidden" name="searchCondition"/>
</form>
</td>
</tr>
</table>   
</DIV>
</body>
</html>
