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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link charset="utf-8" href="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/style.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" src="script.js"></script>
		<title>세종진로진학 취업지원센터 | 진로체험</title>
		<script type="text/javascript" src="${C_JS}/jquery/jquery-1.9.1.min.js"></script>	 
		<script src="${C_JS}/jquery.printElement.js"></script>
		<script type="text/javascript">
		<!--
		$(document).ready(function() {
			$("#printBtn").click(function() {
				printElem({
					printMode : "iframe",
					leveOpen : true
				});
			});
		});
		
		function printElem(options) {
			$("#print").printElement(options);
		}
		//-->
		</script>
	</head>

	 <body>
	 	<button id="printBtn">인쇄</button>
		<div id="print" style="color:#000;padding:15px;">
			<div class="certificate" style="padding:15px;border:2px solid #000;text-align:center;">
				<span class="num" style="display:block;margin-top:20px;font-size:16px;line-height:16px;text-align:left;">제 ${comtnprogrmtrgterVO.complNo }호</span>

				<h1 style="font-size:40px;line-height:40px;margin:30px 0;font-weight:bold;">수 료 증</h1>

				<div class="cont" style="padding:40px 0 20px;margin:0 auto;font-weight:bold;">
					<ul style="list-style:none;">
						<li style="overflow:hidden;font-size:14px;line-height:20px;margin:20px 0;"><span style="display:inline-block;width:30%;line-height:18px;height:20px;text-align:right;">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 &nbsp;&nbsp;&nbsp;: </span><strong style="display:inline-block;width:45%;padding-left:3%;font-weight:normal;line-height:18px;height:20px;text-align:left;">${comtnprogrmtrgterVO.adhrncNm }</strong></li>
						<li style="overflow:hidden;font-size:14px;line-height:20px;margin:20px 0;"><span style="display:inline-block;width:30%;line-height:18px;height:20px;text-align:right;">소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속 &nbsp;&nbsp;&nbsp;:</span><strong style="display:inline-block;width:45%;padding-left:3%;font-weight:normal;line-height:18px;height:20px;text-align:left;">${comtnprogrmtrgterVO.schulNm }</strong></li>
						<li style="overflow:hidden;font-size:14px;line-height:20px;margin:20px 0;"><span style="display:inline-block;width:30%;line-height:18px;height:20px;text-align:right;">프&nbsp;로&nbsp;그&nbsp;램 &nbsp;&nbsp;&nbsp;:</span><strong>${comtnprogrmVO.prgNm }</strong></li>
						<li style="overflow:hidden;font-size:14px;line-height:20px;margin:20px 0;"><span style="display:inline-block;width:30%;line-height:18px;height:20px;text-align:right;">기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;간 &nbsp;&nbsp;&nbsp;:</span>
							<strong style="display:inline-block;width:45%;padding-left:3%;font-weight:normal;line-height:18px;height:20px;text-align:left;">
								<fmt:parseDate var="operBgnde" value="${comtnprogrmVO.operBgnde }" pattern="yyyy-MM-dd"/>
							  	<fmt:parseDate var="operEndde" value="${comtnprogrmVO.operEndde }" pattern="yyyy-MM-dd"/>
							  	<fmt:formatDate value="${operBgnde }" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${operEndde}" pattern="yyyy년 MM월 dd일"/>
							</strong>
						</li>
					</ul>

					<p style="margin:30px auto;line-height:22px;text-align:center;">위 사람은 <fmt:formatDate value="${operBgnde }" pattern="yyyy년도 MM월 dd일"/> 부터 
					<fmt:formatDate value="${operEndde}" pattern="yyyy년 MM월 dd일"/>까지 실시된체험학습<br /> 프로그램을 성실히 수료하였음을 증명함.</p>
				</div>

				<div class="txt" style="display:block;margin:20px 0 30px;font-size:14px;font-weight:bold;">위의 사실을 증명 합니다</div>

				<span class="date" style="font-size:14px;">
					<fmt:parseDate var="complDe" value="${comtnprogrmtrgterVO.complDe }" pattern="yyyy-MM-dd"/>
					<fmt:formatDate value="${complDe }" pattern="yyyy년 MM월 dd일"/>
				</span>
				
				<div class="sign" style="height:100px;font-size:25px;line-height:28px;margin:10px 0;font-weight:bold;letter-spacing:-0.1em;"><span class="">${comtnprogrmVO.operInsttNm}  &nbsp;&nbsp;&nbsp;${comtnprogrmVO.operIstdrNm }</span> 
					<span class="dsign" style="margin-left:30px;width:100px;height:100px;display:inline-block;vertical-align:middle;background:#efefef;">
					<c:if test="${not empty comtnprogrmVO.operIstdrFileNm}"><img src="${ProgrmFileStoreWebPath}${siteInfo.siteId}/${comtnprogrmVO.operIstdrFileNm}" width="100" height="100" alt="${comtnprogrmVO.operIstdrNm } 직인"/></c:if>
					</span>
				</div>

			</div>
		</div>	
	 </body>
</html>