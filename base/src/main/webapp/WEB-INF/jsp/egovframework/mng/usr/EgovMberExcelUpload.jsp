<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="_IMG" value="/template/member/images"/>
<c:set var="_CSS" value="/template/member/css"/>
<c:set var="C_JS" value="/template/common/js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="${_CSS}/login.css" type="text/css" charset="utf-8" /> 
  <style>
	.total{background:url('/template/common/images/page/board/icon_balloon.gif') 0 center no-repeat;padding-left:18px;font-size:11px;color:#999999;letter-spacing:-0.05em;margin-bottom:10px;}
	.chart_board{margin-top:30px;margin-bottom:50px;width:100%;border-collapse:collapse;color:#666666; background:url('/template/common/images/page/board/bg_board_tit2.gif') repeat-x 0 0;}
	.chart_board img {vertical-align:middle;}
	.chart_board thead th{ text-align:center; padding:10px 0; color:#657591; font-weight:bold; }
	.chart_board thead th.first{background:none;border-left:1px solid #e4e4e4;}
	.chart_board thead th.last{background:none;border-right:1px solid #e4e4e4;}
	.chart_board tbody td{background:none;border-bottom:1px dotted #cbcbcb;padding:5px 0; text-align:center;}
	.chart_board tbody td a{color:#666666;}
	.chart_board tbody td.tit{text-align:left}
	.chart_board tbody tr.deleted a{color:#dfdfdf;text-decoration: line-through;}
  	.org {color: #EE8342;font-size: 11px;
}
  </style>
  <script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>
<title>학생/교사 일괄등록</title>
<style type="text/css">
	body{background:none;}
</style>
<script type="text/javascript">

function fn_egov_regist() {
	if($('#siteId').val() == '') {
		alert('사이트(학교)가 선택되지 않았습니다. 창을 닫고 다시 시도해주세요');
		return false;
	}
	
	if($('#excelFile').val() == '') {
		alert('파일을 첨부해주세요');
		return false;
	}
	
	if($('#excelFile').val().toUpperCase().indexOf('.XLS') != -1 || $('#excelFile').val().toUpperCase().indexOf('.XLSX') != -1) {
		return true;
	} else {
		alert("파일형식이 올바르지 않습니다('.xls','.xlsx')");
		return false;
	}
}

</script>
</head>

 <body>

		<div class="pop_tit">
			<h1>학생/교사 일괄등록</h1>
		</div>

	
		<div class="pop_con">
			
			<form name="checkForm" action="<c:url value='/mng/usr/EgovMberExcelUpload.do'/>" method="post" enctype="multipart/form-data" onsubmit="return fn_egov_regist()">
				<input type="hidden" id="siteId"  name="siteId" value="<c:out value="${searchVO.siteId}"/>" />
				<fieldset>
					<legend>학생/교사 일괄등</legend>
					
					<div class="pop_gbox" style="width:100%;height:80px;background-color:#F6F7F8;background-image:none;background-repeat:repeat;margin-bottom:10px;margin-top:0px">
						
						<c:choose>
			                <c:when test="${empty message}">
			                	<div class="id_no">
									<p><span style="color:#ee8342;">엑셀파일을 첨부해주세요</span></p>
									<p>양식이 없으시면 하단 양식을 <a href="/template/manage/userSample.xls"><span style="color:#ee8342;">다운로드</span></a> 하시기바랍니다.</p>
									<p>엑셀의 첫번째 라인은 저장하지 않습니다. 양식대로 작성하여 올려주시기 바랍니다.</p>
								</div>
			                </c:when>
			                <c:otherwise>
			                	<div class="id_no">
									<p><span style="color:#ee8342;"><c:out value="${message}"/></span></p>
								</div>
								
								
			                </c:otherwise>
		                </c:choose>

					</div>
					
					<div class="id_chk" style="width:780px;">
						<span><a href="/template/manage/userSample.xls"><strong><img src="/template/manage/images/btn/xls.gif" style="text-align:center;"/> 양식</strong></a></span>
						<input type="file" class="inp" id="excelFile" name="excelFile"/>
						<span class="btn_s"><button type="submit">확인</button></span>					
							
					</div>
				
					<c:if test="${fn:length(dataList) > 0}">
						<table class="chart_board" summary="" >
							<caption class="hdn">결과 목록</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>학생(S)/교사(T)구분</th>
									<th>아이디</th>
									<th>비밀번호</th>
									<th>이름</th>
									<th>학년</th>
									<th>반</th>
									<th>번호</th>
									<th>이메일</th>
									<th>전화</th>
									<th>휴대폰</th>
									<th>우편번호</th>
									<th>기본주소</th>
									<th>상세주소</th>
									<th>메세지</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${dataList}" varStatus="status">
									<tr>
										<td><c:out value="${result.no}"/></td>
										<td><c:out value="${result.userSeCode}"/></td>
										<td><c:out value="${result.userId}"/></td>
										<td><c:out value="${result.password}"/></td>
										<td><c:out value="${result.userNm}"/></td>
										<td><c:out value="${result.stGrade}"/></td>
										<td><c:out value="${result.stClass}"/></td>
										<td><c:out value="${result.stNumber}"/></td>
										<td><c:out value="${result.emailAdres}"/></td>
										<td><c:out value="${result.tlphonNo}"/></td>
										<td><c:out value="${result.moblphonNo}"/></td>
										<td><c:out value="${result.zip}"/></td>
										<td><c:out value="${result.adres}"/></td>
										<td><c:out value="${result.adresDetail}"/></td>
										<td class="org"><c:out value="${result.message}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</fieldset>
			</form>
		</div>

		<button class="pop_mclose" onclick="window.close(); return false;">닫기</button>




 </body>
</html>
