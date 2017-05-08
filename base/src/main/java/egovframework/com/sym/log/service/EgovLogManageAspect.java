package egovframework.com.sym.log.service;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovSsoSecureEncryptUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;

/**
 * @Class Name : EgovLogManageAspect.java
 * @Description : 시스템 로그 생성을 위한 ASPECT 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭   최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
public class EgovLogManageAspect {
	
	@Resource(name="EgovLogManageService")
	private EgovLogManageService logManageService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "loginService")
    private EgovLoginService loginService;
		
	protected final static Log LOG = LogFactory.getLog(EgovLogManageAspect.class);
	
	/**
	 * 로그인 로그정보를 생성한다.
	 * EgovLoginController.actionMain Method
	 * 
	 * @param 
	 * @return void
	 * @throws Exception 
	 */
	public void logLogin(JoinPoint joinPoint) throws Throwable {
		
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];		
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		String siteId = siteVO.getSiteId();
		String sysTyCode = siteVO.getSysTyCode();
		
		String id = "";
		String ip = EgovClntInfo.getClntIP(request);
		/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, null);
    	if(isAuthenticated.booleanValue()) {
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, null);
			id = user.getId();
			
			
			//로그인현황
			String secureToken = null;
			if("Y".equals((String)EgovSessionCookieUtil.getSessionAttribute(request, "isMasterLogin"))) {
				secureToken = EgovSsoSecureEncryptUtil.generateEncyptToken(EgovSsoSecureEncryptUtil.generateEncyptKey(), id);
			} else {
				secureToken = (String)EgovSessionCookieUtil.getSessionAttribute(request, "sessionSecureToken");
			}
			
			if(secureToken != null) {
			
				//LoginVO에 토큰 저장
				user.setSsoToken(secureToken);				
				
				LoginInfoVO loginInfoVO = new LoginInfoVO();
		        loginInfoVO.setLoginId(id);
		        loginInfoVO.setLoginIdntfcId(secureToken);
		        loginInfoVO.setSiteId(siteId);
		        loginInfoVO.setLoginIp(ip);
		        loginInfoVO.setSessionId(request.getSession().getId());
		        
		        //로그인현황   기록
		        loginService.insertLoginInfo(loginInfoVO);
			}
			
			EgovSessionCookieUtil.removeSessionAttribute(request, "isMasterLogin");
			EgovSessionCookieUtil.removeSessionAttribute(request, "sessionSecureToken");
    	}

    	LoginLog loginLog = new LoginLog();
    	loginLog.setSiteId(siteId);
    	loginLog.setSysTyCode(sysTyCode);
    	loginLog.setLoginId(id);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        logManageService.logInsertLoginLog(loginLog);
        
	}
	
	/**
	 * 로그아웃 로그정보를 생성한다.
	 * EgovLoginController.actionLogout Method
	 * 
	 * @param 
	 * @return void
	 * @throws Exception 
	 */
	public void logLogout(JoinPoint joinPoint) throws Throwable {
		
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];		
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		String siteId = siteVO.getSiteId();
		String sysTyCode = siteVO.getSysTyCode();
		
		String id = "";
		String ip = EgovClntInfo.getClntIP(request);

		/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, null);
    	if(isAuthenticated.booleanValue()) {
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, null);
			id = user.getId();
			
			//로그인현황
	        LoginInfoVO loginInfoVO = new LoginInfoVO();
	        loginInfoVO.setLoginId(id);
	        loginInfoVO.setSiteId(siteId);        
	        loginInfoVO.setLoginIdntfcId(user.getSsoToken());
	        //접속된 사이트에 로그아웃 요청
	        loginService.allSiteLogoutRequest(loginInfoVO);
	        //로그인현황 삭제
	        loginService.deleteLoginInfo(loginInfoVO);
    	}

    	LoginLog loginLog = new LoginLog();
    	loginLog.setSiteId(siteId);
    	loginLog.setSysTyCode(sysTyCode);
    	loginLog.setLoginId(id);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("O"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        logManageService.logInsertLoginLog(loginLog);
        
	}
	
	 public void logDataUse(JoinPoint joinPoint, Map commandMap) throws Throwable {
		 
		 try{
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[1];		
			
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		String siteId = siteVO.getSiteId();
		String sysTyCode = siteVO.getSysTyCode();
		
		String id = "";
		String ip = EgovClntInfo.getClntIP(request);

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, null);
    	if(user != null) {
			id = user.getId();
    	}

    	DataUseLog log = new DataUseLog();
    	log.setSiteId(siteId);
    	log.setSysTyCode(sysTyCode);
    	log.setTrgetId((String)commandMap.get("trgetId"));
    	log.setBbsId((String)commandMap.get("bbsId"));
    	log.setNttId((String)commandMap.get("nttId"));
    	log.setAtchFileId((String)commandMap.get("atchFileId"));
    	log.setFileSn((String)commandMap.get("fileSn"));
    	log.setRqesterIp(ip);
    	log.setRqesterId(id);
        logManageService.logInsertDataUseLog(log);
		 } catch(Exception ex) {
			 ex.printStackTrace();
		 }
		 
	 }

	
}
