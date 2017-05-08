<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /** 
  * @Class Name : EgovDeptSearch.java
  * @Description : EgovDeptSearch Search 화면
  * @Modification Information
  * @
  * @  수정일                     수정자               수정내용
  * @ ----------    --------    ---------------------------
  * @ 2009.03.26    lee.m.j     최초 생성
  *
  *  @author lee.m.j
  *  @since 2009.03.26
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

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked)
                    checkField[i].value = checkId[i].value;
                if(returnValue == "")
                    returnValue = checkField[i].value;
                else 
                    returnValue = returnValue + ";" + checkField[i].value;
            }
        }
    } 

    document.listForm.groupIds.value = returnValue;
}

function fncSelectDeptList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectDept(deptCode, deptNm) {
 // window.returnValue = deptCode + "|" + deptNm;
    opener.listForm.deptCode.value = deptCode;
    opener.listForm.deptNm.value = deptNm;
    window.close();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
   //document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectDeptConfirm() {
	var checkField = document.listForm.delYn;
    var checkFieldCd = document.listForm.checkId;
	var checkFieldNm = document.listForm.checkNm;
	var checkCount = 0;

	var org_cd;
	var org_nm;
	
	if(checkField) {
		if(checkField.length > 1) {
			for(var i=0; i<checkField.length; i++) {
				if(checkField[i].checked) {
					checkCount++;
                    org_cd = checkFieldCd[i].value;
                    org_nm = checkFieldNm[i].value;
				}
			}

			if(checkCount == 1) {
             // window.returnValue = org_cd + "|" + org_nm; 
                opener.listForm.deptCode.value = org_cd;
                opener.listForm.deptNm.value = org_nm;
                window.close();
		    } else {
			    alert("하나의 부서를 선택하세요.");
			    return;
			}
		} else {
			if(document.listForm.delYn.checked) {
             // window.returnValue = document.listForm.checkId.value + "|" + document.listForm.checkNm.value;
                opener.listForm.deptCode.value = org_cd;
                opener.listForm.deptNm.value = org_nm;
                window.close();
			} else {
	            alert("선택된 항목이 없습니다.");
	            return;
			}
		} 
	} else {
        alert("조회 후 선택하시기 바랍니다.");
        return;
	}
}

function press() {

    if (event.keyCode==13) {
    	fncSelectDeptList('1');
    }
}
-->
</script>

</head>

<body>
<form name="listForm" action="<c:url value='/cmm/sec/ram/EgovDeptSearchList.do'/>">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="30%" class="title_left">
   <img src="<c:url value='/images/egovframework/cmm/sec/ram/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle">&nbsp;부서 조회 팝업</td>
  <td width="40%">부서 명 : <input name="searchKeyword" type="text" value="<c:out value="${deptAuthorVO.searchKeyword}"/>" title="검색" onkeypress="press();" /></td>
  <th width="20%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectDeptList('1')">조회</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" width="8" height="20"></td>     
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif' />" width="8" height="20"></td>
      <td background="<c:url value='/images/egovframework/cmm/sec/ram/btn/bu2_bg.gif'/>" class="text_left" nowrap><a href="javascript:fncSelectDeptConfirm()" style="selector-dummy:expression(this.hideFocus=false);">확인</a> 
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
    <th class="title" width="15%" nowrap>부서 ID</th>
    <th class="title" width="25%" nowrap>부서 명</th>
  </tr>
 </thead>
 <tbody>
 <c:forEach var="dept" items="${deptList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${dept.deptCode}"/>" /><input type="hidden" name="checkNm" value="<c:out value="${dept.deptNm}"/>" /></td>
    <td class="lt_text" nowrap><a href="javascript:fncSelectDept('<c:out value="${dept.deptCode}"/>', '<c:out value="${dept.deptNm}"/>')"><c:out value="${dept.deptCode}"/></a></td>
    <td class="lt_text" nowrap><c:out value="${dept.deptNm}"/></td>
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
</div>
</c:if>
<input type="hidden" name="pageIndex" value="<c:out value='${deptAuthorVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form>

</body>
</html>
