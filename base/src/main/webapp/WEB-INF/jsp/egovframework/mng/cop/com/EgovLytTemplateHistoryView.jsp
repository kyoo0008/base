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

<script type="text/javascript">
function fnTabView(idx) {
	
	$('#tabLink01').removeClass('active');
	$('#tabLink02').removeClass('active');
	$('#tabLink' + idx).addClass('active');
	
	$('#tab01').hide();
	$('#tab02').hide();    		
	$('#tab' + idx).show();
	
}

$(document).ready( function() {
	
	$('#tab02').hide();
	$('#tmplatNm').focus();
	
});

</script>

<style type="text/css">
<!--
.conf_top{overflow:hidden;}
.tab_menu{right:0;z-index:1000;}
.tab_menu li{float:left;background:#f8f8f8;width:150px;height:30px;text-align:center;border:1px solid #ccc;}
.tab_menu li a{display:block;padding:8px 0px;height:30px;}
.tab_menu li a:hover, .tab_menu li a.active{background:url('${_IMG}/tab_over.gif') 0 0 repeat;padding:8px 0px;height:15px;font-weight:bold;color:#32688c;}
.cont{position:relative;width:100%;border-top:1px solid #ccc;padding:0px 0;z-index:1001;}
.cont table{width:100%;}
-->
</style>  


<div id="cntnts">
    
        <form:form commandName="lytTmplatVO" name="lytTmplatVO" action="" method="post" enctype="multipart/form-data" onsubmit="return false;"> 
        <form:hidden path="lytTmplatId"/>
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
					<c:when test="${not empty lytTmplatVO.prevewFileNm}"><a href="#" onclick="fnImagePreview('${fileStoreWebPathByPreFile}/${lytTmplatVO.prevewFileNm}');return false;"><img src="${fileStoreWebPathByPreFile}/${lytTmplatVO.prevewFileNm}" width="120" height="107"/></a></c:when>
					<c:otherwise><img src="${_IMG}/board/no_img.gif" alt="이미지없음" width="120" height="107"/></c:otherwise>
				</c:choose>
              </td>
            </tr>
            <tr>
				<th><label>HTML</label></th>
				<td>
					<div class="conf_top">
				    	<ul class="tab_menu">
							<li><a href="#tab1" id="tabLink01" onclick="fnTabView('01');return false;" class="active">WEB</a></li>
						</ul>
					</div>
					
					<div id="tab01" class="cont">
						<table>
							<caption>등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<tr>
						              <th><label for="cssSourc">스타일시트</label></th>
						              <td>
						                <form:textarea path="cssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="cssSourc"/></div>         
						              </td>
						            </tr>
						            <tr>
						              <th><label for="scriptSourc">자바스크립트</label></th>
						              <td>
						                <form:textarea path="scriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="scriptSourc"/></div>         
						              </td>
						            </tr>
								</tbody>
						</table>
					</div>
					<div id="tab02" class="cont" style="visibility:hidden;height:0px;position:absolute;top:0;left:0;z-index:-1;">
						<table>
							<caption>등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<th><label for="mobileCssSourc">스타일시트</label></th>
						              <td>
						                <form:textarea path="mobileCssSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="mobileCssSourc"/></div>         
						              </td>
						            </tr>
						            <tr>
						              <th><label for="mobileScriptSourc">자바스크립트</label></th>
						              <td>
						                <form:textarea path="mobileScriptSourc" rows="10" cssStyle="width:90%;" cssClass="inp_default" />
						                <div><form:errors path="mobileScriptSourc"/></div>         
						              </td>
						            </tr>
								</tbody>
						</table>
					</div>
				</td>
			</tr>   
          </tbody>
          <tfoot>
          </tfoot>
          </table>
  
          <div class="btn_r">
          	<c:url var="listUrl" value="/mng/cop/com/selectLytTemplateHistoryList.do">
          		<c:param name="lytTmplatId" value="${searchVO.lytTmplatId}" />
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