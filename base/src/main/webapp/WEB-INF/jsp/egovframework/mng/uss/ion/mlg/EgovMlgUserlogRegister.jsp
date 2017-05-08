<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="_IMG" value="/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MILEAGE_MANAGE"/>
	<c:param name="depth1" value="MILEAGE_LIST"/>
	<c:param name="title" value="마일리지내역"/>		
</c:import>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
	frm = document.getElementById("detailForm");
	frm.action="<c:url value="/mng/uss/ion/mlg/selectMlgUserlogList.do"/>";
	frm.submit();
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");
	
	<c:choose>
		<c:when test="${command eq 'add'}">
			if(frm.userId.value == "") {
				alert("아이디를 입력하세요");
			    frm.userId.focus();
			    return false;
			}
			
			if(!isNumber(frm.mlgScore)) {
			    alert("마일리지는 숫자만 입력하세요");
			    frm.mlgScore.focus();
			    return false;
		    }
			
			var finalValue = frm.mlgScore.value;
			var addText = "증감";
			if(fn_egov_RadioBoxValue("addAt") == "N") {
				finalValue = finalValue * -1;
				addText = "가감";
			}
			
			if(confirm("\"" + frm.userId.value + "\"님에게 \"" + finalValue + "\"점을 " + addText + "하시겠습니까?")) {
				frm.mlgScore.value = finalValue;
				frm.action="<c:url value="/mng/uss/ion/mlg/addMlgUserlog.do"/>";
				return true;
			}
			
			return false;
		</c:when>
		<c:when test="${command eq 'update'}">
			if (confirm('<spring:message code="common.update.msg" />')) {
				frm.action="<c:url value="/mng/uss/ion/mlg/updateMlgUserlog.do"/>";
				return true;
			}
			
			return false;
		</c:when>
	</c:choose>
}

/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	return FValue;
}

function  isNumber(obj) 
{ 
   var  str  =  obj.value; 
   if(str.length  ==  0) 
      return  false; 
   for(var  i=0;  i  <  str.length;  i++) 
   { 
      if(!('0'  <=  str.charAt(i)  &&  str.charAt(i)  <=  '9')) 
         return  false; 
   } 
   
   return  true; 
} 

// -->
</script>


<div id="cntnts">

<form:form commandName="comtnmlguserlogVO" onsubmit="return fn_egov_save()" name="detailForm" id="detailForm" >
<form:hidden path="userlogId"/>

<!-- 검색조건 유지 -->
<input type="hidden" name="searchSiteId" value="<c:out value='${searchVO.searchSiteId}'/>"/>
<input type="hidden" name="searchMlgCode" value="<c:out value='${searchVO.searchMlgCode}'/>"/>
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

	<table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
		<caption> </caption>
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
		<c:if test="${command eq 'add'}">
			<tr>
				<th>대상시스템</th>
				<td>
					<select name="siteId" >
						<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}">${result.siteNm}</option>
						</c:forEach>		
					</select>
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<form:input path="userId" cssClass="inp" size="20"/>
					&nbsp;<form:errors path="userId" />
				</td>
			</tr>
			<tr>
				<th>증감여부</th>
				<td>
					증감 : <input type="radio" name="addAt"  value="Y" checked="checked"/>
					가감 : <input type="radio" name="addAt"  value="N" />
				</td>
			</tr>
			<tr>
				<th>마일리지</th>
				<td>
					<form:input path="mlgScore" cssClass="inp" size="5"/>
					&nbsp;<form:errors path="mlgScore" />
				</td>
			</tr>
		</c:if>
		<c:if test="${command ne 'add'}">
			<tr>
				<th>아이디</th>
				<td><c:out value="${comtnmlguserlogVO.userId }"/></td>
			</tr>
			<tr>
				<th>이전마일리지</th>
				<td><fmt:formatNumber value="${comtnmlguserlogVO.oldMlgScore}" type="number"/>점</td>
			</tr>
			<tr>
				<th>발생마일리지</th>
				<td><fmt:formatNumber value="${comtnmlguserlogVO.mlgScore}" type="number"/>점</td>
			</tr>
			<tr>
				<th>현재마일리지</th>
				<td><fmt:formatNumber value="${comtnmlguserlogVO.newMlgScore}" type="number"/>점</td>
			</tr>
			<tr>
				<th>참조아이디</th>
				<td><c:out value="${comtnmlguserlogVO.refrnProgrmId }"/></td>
			</tr>
		</c:if>
		<tr>
			<th>내용</th>
			<td>
				<form:input path="scoreCn" cssClass="inp_long" maxlength="100"/>
				&nbsp;<form:errors path="scoreCn" />
			</td>
		</tr>
		<tr>
			<th>메모</th>
			<td>
				<form:input path="memo" cssClass="inp_long" maxlength="100"/>
				&nbsp;<form:errors path="memo" />
				<br/><font color="red"> ※ 메모 내용은 관리자만 볼수있습니다.</font>
			</td>
		</tr>
		</tbody>
	</table>
  
  
  	<div class="btn_r">
  		<c:choose>
          <c:when test="${command eq 'add'}">
          	<input type="image" src="${_IMG}/btn/btn_regist.gif" alt="등록"/> 
          </c:when>
          <c:otherwise>
          	<input type="image" src="${_IMG}/btn/btn_modify.gif" alt="수정" /></a>
          </c:otherwise>
          </c:choose>
          
		<a href="#" onclick="fn_egov_selectList(); return false;"><img src="${_IMG}/btn/btn_list.gif" alt="목록" /></a>
	</div>

	</form:form>
	
</div>	


<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
