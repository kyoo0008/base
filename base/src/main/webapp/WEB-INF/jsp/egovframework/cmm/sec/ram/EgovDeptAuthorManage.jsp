<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /** 
  * @Class Name : EgovDeptAuthorManage.java
  * @Description : EgovDeptAuthorManage List 화면
  * @Modification Information
  * @
  * @  수정일                     수정자                    수정내용
  * @ -------       --------    ---------------------------
  * @ 2009.03.23    Lee.m.j       최초 생성
  *
  *  @author Lee.m.j  
  *  @since 2009.03.23
  *  @version 1.0
  *  @see
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cmm/sec/ram/com.css' />" rel="stylesheet" type="text/css">
<title>SYSTEM HISTORY</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/zip/EgovZipPopup.js' />" ></script>
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

    var resultCheck = true;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;
        
    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";

    var checkedCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        returnRegYn = booleanRegYn[i].value;
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                    }
                }
            }
            if(checkedCount > 0) 
                resultCheck = true;
            else {
                alert("선택된  사용자가 없습니다.");
                resultCheck = false;
            }
        } else {
        	if(document.listForm.delYn.checked == false) {
                alert("선택된 사용자가  없습니다.");
                resultCheck = false;
            }
            else {
            	returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                resultCheck = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    } 

    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;

    return resultCheck;
}

function fncSelectDeptAuthorList(pageNo) {
	if(document.listForm.deptCode.value == '') {
		alert("부서를 선택하세요");
		return;
	}
	
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptAuthorList.do'/>";
    document.listForm.submit();
}

function fncAddDeptAuthorInsert() {

    if(!fncManageChecked()) return;

    if(confirm("등록하시겠습니까?")) {
        document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptAuthorInsert.do'/>";
        document.listForm.submit();
    }
}

function fncDeptAuthorDeleteList() {
 
    if(!fncManageChecked()) return;

    if(confirm("삭제하시겠습니까?")) {
        document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptAuthorDelete.do'/>";
        document.listForm.submit(); 
    }
}

function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptAuthorList.do'/>";
    document.listForm.submit();
}


/*
function fncSelectDeptAuthorPop() {

    var url = "<c:url value='/cmm/sec/ram/EgovDeptSearchView.do'/>";
    var varParam = new Object();
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";

    var retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.listForm.deptCode.value = retVal.substring(0, retVal.indexOf("|"));
        document.listForm.deptNm.value = retVal.substring(retVal.indexOf("|")+1, retVal.length);
    }
}
*/
function fncSelectDeptAuthorPop() {


    var url = "<c:url value='/cmm/sec/ram/EgovDeptSearchView.do'/>";
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";
    /*
    var retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.listForm.deptCode.value = retVal.substring(0, retVal.indexOf("|"));
        document.listForm.deptNm.value = retVal.substring(retVal.indexOf("|")+1, retVal.length);
    }
    */

    window.open(url,"부서검색",'width=500,height=485,scrollbars=no,resizable=no,status=no,center:yes');

}

function press() {

    if (event.keyCode==13) {
    	fncSelectDeptAuthorList('1');
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
<form name="listForm" action="<c:url value='/cmm/sec/ram/EgovDeptAuthorList.do'/>" method="post">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="25%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;부서 권한 관리</td>
  <td width="55%">부서<img src="/images/egovframework/uss/olp/mgt/icon/required.gif" width="15" height="15"> : <input name="deptCode" type="text" value="<c:out value="${deptAuthorVO.deptCode}"/>" size="22" title="부서코드" onkeypress="press();" readOnly />
                              <input name="deptNm" type="text" value="<c:out value="${deptAuthorVO.deptNm}"/>" size="17" title="부서명" onkeypress="press();" readOnly />
  </td>
  <td width="4%">
    <table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
        <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectDeptAuthorPop()">팝업</a>
        </td>
        <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>       
      </tr>
    </table>
  </td>
  <th width="17%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectDeptAuthorList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncAddDeptAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>    
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncDeptAuthorDeleteList()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
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
    <th class="title" width="5%" nowrap><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>  
    <th class="title" width="10%" nowrap>사용자 ID</th>
    <th class="title" width="10%" nowrap>사용자 명</th>
    <th class="title" width="20%" nowrap>권한</th>
    <th class="title" width="10%" nowrap>등록 여부</th>
  </tr>
 </thead>
 <tbody>
 <c:forEach var="deptAuthor" items="${deptAuthorList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${deptAuthor.uniqId}"/>" /></td>
    <td class="lt_text3" nowrap><c:out value="${deptAuthor.userId}"/></td>
    <td class="lt_text3" nowrap><c:out value="${deptAuthor.userNm}"/></td>
    <td class="lt_text3" nowrap><select name="authorManageCombo">
            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
                <option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == deptAuthor.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
            </c:forEach>
        </select></td>
    <td class="lt_text3" nowrap><c:out value="${deptAuthor.regYn}"/><input type="hidden" name="regYn" value="<c:out value="${deptAuthor.regYn}"/>"></td>
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

<c:if test="${!empty deptAuthorVO.pageIndex }">
<div align="center">
    <div>
        <ui:pagination paginationInfo = "${paginationInfo}"
            type="default"
            jsFunction="linkPage"
            />
    </div>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly/>
    </div>
</div>
</c:if>
<input type="hidden" name="userId"/>
<input type="hidden" name="userIds"/>
<input type="hidden" name="authorCodes"/>
<input type="hidden" name="regYns"/>
<input type="hidden" name="pageIndex" value="<c:out value='${deptAuthorVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form>
</td>
</tr>
</table>
</DIV>
</body>
</html>
