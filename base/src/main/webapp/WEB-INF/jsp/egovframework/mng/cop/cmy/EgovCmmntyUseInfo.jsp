<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="/template/manage/images"/>
<c:set var="_PREFIX" value="/mng/cop/cmy"/>
<c:set var="USER_PREFIX" value="/cop/cmy"/>

<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="CMMNTY_MANAGE"/>
	<c:param name="depth1" value="CMMNTY_ING"/>
	<c:param name="title" value="커뮤니티관리"/>
</c:import>
<script charset="utf-8" src="${CMM_JS}/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
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
    
    function iconDel(form) {
    	document.community.atchFileIcon.value="";
		document.all.iconf.style.display="none";
		return true;
	}
    function peprsntDel(form) {
    	document.community.atchFileNm.value="";
		document.all.peprsntf.style.display="none";
		return true;
	}
</script>

<div id="cntnts">
<form:form commandName="communityVO" name="community" method="post" action="${_PREFIX}/updtCmmntyUseInf.do" enctype="multipart/form-data">
		<form:hidden path="siteId"/>
		<form:hidden path="cmmntyId"/>
		<form:hidden path="cmmntyAdres"/>
		<form:hidden path="atchFileIcon"/>
		<form:hidden path="atchFileNm"/>
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input name="searchUse" type="hidden" value="<c:out value='${searchVO.searchUse}'/>"/>
		<input name="searchCnd" type="hidden" value="<c:out value="${searchVO.searchCnd}"/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value="${searchVO.searchWrd}"/>"/>
          <table class="chart2">
		  <caption>커뮤니티 정보</caption>
            <tr>
              <th scope="row"><label for="cmmntyNm"><spring:message code="cop.cmmntyNm" /></label></th>
              <td class="bold"><form:input path="cmmntyNm" cssClass="inp_long" title="커뮤니티이름" readonly="true" />
              <a href="${USER_PREFIX}/selectCmmntyNmDplct.do?cmmntyNm="  onclick="window.open(this.href+community.cmmntyNm.value,'cmmntyNmDplct','height=350,width=450,toolbar=no,directories=no,status=no,linemenubar=no,scrollbars=yes,resizable=no');return false;" target="_blank" class="btn_mem"><img src="${_IMG}/btn/btn_duplicate.gif" alt="중복확인 팝업띄우기" /></a>
              <form:errors path="cmmntyNm" />
              </td>
            </tr>
            <tr>
              <th scope="row"><label for="cmmntyAdres"><spring:message code="cop.cmmntyAdres" /></label></th>
              <td class="bold"><a href="http://<c:out value='${siteInfo.siteUrl}' />/cmy/<c:out value="${communityVO.cmmntyAdres}"/>.do" target="_blank">http://<c:out value='${siteInfo.siteUrl}' />/cmy/<c:out value="${communityVO.cmmntyAdres}"/>.do</a></td>
            </tr>
            <tr>
            <th scope="row">운영여부</th>
              <td>
				<c:choose>
				 <c:when test="${communityVO.useAt eq 'Y'}">운영</c:when>
				 <c:otherwise>폐쇄</c:otherwise>
				</c:choose>
			</td>
            <tr>
              <th scope="row"><label for="othbcAt"><spring:message code="cop.othbcAt" /></label></th>
              <td>
				<form:radiobutton path="othbcAt" cssClass="txt" value="Y"/>공개
				<form:radiobutton path="othbcAt" cssClass="txt" value="N"/>비공개
				<form:errors path="othbcAt" />
			</td>
            </tr>
            <tr>
              <th scope="row"><label for="confmPolicyCode"><spring:message code="cop.confmPolicyCode" /></label></th>
              <td>
				<form:radiobutton path="confmPolicyCode" cssClass="txt" value="Y"/>가입신청시 자동승인
				<form:radiobutton path="confmPolicyCode" cssClass="txt" value="N"/>확인 후 수동승인
				<form:errors path="confmPolicyCode" />
			</td>
            </tr>
            <tr>
              <th scope="row"><label for="resbscrbPolicyCode"><spring:message code="cop.resbscrbPolicyCode" /></label>	</th>
              <td>
				<form:radiobutton path="resbscrbPolicyCode" cssClass="txt" value="Y" cssStyle="checked;"/>재가입 가능
				<form:radiobutton path="resbscrbPolicyCode" cssClass="txt" value="N"/>재가입 불가
				<form:errors path="resbscrbPolicyCode" />
			</td>
            </tr>
            <tr>
              <th scope="row"><label for="cmmntySeCode"><spring:message code="cop.cmmntySeCode" /></label></th>
              <td>
              	<form:select path="cmmntySeCode">
				<form:options items="${cmmntySe}" itemValue="code" itemLabel="codeNm"/>
				</form:select>
				<form:errors path="cmmntySeCode" />
              </td>
            </tr>
            <tr>
              <th scope="row"><label for="cmmntyIntrcn"><spring:message code="cop.cmmntyIntrcn" /></label></th>
              <td><form:textarea id="cmmntyIntrcn" path="cmmntyIntrcn" rows="5" cols="45" cssClass="com_cont_l" title="커뮤니티 소개"/>
              <DIV class=remaining><ul class="ul02">
					<li>최대 한글 기준 (<SPAN class=count>2500</SPAN>/2500)자 이내 입력가능하며, 테그는 사용불가 합니다</li>
                </ul></DIV>
              </td>
            </tr>
            <tr>
              <th scope="row">대표이미지</th>
              <td><input type="file" name="iconfile" id="commimg" class="input300 inp" />
              <c:if test="${not empty communityVO.atchFileIcon}">
              <div id="iconf"><img src="/template/common/images/page/board/icon_file.gif"/> <c:out value='${communityVO.atchFileIcon}'/> <a onclick="return iconDel();return false;"><img src="/template/common/images/page/board/icon_del.gif"  style="cursor:pointer"/></a></div>
              </c:if>
                <ul class="ul02">
                  <li>대표이미지는 <span class="blue_bold">가로 90px 세로 60px</span>의 사이즈를 유지해 주십시오.</li>
                  <li>이미지는 <span class="blue_bold">jpg, gif, png</span> 파일만 가능하며 <span class="blue_bold">2M</span>이하의 용량을 유지해 주시기 바랍니다.</li>
                  <li> 이미지를 추가하시지 않으면 기본대표이미지가 제공됩니다.</li>
                </ul></td>
            </tr>
            <tr>
              <th scope="row">배경이미지</th>
              <td><input type="file" name="peprsntfile" id="commbgimg" class="input300 inp" />
              <c:if test="${not empty communityVO.atchFileNm}">
              <div id="peprsntf"><img src="/template/common/images/page/board/icon_file.gif"/> <c:out value='${communityVO.atchFileNm}'/> <a onclick="return peprsntDel();return false;"><img src="/template/common/images/page/board/icon_del.gif"  style="cursor:pointer"/></a></div>
              </c:if>
                <ul class="ul02">
                  <li>배경이미지는 <span class="blue_bold">가로 920px 세로 150px</span>의 사이즈를 유지해 주십시오.</li>
                  <li> 이미지는 <span class="blue_bold">jpg, gif, png</span> 파일만 가능하며 <span class="blue_bold">2M</span>이하의 용량을 유지해 주시기 바랍니다.</li>
                  <li>이미지를 추가하시지 않으면 기본배경이미지가 제공됩니다.</li>
                </ul></td>
            </tr>
            <tr>
              <th scope="row">운영여부</th>
              <td>
              		운영중 : <form:radiobutton path="useAt"  value="Y" />&nbsp;
          	    	폐 쇄 : <form:radiobutton path="useAt"  value="N"  />
              </td>         
            </tr>
          </table>
          <div class="btn_r"> <input type="image" src="${_IMG}/btn/btn_modify.gif" onclick="return fn_egov_regist_cmmnty(this.form);" alt="수정하기" />
			<c:url var="listUrl" value="${_PREFIX}/selectCmmntyUseList.do">
				<c:param name="siteId" value="${searchVO.siteId}"/>
				<c:if test="${not empty param.searchCnd}"><c:param name="searchCnd" value="${param.searchCnd}" /></c:if>
				<c:if test="${not empty param.searchWrd}"><c:param name="searchWrd" value="${param.searchWrd}" /></c:if>
				<c:if test="${not empty param.pageIndex}"><c:param name="pageIndex" value="${param.pageIndex}" /></c:if>
			</c:url>
          <a href="<c:url value='${listUrl}'/>"><img src="${_IMG}/btn/btn_list.gif" alt="목록으로" /></a></div>
        </form:form>

</DIV>

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	
