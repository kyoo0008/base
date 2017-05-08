<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8">
	<c:param name="defaultHeader">Y</c:param>
</c:import>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="communityVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

var cmmntyNmCheckFlag = false;
var cmmntyAdresCheckFlag = false;

	function fn_egov_regist_cmmnty(form){
		
		if(!cmmntyNmCheckFlag) {
			alert("커뮤니티명을 중복확인 하십시오.");
			return false;
		}
		
		if(!cmmntyAdresCheckFlag) {
			alert("커뮤니티주소를 중복확인 하십시오.");
			return false;
		}
		
		if (!validateCommunityVO(document.community)){
			return false;
		}
		
		if(confirm('<spring:message code="common.regist.msg" />')) {
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
	
	function communityAdresSelect(adres) {
		cmmntyAdresCheckFlag = true;
		var f = document.community;

		if( adres && adres != '' )
			f.cmmntyAdres.value = adres;
	}

    $(document).ready(function () {
        $('.remaining').each(function () {
            // count 정보 및 count 정보와 관련된 textarea/input 요소를 찾아내서 변수에 저장한다.
            var $count = $('.count', this);
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
    
    function fn_egov_cmmntTitle_dplct() {
    	var cName = document.community.cmmntyNm.value;
    	if (cName.value == "" || cName.length > 50 || cName.length < 3) {
			alert("커뮤니명은 3~50자 이내 입력하실수 있습니다.");
			return false;
		}else{
			window.open("./selectCmmntyNmDplct.do?cmmntyNm="+cName,'cmmntyNmDplct','height=350,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');
			return true;
		}
    	
    }
    
    function fn_egov_cmmntyAdres_dplct() {
    	var cAdres = document.community.cmmntyAdres.value;
    	if (cAdres.search(/[^a-z|^A-Z][^0-9]/) != -1 || cAdres.value == "" || cAdres.length > 30 || cAdres.length < 3) {
			alert("커뮤니티 주소는 영문, 숫자로 3~30자 이내 입력하실수 있습니다.");
			return false;
		}else{
			window.open("./selectCmmntyAdresDplct.do?cmmntyAdres="+cAdres,'cmmntyAdresDplct','height=350,width=500,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');
			return true;
		}
    	
    }
</script>

		<div class="cm_make">
		<form:form commandName="communityVO" name="community" method="post" action="${_PREFIX}/insertCmmntyInf.do" enctype="multipart/form-data">
		<form:hidden path="cmmntyId"/>		
		<input type="hidden" name="menuId" value="<c:out value='${searchVO.menuId}'/>"/>
		<input type="hidden" name="cmmntySeCode" value="<c:out value='${searchVO.searchTy}'/>"/>
		<input type="hidden" name="searchTy" value="<c:out value='${searchVO.searchTy}'/>"/>
		<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
		<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<table class="cm_chart" summary="커뮤니티만들기 정보입력 화면">
		  <caption>커뮤니티만들기 정보입력</caption>
		  	<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
            <tr>
              <th><label for="cmmntyNm"><spring:message code="cop.cmmntyNm" /></label></th>
              <td>
				<form:input path="cmmntyNm" cssClass="inp w425" maxlength="50" title="커뮤니티이름"/><a href="#" onclick="fn_egov_cmmntTitle_dplct();return false;" title="새창열림" class="btn"><span>중복확인</span></a>
				<p>· 커뮤니티명은 3~50자 이내로 입력하여 주십시오.</p>
                <form:errors path="cmmntyNm" />
			 </td>
            </tr>
            <tr>
              <th><label for="cmmntyAdres"><spring:message code="cop.cmmntyAdres" /></label></th>
              <td><span class="cm_domain">${_WEB_FULL_PATH}/cmy/</span><form:input path="cmmntyAdres" id="textfield" cssClass="inp w222" title="커뮤니티주소" maxlength="30"/><span class="cm_domain">.do</span><a href="#" onclick="fn_egov_cmmntyAdres_dplct();return false;" title="새창열림" class="btn"><span>중복확인</span></a> 
                <p>· 주소는 3~30자 이내의 영문, 숫자를 띄어쓰기와 특수문자 없이 사용하실 수 있습니다.</p>
               <form:errors path="cmmntyAdres" />
               </td>
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
                  <form:radiobutton path="confmPolicyCode" value="Y" label="가입신청시 바로 "/>            
                  <form:radiobutton path="confmPolicyCode" value="N" label="가입신청시 승인"/>
                  <form:errors path="confmPolicyCode" />
			 </td>
            </tr>
            <tr>
              <th><spring:message code="cop.resbscrbPolicyCode" /></th>
              <td>
                  <form:radiobutton path="resbscrbPolicyCode" value="Y" cssStyle="checked;" label="재가입 허용"/>              
                  <form:radiobutton path="resbscrbPolicyCode" value="N" label="재가입 불가"/>
                  <form:errors path="resbscrbPolicyCode" />
				 </td>
            </tr>
            <tr>
              <th><spring:message code="cop.cmmntyIntrcn" /></th>
              <td>
              <form:textarea id="cmmntyIntrcn" path="cmmntyIntrcn" rows="10" cols="30" cssClass="inp_area" title="커뮤니티 소개"/>
              	<p class=remaining>· 최대 한글 기준 (<SPAN class=count>2500</SPAN>/2500)자 이내 입력가능하며, 테그는 사용불가 합니다</p>
	    		<form:errors path="cmmntyIntrcn" />	 
              </td>
            </tr>
            <tr>
              <th><label for="commimg">대표이미지</label></th>
              <td><input type="file" name="iconfile" id="commimg" class="inp_file" />
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
                <ul>
                  <li>배경이미지는 <strong>가로 920px 세로 150px</strong>의 사이즈를 유지해 주십시오.</li>
                  <li> 이미지는 <strong>jpg, gif, png</strong> 파일만 가능하며 <strong>2M</strong>이하의 용량을 유지해 주시기 바랍니다.</li>
                  <li>이미지를 추가하시지 않으면 기본배경이미지가 제공됩니다.</li>
                </ul>
              </td>
            </tr>
            </tbody>
          </table>
          
          <div class="btn_c">
				<span  class="btn"><button type="submit" onclick="return fn_egov_regist_cmmnty(this.form);">확인</button></span>
				<c:url var="listUrl" value="${_PREFIX}/selectCmmntyInfs.do">
					<c:if test="${not empty searchVO.menuId}"><c:param name="menuId" value="${searchVO.menuId}"/></c:if>
					<c:if test="${not empty searchVO.searchTy}"><c:param name="searchTy" value="${searchVO.searchTy}"/></c:if>
					<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}"/></c:if>
					<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}"/></c:if>
					<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}"/></c:if>
				</c:url>
				<span  class="btn2"><button type="button" onclick="this.href='<c:out value='${listUrl}'/>';">취소</button></span>
		  </div>
		  </form:form>
		  
        </div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>