<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/member/images"/>

<c:import url="/msi/cmm/tmplatHead.do" charEncoding="utf-8">
	<c:param name="menuSeq" value="02"/>
</c:import>

    <div id="sub_content">
				<h2><img src="${_IMG}/login/tit_pw_re.gif" alt="비밀번호재발급" /></h2>
			
				<div class="id_box2">
					
		
							<div class="id_result_wrap">
								<div class="id_intro">
									<p><span>* 잠시후 SMS로 수신된 </span><span style="color:#8494a1;">임시 비밀번호</span><span>를 확인하신 후 로그인하시기 바랍니다.</span></p>
									<p><span>* 로그인하신 후 고객님께서 사용하실 비밀번호를 변경해 주시기 바랍니다.</span></p>
								</div>

								<div class="id_result"><span><c:out value="${resultInfo.name}"/>님의 휴대전화</span><span class="result_txt">(<c:out value="${resultInfo.mobileNo}"/>)</span><span>로 임시비밀번호를 발송하였습니다.</span></div>
									
								<div class="btn_id3">
									<a href="pw_re.html" class="btn2"><span>로그인</span></a>
								</div>
							</div>

				</div>
			</div>
			
<c:import url="/msi/cmm/tmplatBottom.do" charEncoding="utf-8"/>