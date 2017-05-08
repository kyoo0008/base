<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="MNG_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MBER_MANAGE"/>
	<c:param name="depth1" value="MBER_MANAGE"/>
	<c:param name="depth2" value="MBER_MANAGE"/>
	<c:param name="validator" value="userManageVO"/>
</c:import>	

<style type="text/css">
	.btn_w{float:left;margin-left:5px;}
	.out{overflow:hidden;width:100%;}
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/ajaxtags/js/prototype.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ajaxtags/js/scriptaculous/scriptaculous.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ajaxtags/js/overlibmws/overlibmws.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ajaxtags/js/ajaxtags.js"></script>

<c:set var="registerFlag" value="${empty userManageVO.userId ? '등록' : '수정'}"/>

<script type="text/javascript">

<c:if test='${not empty message}'>
alert("${message}");
</c:if>



	    function fnIdRcomd(){
	    	var frm = document.userManageVO;
	        var url = "<c:url value='/uss/umt/cmm/EgovIdRecomendCnfirmView.do'/>";
	        window.open(url, 'RcomdIdCheck', 'menu=no, scrollbars=yes, width=420,height=300');
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

		function fn_egov_return_IdCheck(userId) {
	    	var frm = document.userManageVO;
			frm.userId.value = userId;
	    }

		function fn_egov_return_RcomdCheck(rcomdId) {
	    	var frm = document.userManageVO;
			frm.recomendId.value = rcomdId;
	    }
	    
		function fn_egov_select_noticeList() {
			document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
			document.board.submit();	
		}

		function fn_egov_ZipSearch() {
	    	
	    	var url = "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>";
	    	window.open(url, 'zip', 'height=600,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');
	    }

		/*
		function fn_egov_return_ZipCode(sZip, sAddr, vAddr1, vAddr2) {
	    	var frm = document.userManageVO;
			frm.zip.value = sZip;
			frm.adres.value = sAddr;

			frm.zip1.value = vAddr1;
			frm.zip2.value = vAddr2;
	    }
		*/
		function fn_egov_return_ZipCode(sZip, sAddr1, sAddr2, vAddr1, vAddr2) {
	    	var frm = document.userManageVO;
			frm.zip.value = sZip;
			frm.adres.value = sAddr1;
			frm.adresDetail.value = sAddr2;
	    }

		function inputDirectEmailDns(val){
		 	document.getElementById('email2').value = val;
		}

		function checkForm(form) {	
			 
			if(!validateUserManageVO(form)) {				
				return false;
			}
 			
 			
			form.brthdy.value = trim(form.brthdy1.value) + trim(form.brthdy2.value)+ trim(form.brthdy3.value);
			
			<c:choose>
			<c:when test="${registerFlag == '수정'}">
			if(confirm('<spring:message code="common.update.msg" />')) {
			</c:when>
			<c:otherwise>
			if(confirm('<spring:message code="common.regist.msg" />')) {
			</c:otherwise>
			</c:choose>
				return true;
			}else {
				return false;
			}
		}

		function sendPassword() {
		    if(confirm("비밀번호를 재발급하고 "+document.userManageVO.moblphonNo.value+"번호로 전송 하시겠습니까?")) {
		        document.userManageVO.action = "${pageContext.request.contextPath}/mng/usr/SendPassword.do";
		        document.userManageVO.target = "passSand";
		        return true;
		    }else{
		    	return false;
			}
		}
		
	</script>
<div id="cntnts">

	<form:form commandName="userManageVO" name="userManageVO" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/mng/usr/EgovUserSelectUpdt.do"> 
	<input type='hidden' name='targetId' value="<c:out value="${userManageVO.userId}"/>"/>
	<input type='hidden' name='credtId' value="<c:out value="${userManageVO.credtId}"/>"/>
	<input type="hidden" name="searchSe" value="<c:out value='${searchVO.searchSe}'/>"/>
	<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
	<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	
	
	<form:hidden path="moblphonNo"/>
		
	<table class="chart2">
		<caption>회원관리 폼</caption>
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
		<tbody>
		<tr>
			<th><em>*</em><label for="userNm"> 이름</label></th>
			<td>
				<form:input path="userNm" id="userNm" cssClass="inp" />
				<div><form:errors path="userNm" /></div>
			</td>
			<%-- <td rowspan="5" align="center">
				<c:choose>
					<c:when test="${empty userManageVO.photoStreFileNm}">사진없음</c:when>
					<c:otherwise><img src="${MembersFileStoreWebPath}<c:out value="${userManageVO.photoStreFileNm}"/>" width="100"/></c:otherwise>
				</c:choose>
				<br><input type="file" name="userPicFile" class="inp" style="width:100px"/>
			</td> --%>
		</tr>
		
		<tr>
			<th><em>*</em><label for="userId"> 아이디</label></th>
			<td><form:input path="userId" id="userId" readonly="true" cssClass="inp" /> <form:errors path="userId" />
			<!-- <a href="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do?checkId='/>" onclick="window.open(this.href+userManageVO.userId.value,'','height=350,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" target="_blank"><img src="${MNG_IMG}/duplicate.gif" /></a> <strong class="org">* 아이디 변경시 반드시 중복 확인을 하여 주십시오.</strong> -->
			</td>
		</tr>
		
		<%-- <tr>
			<th><em>*</em><label for="password"> 비밀번호</label></th>
			<td><form:errors path="password" />
				<input type="image" src="<c:url value='${MNG_IMG}/btn/btn_pass_reissue.gif'/>" alt="비밀번호재발급" onclick="return sendPassword(document.userManageVO);"/> <strong class="org">* 자동으로 비밀번호를 생성하여 이용자에게 전송합니다.</strong>
			</td>
		</tr> --%>
		<tr>
			<th><label for="tlphonNo">전화번호</label></th>
			<td colspan="2">
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
			<th><label for="moblphonNo">핸드폰번호</label></th>
			<td colspan="2">
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
			<th><label for="emailHead"> 이메일</label></th>
			<td colspan="2">
			<c:set var="emailArr" value="${fn:split(userManageVO.emailAdres, '@')}"/>
				<c:forEach items="${emailArr}" var="arr" varStatus="status">
					<c:if test="${status.count eq 1}">
						<c:set var="emailHead" value="${fn:trim(arr)}"/>
					</c:if>
					<c:if test="${status.count eq 2}">
						<c:set var="emailBody" value="${fn:trim(arr)}"/>
					</c:if>
				</c:forEach>
				<input type="text" name="email1" id="email1" value="${emailHead}" class="inp" /> @ <input type="text" name="email2" value="${emailBody}" id="email2" class="inp"/>
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
				
			</td>
		</tr>
		<tr>
			<th rowspan="2"><label for="zip">주소</label></th>
			<td colspan="2">
				<form:input path="zip" size="6" maxlength="6" cssClass="inp"/>
				<a href="<c:url value='/sym/cmm/EgovCcmRdnmZipSearchList.do'/>" target="_blank" onclick="window.open(this.href,'','height=600,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;"><img src="${MNG_IMG}/btn/btn_zipcode.gif" alt=""/></a> 
			</td>
		</tr>
		<tr>
			<td>
				<form:input path="adres" id="adres" maxlength="100" cssClass="inp addr"/>
				<form:input path="adresDetail" id="adresDetail" maxlength="100" cssClass="inp addr2"/>
			</td>
		</tr>
		<tr>
			<th><label for="slrcldLrrCode">생년월일</label></th>
			<td colspan="2"><form:hidden path='brthdy'/>
				<c:set var="brthdy1" value="${fn:substring(userManageVO.brthdy, 0,4)}"/>
				<c:set var="brthdy2" value="${fn:substring(userManageVO.brthdy, 4,6)}"/>
				<c:set var="brthdy3" value="${fn:substring(userManageVO.brthdy, 6,8)}"/>
				<input type="radio" id="slrcldLrrCode" name="slrcldLrrCode" value="01" <c:if test="${userManageVO.slrcldLrrCode eq '01'}"> checked</c:if>/>양력
				<input type="radio" id="slrcldLrrCode" name="slrcldLrrCode" value="02" <c:if test="${userManageVO.slrcldLrrCode eq '02'}"> checked</c:if>/>음력
				<input type="text" value="${brthdy1}" name="brthdy1" id="brthdy1" size="4" maxlength="4" class="inp"/>년
				<input type="text" value="${brthdy2}" name="brthdy2" id="brthdy2" size="2" maxlength="2" class="inp"/>월
				<input type="text" value="${brthdy3}" name="brthdy3" id="brthdy3" size="2" maxlength="2" class="inp"/>일
			</td>
		</tr>
		<tr>
			<th><label for="man">성별</label></th>
			<td colspan="2">
				<form:radiobutton path="sexdstn" id="man" value="1" cssClass="cho"/> <label for="man" class="man">남</label>
				<form:radiobutton path="sexdstn" id="woman" value="2" cssClass="cho"/> <label for="woman">여</label>
			</td>
		</tr>
		<tr>
			<th><label for="sms_receive">SMS수신여부</label></th>
			<td colspan="2">
				<form:radiobutton id="sms_receive" path="moblphonRecptnAt" value="Y" cssClass="cho"/> <label for="sms_receive">수신</label>
				<form:radiobutton id="sms_noreceive" path="moblphonRecptnAt" value="N" cssClass="cho"/> <label for="sms_noreceive">수신거부</label>
			</td>
		</tr>
		<tr>
			<th><label for="email_receive">이메일 수신여부</label></th>
			<td colspan="2">
				<form:radiobutton id="email_receive" path="emailRecptnAt" value="Y" cssClass="cho"/> <label for="email_receive">수신</label>
				<form:radiobutton id="email_noreceive" path="emailRecptnAt" value="N" cssClass="cho"/> <label for="email_noreceive">수신거부</label>
			</td>
		</tr>
		<tr>
			<th><label for="userSeCode">회원권한</label></th>
			<td colspan="2">
				<form:select path="userSeCode">
					<option value="02" <c:if test="${userManageVO.userSeCode == '02'}">selected="selected"</c:if>>일반</option>
					<option value="04" <c:if test="${userManageVO.userSeCode == '04'}">selected="selected"</c:if>>학부모</option>
					<option value="06" <c:if test="${userManageVO.userSeCode == '06'}">selected="selected"</c:if>>학생</option> 
					<option value="07" <c:if test="${userManageVO.userSeCode == '07'}">selected="selected"</c:if>>강사</option>
					<option value="08" <c:if test="${userManageVO.userSeCode == '08'}">selected="selected"</c:if>>교사</option>
					<option value="10" <c:if test="${userManageVO.userSeCode == '10'}">selected="selected"</c:if>>사이트관리자</option>
					<option value="99" <c:if test="${userManageVO.userSeCode == '99'}">selected="selected"</c:if>>통합관리자</option>
				</form:select>
			</td>
		</tr>
		</tbody>
	</table>
	
	<div class="btn_r">
		<c:url var="listUrl" value="./EgovMberManage.do">
			<c:if test="${!empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}" /></c:if>
			<c:if test="${!empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
			<c:if test="${!empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
		</c:url>
		<input type="image" src="${MNG_IMG}/btn/btn_modify.gif" alt="수정" onclick="return checkForm(document.userManageVO);"/>
		<a href="<c:out value="${listUrl}"/>"><img src="${MNG_IMG}/btn/btn_cancel.gif" alt="취소"/></a>
						
	</div>
</form:form>
<iframe name="passSand" id="passSand" style='visibility: hidden; height: 0; width: 0; border: 0px'></iframe>

</div>
<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	