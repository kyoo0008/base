<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="HPG_IMG" value="${pageContext.request.contextPath}/template/homepage/011/images"/>

<c:import url="/msi/tmplatHead.do" charEncoding="utf-8"/>
	
						<div id="all_sitemap">
						<c:forEach var="result1" items="${mnMnuList}" varStatus="status1">
						<c:if test="${(result1.expsrUseAt eq 'Y') and (result1.menuLevel eq 1)}">
							<c:url var="menuURL" value='${result1.menuWebPath}'></c:url>
							<c:if test="${fn:indexOf(result1.menuWebPath, 'menuId') eq -1}">
								<c:url var="menuURL" value='${result1.menuWebPath}'><c:param name="menuId" value="${result1.upperMenuId}"></c:param></c:url>
							</c:if>
								<dl class="site01">
									<dt>
										<c:choose>
											<c:when test="${fn:startsWith(result1.menuWebPath, 'javascript')}">
												<a href="#pageLink" onclick="${result1.menuWebPath};return false;">
											</c:when>
											<c:otherwise>
												<a href="${menuURL}" <c:if test="${result1.nwdAt eq 'Y'}">target="_blank"</c:if>>
											</c:otherwise>
										</c:choose>
										<%-- 
										<img src="${HPG_IMG}/etc/site_tt_0${status1.count}.gif" alt="<c:out value="${result1.menuNm}" />" />
										--%>
										<c:out value="${result1.menuNm}" />
										</a>
									</dt>
									<dd>
										<ul>
											<c:forEach var="result2" items="${mnMnuList}" varStatus="status2">
												<c:if test="${result1.menuId eq result2.upperMenuId and result2.expsrUseAt eq 'Y'}">
													<c:url var="menuURL" value='${result2.menuWebPath}'></c:url>
										        	<c:if test="${fn:indexOf(result2.menuWebPath, 'menuId') eq -1}">
														<c:url var="menuURL" value='${result2.menuWebPath}'><c:param name="menuId" value="${result2.menuId}"></c:param></c:url>
													</c:if>
													<li>
														<c:choose>
															<c:when test="${fn:startsWith(result2.menuWebPath, 'javascript')}">
																<a href="#pageLink" onclick="${result2.menuWebPath};return false;"><c:out value="${result2.menuNm}" /></a>
															</c:when>
															<c:otherwise>
																<a href="${menuURL}" <c:if test="${result2.nwdAt eq 'Y'}">target="_blank"</c:if>><c:out value="${result2.menuNm}" /></a>
															</c:otherwise>
														</c:choose>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</dd>
								</dl>
							</c:if>
						</c:forEach>
						
						</div>
				
	

<c:import url="/msi/tmplatBottom.do" charEncoding="utf-8"/>