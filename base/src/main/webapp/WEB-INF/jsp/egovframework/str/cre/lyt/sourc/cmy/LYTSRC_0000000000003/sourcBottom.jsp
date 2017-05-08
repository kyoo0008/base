<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	
					</div>	
				</div>	
				
				<div id="footer">
					<ul>
						<li><a href="${_WEB_FULL_PATH}/msi/indvdlInfoPolicy.do"><spring:message code="etc.link.indvdlInfoPolicy" /></a><span>|</span></li>
						<li><a href="${_WEB_FULL_PATH}/msi/useStplat.do"><spring:message code="etc.link.useStplat" /></a><span>|</span></li>
						<li><a href="${_WEB_FULL_PATH}/msi/emailColctPolicy.do"><spring:message code="etc.link.emailColctPolicy" /></a></li>
					</ul>

					<p>${siteInfo.adresReplcText}</p>
				</div>

			</div>
		</div>

	 </body>
</html>