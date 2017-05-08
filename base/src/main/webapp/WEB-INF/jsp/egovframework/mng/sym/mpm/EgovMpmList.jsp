<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper"%>
<c:set var="USER_INFO" value="<%=EgovUserDetailsHelper.getAuthenticatedUser(request, response) %>"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}/template/manage/images"/>
<c:set var="_C_JS" value="${pageContext.request.contextPath}/template/common/js"/>

<c:set var="MENU_AUTO_MAKE_SITE_ID" value="<%=Globals.MENU_AUTO_MAKE_SITE_ID%>"/>
<c:set var="_SITE_ID" value=""/>
<c:set var="_SITE_NM" value=""/>
<c:import url="/mng/template/top.do" charEncoding="utf-8">
	<c:param name="menu" value="MENUCNTNTS_MANAGE"/>
	<c:param name="depth1" value="${searchVO.siteId eq MENU_AUTO_MAKE_SITE_ID ? 'MENU_AUTHO_MANAGE' : 'MENU_MANAGE'}"/>
	<c:param name="depth2" value=""/>
	<c:param name="title" value="${searchVO.siteId eq MENU_AUTO_MAKE_SITE_ID ? '기본 자동생성 메뉴관리' : '메뉴관리'}"/>
</c:import>

<style type="text/css">
#common_pop_up { display:none; position:absolute; position:fixed; width:400px; top:140px; margin:0 auto; z-index:222; left:50%; top:50%; margin-left:-200px; margin-top:-70px;}
.common_pop_t{background:url(http://smart.edus.or.kr/template/web/smart_001/image/sub/common/popup_top.png) no-repeat left top; height:45px; padding-top:5px; }
.common_pop_bg{background:url(http://smart.edus.or.kr/template/web/smart_001/image/sub/common/popup_bg.gif) no-repeat left bottom; padding:20px 20px 20px 20px; }
.poll_result_title{ float:left; font-size:14px; color:#FFF;  font-weight:bold; padding:10px 0 0 20px;}
.result_close { float:right; padding:10px 20px 0 0; }
</style>

<script type="text/javascript" src="<c:url value='/template/common/js/jquery/jquery.contextmenu.r2.packed.js'/>"></script>
<script type="text/javascript">
var sorttableClass = ".sortable";
$(function() {
	$( sorttableClass).sortable({
		//items: "li:.ui-state-default",
		//cancel: ".ui-state-disabled",
		opacity: 0.7,
		cursor: 'move',
		//revert: true,
		 axis: 'y',
		start: function(event, ui) {
			ui.item.data('originIndex', ui.item.index());
		},
		stop: function(event, ui) {
			//var oriItem = null
			var moveItem = ui.item;

			var originIndex = moveItem.data('originIndex');
			var newIndex = moveItem.index();

			if(originIndex != newIndex) {
				//oriItem = (originIndex < newIndex) ? ui.item.prev() : ui.item.next();
				//var url = '/mng/sym/mpm/updateMpmSortOrdr.do?upperMenuId=' + oriItem.attr("menuId") + '&menuId=' + moveItem.attr("menuId") + '&sortOrdr=' + oriItem.attr("sortOrdr");
				
				var sortTyCode = (originIndex < newIndex) ? "D" : "U";
				var url = '${pageContext.request.contextPath}/mng/sym/mpm/updateMpmSortOrdr.do?siteId=' + moveItem.attr("siteId") + '&sysTyCode=' + moveItem.attr("sysTyCode") + '&upperMenuId=' + moveItem.attr("upperMenuId") + '&menuId=' + moveItem.attr("menuId") + '&sortOrdr=' + newIndex + '&sortTyCode=' + sortTyCode;
				
				$( sorttableClass ).sortable( "option", "disabled", true );
				
				$.getJSON(url, function(data) {
			  		if(data.updateCnt > 0) {
			  			$( sorttableClass ).sortable( "option", "disabled", false );
			  		} else {
			  			alert('문제가 발생하여 작업을 완료하지 못하였습니다.');
			  		}
				})
				.success(function() {})
				.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
				.complete(function() {});

				/*
				$.ajax({
	                type: 'GET',
	                url: url,
	                dataType: 'json',
	                success: function(html, textStatus) {
	                	$( sorttableClass ).sortable( "option", "disabled", false );
	                },
	                error: function(xhr, textStatus, errorThrown) {
	                    alert('An error occurred! ' + ( errorThrown ? errorThrown :xhr.status ));
						$( sorttableClass ).sortable( "option", "disabled", true );
	                },
					beforeSend: function() {
						$(sorttableClass ).sortable( "option", "disabled", true );
					}
	            });
				*/
			}
		}
	});
	$( sorttableClass ).disableSelection();
	$(".imgCol").click(function() {
		$(this).parent().parent().parent().parent().parent().find(sorttableClass + ':first').toggle(function(){
			
		});
		$(this).parent().find('.imgCol').toggle();
	});
	
	$('a.menu').contextMenu('menuContext', {
		  menuStyle: {
	        border: '1px solid #8bb1f7'
	      },
	      shadow : false,
	      itemStyle: {
	        backgroundColor : 'white',
	        color: 'black',
	        border: 'none',
	        padding: '1px'
	      },
	      itemHoverStyle: {
	        color: 'black',
	        backgroundColor: '#e9e9e9',
	        border: '1px solid #8bb1f7'
	      },

	      bindings: {
	        'cmMenuNm': function(t) {	        	
	        	$('#cmSiteId').val(t.siteId);
	        	$('#menuId').val(t.id);
	        	$('#menuNm').val(t.innerText);
	        	cfgCommonPopShow('common_pop_up');
	        }
	      }
	});
	
	$('#btnMenuNmChange').click(function() {
		var url = '${pageContext.request.contextPath}/mng/sym/sit/updateMpmMenuNm.do?siteId=' + $('#cmSiteId').val() + '&menuId=' + $('#menuId').val() + '&menuNm=' + encodeURIComponent($('#menuNm').val());
		
		$.getJSON(url, function(data) {
	  		if(data.updateCount > 0) {
	  			$('#' + data.menuId).html(data.menuNm);
	  		} else {
	  			alert('문제가 발생하여 작업을 완료하지 못하였습니다.');
	  		}
		})
		.success(function() {})
		.error(function() {alert('문제가 발생하여 작업을 완료하지 못하였습니다.');})
		.complete(function() {cfgCommonPopHide();});
		
		return false;
	});
	
});
</script>
<script type="text/javascript">	
	function fn_egov_delete_mnu(siteId, menuId) {
				
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.location.href = "<c:url value='/mng/sym/mpm/deleteMpm.do'/>?siteId=" + siteId + "&menuId=" + menuId;
		}	
	}	
	
	function fn_egov_update_sortordr(sortTyCode, siteId, menuId, upperMenuId, sortOrdr) {
		document.location.href = "<c:url value="/mng/sym/mpm/updateMpmSortOrdr.do"/>?sortTyCode=" + sortTyCode + "&siteId=" + siteId + "&menuId=" + menuId + "&upperMenuId=" + upperMenuId + "&sortOrdr=" + sortOrdr;
	}
	
	function fn_egov_view_HisManage(siteId, menuId) {
		var url = "<c:url value='/mng/sym/mpm/selectMpmHistoryList.do'/>?";
		url = url + "siteId=" + siteId;
		url = url + "&menuId=" + menuId;
		
		var win = window.open(url ,'his',' scrollbars=yes, resizable=yes, left=0, top=0, width=1100,height=750');
		if(win != null) {
			win.focus();
		}
	}

	function cfgCommonPopShow(id) {
    	jQuery('#wrap').append("<div id='layer_blind_box' style='position:absolute; position:fixed; top:0; left:0; width:100%; height:100%; background:#000; z-index:50;'></div>");
    	jQuery('#layer_blind_box').css('opacity', 0.3);
    	
    	jQuery('#' + id).css('z-index', 100);
    	jQuery('#' + id).show();
    }
	
	function cfgCommonPopHide() {
			jQuery('#layer_blind_box').remove();
			jQuery('#common_pop_up').hide();
			return false;
    };
</script>

<div class="contextMenu" id="menuContext" style="display:none">
  <ul>
    <li id="cmMenuNm"><img src="${_IMG}/btn/edit.gif"/> 메뉴명변경</li>
  </ul>
</div>

<div id="common_pop_up">	
	<div class="common_pop_t">
    	<p  class="poll_result_title">메뉴명 변경</p>
    	<p class="result_close" > <a href="#" onclick="return cfgCommonPopHide()" title="닫기"><img src="http://smart.edus.or.kr/template/web/smart_001/image/sub/smartcn/poll_result_close.gif" width="22" height="22" alt="닫기" /></a></p>
  	</div>
  	<div  class="common_pop_bg">
    	<div class="common_pop_con">
    		<input type="hidden" id="cmSiteId" name="cmSiteId"/>
    		<input type="hidden" id="menuId" name="menuId"/>
    		<input type="text" class="inp" size="49" id="menuNm" name="menuNm"/> <a href="#" id="btnMenuNmChange"><img src="${_IMG}/btn/btn_change_s.gif"/></a>
    	</div>
  	</div>	 
</div>			
<div id="cntnts">

	<c:choose>
		<c:when test="${searchVO.siteId ne MENU_AUTO_MAKE_SITE_ID}">
			<c:if test="${USER_INFO.userSe > 10}">
				<form name="SiteListForm" action="<c:url value="/mng/sym/mpm/selectMpmList.do"/>" method="post">
					<div id="bbs_search">
						<c:import url="/mng/sym/sit/selectCommonSiteList.do"/>
					</div>
				</form>
			</c:if>
	    </c:when>
	    <c:otherwise>
	    	<c:set var="_SITE_NM" value="-"/>
	    </c:otherwise>
    </c:choose>

    <table class="chart_board">
    <colgroup>
			<col class="co3"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
			<col class="co6"/>
	</colgroup>
    <caption class="hdn">메뉴관리</caption>
    
    <thead>
      <tr>
        <th>메뉴명</th>
        <th>노출여부</th>
        <th>하위추가</th>
        <th>관리</th>
        <th>복원</th>
      </tr>
    </thead>
    <tbody>
    
<c:set var="_PRE_MENU_LEVEL" value="-1"/>
	<ul class="sortable">
	    <c:forEach var="result" items="${mpmList}" varStatus="status">
	    	
	    	<c:if test="${_PRE_MENU_LEVEL > result.menuLevel}">
	    		<c:forEach begin="1" end="${_PRE_MENU_LEVEL - result.menuLevel}" step="1">
		    			</ul>
		    		</li>
	    		</c:forEach>
	    	</c:if>
	    	
	    	<li class="menu_board" siteId="${result.siteId}" sysTyCode="${result.sysTyCode}" upperMenuId="${result.upperMenuId}" menuId="${result.menuId}">
	    		<table class="menu_board">
				    <colgroup>
							<col class="co3"/>
							<col class="co6"/>
							<col class="co6"/>
							<col class="co6"/>
							<col class="co6"/>
					</colgroup>
				    <caption class="hdn">메뉴관리</caption>
    			<tbody>
			      <tr>
			        <td class="tit">&nbsp;&nbsp;
				        <c:forEach begin="0" end="${result.menuLevel}" step="1">
				            &nbsp;
				        </c:forEach>
				        <c:if test="${not empty result.upperMenuId}">
			        		<img src="${_IMG}/btn/folder_${result.menuLevel}.gif"/>
			        	</c:if>
			        	<a <c:if test="${searchVO.siteId ne MENU_AUTO_MAKE_SITE_ID}">href="<c:url value='${result.menuWebPath}'/>"</c:if> class="menu" target="_blank" id="<c:out value="${result.menuId}"/>" siteId="${result.siteId}"><c:out value="${result.menuNm}" /></a>
			        	<c:if test="${result.menuLastNodeAt eq 'N' and not empty result.upperMenuId}"><img src="${_IMG}/btn/btn_minus.gif" class="imgCol"/><img src="${_IMG}/btn/btn_plus.gif" class="imgCol" style="display:none"/></c:if>
			        </td>
			        <td>
					   	<c:if test="${result.expsrUseAt == 'Y'}">
					   		<img src="${_IMG}/btn/use_yes.gif"/>
					   	</c:if>
					   	<c:if test="${result.expsrUseAt == 'N'}">
					   		<img src="${_IMG}/btn/use_no.gif"/>
					   	</c:if>
				    </td>
			       	<td>
				        <a href="<c:url value='/mng/sym/mpm/addMpm.do'/>?siteId=<c:out value="${result.siteId}"/>&upperMenuId=<c:out value="${result.menuId}"/>&menuLevel=<c:out value="${result.menuLevel + 1}"/>"><img src="${_IMG}/btn/add_btn_2.gif"/></a>
				    </td>
				    <td>
				    	<c:if test="${not empty result.upperMenuId}">
					        <a href="<c:url value='/mng/sym/mpm/forUpdateMpm.do'/>?siteId=<c:out value="${result.siteId}"/>&menuId=<c:out value="${result.menuId}"/>"><img src="${_IMG}/btn/edit.gif"/></a>
					        <c:if test="${not empty result.upperMenuId}">
					        	<a href="javascript:fn_egov_delete_mnu('<c:out value="${result.siteId}"/>', '<c:out value="${result.menuId}"/>')"><img src="${_IMG}/btn/del.gif"/></a>
					        </c:if>
				        </c:if>
				    </td>
				    <td>
				    	<c:if test="${not empty result.upperMenuId}">
				    		<a href="#" onclick="fn_egov_view_HisManage('<c:out value="${result.siteId}"/>', '<c:out value="${result.menuId}"/>');return false;"><img src="${_IMG}/btn/btn_search02.gif" alt="찾기"/></a>
				    	</c:if>
				    </td>
				  </tr>
				 </tbody>
				</table>
			<c:choose>
		    	<c:when test="${result.menuLastNodeAt eq 'Y'}"></li></c:when>
		    	<c:otherwise><ul class="sortable"></c:otherwise>
	    	</c:choose>
			<c:set var="_PRE_MENU_LEVEL" value="${result.menuLevel}"/>
	    </c:forEach>
	</ul>

    <c:if test="${fn:length(mpmList) == 0}">
      <tr>
		<td class="listCenter" colspan="7"><spring:message code="common.nodata.msg" /></td>
      </tr>
    </c:if>
 
    </tbody>    
    </table>
	<!-- 
  	<div class="btn_r">
		<a href="<c:url value='/mng/sym/mpm/addMpm.do'/>?siteId=<c:out value="${_SITE_ID}"/>&upperMenuId=<c:out value="${_ROOT_MENU_ID}"/>"><img src="${_IMG}/btn/1dep_btn.gif" alt="1차메뉴 등록"/></a>
	</div>
	 -->
  
</div>        

<c:import url="/mng/template/bottom.do" charEncoding="utf-8"/>	