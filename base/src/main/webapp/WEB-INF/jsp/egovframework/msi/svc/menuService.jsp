<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:choose>
	<c:when test="${param.menuTarget eq 'Main'}">
		<c:choose>
			<c:when test="${param.menuType eq 'FullDisplay'}">
				<c:set var="mpmDepth01Count" value="1"/>
				<c:forEach var="mpmDepth01" items="${mpmList}" varStatus="status">
					<c:if test="${mpmDepth01.menuLevel eq 1 and mpmDepth01Count <= 6 and mpmDepth01.expsrUseAt eq 'Y'}">
					<li class="gnb"><a href="<c:out value="${mpmDepth01.menuWebPath}"/>" <c:if test="${mpmDepth01.nwdAt eq 'Y'}">target="_blank"</c:if> class="mMenu"><c:out value="${mpmDepth01.menuNm}"/></a>
						<div class="sub_wrap">
							<div class="arrow_gnb">
								<div class="arrow_gnb${mpmDepth01Count}"><img src="${_IMG}/main/arrow_top.png" alt=""/></div>
							</div>
							<ul class="sub_gnb${mpmDepth01Count}" style=" background: url('${MenuFileStoreWebPath}${mpmDepth01.siteId}/${mpmDepth01.imageFileNm}') 0px 5px no-repeat; ">
								<c:forEach var="mpmDepth02" items="${mpmList}">
									<c:if test="${mpmDepth02.menuLevel eq 2 and fn:contains(mpmDepth02.menuPathById, mpmDepth01.menuId) and mpmDepth02.expsrUseAt eq 'Y'}">
										<li class="sub_title"><a href="<c:out value="${mpmDepth02.menuWebPath}"/>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>  class="sub_tit"><c:out value="${mpmDepth02.menuNm}"/></a>
											<ul class="sub_cont">
												<c:forEach var="mpmDepth03" items="${mpmList}">
													<c:if test="${mpmDepth03.menuLevel eq 3 and fn:contains(mpmDepth03.menuPathById, mpmDepth02.menuId) and mpmDepth03.expsrUseAt eq 'Y'}">
														<li><a href="<c:out value="${mpmDepth03.menuWebPath}"/>" <c:if test="${mpmDepth03.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth03.menuNm}"/></a></li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</li>
					<c:set var="mpmDepth01Count" value="${mpmDepth01Count + 1}"/>
					</c:if>
				</c:forEach>
			</c:when>
			<c:when test="${param.menuType eq 'Simple2Depth'}">
				<c:set var="mpmDepth01Count" value="1"/>
				<c:forEach var="mpmDepth01" items="${mpmList}" varStatus="status">
				<c:if test="${mpmDepth01.menuLevel eq 1 and mpmDepth01Count <= 5 and mpmDepth01.expsrUseAt eq 'Y'}">
				<li class="menu${mpmDepth01Count }">
					<a href="<c:out value="${mpmDepth01.menuWebPath}"/>" <c:if test="${mpmDepth01.nwdAt eq 'Y'}">target="_blank"</c:if> class="menuNm">
						<c:out value="${mpmDepth01.menuNm}"/>
						<%-- <img src="${LytFileStoreWebPathByWebFile}sit/${siteInfo.lytTmplatId}/images/common/menu0${mpmDepth01Count}_off.png" alt="<c:out value="${mpmDepth01.menuNm}"/>"/> --%>
					</a>
					<div>										
						<ul>
							<c:forEach var="mpmDepth02" items="${mpmList}">
							<c:set var="mpmDepth02Count" value="1"/>
							<c:if test="${mpmDepth02.menuLevel eq 2 and fn:contains(mpmDepth02.menuPathById, mpmDepth01.menuId) and mpmDepth02.expsrUseAt eq 'Y'}">
								<li>
									<a href="<c:out value="${mpmDepth02.menuWebPath}"/>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>>
										<c:out value="${mpmDepth02.menuNm}"/>
									</a>													
								</li>
								<c:set var="mpmDepth02Count" value="${mpmDepth02Count + 1 }"/>
							</c:if>
							<%-- <c:if test="${mpmDepth02Count eq 1}"><li class="hdn">&nbsp;</li></c:if> --%>
							</c:forEach>
						</ul>
					</div>
				</li>
				<c:set var="mpmDepth01Count" value="${mpmDepth01Count + 1}"/>
				</c:if>
				<c:if test="${fn:length(mpmList) eq 0}"><li class="alt_msg">메뉴를 생성하세요</li></c:if>
				</c:forEach>
			</c:when>
		</c:choose>
	</c:when>
	<c:when test="${param.menuTarget eq 'Sub'}">
		<c:forEach var="mpmDepth02" items="${mpmList}" varStatus="status">
			<c:if test="${mpmDepth02.menuLevel eq 2 and fn:contains(mpmDepth02.menuPathById, currRootMpm.menuId) and mpmDepth02.expsrUseAt eq 'Y'}">
				<c:choose>
					<c:when test="${mpmDepth02.menuLastNodeAt eq 'Y'}">
						<li>
							<a href="<c:out value="${mpmDepth02.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId)}">on</c:if>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth02.menuNm}"/></a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="<c:out value="${mpmDepth02.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId)}">on</c:if>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth02.menuNm}"/></a>
							<ul class="depth02">
								<c:forEach var="mpmDepth03" items="${mpmList}">
									<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId) and mpmDepth03.menuLevel eq 3 and fn:contains(mpmDepth03.menuPathById, mpmDepth02.menuId) and mpmDepth03.expsrUseAt eq 'Y'}">
										<li><a href="<c:out value="${mpmDepth03.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth03.menuId)}">on</c:if>" <c:if test="${mpmDepth03.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth03.menuNm}"/></a></li>
									</c:if>
								</c:forEach> 
							</ul>
						</li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</c:when>
	<c:when test="${param.menuTarget eq 'Sub_mobile'}">
		<c:forEach var="mpmDepth02" items="${mpmList}" varStatus="status">
			<c:if test="${mpmDepth02.menuLevel eq 2 and fn:contains(mpmDepth02.menuPathById, currRootMpm.menuId) and mpmDepth02.expsrUseAt eq 'Y' and mpmDepth02.mobileUseAt eq 'Y'}">
				<c:choose>
					<c:when test="${mpmDepth02.menuLastNodeAt eq 'Y'}">
						<li>
							<a href="<c:out value="${mpmDepth02.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId)}">on</c:if>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth02.menuNm}"/></a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="<c:out value="${mpmDepth02.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId)}">on</c:if>" <c:if test="${mpmDepth02.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth02.menuNm}"/></a>
							<ul class="depth02">
								<c:forEach var="mpmDepth03" items="${mpmList}">
									<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth02.menuId) and mpmDepth03.menuLevel eq 3 and fn:contains(mpmDepth03.menuPathById, mpmDepth02.menuId) and mpmDepth03.expsrUseAt eq 'Y'}">
										<li><a href="<c:out value="${mpmDepth03.menuWebPath}"/>" class="<c:if test="${fn:contains(currMpm.menuPathById, mpmDepth03.menuId)}">on</c:if>" <c:if test="${mpmDepth03.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${mpmDepth03.menuNm}"/></a></li>
									</c:if>
								</c:forEach> 
							</ul>
						</li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</c:when>
</c:choose>