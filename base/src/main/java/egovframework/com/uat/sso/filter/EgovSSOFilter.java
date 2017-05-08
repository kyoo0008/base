package egovframework.com.uat.sso.filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.ui.webapp.AuthenticationProcessingFilter;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.service.LoginInfoVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovSsoSecureEncryptUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;


/**
 * 
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 8. 2.
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information) 
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 2.    서준식        최초생성
 *  
 *  </pre>
 */

public class EgovSSOFilter implements Filter{
	
	private FilterConfig config;
	
	protected final static Log LOG = LogFactory.getLog(EgovSSOFilter.class);

	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;		
		
		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(httpRequest, httpResponse);
		
		if(!EgovStringUtil.isEmpty(httpRequest.getParameter("token"))) {			
			try {
				ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
				EgovLoginService loginService = (EgovLoginService)act.getBean("loginService");
				EgovSiteManageService siteManageService = (EgovSiteManageService)act.getBean("SiteManageService");
				SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(httpRequest);
				String encrypToken = httpRequest.getParameter("token");
				if(loginVO == null) {
					String userId = EgovSsoSecureEncryptUtil.generateDecryptToken(encrypToken);
					
					LoginInfoVO loginInfoVO = new LoginInfoVO();
					loginInfoVO.setLoginId(userId);
					loginInfoVO.setSiteId(siteVO.getSiteId());
					loginInfoVO.setLoginIdntfcId(encrypToken);
					loginInfoVO.setSessionId(httpRequest.getSession().getId());
					
					LoginVO resultVO = loginService.searchSSOLogin(loginInfoVO);
					
					if(resultVO != null && !EgovStringUtil.isEmpty(resultVO.getId())) {
						//토큰정보 세션저장 및 로그인후 이동경로 설정
						EgovSessionCookieUtil.setSessionAttribute(httpRequest, "sessionSecureToken", encrypToken);
						EgovSessionCookieUtil.setSessionAttribute(httpRequest, "returnUrl", httpRequest.getRequestURI() + "?" + EgovStringUtil.nullConvert(httpRequest.getQueryString()).replaceAll("token=[^&]*&*","") );
						
						AuthenticationProcessingFilter springSecurity = null;
						
						@SuppressWarnings("rawtypes")
						Map beans = act.getBeansOfType(AuthenticationProcessingFilter.class);
						 if (beans.size() > 0) {
					        	springSecurity = (AuthenticationProcessingFilter)beans.values().toArray()[0];
					        } else {
					        	LOG.error("No AuthenticationProcessingFilter");
					        	throw new IllegalStateException("No AuthenticationProcessingFilter");
					        }
						//springSecurity.setContinueChainBeforeSuccessfulAuthentication(false);	// false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

						LOG.debug("before security filter call....");
						springSecurity.doFilter(
								new RequestWrapperForSecurity(httpRequest, resultVO.getId(), resultVO.getPassword()), 
								httpResponse, chain);
						LOG.debug("after security filter call....");
					}
				} else {
					if(!loginVO.getSsoToken().equals(encrypToken)) {
						String userId = null;
						boolean isErrored = false;
						try {
							userId = EgovSsoSecureEncryptUtil.generateDecryptToken(encrypToken);
						} catch(Exception ex) {
							isErrored = true;
						}
						//db의 로그인토큰정보 수정
						if(!isErrored && !EgovStringUtil.isEmpty(userId) && loginVO.getId().equals(userId)) {
							LoginInfoVO loginInfoVO = new LoginInfoVO();
							loginInfoVO.setLoginId(loginVO.getId());
							loginInfoVO.setSiteId(siteVO.getSiteId());
							loginInfoVO.setLoginIdntfcId(loginVO.getSsoToken());
							loginInfoVO.setLoginIp(EgovClntInfo.getClntIP(httpRequest));
							loginService.insertLoginInfo(loginInfoVO);
							
							loginVO.setSsoToken(encrypToken);
							
							//로그아웃요청이 있었다면 취소한다.
							loginService.removeLogoutList(loginInfoVO);
						}
					}
					
					//토큰파라메터를 삭제하고 재이동
					EgovSessionCookieUtil.setSessionAttribute(httpRequest, "returnUrl", httpRequest.getRequestURI() + "?" + EgovStringUtil.nullConvert(httpRequest.getQueryString()).replaceAll("(token|logoutToken)=[^&]*&*","") );					
					httpResponse.sendRedirect(httpRequest.getContextPath() +  "/uat/uia/actionLogoutMain.do");
					return;
				}
			
			} catch(Exception ex) {
				LOG.debug("Local SSO authentication Fail : " + ex.getMessage());
			}
		} else if(!EgovStringUtil.isEmpty(httpRequest.getParameter("logoutToken"))) {
			try {
				ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
				EgovLoginService loginService = (EgovLoginService)act.getBean("loginService");
				EgovSiteManageService siteManageService = (EgovSiteManageService)act.getBean("SiteManageService");
				SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(httpRequest);
				
				String decodeToken = httpRequest.getParameter("logoutToken");
				String userId = EgovSsoSecureEncryptUtil.generateDecryptToken(decodeToken);
				
				LoginInfoVO loginInfoVO = new LoginInfoVO();
				loginInfoVO.setLoginId(userId);
				loginInfoVO.setSiteId(siteVO.getSiteId());
				loginInfoVO.setLoginIdntfcId(decodeToken);
				loginInfoVO.setSessionId(httpRequest.getSession().getId());
				
				loginService.addLogoutList(loginInfoVO);				
			} catch(Exception ex) {
				LOG.debug("Local SSO logout Fail : " + ex.getMessage());
			}
		} 
		
		if(loginVO != null){
			try {
				ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
				EgovLoginService loginService = (EgovLoginService)act.getBean("loginService");
				EgovSiteManageService siteManageService = (EgovSiteManageService)act.getBean("SiteManageService");
				SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(httpRequest);
				
				LoginInfoVO loginInfoVO = new LoginInfoVO();
				loginInfoVO.setLoginId(loginVO.getId());
				loginInfoVO.setSiteId(siteVO.getSiteId());
				loginInfoVO.setLoginIdntfcId(loginVO.getSsoToken());
				if(loginService.getLogoutListExists(loginInfoVO)) {
					if(loginService.selectLoginExistsForLoginIdntfcIdCnt(loginInfoVO) == 0) {
						loginService.removeLogoutList(loginInfoVO);
						httpRequest.getSession().invalidate();
						//로그아웃 후 이동경로 설정
						EgovSessionCookieUtil.setSessionAttribute(httpRequest, "returnUrl", httpRequest.getRequestURI() + "?" + EgovStringUtil.nullConvert(httpRequest.getQueryString()).replaceAll("(token|logoutToken)=[^&]*&*","") );
						
						httpResponse.sendRedirect(httpRequest.getContextPath() +  "/uat/uia/actionLogoutMain.do");
						return;
					}
				}
				
			} catch(Exception ex) {
				LOG.debug("Local SSO logout Fail : " + ex.getMessage());
			}
		}
	
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;		
	}

}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {	
	private String username = null;
	private String password = null;
	
	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);
		
		this.username = username;
		this.password = password;
	}
	
	@Override
	public String getRequestURI() {
		return ((HttpServletRequest)super.getRequest()).getContextPath() + "/j_spring_security_check";
	}

	@Override
	public String getParameter(String name) {
        if (name.equals("j_username")) {
        	return username;
        }
        
        if (name.equals("j_password")) {
        	return password;
        }
        
        return super.getParameter(name);
    }
}

