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

		function fnShowId() {
			$('#idLabel').text('<c:out value="${searchVO.id}"/>');
		}
		
	</script>

    <div id="sub_content">
			
				<h2><img src="${_IMG}/login/tit_id.gif" alt="아이디 찾기- 아래의 사용자 확인 방법중 하나를 선택하여 회원가입 시 등록한 정보를 입력해주세요." /></h2>
			
				<!-- id id  start -->
				<div class="id_box2">
					
					<form action="">
						<fieldset>
							<legend>아이디찾기 폼</legend>
		
							<div class="id_result_wrap">
								<div class="id_intro">
									<p><span>* 개인정보 도용에 대한 피해방지를 위해</span><span style="color:#8494a1;">&nbsp;아이디의 앞 3자리를 제외한 나머지는 '*' 표시 처리 </span><span>합니다.</span></p>
									<p><span>* [아이디 전체 보기] 버튼을 클릭하여 아이디 뒷자리를 확인 할 수 있습니다.</span></p>
								</div>

								<div class="id_result"><span><c:out value="${searchVO.name}"/>님의 아이디는 </span><span class="result_txt" id="idLabel"><c:out value="${fn:substring(searchVO.id, 0,3)}"/><c:forEach begin="4" end="${fn:length(searchVO.id)}" step="1">*</c:forEach></span><span>입니다.</span></div>
									
								<div class="btn_id3">
									<span class="btn"><button type="button" onclick="fnShowId()">아이디 전체보기</button></span>
									<a href="<c:url value="/uat/uia/egovPasswordSearchView.do"/>" class="btn2"><span>비밀번호 찾기</span></a>
								</div>
							</div>
						</fieldset>
					</form>

				</div>
				<!-- //id id end -->

			</div>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>