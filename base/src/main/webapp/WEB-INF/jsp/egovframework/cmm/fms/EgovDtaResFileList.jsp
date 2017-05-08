<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="CMMN_IMG" value="${pageContext.request.contextPath}/template/common/images"/>
<% 
 /**
  * @Class Name : EgovDtaResFileList.jsp
  * @Description : 파일 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.26  이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.26
  *  @version 1.0 
  *  @see
  *  
  */
%>

          <c:forEach var="fileVO" items="${fileList}" varStatus="status">
           <li>
           		<span class="blue"><c:out value="${fileVO.orignlFileNm}"/></span>
 			    <c:url var="downLoad" value="/cmm/fms/DtaResFileDown.do">
					<c:param name="atchFileId" value="${fileVO.atchFileId}"/>
					<c:param name="fileSn" value="${fileVO.fileSn}"/>
					<c:param name="bbsId" value="00000000000000000000"/>
					<c:param name="trgetId" value="${param.trgetId}"/>
					<c:param name="nttId" value="${param.requstNo}"/>
 			    </c:url>  			       
 			    <a href="<c:out value="${downLoad}"/>" title="새창으로 다운로드 바로가기" target="_blank"><img src="${CMMN_IMG}/sub/board/btn_download.gif" class="imgbtnwithtxt" alt="다운로드" /></a>
           </li>
          </c:forEach>