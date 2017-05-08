<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>


<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="템플릿 복원"/>
</c:import>



<div id="cntnts">
    
        <form:form commandName="bbsTmplatVO" name="bbsTmplatVO" action="" method="post" enctype="multipart/form-data" onsubmit="return false;"> 
        <form:hidden path="bbsTmplatId"/>
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        <input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
    
		<fieldset>
        <legend class="hdn">템플릿 입력 폼</legend>
        
        <table class="chart2" summary="작성인, 제목, 내용, 파일첨부를 입력하는 표입니다." >
		  <caption> </caption>
          <colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
          <tbody>
            <tr>
              <th><label for="imagePrevewFileNm">미리보기이미지</label></th>
              <td>
              	<c:choose>
					<c:when test="${not empty bbsTmplatVO.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}/${bbsTmplatVO.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}/${bbsTmplatVO.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>
              </td>
            </tr>
            <tr>
              <th><label for="cssSourc">스타일 소스</label></th>
              <td>
                <form:textarea path="cssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="cssSourc"/></div>         
              </td>
            </tr>
            <tr>
              <th><label for="scriptSourc">스크립트 소스</label></th>
              <td>
                <form:textarea path="scriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
                <div><form:errors path="scriptSourc"/></div>         
              </td>
            </tr>
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<c:url var="listUrl" value="/mng/cop/com/selectBbsTemplateHistoryList.do">
          		<c:param name="bbsTmplatId" value="${searchVO.bbsTmplatId}" />
		        <c:param name="pageIndex" value="${searchVO.pageIndex}" />
				<c:param name="searchCnd" value="${searchVO.searchCnd}" />
				<c:param name="searchWrd" value="${searchVO.searchWrd}" />
		      </c:url>
            <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
          </div>
            
        </fieldset>
      </form:form>

    </div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>