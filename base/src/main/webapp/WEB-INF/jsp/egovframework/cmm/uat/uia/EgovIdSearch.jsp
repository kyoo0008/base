<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>

<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="01"/>
</c:import>

	<script type="text/javascript">

		<c:if test="${not empty message}">
			alert("<c:out value="${message}"/>");
		</c:if>

		function fnSearchId(form) {
			
			if ($('#name').val() =="") {
				alert("이름을 입력하세요");
				return false;
			}
			
			if($('#phone1').val() != "" && $('#phone2').val() != "" && $('#phone3').val() != ""){
				$('#mobileNo').val($('#phone1').val() + "-" + $('#phone2').val() + "-" + $('#phone3').val());
			}
			
			if($('#email1').val() != "" && $('#email2').val() != ""){
				$('#email').val($('#email1').val() + "@" + $('#email2').val());
			}
			
			if ($('input[id=findSeMobileNo]:checked').is(':checked')) {
				if ($('#mobileNo').val() == "") {
					alert("핸드폰 번호를 입력하세요");
					return false;
				}
			}
			
			if ($('input[id=findSeEmail]:checked').is(':checked')) {
				if ($('#email').val() == "") {
					alert("이메일주소를 입력하세요");
					return false;
				}
			}

		}
		
		function inputDirectEmailDns(val){
			$('#email2').val(val);
		}

		$(document).ready(function(){
			$('#findSeMobileNo').click(function() {
				$('#phoneSearch').show();
				$('#emailSearch').hide();
			});
			
			$('#findSeEmail').click(function() {
				$('#phoneSearch').hide();
				$('#emailSearch').show();
			});
		});
	</script>

    <div id="sub_content">
				
				<h2><img src="${_IMG}/login/tit_id.gif" alt="아이디 찾기- 아래의 사용자 확인 방법중 하나를 선택하여 회원가입 시 등록한 정보를 입력해주세요." /></h2>
			
				<!-- id id  start -->
				<div class="id_box">
					
					<form action="${pageContext.request.contextPath}/uat/uia/egovIdSearch.do" method="post" onsubmit="return fnSearchId(this);">
						<input type="hidden" id="mobileNo" name="mobileNo"/>
						<input type="hidden" id="email" name="email"/>
						<fieldset>
							<legend>아이디찾기 폼</legend>

								<div class="id_inp_wrap">
									<div class="id_chk">
										<div class="section1">
											<span><input type="radio" id="findSeMobileNo" name="findSe" checked="checked" value="mobileNo" /><label for="findSeMobileNo"> 이름 + 휴대폰/전화번호</label></span>
											<span class="right"><input type="radio" id="findSeEmail" name="findSe" value="email" /><label for="findSeEmail"> 이름 + 이메일</label></span>
										</div>

										<div class="section2">
											<span><input type="radio" id="userSeCode06" name="userSeCode" value="06" checked="checked"/><label for="userSeCode06"> 학생</label></span>
											<span><input type="radio" id="userSeCode08" name="userSeCode" value="08"/><label for="userSeCode08"> 교원</label></span>
											<span class="right"><input type="radio" id="userSeCode02" name="userSeCode" value="02"  /><label for="userSeCode02"> 지역주민/보호자</label></span>
										</div>
									</div>

									<div class="id_inp">
										<span>
											<label for="name">이름</label>
											<input type="text" class="inp name" id="name" name="name" />
										</span>
										<span id="phoneSearch">
											<strong class="">연락처</strong>
											<select id="phone1" name="phone1" title="휴대전화번호 선택">
												<option value="">국번</option>
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											<input type="text" id="phone2" name="phone2" class="inp tel" title="휴대전화번호 가운데자리 입력" />
											<input type="text" id="phone3" name="phone3" class="inp tel" title="휴대전화번호 뒷자리 입력" />
										</span>
										
										<span id="emailSearch" style="display:none">
											<strong class="">이메일</strong>
											<input type="text" class="inp email" id="email1" name="email1" maxlength="30" title="이메일아이디입력"/> @
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
											<input type="text" name="email2" id="email2" class="inp email" maxlength="70" title="이메일주소 직접입력" />
										</span>
									</div>
								</div>
									
								<div class="btn_id">
									<input type="image" src="${_IMG}/login/btn_confirm.gif" alt="확인" />
								</div>
				
						</fieldset>
					</form>

				</div>
				<!-- //id id end -->
			</div>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>