<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}/template/member/css"/>
<c:set var="C_JS" value="${pageContext.request.contextPath}/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
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
	if($('#searchCtprvnNm option:selected').val() == '') {
		alert("시도를 선택하세요");
		return false;
	}
	
	if($('#searchSignguNm option:selected').val() == '') {
		if($('#searchSignguNm option').size() > 1) {
			alert("시군구를 선택하세요");
			return false;
		}
	}
	
	if($.trim($('#searchKeyword').val()) == "") {
		if($('input:radio[name=searchCondition]:checked').val() == '0') {
			alert('도로명+건물번호를 입력하세요');
		} else if($('input:radio[name=searchCondition]:checked').val() == '1') {
			alert('동(읍/면/리)명+지번을 입력하세요');
		} else if($('input:radio[name=searchCondition]:checked').val() == '2') {
			alert('건물명을 입력하세요');
		}
		$('#searchKeyword').focus();
		return false;
	}
}
/* ********************************************************
 * 결과 우편번호,주소 반환 
 ******************************************************** */
function fn_egov_return_Zip(zip,addr1, addr2){
	var retVal   = new Object();
	var sZip     = zip;
	var vZip1     = zip.substring(0,3);
	var vZip2     = zip.substring(3,6);
	var sAddr1    = addr1.replace("/^\s+|\s+$/g","");
	var sAddr2    = addr2.replace("/^\s+|\s+$/g","");
	
	opener.fn_egov_return_ZipCode(sZip, sAddr1, sAddr2, vZip1, vZip2);
	window.close();
}	

$(document).ready( function() {
	$('#searchCtprvnNm').change(function() {
		$('#searchSignguNm').attr('disabled', false);
		$('#searchSignguNm').empty().append("<option value=''>시군구 선택</option>");
		if(this.value != '') {
			var url = "/sym/cmm/selectRdnmZipSignguNmListForAjax.do?searchCtprvnNm=" + encodeURIComponent(this.value);
			$.getJSON(url, function(data) {
				$.each(data, function(idx, zip){
					$('#searchSignguNm').append("<option value='" + zip.signguNm + "'>"+ zip.signguNm + "</option>");
				});
				if(data.length == 0) {
					$('#searchSignguNm').attr('disabled', true);
				}
			})
			.success(function() {})
			.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
			.complete(function() {});
		}
	});
	
	$('input:radio[name=searchCondition]').change(function() {
		$('#lvlRndm').hide();
		$('#lvlEmd').hide();
		$('#lvlBuild').hide();	
		if($('input:radio[name=searchCondition]:checked').val() == '0') {
			$('#lvlRndm').show();
		} else if($('input:radio[name=searchCondition]:checked').val() == '1') {
			$('#lvlEmd').show();
		} else if($('input:radio[name=searchCondition]:checked').val() == '2') {
			$('#lvlBuild').show();
		}
		$('#searchKeyword').focus();
	});
	
	$('input:radio[name=searchCondition]').change();
	
	$('#searchKeyword').focus();
});

</script>
</head>

<body>


		<div class="pop_tit">
			<h1>주소검색</h1>
		</div>

		<div class="pop_con">
		

			<form name="listForm" action="<c:url value='/sym/cmm/EgovCcmRdnmZipSearchList.do'/>" method="post" onsubmit="return fn_egov_search_Zip();">
    			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				<fieldset>
					<legend>주소 검색</legend>
					
					<div class="pop_gbox">
						
						<div class="sch_chk">
							<span><input type="radio" id="rndm" name="searchCondition" value="0" <c:if test="${empty searchVO.searchCondition or searchVO.searchCondition eq '0'}">checked="checked"</c:if> /><label for="rndm">도로명+건물번호</label></span>
							<span><input type="radio" id="emd" name="searchCondition" value="1" <c:if test="${searchVO.searchCondition eq '1'}">checked="checked"</c:if> /><label for="emd">동(읍/면/리)명+지번</label></span>
							<span><input type="radio" id="build" name="searchCondition" value="2" <c:if test="${searchVO.searchCondition eq '2'}">checked="checked"</c:if> /><label for="build">건물명</label></span>
						</div>

						<span class="select_box">
							<select id="searchCtprvnNm" name="searchCtprvnNm" title="시도 선택">
								<option value="">시도 선택</option>
								<c:forEach items="${ctprvnNmList}" var="resultInfo" varStatus="status">
									<option value="<c:out value='${resultInfo}'/>" <c:if test="${searchVO.searchCtprvnNm eq resultInfo}">selected="selected"</c:if>><c:out value='${resultInfo}'/></option>
								</c:forEach>
							</select>
							<select id="searchSignguNm" name="searchSignguNm" title="시군구 선택">
								<option value="">시군구 선택</option>
								<c:forEach items="${signguNmList}" var="resultInfo" varStatus="status">
									<option value="<c:out value='${resultInfo}'/>" <c:if test="${searchVO.searchSignguNm eq resultInfo}">selected="selected"</c:if>><c:out value='${resultInfo}'/></option>
								</c:forEach>
							</select>
							<input type="text" class="inp name" id="searchKeyword" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" title="검색어입력" />
							<span class="btn_s"><button type="submit">검색</button></span>
						</span>						
					</div>
				</fieldset>
			</form>

			<div id="lvlRndm" style="display:none"><strong class="star">*</strong> 검색방법 : 서울시 중구 <strong>소공로 70</strong>  예) '<strong>소공로</strong>(도로명) <strong>70</strong>(건물번호)'</div>
			<div id="lvlEmd" style="display:none"><strong class="star">*</strong> 검색방법 : 서울시 중구 <strong>충무로1가 21-1</strong>  예) '서울' 선택 후 '<strong>충무로1가</strong>(동명) <strong>21-1</strong>(지번)'</div>
			<div id="lvlBuild" style="display:none"><strong class="star">*</strong> 검색방법 : 서울시 중구 <strong>중앙우체국</strong> 예) '서울' 및 '중구' 선택 후 '<strong>중앙우체국</strong>(건물명)'</div>
			
			<table class="addr_chart" summary="주소검색 결과를 나타낸 결과 목록입니다">
				<caption>주소검색결과</caption>
				<tbody>
					<tr>
						<th>우편번호</th>
						<th>주소</th>
					</tr>
					<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
						<tr>
							<td><a href="#" onclick="fn_egov_return_Zip('${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.rdmn}', '${resultInfo.bdnbrMnno}<c:if test="${not empty resultInfo.bdnbrSlno and resultInfo.bdnbrSlno ne 0}">-${resultInfo.bdnbrSlno}</c:if>'); return false;"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></a></td>
							<td class="alL">
								<a href="#" onclick="fn_egov_return_Zip('${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.rdmn}', '${resultInfo.bdnbrMnno}<c:if test="${not empty resultInfo.bdnbrSlno and resultInfo.bdnbrSlno ne 0}">-${resultInfo.bdnbrSlno}</c:if>'); return false;"">
									<span class="blue">${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.rdmn} ${resultInfo.bdnbrMnno}<c:if test="${not empty resultInfo.bdnbrSlno and resultInfo.bdnbrSlno ne 0}">-${resultInfo.bdnbrSlno}</c:if> (${resultInfo.legalEmdNm}<c:if test="${not empty resultInfo.legalLeeNm}"> ${resultInfo.legalLeeNm}</c:if><c:if test="${not empty resultInfo.muchDlvrplcNm}">, ${resultInfo.muchDlvrplcNm}</c:if>)</span>
									<br/>
									${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.legalEmdNm}<c:if test="${not empty resultInfo.legalLeeNm}"> ${resultInfo.legalLeeNm}</c:if> ${resultInfo.lnbrMnno}<c:if test="${not empty resultInfo.lnbrSlno and resultInfo.lnbrSlno ne 0}">-${resultInfo.lnbrSlno}</c:if> ${resultInfo.muchDlvrplcNm}
								</a>
							</td>
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

		<button class="pop_mclose" onclick="window.close();">닫기</button>





 </body>
</html>
