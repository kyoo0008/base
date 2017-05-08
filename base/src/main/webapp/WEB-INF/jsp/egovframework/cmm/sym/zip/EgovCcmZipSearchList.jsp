<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/member/css"/>
<c:set var="C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="address_html" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/login.css" type="text/css" charset="utf-8" /> 
  <script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
<title>주소검색</title>
<style type="text/css">
	body{background:none;}
</style>
<script type="text/javaScript" language="JavaScript">
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){

	if($.trim($('#searchKeyword').val()) == "") {
		alert("주소지의 동(면/읍) 이름을 입력해주세요");
		return false;
	}
	document.listForm.pageIndex.value = 1;
   	return true;
}
/* ********************************************************
 * 결과 우편번호,주소 반환 
 ******************************************************** */
function fn_egov_return_Zip(zip,addr){
	var retVal   = new Object();
	var sZip     = zip;
	var vZip1     = zip.substring(0,3);
	var vZip2     = zip.substring(3,6);
	var sAddr    = addr.replace("/^\s+|\s+$/g","");
	
	opener.fn_egov_return_ZipCode(sZip, sAddr, vZip1, vZip2);
	window.close();
}	


</script>
</head>

<body>


		<div class="pop_tit">
			<h1>주소검색</h1>
		</div>

		<div class="pop_con">
		

			<form name="listForm" action="<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" method="post" onsubmit="return fn_egov_search_Zip();">
    			<input name="searchCondition" type="hidden" value="4"/> 
    			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<fieldset>
					<legend>주소 검색</legend>
					
					<div class="pop_gbox">
						
						<div class="sch_chk">
							<span><input type="radio" id="town" name="ftype" /><label for="town">동(읍/면)명+지번검색</label></span>
							<span><input type="radio" id="road_name" name="ftype" /><label for="road_name">도로명+건물번호검색</label></span>
						</div>

						<!-- 읍면동 검색 -->
						<span class="select_box">
							<select id="town_select" name="town_select" title="지역 선택">
								<option value="">읍면동명</option>
								<option value="오금동">오금동</option>
								<option value="마천동">마천동</option>
								<option value="오륜동">오륜동</option>
								<option value="금오동">금오동</option>
								<option value="신곡동">신곡동</option>
								<option value="봉명동">봉명동</option>
							</select>
							<input type="text" class="inp name" id="searchKeyword" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" title="검색어입력" />
							<span class="btn_s"><button type="submit">검색</button></span>
						</span>

						<!-- // 읍면동 검색 -->
						
						<!-- 도로명 검색 
						<span class="select_box">
							<select id="town_select" name="town_select" title="번호 선택">
								<option value="">---- 선택 ----</option>
								<option value="">세종자치특별시</option>
								<option value="">대전광역시</option>
							</select>
							<input type="text" class="inp" id="name" title="검색어입력"  />
								<span class="btn_s"><button type="submit">검색</button></span>
						</span>
						<!-- //도로명 검색 -->


						
					</div>
				</fieldset>
			</form>

			<table class="addr_chart" summary="주소검색 결과를 나타낸 결과 목록입니다">
				<caption>주소검색결과</caption>
				<tbody>
					<tr>
						<th>우편번호</th>
						<th>주소</th>
					</tr>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
						<tr>
							<td><a href="#" onclick="fn_egov_return_Zip( '${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}'); return false;"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></a></td>
							<td class="alL"><a href="#" onclick="fn_egov_return_Zip( '${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}'); return false;"">${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm} ${resultInfo.lnbrDongHo}</a></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
			 			<tr>
							<td colspan="2">자료가 없습니다. 다른검색조건을 선택해주세요.</td>
						</tr>
			 		</c:if>
				</tbody>
			</table>

		</div>

		<button class="pop_mclose" onclick="window.close(); return false;">닫기</button>





 </body>
</html>
