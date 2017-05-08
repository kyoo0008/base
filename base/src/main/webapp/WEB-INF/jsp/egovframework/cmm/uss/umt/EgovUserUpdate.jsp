<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>" />
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>

<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="03"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
<%-- <c:if test="${not empty userSeCode}">
</c:if> --%>
<c:if test="${result}">
	alert("<c:out value="${message}"/>");
</c:if>

		function fn_egov_return_ZipCode(sZip, sAddr1, sAddr2, vAddr1, vAddr2) {
	    	var frm = document.userManageVO;
			frm.zip.value = sZip;
			frm.adres.value = sAddr1;
			frm.adresDetail.value = sAddr2;
	    }

		function changeEmail() {
			var frm = document.userManageVO;
			frm.emailBody.value = frm.emailSelect.value;
		}

		function checkForm(form) {
			
			if(!validateUserManageVO(form)){
	        	return false;
	        }
									
			if (!confirm('<spring:message code="common.update.msg" />')) {
				return false;
			}
		}


		function inputDirectEmailDns(val){
		 	document.getElementById('email2').value = val;
		}

			
		$(function(){
			$("select[name=stTyCode]").change(function(){
				var stTyCode = $(this).val();
				var stGrade = $("select[name=stGrade]");
				var stCode = $("select[name=stCode]");
				var stClass = $("select[name=stClass]");
				var stTyCodeDetail = stTyCode.substring(0,2);
				stGrade.children().remove();
				stCode.children().remove();
				stClass.children().remove();
				
				$.ajax({
					url:"/uss/umt/cmm/selectSchool.do",
					data:{"stTyCode":stTyCode},
					type:"GET",
					success:function(data) {
						stCode.html(data);
					} 
				});
				
				if(stTyCode == 'SCH01'){
					for(var i=1; i<=6; i++){
						stGrade.append("<option value='"+i+"'>"+i+"학년</option>");	
					}
				}else{
					for(var i=1; i<=3; i++){
						stGrade.append("<option value='"+i+"'>"+i+"학년</option>");	
					}
				}
				for(var i=1; i<=15; i++){
					stClass.append("<option value="+i+">"+i+"반</option>");
				}
			});
		});
	</script>

		<div id="sub_content">
			<h2><img src="${_IMG}/login/mb_tit.gif" alt="회원정보 변경" /></h2>
			
			<div class="mb_re_box2">

				<form:form name="userManageVO" commandName="userManageVO" action="${pageContext.request.contextPath}/uss/umt/cmm/EgovUserUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return checkForm(this);"> 
				<input type="hidden" name="userId" value="dummydummy"/><form:errors path="userId" />
				<input type="hidden" name="userNm" value="dummydummy"/><form:errors path="userNm" />
				<input type="hidden" name="password" value="dummydummy"/><form:errors path="password" />
				<fieldset>
					<legend>회원가입 기본정보 입력폼 </legend>
					<table summary="변경한  회원정보 내용을 나타낸 표입니다" class="chart2">
							<caption>111회원정보 변경 정보</caption>
							<tbody>
								
								<tr>
									<th>이름</th>
									<td><c:out value="${USER_INFO.name}"/> (<c:out value="${USER_INFO.id}"/>)</td>
								</tr>
								<tr>
									<th>생년월일 / 성별</th>
									<c:set var="brthdy1" value="${fn:substring(userManageVO.brthdy, 0,4)}"/>
									<c:set var="brthdy2" value="${fn:substring(userManageVO.brthdy, 4,6)}"/>
									<c:set var="brthdy3" value="${fn:substring(userManageVO.brthdy, 6,8)}"/>
									<td>${brthdy1}년 ${brthdy2}월 ${brthdy3}일(<c:out value="${userManageVO.sexdstn eq 1 ? '남' : '여'}"/>)</td>
								</tr>
								<tr>
									<th>자택 전화번호</th>
									<td>
										<c:set var="tlphonArr" value="${fn:split(userManageVO.tlphonNo, '-')}"/>
										<c:forEach items="${tlphonArr}" var="arr" varStatus="status">
											<c:if test="${status.count eq 1}"><c:set var="tel1" value="${fn:trim(arr)}"/></c:if>
											<c:if test="${status.count eq 2}"><c:set var="tel2" value="${fn:trim(arr)}"/></c:if>
											<c:if test="${status.count eq 3}"><c:set var="tel3" value="${fn:trim(arr)}"/></c:if>
										</c:forEach>
										<select id="tel1" name="tel1" title="국번선택">
											<option value="">국번</option>
											<option value="02" <c:if test="${tel1 eq '02'}"> selected="selected"</c:if>>02</option>
											<option value="051" <c:if test="${tel1 eq '051'}"> selected="selected"</c:if>>051</option>
											<option value="053" <c:if test="${tel1 eq '053'}"> selected="selected"</c:if>>053</option>
											<option value="032" <c:if test="${tel1 eq '032'}"> selected="selected"</c:if>>032</option>
											<option value="062" <c:if test="${tel1 eq '062'}"> selected="selected"</c:if>>062</option>
											<option value="042" <c:if test="${tel1 eq '042'}"> selected="selected"</c:if>>042</option>
											<option value="052" <c:if test="${tel1 eq '052'}"> selected="selected"</c:if>>052</option>
											<option value="031" <c:if test="${tel1 eq '031'}"> selected="selected"</c:if>>031</option>
											<option value="033" <c:if test="${tel1 eq '033'}"> selected="selected"</c:if>>033</option>											
											<option value="041" <c:if test="${tel1 eq '041'}"> selected="selected"</c:if>>041</option>
											<option value="043" <c:if test="${tel1 eq '043'}"> selected="selected"</c:if>>043</option>
											<option value="044" <c:if test="${tel1 eq '044'}"> selected="selected"</c:if>>044</option>
											<option value="063" <c:if test="${tel1 eq '063'}"> selected="selected"</c:if>>063</option>
											<option value="061" <c:if test="${tel1 eq '061'}"> selected="selected"</c:if>>061</option>
											<option value="054" <c:if test="${tel1 eq '054'}"> selected="selected"</c:if>>054</option>
											<option value="055" <c:if test="${tel1 eq '055'}"> selected="selected"</c:if>>055</option>
											<option value="064" <c:if test="${tel1 eq '064'}"> selected="selected"</c:if>>064</option>
											<option value="070" <c:if test="${tel1 eq '070'}"> selected="selected"</c:if>>070</option>
										</select>
										<input type="text" id="tel2" name="tel2" value="${tel2}" maxlength="4" class="inp tel" title="전화번호 앞자리 입력" />
										<input type="text" id="tel3" name="tel3" value="${tel3}" maxlength="4" class="inp tel" title="전화번호 뒷자리" />
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong>휴대 전화번호</th>
									<td>
										<c:set var="moblArr" value="${fn:split(userManageVO.moblphonNo, '-')}"/>
										<c:forEach items="${moblArr}" var="arr" varStatus="status">
											<c:if test="${status.count eq 1}"><c:set var="phone1" value="${fn:trim(arr)}"/></c:if>
											<c:if test="${status.count eq 2}"><c:set var="phone2" value="${fn:trim(arr)}"/></c:if>
											<c:if test="${status.count eq 3}"><c:set var="phone3" value="${fn:trim(arr)}"/></c:if>
										</c:forEach>
										<select id="phone1" name="phone1" title="휴대전화번호 선택">
											<option value="">국번</option>
											<option value="010" <c:if test="${phone1 eq '010'}"> selected="selected"</c:if>>010</option>
											<option value="011" <c:if test="${phone1 eq '011'}"> selected="selected"</c:if>>011</option>
											<option value="016" <c:if test="${phone1 eq '016'}"> selected="selected"</c:if>>016</option>
											<option value="017" <c:if test="${phone1 eq '017'}"> selected="selected"</c:if>>017</option>
											<option value="018" <c:if test="${phone1 eq '018'}"> selected="selected"</c:if>>018</option>
											<option value="019" <c:if test="${phone1 eq '019'}"> selected="selected"</c:if>>019</option>
										</select>
										<input type="text" id="phone2" name="phone2" value="${phone2}" maxlength="4" class="inp tel" title="휴대전화번호 가운데자리 입력" />
										<input type="text" id="phone3" name="phone3" value="${phone3}" maxlength="4" class="inp tel" title="휴대전화번호 뒷자리 입력" />
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong><label for="email1">이메일 주소</label></th>
									<td>
										<c:set var="emailArr" value="${fn:split(userManageVO.emailAdres, '@')}"/>
										<c:forEach items="${emailArr}" var="arr" varStatus="status">
											<c:if test="${status.count eq 1}">
												<c:set var="emailHead" value="${fn:trim(arr)}"/>
											</c:if>
											<c:if test="${status.count eq 2}">
												<c:set var="emailBody" value="${fn:trim(arr)}"/>
											</c:if>
										</c:forEach>
										<input type="text" class="inp email" id="email1" name="email1" value="${emailHead}" maxlength="30"/> @
										<select id="email_choice" name="email_choice" onchange='inputDirectEmailDns(this.value);'>
											<option value="">직접입력</option>
											<option value="hanmail.net"	<c:if test="${emailBody eq 'hanmail.net'}"> selected="selected"</c:if>>다음</option>
												<option value="naver.com"	<c:if test="${emailBody eq 'naver.com'}"> selected="selected"</c:if>>네이버(naver.com)</option>
												<option value="nate.com"	<c:if test="${emailBody eq 'nate.com'}"> selected="selected"</c:if>>네이트(nate.com)</option>
												<option value="empal.com"	<c:if test="${emailBody eq 'empal.com'}"> selected="selected"</c:if>>엠파스</option>
												<option value="paran.com"	<c:if test="${emailBody eq 'paran.com'}"> selected="selected"</c:if>>파란(paran.com)</option>
												<option value="hanafos.com"	<c:if test="${emailBody eq 'hanafos.com'}"> selected="selected"</c:if>>하나포스(hanafos.com)</option>
												<option value="gmail.com"	<c:if test="${emailBody eq 'gmail.com'}"> selected="selected"</c:if>>G메일(gmail.com)</option>
												<option value="kornet.net"	<c:if test="${emailBody eq 'kornet.net'}"> selected="selected"</c:if>>코넷</option>
												<option value="korea.com"	<c:if test="${emailBody eq 'korea.com'}"> selected="selected"</c:if>>코리아닷컴(korea.com)</option>
												<option value="dreamwiz.com"	<c:if test="${emailBody eq 'dreamwiz.com'}"> selected="selected"</c:if>>드림위즈(dreamwiz.com)</option>
												<option value="lycos.co.kr"	<c:if test="${emailBody eq 'lycos.co.kr'}"> selected="selected"</c:if>>라이코스(lycos.co.kr)</option>
												<option value="chollian.net"	<c:if test="${emailBody eq 'chollian.net'}"> selected="selected"</c:if>>천리안(chollian.net)</option>
												<option value="yahoo.co.kr"	<c:if test="${emailBody eq 'yahoo.co.kr'}"> selected="selected"</c:if>>야후(yahoo.co.kr)</option>
												<option value="hotmail.com"	<c:if test="${emailBody eq 'hotmail.com'}"> selected="selected"</c:if>>핫메일(hotmail.com)</option>
										</select>
										<input type="text" name="email2" id="email2" value="${emailBody}" class="inp email" maxlength="70" title="이메일주소 직접입력" />
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong>자택주소</th>
									<td>
										<form:input path="zip" cssClass="inp zip" maxlength="6" title="우편번호 입력"/>
										<a href="<c:url value='/sym/cmm/EgovCcmRdnmZipSearchList.do'/>" target="_blank" onclick="window.open(this.href,'','height=600,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" class="btn_s"><span>우편번호 검색</span></a> <br />
										<form:input path="adres" maxlength="100" cssClass="inp addr" title="주소입력" />
										<form:input path="adresDetail" maxlength="100" cssClass="inp addr" title="상세주소입력" />
									</td>
								</tr>
							</tbody>
							</table>
					</fieldset>
					<%-- </br />
					==초,중,고::${userManageVO.stTyCode }==<br />
					==학교CODE::${userManageVO.stCode }==<br />
					==학년CODE::${userManageVO.stGrade }==<br />
					==반CODE::${userManageVO.stClass }==<br />
					==강사소개::${userManageVO.lecInfo }==<br /> --%>
					
					<c:choose>
						<c:when test="${userManageVO.userSeCode eq '02' }"></c:when>
						<c:when test="${userManageVO.userSeCode eq '06' }">
							<div id="student">
								<h3 class="icon2">개별정보</h3>
								<table summary="학생들을 위한 추가 정보 테이블입니다." class="chart2 rechart">
								<caption>개별정보 입력</caption>
								<tbody>
									<tr>
										<th><strong class="star">*</strong> 학생소속</th>
										<td>
											<select id="stTyCode" name="stTyCode" title="학교급 선택">
												<option value="">학교급선택</option>
												<option value="SCH01" <c:if test="${userManageVO.stTyCode eq 'SCH01'}"> selected="selected"</c:if>>초등학교</option>
												<option value="SCH02" <c:if test="${userManageVO.stTyCode eq 'SCH02'}"> selected="selected"</c:if>>중학교</option>
												<option value="SCH03" <c:if test="${userManageVO.stTyCode eq 'SCH03'}"> selected="selected"</c:if>>고등학교</option>
											</select>
										</td>
										<th><strong class="star">*</strong> 학교 선택</th>
										<td>
											<select id="stCode" name="stCode" title="학교선택">
												<option value="">학교선택</option>
												<c:forEach var="result" items="${resultList }" varStatus="status">
													<option value="${result.code }" <c:if test="${userManageVO.stCode eq result.code}"> selected="selected"</c:if>>${result.codeNm }</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th><strong class="star">*</strong> 학년 선택</th>
										<td>
											<select id="stGrade" name="stGrade" title="학년 선택">
												<option value="">학년선택</option>
												<c:choose>
													<c:when test="${userManageVO.stTyCode eq 'SCH01'}">
														<c:forEach var="i" step="1" begin="1" end="6">
															<option value="${i}" <c:if test="${userManageVO.stGrade eq i}" > selected="selected"</c:if>>${i}학년</option>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<c:forEach var="i" step="1" begin="1" end="3">
															<option value="${i}" <c:if test="${userManageVO.stGrade eq i}" > selected="selected"</c:if>>${i}학년</option>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</select>
										</td>
										<th><strong class="star">*</strong> 반 선택</th>
										<td>
											<select id="stClass" name="stClass" title="반 선택">
												<option value="">반 선택</option>
												<c:forEach var="i" begin="1" end="15" step="1">
													<option value="${i}" <c:if test="${userManageVO.stClass eq i }"> selected="selected"</c:if>>${i }반</option>
												</c:forEach>
											</select>
											<!-- <input type="text" name="stClass" id="stClass" size="2" maxlength="2" />반 -->
										</td>
									</tr>
								</tbody>
								</table>
							</div>
						</c:when>
						<c:when test="${userManageVO.userSeCode eq '07' }">
							<div id="lecture">
							<h3 class="icon2">개별정보</h3>
							<table summary="강사들을 위한 추가 정보 테이블입니다." class="chart2 rechart">
							<caption>개별정보 입력</caption>
							<tbody>
								<tr>
									<th><strong class="star">*</strong> 학력</th>
									<td>
										<input type="text" id="lecAcdmcr" name="lecAcdmcr"  value="${userManageVO.lecAcdmcr }"/> 
									</td>
									
								</tr>
								<tr>
									<th><strong class="star">*</strong> 강의경력</th>
									<td>
										<input type="text" id="lecCareer" name="lecCareer" value="${userManageVO.lecCareer }"/>
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong> 소개</th>
									<td>
										<textarea name="lecInfo">${userManageVO.lecInfo }</textarea>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</c:when>
						<c:when test="${userManageVO.userSeCode eq '08' }">
							<div id="staff">
							<h3 class="icon2">개별정보</h3>
							<table summary="교직원들을 위한 추가 정보 테이블입니다." class="chart2 rechart">
							<caption>개별정보 입력</caption>
							<tbody>
								<tr>
									<th><strong class="star">*</strong> 학생소속</th>
									<td>
										<select id="stTyCode" name="stTyCode" title="학교급 선택">
											<option value="">학교급선택</option>
											<option value="SCH01" <c:if test="${userManageVO.stTyCode eq 'SCH01'}"> selected="selected"</c:if>>초등학교</option>
											<option value="SCH02" <c:if test="${userManageVO.stTyCode eq 'SCH02'}"> selected="selected"</c:if>>중학교</option>
											<option value="SCH03" <c:if test="${userManageVO.stTyCode eq 'SCH03'}"> selected="selected"</c:if>>고등학교</option>
										</select>
									</td>
									<th><strong class="star">*</strong> 학교 선택</th>
									<td>
										<select id="stCode" name="stCode" title="학교선택">
											<option value="">학교선택</option>
											<c:forEach var="result" items="${resultList }" varStatus="status">
												<option value="${result.code }" <c:if test="${userManageVO.stCode eq result.code}"> selected="selected"</c:if>>${result.codeNm }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<div class="btn_c">
						<span class="btn"><button type="submit">정보입력 완료</button></span>
						<span class="btn2"><button type="reset">취소</button></span>
					</div>
				</form:form>
			</div>
		</div>

<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>