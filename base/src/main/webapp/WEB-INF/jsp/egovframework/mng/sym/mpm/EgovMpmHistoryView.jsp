<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_IMG" value="/template/manage/images"/>
<c:set var="_C_LIB" value="/lib"/>
<c:set var="_EDITOR_ID" value="htmlCn_Html"/>
<c:set var="_MOBILE_EDITOR_ID" value="mobileHtmlCn_Html"/>

<c:import url="/EgovPageLink.do?link=/mng/template/popTop" charEncoding="utf-8">
	<c:param name="title" value="메뉴 복원"/>
</c:import>

<script type="text/javascript" src="${_C_LIB}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript">
	function fn_egov_select_prog() {
			
		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
		var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();
		if(compositionTyCode == 'LINK' && cntntsTyCode != 'CTS01') {
			$('input:radio[name=compositionTyCode]:input[value=CNTNTS]').attr('checked', true);
			}
		
			fn_egov_all_prog_hide();
			
		if(cntntsTyCode == 'CTS01') {//없음
			
		} else if(cntntsTyCode == 'CTS02') {//게시판
			$('#bbsDiv').show();
		} else if(cntntsTyCode == 'CTS04') {//프로그램
			$('#progDiv').show();
		} else if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {//IFRAME or 포틀릿
			$('#urlTr').show();
		}
	}

	function fn_egov_all_prog_hide() {
	
		$('#bbsDiv').hide();
		$('#progDiv').hide();
		$('#urlTr').hide();
	}

	function fn_egov_select_comp() {

   		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
		
		$('#htmlTr').hide(1, fnTabHide);
		$('#urlTr').hide();
		if(compositionTyCode == 'LINK') {
			$('input:radio[name=htmlUseAt]:input[value=N]').attr('checked', true);
			$('input:radio[name=cntntsTyCode]:input[value=CTS01]').attr('checked', true);
			fn_egov_all_prog_hide();    					
			$('#urlTr').show();
			
		} else if(compositionTyCode == 'CNTNTS') {
			if($('input:radio[name=htmlUseAt]:checked').val() == "Y") {
				$('#htmlTr').show(1, fnTabShow);
			}
			
			var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();    					
    		if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {
    			$('#urlTr').show();
    		}
		}
   	}

   	function fn_egov_select_html() {
   		
   		var compositionTyCode = $('input:radio[name=compositionTyCode]:checked').val();
   		var htmlUseAt = $('input:radio[name=htmlUseAt]:checked').val();
   		
   		
   		if(compositionTyCode == 'LINK' && htmlUseAt == 'Y') {
   			$('input:radio[name=compositionTyCode]:input[value=CNTNTS]').attr('checked', true);
   			var cntntsTyCode = $('input:radio[name=cntntsTyCode]:checked').val();    					
    		if(cntntsTyCode == 'CTS05' || cntntsTyCode == 'CTS06') {
    			$('#urlTr').show();
    		} else {
   				$('#urlTr').hide();
    		}
   		}
   		
		if(htmlUseAt == 'Y') {
			$('#htmlTr').show(1, fnTabShow);
		} else if(htmlUseAt == 'N') {
			$('#htmlTr').hide(1, fnTabHide);
		} 
   	}
   	
   	function fn_egov_select_html_cn() {
   		var htmlsourcTyCode = $('input:radio[name=htmlsourcTyCode]:checked').val(); 
   		$('#div_HtmlCn_Html').hide();
		$('#div_HtmlCn_Jsp').hide();
		
   		if(htmlsourcTyCode == 'HTML') {
   			$('#div_HtmlCn_Html').show();
   		} else if(htmlsourcTyCode == 'JSP') {
   			$('#div_HtmlCn_Jsp').show();
   		} 
   	}
   	
	function fn_egov_select_html_mobile_cn() {
		var mobileHtmlsourcTyCode = $('input:radio[name=mobileHtmlsourcTyCode]:checked').val(); 
   		$('#div_MobileHtmlCn_Html').hide();
		$('#div_MobileHtmlCn_Jsp').hide();
		
   		if(mobileHtmlsourcTyCode == 'HTML') {
   			$('#div_MobileHtmlCn_Html').show();
   		} else if(mobileHtmlsourcTyCode == 'JSP') {
   			$('#div_MobileHtmlCn_Jsp').show();
   		} 
   	}

   	
   	function fnTabView(idx) {
   		
   		$('#tabLink01').removeClass('active');
   		$('#tabLink02').removeClass('active');
   		$('#tabLink' + idx).addClass('active');
   		
   		$('#tab01').hide();
   		$('#tab02').hide();    		
   		$('#tab' + idx).show();
   		
   	}

   	function fnTabShow() {
		
		if($('#tabLink01').attr('class') == 'active') {
			$('#tab01').show();
		} else if($('#tabLink02').attr('class') == 'active') {
			$('#tab02').show();
		}			
   	}
   	
	function fnTabHide() {
		$('#tab01').hide();
		$('#tab02').hide();
   	}
	
	$(document).ready( function() {
		var adfile_config = {
				storePath:"Menu.fileStorePath",
				appendPath:"",
				siteId:"${searchVO.siteId}",
				editorId:"${_EDITOR_ID}"
			};
	   		
	   		var moblie_adfile_config = {
				storePath:"Menu.fileStorePath",
				appendPath:"",
				siteId:"${searchVO.siteId}",
				editorId:"${_MOBILE_EDITOR_ID}"
			};
	   		
	   		$('#' + adfile_config.editorId).tinymce({
	   			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
	   			language : "ko", 
	   			theme : "advanced",
	   			skin : "o2k7",
	   			skin_variant : "silver",
	   			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
	   			theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
	   			theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
	   			theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
	   			theme_advanced_toolbar_location : "top",
	   			theme_advanced_toolbar_align : "left",
	   			theme_advanced_statusbar_location : "bottom",
	   			theme_advanced_resizing : true,
	   			content_css : "/template/manage/css/default.css",
	   			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
	   			convert_urls : false,
	   			adfile_external_param : adfile_config,
	   			setup : function(ed) {  
	   				ed.addButton('img', {            
	   					title : '이미지 삽입/편집',
	   					image : '/lib/tiny_mce/img/icon_01.gif',
	   					onclick : function() {                
	   						ed.execCommand('mceAdvImage');            
	   					}        
	   				});
	   				ed.addButton('attach', {            
	   					title : '파일 첨부',            
	   					image : '/lib/tiny_mce/img/icon_03.gif',
	   					onclick : function() {                
	   						ed.execCommand('mceAdvFile');            
	   					}        
	   				});    
	   			}
	   		});
	   		
	   		fn_egov_file_clean_action(adfile_config.editorId);
	   		
	   		$('#' + moblie_adfile_config.editorId).tinymce({
	   			script_url : '${_C_LIB}/tiny_mce/tiny_mce.js',
	   			language : "ko", 
	   			theme : "advanced",
	   			skin : "o2k7",
	   			skin_variant : "silver",
	   			plugins : "autolink,lists,table,advhr,advimage,advlink,inlinepopups,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,advlist,advfile,template",
	   			theme_advanced_buttons1 : "img,|,attach,|,media,|,template",//"image,file,media",
	   			theme_advanced_buttons2 : "code,|,fullscreen,|,preview,|,print,|,newdocument,|,undo,redo,|,cut,copy,paste,pastetext,pasteword,|,search,replace,|,link,unlink,cleanup,|,tablecontrols",
	   			theme_advanced_buttons3 : "fontselect,fontsizeselect,|,bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,outdent,indent,|,charmap,hr,removeformat,visualaid,|,sub,sup,|,ltr,rtl",
	   			theme_advanced_toolbar_location : "top",
	   			theme_advanced_toolbar_align : "left",
	   			theme_advanced_statusbar_location : "bottom",
	   			theme_advanced_resizing : true,
	   			content_css : "/template/manage/css/default.css",
	   			template_external_list_url : "/template/manage/docTemplate/mpm/template_list.js",
	   			convert_urls : false,
	   			adfile_external_param : moblie_adfile_config,
	   			setup : function(ed) {  
	   				ed.addButton('img', {            
	   					title : '이미지 삽입/편집',
	   					image : '/lib/tiny_mce/img/icon_01.gif',
	   					onclick : function() {                
	   						ed.execCommand('mceAdvImage');            
	   					}        
	   				});
	   				ed.addButton('attach', {            
	   					title : '파일 첨부',            
	   					image : '/lib/tiny_mce/img/icon_03.gif',
	   					onclick : function() {                
	   						ed.execCommand('mceAdvFile');            
	   					}        
	   				});    
	   			}
	   		});
	   		
	   		fn_egov_file_clean_action(moblie_adfile_config.editorId);
	   		
			$('input:radio[name=compositionTyCode]').click(fn_egov_select_comp);
			$('input:radio[name=htmlUseAt]').click(fn_egov_select_html);
			$('input:radio[name=htmlsourcTyCode]').click(fn_egov_select_html_cn);
			$('input:radio[name=mobileHtmlsourcTyCode]').click(fn_egov_select_html_mobile_cn);
			$('input:radio[name=cntntsTyCode]').click(fn_egov_select_prog);
			
			fn_egov_select_prog();
			fn_egov_select_html();
			fn_egov_select_html_cn();
			fn_egov_select_html_mobile_cn()
			fn_egov_select_comp(); 
			
			$('#tab02').hide();
			//$('#menuNm').focus();
	});

</script>
<style type="text/css">
<!--
.conf_top{overflow:hidden;}
.tab_menu{right:0;z-index:1000;}
.tab_menu li{float:left;background:#f8f8f8;width:150px;height:30px;text-align:center;border:1px solid #ccc;}
.tab_menu li a{display:block;padding:8px 0px;height:30px;}
.tab_menu li a:hover, .tab_menu li a.active{background:url('${_IMG}/tab_over.gif') 0 0 repeat;padding:8px 0px;height:15px;font-weight:bold;color:#32688c;}
.cont{position:relative;width:100%;border-top:1px solid #ccc;padding:0px 0;z-index:1001;}
.cont table{width:100%;}
-->
</style>  

<div id="cntnts">
    
<form:form commandName="mnuVO" name="mnu" method="post" action="" enctype="multipart/form-data" onsubmit="return false;">
	<form:hidden path="siteId"/>
	<form:hidden path="menuId"/>
	<form:hidden path="progrmId"/>
	<form:hidden path="atchFileId"/>
	<form:hidden path="mobileAtchFileId"/>
	
	<form:hidden path="htmlCn"/>
	<form:hidden path="mobileHtmlCn"/>
	
	<table class="chart2">
	<caption>메뉴 등록폼</caption>
	<colgroup>
		<col width="150"/>
		<col/>
	</colgroup>
		<tbody>
			<tr>
				<th><em>*</em> <label>메뉴명</label></th>
				<td>
					<form:input path="menuNm" cssClass="inp_long" size="50" maxlength="50" />
					<div><form:errors path="menuNm"/></div>      	 
				</td>
			</tr>
			<tr>
              <th><label for="imageFileNm">스마트아이콘</label></th>
              <td>
              	<input type="file" name="imageFileIdFile" id="imageFileNm" title="스마트아이콘" class="input300 inp" >
              	<c:if test="${not empty mnuVO.imageFileNm}"><br/><img src="${MenuFileStoreWebPath}${mnuVO.siteId}/${mnuVO.imageFileNm}"/></c:if>
              </td>
            </tr>
            <tr>
				<th> <label>노출대상</label></th>
				<td>
					일반인 : <input type="checkbox" name="generalUseAt"  value="Y" <c:if test="${mnuVO.generalUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					학생 : <input type="checkbox" name="stdntUseAt"  value="Y" <c:if test="${mnuVO.stdntUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					학부모 : <input type="checkbox" name="stdnprntUseAt"  value="Y" <c:if test="${mnuVO.stdnprntUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
					교직원 : <input type="checkbox" name="profsrUseAt"  value="Y" <c:if test="${mnuVO.profsrUseAt == 'Y'}"> checked="checked"</c:if>/>&nbsp;
				</td>
			</tr>
			<tr>
				<th><em>*</em> <label>구성유형</label></th>
				<td>
					링크 구성 : <form:radiobutton path="compositionTyCode"  value="LINK" />&nbsp;
	                                컨텐츠 구성 : <form:radiobutton path="compositionTyCode"  value="CNTNTS"/>
	            	<br/><form:errors path="compositionTyCode" />	 
				</td>
			</tr>
			<tr>
				<th><em>*</em> <label>HTML 사용여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="htmlUseAt"  value="Y" />&nbsp;
          	     	<spring:message code="button.no" /> : <form:radiobutton path="htmlUseAt"  value="N"  />
		            <br/><form:errors path="htmlUseAt" />
				</td>
			</tr>
			<tr id="htmlTr">
				<th><label>HTML</label></th>
				<td>
					<div class="conf_top">
				    	<ul class="tab_menu">
							<li><a href="#tab1" id="tabLink01" onclick="fnTabView('01');return false;" class="active">WEB</a></li>
							<li><a href="#tab2" id="tabLink02" onclick="fnTabView('02');return false;">MOBILE</a></li>
						</ul>
					</div>
					
					<div id="tab01" class="cont">
						<table>
							<caption>메뉴 등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<tr>
										<th> <label>스타일시트</label></th>
										<td>
											<form:textarea path="styleCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="styleCn" />
										</td>
									</tr>
									<tr>
										<th> <label>자바스크립트</label></th>
										<td>
											<form:textarea path="scriptCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="scriptCn" />
										</td>
									</tr>
									<tr>
										<th> <label>내용유형</label></th>
										<td>
											HTML : <form:radiobutton path="htmlsourcTyCode"  value="HTML"/>&nbsp;
							                JSP : <form:radiobutton path="htmlsourcTyCode"  value="JSP"/>
							            	<br/><form:errors path="htmlsourcTyCode" />	 
										</td>
									</tr>
									<tr>
										<th> <label>내용</label></th>
										<td>
											<div id="div_HtmlCn_Html">
												<textarea id="htmlCn_Html" rows="30"style="width:90%;" class="inp_default" >${mnuVO.htmlCn}</textarea>
												<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								                	<c:param name="editorId" value="${_EDITOR_ID}"/>
													<c:param name="estnAt" value="N" />
											    	<c:param name="param_atchFileId" value="${mnuVO.atchFileId}" />
											    	<c:param name="imagePath" value="${_IMG }"/>
												</c:import>
											</div>
											<div id="div_HtmlCn_Jsp"><textarea id="htmlCn_Jsp" rows="30"style="width:90%;" class="inp_default" >${mnuVO.htmlCn}</textarea></div>
										</td>
									</tr>
								</tbody>
						</table>
					</div>
					<div id="tab02" class="cont">
						<table>
							<caption>메뉴 등록폼</caption>
							<colgroup>
								<col width="130"/>
								<col/>
							</colgroup>
								<tbody>
									<tr>
										<th> <label>스타일시트</label></th>
										<td>
											<form:textarea path="mobileStyleCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="mobileStyleCn" />
										</td>
									</tr>
									<tr>
										<th> <label>자바스크립트</label></th>
										<td>
											<form:textarea path="mobileScriptCn" rows="10" cssStyle="width:90%;" cssClass="inp_default" /> 
								            <form:errors path="mobileScriptCn" />
										</td>
									</tr>
									<tr>
										<th> <label>내용유형</label></th>
										<td>
											HTML : <form:radiobutton path="mobileHtmlsourcTyCode"  value="HTML" onclick="fn_egov_select_comp()" />&nbsp;
							                JSP : <form:radiobutton path="mobileHtmlsourcTyCode"  value="JSP" onclick="fn_egov_select_comp()" />
							            	<br/><form:errors path="mobileHtmlsourcTyCode" />	 
										</td>
									</tr>
									<tr>
										<th> <label>내용</label></th>
										<td>
											<div id="div_MobileHtmlCn_Html">
												<textarea id="mobileHtmlCn_Html" rows="30"style="width:90%;" class="inp_default" >${mnuVO.mobileHtmlCn}</textarea>
												<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								                	<c:param name="editorId" value="${_MOBILE_EDITOR_ID}"/>
													<c:param name="estnAt" value="N" />
											    	<c:param name="param_atchFileId" value="${mnuVO.mobileAtchFileId}" />
											    	<c:param name="imagePath" value="${_IMG }"/>
												</c:import>
											</div>
											<div id="div_MobileHtmlCn_Jsp"><textarea id="mobileHtmlCn_Jsp" rows="30"style="width:90%;" class="inp_default" >${mnuVO.mobileHtmlCn}</textarea></div>
										</td>
									</tr>
								</tbody>
						</table>
					</div>
				</td>
			</tr>			
			<tr>
				<th><em>*</em> <label>컨텐츠유형</label></th>
				<td>
					<form:radiobuttons path="cntntsTyCode" items="${mnuCntsList}" itemLabel="codeNm" itemValue="code"/>
		        	<div><form:errors path="cntntsTyCode"/></div>
		        	<div id="bbsDiv" style="display:none">
		        			<select name="selectBbs" id="selectBbs" class="searchCate inp">
		        				<option value="">--- 선택하세요 ---</option>
		        		  		<c:forEach var="result" items="${bbsList}" varStatus="status">        		  			
		        		  			<option value="<c:out value="${result.bbsId}"/>" <c:if test="${mnuVO.progrmId == result.bbsId}">selected="selected"</c:if>><c:out value="${result.bbsNm}"/></option>
		        		  		</c:forEach>
		        	  		</select>
		        	</div>
		        	<div id="progDiv" style="display:none">
		        			<select name="selectProgrmId" id="selectProgrmId" class="searchCate inp">
		        				<option value="">--- 선택하세요 ---</option>
		        		  		<c:forEach var="result" items="${progList}" varStatus="status">
		        		  			<option value="<c:out value="${result.code}"/>" <c:if test="${mnuVO.progrmId == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
		        		  		</c:forEach>
		        	  		</select>
		        	  		프로그램인자:<form:input path="progrmFactr" size="30" cssClass="inp" maxlength="30" />
		        	</div>        	
				</td>
			</tr>
			<tr id="urlTr">
				<th> <label>URL</label></th>
				<td>
					<form:input path="url" size="100" cssClass="inp" maxlength="255" />
		       		<div><form:errors path="url"/></div>  	 
				</td>
			</tr>
			<tr>
				<th> <label>새창여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="nwdAt"  value="Y" />&nbsp;
		            <spring:message code="button.no" /> : <form:radiobutton path="nwdAt"  value="N" />
		            <br/><form:errors path="nwdAt" />
				</td>
			</tr>
			<tr>
				<th> <label>노출여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="expsrUseAt"  value="Y" />&nbsp;
		            <spring:message code="button.no" /> : <form:radiobutton path="expsrUseAt"  value="N" />
		            <br/><form:errors path="expsrUseAt" />
				</td>
			</tr>
			<tr <c:if test="${empty mnuVO.upperMenuId}">style="display:none"</c:if>>
				<th> <label>노출순서</label></th>
				<td>
					<form:input path="sortOrdr" size="10" cssClass="inp"/>
		       		<div><form:errors path="sortOrdr"/></div>  	
				</td>
			</tr>
			<tr>
				<th> <label>모바일사용여부</label></th>
				<td>
					<spring:message code="button.yes" /> : <form:radiobutton path="mobileUseAt"  value="Y" />&nbsp;
		            <spring:message code="button.no" /> : <form:radiobutton path="mobileUseAt"  value="N" />
		            <br/><form:errors path="mobileUseAt" />
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="btn_r">
       	<c:url var="listUrl" value="/mng/sym/mpm/selectMpmHistoryList.do">
       		<c:param name="siteId" value="${param.siteId}"/>
       		<c:param name="menuId" value="${searchVO.menuId}" />
       		<c:param name="pageIndex" value="${searchVO.pageIndex}" />
			<c:param name="searchCnd" value="${searchVO.searchCnd}" />
			<c:param name="searchWrd" value="${searchVO.searchWrd}" />
     	</c:url>
        <a href="${listUrl}"><img src="${_IMG}/btn/btn_list.gif" alt="목록"/></a>
	</div>
	
</form:form>

    </div>        

<c:import url="/EgovPageLink.do?link=/mng/template/popBottom" charEncoding="utf-8"/>