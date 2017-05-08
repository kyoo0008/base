<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="communityVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
var cmmntyNmCheckFlag = false;

	function fn_egov_regist_cmmnty(){
		
		if (!validateCommunityVO(document.community)){
			return false;
		}
		if(confirm('<spring:message code="common.update.msg" />')) {
			return true;
		}else {
			return false;	
		}
	}
	
	function communityTitleSelect(title) {
		cmmntyNmCheckFlag = true;
		var f = document.community;

		if( title && title != '' )
			f.cmmntyNm.value = title;
	}
	
    $(document).ready(function () {
        $('.remaining').each(function () {
            // count 정보 및 count 정보와 관련된 textarea/input 요소를 찾아내서 변수에 저장한다.
            var $count = $('.count', this);
            var $input = $(this).prev();
			var $input = $("#cmmntyIntrcn");

            // .text()가 문자열을 반환하기에 이 문자를 숫자로 만들기 위해 1을 곱한다.
            var maximumCount = $count.text() * 1;

            // update 함수는 keyup, paste, input 이벤트에서 호출한다.
            var update = function () {
                var before = $count.text() * 1;
                var now = maximumCount - $input.val().length;

                // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
				if (now < 0) {
					var str = $input.val();
					$("#cmmntyIntrcn").focus();
					var inputVal = str.substr(0, maximumCount);
					alert(maximumCount + '자를 초과하였습니다.');
					now = 0;
					$input.val(inputVal);
				}
                if (now < 0) {
                    var str = $input.val();
                    $input.val(str.substr(0, maximumCount));
                    now = 0;
                }

                // 필요한 경우 DOM을 수정한다.
                if (before != now) {
                    $count.text(now);
                }
            };

            // input, keyup, paste 이벤트와 update 함수를 바인드한다
            $input.bind('input keyup paste', function () { setTimeout(update, 0) });

            update();
        });
    });
    
    function iconDel() {
    	$('#atchFileIcon').val('');
    	$('#iconf').toggle();
	}
    function peprsntDel() {
    	$('#atchFileNm').val('');
    	$('#peprsntf').toggle();
	}
</script>


<div class="cm_sub_box">
	<h2>커뮤니티 정보 관리</h2>
	<div class="cm_sub_cont">							
		<form:form commandName="communityVO" name="community" method="post" action="${_PREFIX}/updtCmmntyInf.do" enctype="multipart/form-data">
		<form:hidden path="cmmntyId"/>
		<form:hidden path="cmmntySeCode"/>
		<form:hidden path="cmmntyAdres"/>
		<form:hidden path="atchFileIcon"/>
		<form:hidden path="atchFileNm"/>
          
          <table class="cm_chart" summary="커뮤니티 생성 정보 입력하는 표입니다">
		  	<caption>커뮤니티 생성 정보 입력</caption>
		  	<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
            <tr>
              <th><label for="cmmntyNm"><spring:message code="cop.cmmntyNm" /></label></th>
              <td>
              	<form:input path="cmmntyNm" cssClass="inp wid75" readonly="true" />
              	<a href="${_PREFIX}/selectCmmntyNmDplct.do?cmmntyNm=" onclick="window.open(this.href+communityVO.cmmntyNm.value,'cmmntyNmDplct','height=350,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" target="_blank" title="새창열림" class="btn"><span>중복확인</span></a>
              	<p>· 커뮤니티명은 3~50자 이내로 입력하여 주십시오.</p>
              	<form:errors path="cmmntyNm" />
              </td>
            </tr>
            <tr>
              	<th><spring:message code="cop.cmmntyAdres" /></th>
              	<td><strong>${_WEB_FULL_PATH}/cmy/<c:out value="${communityVO.cmmntyAdres}"/>.do</strong></td>
            </tr>
            <tr>
              	<th><spring:message code="cop.othbcAt" /></th>
              	<td>
					<form:radiobutton path="othbcAt" value="Y" label="공개"/>
					<form:radiobutton path="othbcAt" value="N" label="비공개"/>
					<form:errors path="othbcAt" />
				</td>
            </tr>
            <tr>
              	<th><spring:message code="cop.confmPolicyCode" /></th>
              	<td>
					<form:radiobutton path="confmPolicyCode" value="Y" label="가입신청시 자동승인"/>
					<form:radiobutton path="confmPolicyCode" value="N" label="확인 후 수동승인"/>
					<form:errors path="confmPolicyCode" />
				</td>
            </tr>
            <tr>
              	<th><spring:message code="cop.resbscrbPolicyCode" /></th>
              	<td>
					<form:radiobutton path="resbscrbPolicyCode" value="Y" label="재가입 가능"/>
					<form:radiobutton path="resbscrbPolicyCode" value="N" label="재가입 불가"/>
					<form:errors path="resbscrbPolicyCode" />
				</td>
            </tr>
            <tr>
              	<th><label for="cmmntyIntrcn"><spring:message code="cop.cmmntyIntrcn" /></label></th>
              	<td><form:textarea id="cmmntyIntrcn" path="cmmntyIntrcn" rows="5" cols="45" cssClass="inp_area"/>
              		<p class=remaining>· 최대 한글 기준 (<SPAN class=count>2500</SPAN>/2500)자 이내 입력가능하며, 테그는 사용불가 합니다</p>
              	</td>
            </tr>
            <tr>
              	<th><label for="commimg">대표이미지</label></th>
              	<td><input type="file" name="iconfile" id="commimg" class="inp_file" />
	              	<c:if test="${not empty communityVO.atchFileIcon}">
	              		<div id="iconf" class="file_name"><c:out value='${communityVO.atchFileIcon}'/> <button type="button" onclick="iconDel();return false;" class="fdel"><span>삭제</span></button></div>
	              	</c:if>
                  	<ul>
	                  <li>대표이미지는 <strong>가로 90px 세로 60px</strong>의 사이즈를 유지해 주십시오.</li>
	                  <li>이미지는 <strong>jpg, gif, png</strong> 파일만 가능하며 <strong>2M</strong>이하의 용량을 유지해 주시기 바랍니다.</li>
	                  <li>이미지를 추가하시지 않으면 기본대표이미지가 제공됩니다.</li>
	              	</ul>
           	  	</td>
            </tr>
            <tr>
              	<th><label for="commbgimg">배경이미지</label></th>
              	<td><input type="file" name="peprsntfile" id="commbgimg" class="inp_file" />
	              	<c:if test="${not empty communityVO.atchFileNm}">
	              		<div id="peprsntf" class="file_name"><c:out value='${communityVO.atchFileNm}'/> <button type="button" onclick="peprsntDel();return false;" class="fdel"><span>삭제</span></button></div>
	              	</c:if>
	                <ul>
	                  <li>배경이미지는 <strong>가로 920px 세로 150px</strong>의 사이즈를 유지해 주십시오.</li>
	                  <li> 이미지는 <strong>jpg, gif, png</strong> 파일만 가능하며 <strong>2M</strong>이하의 용량을 유지해 주시기 바랍니다.</li>
	                  <li>이미지를 추가하시지 않으면 기본배경이미지가 제공됩니다.</li>
	                </ul>
              	</td>
            </tr>
          </table>
          
          <div class="btn_c">
			<span class="btn"><button type="submit" onclick="return fn_egov_regist_cmmnty(this.form);">확인</button></span>
			<span class="btn2"><button type="button" onclick="location.href='<c:url value='/cmy/${communityVO.cmmntyAdres}.do'/>'">취소</button></span>
		  </div>
        </form:form>
	</div>
</div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>