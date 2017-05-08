package egovframework.com.sym.log.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.service.EgovLogManageService;
import egovframework.com.sym.log.service.WebLog;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : EgovWebLogInterceptor.java
 * @Description : 웹로그 생성을 위한 인터셉터 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 9.   이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 9.
 * @version
 * @see
 *
 */
public class EgovWebLogInterceptor extends HandlerInterceptorAdapter {

	@Resource(name="EgovLogManageService")
	private EgovLogManageService logManageService;
		
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	String[] disableUrlList = new String[]
	            {
					"/mng/",
					"/validator.do", 
					"/msi/tmplatHead.do",
					"/msi/tmplatBottom.do",
					"/cmm/fms/",
					"/cop/sns/",
					"/uss/ion/pwm/openPopupManage.do"
				};
	/**
	 * 웹 로그정보를 생성한다.
	 * 
	 * @param HttpServletRequest request, HttpServletResponse response, Object handler 
	 * @return 
	 * @throws Exception 
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler, ModelAndView modeAndView) throws Exception {
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			int SE_CODE = Integer.parseInt(user.getUserSeCode());
			if(SE_CODE == 10) {
				user.setUserSe(siteVO.getSiteId().equals(user.getSiteId())? user.getUserSeCode() : "02");
			}
		}
		
		String reqURL = request.getRequestURI();		
		try {
			String webLogWrite = (String)EgovSessionCookieUtil.getSessionAttribute(request, "webLogWrite");
			if(!"Y".equals(webLogWrite)) {
				String menuId = request.getParameter("menuId");
				String cmmntyId = request.getParameter("cmmntyId");
				
				if(EgovStringUtil.isEmpty(menuId)) {
					menuId = cmmntyId;
					
					if("/index.do".equals(reqURL)) {
						menuId = "99999999990000000000";
					}
				}
							
				//if(("/".equals(reqURL) || reqURL.endsWith(".do")) && !isExistsDeny(reqURL)) {
				if(!EgovStringUtil.isEmpty(menuId)) {
					
					String siteId = request.getParameter("siteId");
					String sysTyCode = "";			
					
					if(EgovStringUtil.isEmpty(siteId)) {
						siteId = siteVO.getSiteId();
						sysTyCode = siteVO.getSysTyCode();
					}
					
					String userId = "";
					String mobileAt = "N";
					
					WebLog webLog = new WebLog();
					
			    	if(user != null) {
						userId = user.getId();
			    	}
			
			    	if(egovframework.com.utl.fcc.service.EgovHttpUtil.getIsMobile(request)) {
			    		//reqURL = EgovStringUtil.replace(reqURL, "/hpg/", "/mbl/");
			    		mobileAt = "Y";
			    		
			    	}
			    	
			    	webLog.setSiteId(siteId);
			    	webLog.setSysTyCode(sysTyCode);
			    	webLog.setMenuId(menuId);
					webLog.setUrl(reqURL);
					webLog.setRqesterId(userId);
					webLog.setRqesterIp(EgovClntInfo.getClntIP(request));
					webLog.setMobileAt(mobileAt);
					
					logManageService.logInsertWebLog(webLog);
					
					EgovSessionCookieUtil.setSessionAttribute(request, "webLogWrite", "Y");
				}
			}
		
		} catch(Exception ex) {
			System.out.println("Error EgovWebLogInterceptor : " + ex.getMessage());
		}
		
		
	}
	
	private boolean isExistsDeny(String url) {
		boolean isExists = false;
		for(int i=0; i < disableUrlList.length; i++) {
			if(url.startsWith(disableUrlList[i])) {
				isExists = true;
				break;
			}
		}
		
		return isExists;
	}
}
