<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images"/>
<c:set var="_CSS" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}"/>
<c:set var="C_JS" value="${_WEB_FULL_PATH}/template/common/js"/>
<c:set var="SE_CODE" value="01" />
<c:if test="${not empty USER_INFO.id}">
	<c:set var="SE_CODE" value="${USER_INFO.userSe}" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>	 
	<title>체험프로그램 신청</title>
	<c:if test="${not empty message }">
	<script type="text/javascript">
	alert("${message}");
	</script>
	</c:if>
	<script type="text/javascript">
	<!--
	$(document).ready(function() {
		$("#prgBtn").click(function() {
			
			if(confirm('본 체험프로그램에 참가하시겠습니까?')) {
				return true;
			}else {
				return false;
			}
			return false;
		});
		
		$("#closeBtn").click(function() {
			window.close();
			return false;
		});
	});
	//-->
	</script>
	
	<c:if test="${comtnprogrmtrgterVO.reqstTyCode eq 'ORG' }">
	<script type="text/javascript">	
	<!--
	$(document).ready(function() {
		$("#schTySelect").change(function() {
			var tyCode = $(this).val(); 
			
			if(tyCode == "") {
				$("#schSelect").html("<option>학교선택</option>");
			}else {
				$("#schGrade").html("");
				$("#schGrade").prepend("<option value=''>학년선택</option>");
				if(tyCode == "SCH01") {					
					for(var i = 1; i <=6; i++) {
						$("#schGrade").append("<option value='" + i + "'>" + i + "</option>");
					}
				}else if(tyCode == "SCH02") {
					for(var i = 1; i <=3; i++) {
						$("#schGrade").append("<option value='" + i + "'>" + i + "</option>");
					}
				}else if(tyCode == "SCH03") {
					for(var i = 1; i <=3; i++) {
						$("#schGrade").append("<option value='" + i + "'>" + i + "</option>");
					}
				}
				
				$("#schClass").html("");
				$("#schClass").prepend("<option value=''>반선택</option>");
				for(var i = 1; i <=15; i++) {
					$("#schClass").append("<option value='" + i + "'>" + i + "</option>");
				}
				
				$.ajax({
					url:"/prg/dat/schoolList.do",
					data:{"stTyCode":$("#schTySelect").val()},
					type:"GET",
					success:function(data) {
						$("#schSelect").html(data);
					}
				});
			}
		});
		
		$("#selectBtn").click(function() {
			$.ajax({
				url:"/prg/dat/schoolMemberList.do",
				data:{"stCode":$("#schSelect").val(),"stGrade":$("#schGrade").val(),"stClass":$("#schClass").val()},
				type:"GET",
				success:function(data) {
					$("#stdList").html(data);
					
					$(".userBtn").click(function() {
						if( $(this).hasClass("icon_del") ) {
							$(this).removeClass("icon_del");
							$(this).addClass("icon_add");
							$(this).parent().css('color','#cfcfcf');
							$(this).children(".uId").attr("name", "delUserId");	
						}else if($(this).hasClass("icon_add") ) {
							$(this).removeClass("icon_add");
							$(this).addClass("icon_del");
							$(this).parent().css('color','#666666');
							$(this).children(".uId").attr("name", "userId");	
						}
						
					});
					/*
					$(".userBtn").click(function() {
						
					});
					*/
				}
			});
			return false;			
		});
		
		$("#saveBtn").click(function() {
			var stdCnt = $("#stdList input[name=userId]").length;
			if(stdCnt == 0) {
				alert("학생 목록이 없습니다.");
				return false;
			}
			var rstCnt = ${comtnprogrmVO.trgterCnt} + stdCnt;
			var limitCnt = ${comtnprogrmVO.psncpaNmpr};
			if(rstCnt > limitCnt){
				alert("정원수"  + (rstCnt - limitCnt) +"명 초과하였습니다.\n" + 
					  "현재 이프로그램은 최대"+ (limitCnt - <c:out value='${comtnprogrmVO.trgterCnt}'/>) + "명까지 신청가능합니다.");
				return false;
			}
			
			if(confirm("본 프로그램에 " + stdCnt + "명의 학생을 참가 시키겠습니까?")) {
				return true;
			}
			return false;
		});
				
	});
	
	
	//-->
	</script>
	</c:if>
</head>
<body>

<div id="pop_page">
	<div class="pop_top">
		<h1>프로그램신청</h1>
	</div>
	<div class="pop_cont">
		<c:choose>
		<c:when test="${comtnprogrmtrgterVO.reqstTyCode eq 'PER' }">
			<%-- 개인 신청 --%>
			<form:form commandName="comtnprogrmtrgterVO" name="detailForm" id="detailForm" action="/prg/addComtnprogrmtrgterPer.do">
				<form:hidden path="prgId"/>
				<form:hidden path="reqstTyCode"/>
				<div id="pbbs_wrap">
					<div class="info">
						<table class="list_table" summary="신청정보" >
						<tbody>
							<tr>
								<th>학교</th>
								<td colspan="3">${userManageVO.stName }</td>
							</tr>
							<tr>
								<th>학년</th>
								<td>${empty userManageVO.stGrade?"<strong class='warning'>학년 정보가 없습니다.</strong>":userManageVO.stGrade }</td>
								<th>반</th>
								<td>${empty userManageVO.stClass?"<strong class='warning'>반 정보가 없습니다.</strong>":userManageVO.stClass }</td>
							</tr>
							<tr>
								<th>신청자명</th>
								<td colspan="3">${userManageVO.userNm }</td>
							</tr>
						</tbody>
						</table>
					</div>
					<button type="submit" id="prgBtn">프로그램 신청</button>
					<button id="closeBtn">취소</button>
				</div>
			</form:form>
		</c:when>
		<c:otherwise>
			<%-- 단체 신청 --%>
			<form:form commandName="comtnprogrmtrgterVO" name="detailForm" id="detailForm" action="/prg/addComtnprogrmtrgterOrg.do">
				<form:hidden path="prgId"/>
				<form:hidden path="reqstTyCode"/>
				<c:url var="orgRequestUrl" value="/prg/addComtnprogrmtrgterView.do">
				 </c:url>
				<div class="choice_box">
					<div class="choice_select">
						<h2>소속선택</h2>
						<select id="schTySelect" title="학교급선택">
							<option value="">학교급선택</option>
							<option value="SCH01">초등학교</option>
							<option value="SCH02">중학교</option>
							<option value="SCH03">고등학교</option>
						</select>
						<select id="schSelect" title="학교선택">
							<option>학교선택</option>
						</select>
						<select id="schGrade" title="학년선택">
							<option value=''>학년선택</option>				
						</select>
						<select id="schClass" title="반선택">
							<option value=''>반선택</option>																	
						</select>
					
						<span class="btn_b"><button id="selectBtn">선택완료</button></span> 
					</div>
					
					
					<div class="name_list">
						<h2>학생리스트</h2>
						<ul id="stdList">
							<li>검색이 필요합니다.</li>														
						</ul>
						<%-- <li>김철수 <span class="icon_del"><a href=""> 삭제</a></span></li>		 --%>
					</div>
				</div>
	
				<div class="btn_c">
					<span class="bbtn_bg1"><button type="submit" id="saveBtn">확인</button></span>
					<span class="bbtn_bg2"><a href="" onclick="window.close();">취소</a></span> 
				</div>
			</form:form>	
		</c:otherwise>
		</c:choose>		
	</div>
	
	
<%-- 	<form:form commandName="comtnprogrmtrgterVO" name="detailForm" id="detailForm" >
	<!-- 검색조건 유지 -->
	<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
	
	
		<tr>
			<th>PRG_ID</th>
			<td>
				<form:input path="prgId" cssClass="txt"/>
				&nbsp;<form:errors path="prgId" />
			</td>
		</tr>	
		<tr>
			<th>USER_ID</th>
			<td>
				<form:input path="userId" cssClass="txt"/>
				&nbsp;<form:errors path="userId" />
			</td>
		</tr>	
		<tr>
			<th>REQST_TY_CODE</th>
			<td>
				<form:input path="reqstTyCode" cssClass="txt"/>
				&nbsp;<form:errors path="reqstTyCode" />
			</td>
		</tr>	
		<tr>
			<th>SCHUL_NM</th>
			<td>
				<form:input path="schulNm" cssClass="txt"/>
				&nbsp;<form:errors path="schulNm" />
			</td>
		</tr>	
		<tr>
			<th>GRADE</th>
			<td>
				<form:input path="grade" cssClass="txt"/>
				&nbsp;<form:errors path="grade" />
			</td>
		</tr>	
		<tr>
			<th>GRADE_CLAS</th>
			<td>
				<form:input path="gradeClas" cssClass="txt"/>
				&nbsp;<form:errors path="gradeClas" />
			</td>
		</tr>	
		<tr>
			<th>ADHRNC_NM</th>
			<td>
				<form:input path="adhrncNm" cssClass="txt"/>
				&nbsp;<form:errors path="adhrncNm" />
			</td>
		</tr>	
		<tr>
			<th>PRTCTOR_NM</th>
			<td>
				<form:input path="prtctorNm" cssClass="txt"/>
				&nbsp;<form:errors path="prtctorNm" />
			</td>
		</tr>	
		<tr>
			<th>TLPHON_NO</th>
			<td>
				<form:input path="tlphonNo" cssClass="txt"/>
				&nbsp;<form:errors path="tlphonNo" />
			</td>
		</tr>	
		<tr>
			<th>REPRT_CN</th>
			<td>
				<form:input path="reprtCn" cssClass="txt"/>
				&nbsp;<form:errors path="reprtCn" />
			</td>
		</tr>	
		<tr>
			<th>COMPL_AT</th>
			<td>
				<form:input path="complAt" cssClass="txt"/>
				&nbsp;<form:errors path="complAt" />
			</td>
		</tr>	
		<tr>
			<th>FRST_REGISTER_PNTTM</th>
			<td>
				<form:input path="frstRegisterPnttm" cssClass="txt"/>
				&nbsp;<form:errors path="frstRegisterPnttm" />
			</td>
		</tr>	
		<tr>
			<th>FRST_REGISTER_ID</th>
			<td>
				<form:input path="frstRegisterId" cssClass="txt"/>
				&nbsp;<form:errors path="frstRegisterId" />
			</td>
		</tr>	
		<tr>
			<th>LAST_UPDUSR_PNTTM</th>
			<td>
				<form:input path="lastUpdusrPnttm" cssClass="txt"/>
				&nbsp;<form:errors path="lastUpdusrPnttm" />
			</td>
		</tr>	
		<tr>
			<th>LAST_UPDUSR_ID</th>
			<td>
				<form:input path="lastUpdusrId" cssClass="txt"/>
				&nbsp;<form:errors path="lastUpdusrId" />
			</td>
		</tr>	
	</table>

	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("detailForm").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
	</form:form> --%>
</div>


</body>
</html>

