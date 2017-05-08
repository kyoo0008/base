<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="egovframework.com.cmm.service.Globals"  %>
<c:set var="MNG_IMG" value="/template/manage/images"/>
<c:set var="CMMN_JS" value="/template/common/js"/>
<c:set var="_PREFIX" value="/mng/ems"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="SMS_MANAGE"/>
	<c:param name="depth1" value="SMS_SEND"/>
	<c:param name="depth2" value="EMS"/>
	<c:param name="title" value="메일발송"/>
</c:import>	

<script type="text/javascript">

<c:if test='${not empty message}'>
alert("${message}");
</c:if>


	function emsSend(se) {

		var frm = document.mailMessageVO;
		if(frm.senderName.value == "") {
			alert("작성자명을 입력하세요");
			return false;
		}
		if(frm.senderEmail.value == "") {
			alert("작성자 이메일을 입력하세요");
			return false;
		}
		if(frm.subject.value == "") {
			alert("제목을 입력하세요");
			return false;
		}
		if(frm.content.value == "") {
			alert("내용을 입력하세요");
			return false;
		}

		if(confirm("메일을 전송 하시겠습니까?")) {
			return true;
		}

		return false;
	}
</script>

<div id="cntnts">

        <form:form commandName="mailMessageVO" name="mailMessageVO" method="post" action="${_PREFIX}/addEmsManage.do"> 

        <fieldset>
          <legend class="hdn">메일 입력 폼</legend>
        
        <table class="chart2" summary="작성인, 제목, 내용을 입력하는 표입니다." >
			<caption> </caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
          <tr>
              <th><em>*</em> <label for="subject">발송대상자</label></th>
              <td>
				<select name="sendSe" id="sendSe" title="발송대상자">
					<option value="02">일반회원</option>
					<option value="04">일반단체회원</option>
					<option value="03">입주작가회원</option>
					<option value="05">문화예술단체</option>
                </select> 선택한 그룹중 메일수신자에게만 발송 합니다.
                <br/><form:errors path="emails"/>
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="senderName">작성자명</label></th>
              <td>
                <form:input path="senderName" cssClass="inp" size="30" /> EX)대구문화예술아카이브
                <br/><form:errors path="senderName" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="senderEmail">작성자 이메일</label></th>
              <td>
                <form:input path="senderEmail" cssClass="inp_long" size="30" /> EX)help@daegu.go.kr
                <br/><form:errors path="senderEmail" />
              </td>         
            </tr>
			<tr>
              <th><em>*</em> <label for="subject">제목</label></th>
              <td>
                <form:input path="subject" cssClass="inp_long" size="30" /> 
                <br/><form:errors path="subject" />
              </td>         
            </tr>
            <tr>
              <th><em>*</em> <label for="content">내용</label></th>
              <td><form:textarea cssClass="join_area" path="content" cols="70" rows="10" /><form:errors path="content" /></td>         
            </tr>
          </tbody>
          </table>
  
          <div class="btn_r">
           	<input type="image" onclick="return emsSend();" src="${MNG_IMG}/btn/btn_regist.gif" alt="메일발송" />
          </div>
            
        </fieldset>
        </form:form>
      
</div>      

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	