<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>
<c:set var="grade" value="${userManageVO.grade }"/>
<c:choose>
	<c:when test="${grade eq 'general'}">
		<c:set var="grade" value="02"/>
	</c:when>
	<c:when test="${grade eq 'student'}">
		<c:set var="grade" value="06"/>
	</c:when>
	<c:when test="${grade eq 'lecture'}">
		<c:set var="grade" value="07"/>
	</c:when>
	<c:when test="${grade eq 'staff'}">
		<c:set var="grade" value="08"/>
	</c:when>
</c:choose>
<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="step" value="3"/>
</c:import>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

		function fnIdCheck(){
	    	var frm = document.userManageVO;
	    	var userId = frm.userId.value;
	    	if(!fnCheckUserIdLength(userId) || !fnCheckSpace(userId) || !fnCheckNotKorean(userId) || !(fnCheckEnglish(userId) && fnCheckDigit(userId) && !fnCheckTksu(userId))){
		    	alert("아이디는 띄어쓰기 없는 영문+숫자 조합 8~20자 내에서 입력해야 합니다.");
		    } else {
		        var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do?checkId=" + encodeURIComponent(userId) + "'/>";
		        window.open(url, 'IdCheck', 'menu=no, scrollbars=yes, width=500,height=350');
		    }
	    }	    

		function fnCheckUserIdLength(str) {
            if (str.length < 8 || str.length > 20 ){
                    return false;
            }
            return true;
        }
		
		function fnCheckSpace(str){
				for (var i=0; i < str .length; i++) {
				    ch_char = str .charAt(i);
				    ch = ch_char.charCodeAt();
				        if(ch == 32) {
				            return false;
				        }
				}
	    	    return true;
	    	}
		
		function fnCheckNotKorean(koreanStr){                  
    	    for(var i=0;i<koreanStr.length;i++){
    	        var koreanChar = koreanStr.charCodeAt(i);
    	        if( !( 0xAC00 <= koreanChar && koreanChar <= 0xD7A3 ) && !( 0x3131 <= koreanChar && koreanChar <= 0x318E ) ) { 
    	        }else{
    	            //hangul finding....
    	            return false;
    	        }
    	    }
    	    return true;
    	}
		
		function fnCheckTksu(str) { 
			for (var i=0; i < str .length; i++) {
			    ch_char = str .charAt(i);
			    ch = ch_char.charCodeAt();
			        if( !(ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126) ) {
			            
			        } else {
			        	return true;
			        }
			}
            return false;
            
        }
        
        function fnCheckEnglish(str){
       		for(var i=0;i<str.length;i++){
       			var EnglishChar = str.charCodeAt(i);
       			if( !( 0x61 <= EnglishChar && EnglishChar <= 0x7A ) && !( 0x41 <= EnglishChar && EnglishChar <= 0x5A ) ) {
       				
       			} else {
		        	return true;
		        }
       		}
       		return false;
       }
       
       function fnCheckDigit(str) {  
			for (var i=0; i < str .length; i++) {
			    ch_char = str .charAt(i);
			    iValue = parseInt(ch_char);
		        if(isNaN(iValue)) {
		           
		        } else {
		        	return true;
		        }
			}
            return false;
            
        }

		function fn_egov_return_IdCheck(userId) {
	    	var frm = document.userManageVO;
			frm.userId.value = userId;
	    }

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
			
			if(!fnCheckNotKorean(form.userId.value)){
		    	alert("아이디는 한글을 사용할 수 없습니다.");
		        return false;
		    }

			if(form.password.value != form.password2.value){
                alert("<spring:message code="fail.user.passwordUpdate2" />");
                return false;
            }
						
			if (!confirm('<spring:message code="common.regist.msg" />')) {
				return false;
			}
		}


		function inputDirectEmailDns(val){
		 	document.getElementById('email2').value = val;
		}
		
		function fn_egov_ZipSearch() {
			url = "/search/link/road.jsp"
			window.open(url, "result1122", "resizable=no, status=no, scrollbars=yes, toolbar=no, menubar=no,, width=440, height=420");
		};
		
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
					url:"${pageContext.request.contextPath}/uss/umt/cmm/selectSchool.do",
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
			<h2 class="icon1">회원정보입력</h2>
				<p class="mB20">회원가입을 위해 아래의 정보를 입력해 주십시오. <strong class="star">*</strong>표시는 필수 입력사항 입니다.</p>

				<h3 class="icon2">기본정보</h3>
				<form:form name="userManageVO" commandName="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserInsert.do" method="post" enctype="multipart/form-data" onsubmit="return checkForm(this);"> 
				<form:hidden path='credtId'/>
				<form:hidden path="userNm"/>				
				<form:hidden path='siteId'/>
				<form:hidden path='userSeCode' value="${grade }"/>
				<fieldset>
					<legend>회원가입 기본정보 입력폼 </legend>
					<table summary="회원가입 기본정보를 입력하는 폼입니다" class="join_chart">
							<caption>기본정보</caption>
							<colgroup>
								<col width="20%" />
								<col width="30%" />
								<col width="20%" />
								<col width="30%" />
							</colgroup>
							<tbody>
								<!--
								<tr>
									<th><strong class="star">*</strong>회원구분 선택</th>
									<td colspan="3">
										<%-- <form:hidden path='userSeCode'/> --%>
										
										<form:radiobutton id="userSeCode1" path="userSeCode" value="02" label="일반"/>&nbsp;
										<form:radiobutton id="userSeCode2" path="userSeCode" value="06" label="학생"/>&nbsp;
										<form:radiobutton id="userSeCode3" path="userSeCode" value="08" label="교직원"/>&nbsp;
										<form:radiobutton id="userSeCode4" path="userSeCode" value="07" label="강사"/> 
										강사<input type="radio" id="userSeCode" name="userSeCode" value="07">
										일반<input type="radio" id="userSeCode" name="userSeCode" value="02">
										학생<input type="radio" id="userSeCode" name="userSeCode" value="06">
										 
									</td>
								</tr>
								-->
								<tr>
									<th><strong class="star">*</strong> 이름</th>
									<td><c:out value="${userManageVO.userNm}"/></td>
									<th><strong class="star">*</strong> 생년월일 / 성별</th>
									<c:set var="brthdy1" value="${fn:substring(userManageVO.brthdy, 0,4)}"/>
									<c:set var="brthdy2" value="${fn:substring(userManageVO.brthdy, 4,6)}"/>
									<c:set var="brthdy3" value="${fn:substring(userManageVO.brthdy, 6,8)}"/>
									<td>${brthdy1}년 ${brthdy2}월 ${brthdy3}일(<c:out value="${userManageVO.sexdstn eq 1 ? '남' : '여'}"/>)</td>
								</tr>
								<tr>
									<th>
										<strong class="star">*</strong><label for="userId">회원 아이디</label>
									</th>
									<td colspan="3">
										<form:input path="userId" id="userId" cssClass="inp" maxlength="20"/> <a href="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do?checkId='/>" onclick="fnIdCheck();return false;" class="btn_s"><span>중복확인</span></a>
										<p>띄어쓰기 없는 영문+숫자 조합 8~20자</p>
									</td>
								</tr>
								<tr>
									<th>
										<strong class="star">*</strong> <label for="password">비밀번호</label>
									</th>
									<td colspan="3">
										<form:password path="password" id="password" cssClass="inp" maxlength="20" />
										<p>띄어쓰기 없는 영문+숫자 조합 10자~20자, 영문+숫자+특수문자조합 8~20자</p>
										<p>사용가능한 특수문자 : ! ” ! $ % & ’ ( ) * + , - . / : ; < > = ? @ [ \ ] ^ _ ` { | } ~</p>
									</td>
								</tr>
								<tr>
									<th>
										<strong class="star">*</strong><label for="password2">비밀번호 확인</label>
									</th>
									<td colspan="3">
										<form:password path="password2" id="password2" cssClass="inp" maxlength="20" />
										<p>비밀번호를 한번 더 입력해주세요</p>
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong> 자택 전화번호</th>
									<td colspan="3">
										<select id="tel1" name="tel1" title="국번선택">
											<option value="">국번</option>
											<option value="02">02</option>
											<option value="051">051</option>
											<option value="053">053</option>
											<option value="032">032</option>
											<option value="062">062</option>
											<option value="042">042</option>
											<option value="052">052</option>
											<option value="031">031</option>
											<option value="033">033</option>											
											<option value="041">041</option>
											<option value="043">043</option>
											<option value="044">044</option>
											<option value="063">063</option>
											<option value="061">061</option>
											<option value="054">054</option>
											<option value="055">055</option>
											<option value="064">064</option>
											<option value="070">070</option>
										</select>
										<input type="text" id="tel2" name="tel2" maxlength="4" class="inp tel" title="전화번호 앞자리 입력" />
										<input type="text" id="tel3" name="tel3" maxlength="4" class="inp tel" title="전화번호 뒷자리" />
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong>휴대 전화번호</th>
									<td colspan="3">
										<select id="phone1" name="phone1" title="휴대전화번호 선택">
											<option value="">국번</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										<input type="text" id="phone2" name="phone2" maxlength="4" class="inp tel" title="휴대전화번호 가운데자리 입력" />
										<input type="text" id="phone3" name="phone3" maxlength="4" class="inp tel" title="휴대전화번호 뒷자리 입력" />
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong><label for="email1">이메일 주소</label></th>
									<td colspan="3">
										<input type="text" class="inp email" id="email1" name="email1" maxlength="30" title="이메일아이디입력"/> @
										<input type="text" name="email2" id="email2" class="inp email" maxlength="70" title="이메일주소 직접입력" />
										<select id="email_choice" name="email_choice" onchange='inputDirectEmailDns(this.value);'>
											<option value="">직접입력</option>
											<option value="hanmail.net">다음</option>
											<option value="naver.com">네이버(naver.com)</option>
											<option value="nate.com">네이트(nate.com)</option>
											<option value="empal.com">엠파스</option>
											<option value="paran.com">파란(paran.com)</option>
											<option value="hanafos.com">하나포스(hanafos.com)</option>
											<option value="gmail.com">G메일(gmail.com)</option>
											<option value="kornet.net">코넷</option>
											<option value="korea.com">코리아닷컴(korea.com)</option>
											<option value="dreamwiz.com">드림위즈(dreamwiz.com)</option>
											<option value="lycos.co.kr">라이코스(lycos.co.kr)</option>
											<option value="chollian.net">천리안(chollian.net)</option>
											<option value="yahoo.co.kr">야후(yahoo.co.kr)</option>
											<option value="hotmail.com">핫메일(hotmail.com)</option>
										</select>
									</td>
								</tr>
								<tr>
									<th><strong class="star">*</strong>자택주소</th>
									<td colspan="3">
										<form:input path="zip" cssClass="inp zip" maxlength="7" title="우편번호 입력"/>
										<%-- <a href="<c:url value='/sym/cmm/EgovCcmRdnmZipSearchList.do'/>" target="_blank" onclick="window.open(this.href,'','height=600,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" class="btn_s"><span>우편번호 검색</span></a> <br /> --%>
										<a href="#" onkeypress="onclick" onclick="fn_egov_ZipSearch(); return false;" title="우편번호 찾기 새창" class="btn_s"><span>우편번호 검색</span></a> <br />
										<form:input path="adres" maxlength="100" cssClass="inp addr" title="주소입력" size="50px" />
										<form:input path="adresDetail" maxlength="100" cssClass="inp addr" title="상세주소입력" />
									</td>
								</tr>
							</tbody>
							</table>
							<br />
							<c:choose>
								<c:when test="${grade eq '02' }"></c:when>
								<c:when test="${grade eq '06' }">
									<div id="student">
										<h3 class="icon2">개별정보</h3>
										<table summary="학생들을 위한 추가 정보 테이블입니다." class="join_chart">
										<caption>개별정보 입력</caption>
										<colgroup>
											<col width="20%" />
											<col width="30%" />
											<col width="20%" />
											<col width="30%" />
										</colgroup>
										<tbody>
											<tr>
												<th><strong class="star">*</strong> 학생소속</th>
												<td>
													<select id="stTyCode" name="stTyCode" title="학교급 선택">
														<option value="">학교급선택</option>
														<option value="SCH01">초등학교</option>
														<option value="SCH02">중학교</option>
														<option value="SCH03">고등학교</option>
													</select>
												</td>
												<th><strong class="star">*</strong> 학교 선택</th>
												<td>
													<select id="stCode" name="stCode" title="학교선택">
														<option value="">학교선택</option>
														<c:forEach var="result" items="${resultList }" varStatus="status">
															<option value="${result.code }">${result.codeNm }</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<th><strong class="star">*</strong> 학년 선택</th>
												<td>
													<select id="stGrade" name="stGrade" title="학년 선택">
														<option value="">학년선택</option>
													</select>
												</td>
												<th><strong class="star">*</strong> 반 선택</th>
												<td>
													<select id="stClass" name="stClass" title="반 선택">
														<option value="">반 선택</option>
													</select>
													<!-- <input type="text" name="stClass" id="stClass" size="2" maxlength="2" />반 -->
												</td>
											</tr>
										</tbody>
										</table>
									</div>
								</c:when>
								<c:when test="${grade eq '07' }">
									<div id="lecture">
									<h3 class="icon2">개별정보</h3>
									<table summary="강사들을 위한 추가 정보 테이블입니다." class="join_chart">
									<caption>개별정보 입력</caption>
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="30%" />
									</colgroup>
									<tbody>
										<tr>
											<th><strong class="star">*</strong> 학력</th>
											<td colspan="3">
												<input type="text" id="lecAcdmcr" name="lecAcdmcr" /> 
											</td>
											
										</tr>
										<tr>
											<th><strong class="star">*</strong> 강의경력</th>
											<td colspan="3">
												<input type="text" id="lecCareer" name="lecCareer" />
											</td>
										</tr>
										<tr>
											<th><strong class="star">*</strong> 소개</th>
											<td colspan="3">
												<textarea rows="10" cols="70" name="lecInfo" ></textarea>
											</td>
										</tr>
									</tbody>
									</table>
									</div>
								</c:when>
								<c:when test="${grade eq '08' }">
									<div id="staff">
									<h3 class="icon2">개별정보</h3>
									<table summary="교직원들을 위한 추가 정보 테이블입니다." class="join_chart">
									<caption>개별정보 입력</caption>
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="30%" />
									</colgroup>
									<tbody>
										<tr>
											<th><strong class="star">*</strong> 학생소속</th>
											<td>
												<select id="stTyCode" name="stTyCode" title="학교급 선택">
													<option value="">학교급선택</option>
													<option value="SCH01">초등학교</option>
													<option value="SCH02">중학교</option>
													<option value="SCH03">고등학교</option>
												</select>
											</td>
											<th><strong class="star">*</strong> 학교 선택</th>
											<td>
												<select id="stCode" name="stCode" title="학교선택">
													<option value="">학교선택</option>
													<c:forEach var="result" items="${resultList }" varStatus="status">
														<option value="${result.code }">${result.codeNm }</option>
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
					</fieldset>
					<div class="btn_c">
						<span class="btn"><button type="submit">정보입력 완료</button></span>
						<span class="btn2"><button type="reset">취소</button></span>
					</div>

				</form:form>

<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>