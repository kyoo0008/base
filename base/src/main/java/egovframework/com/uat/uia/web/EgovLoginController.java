package egovframework.com.uat.uia.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.LoginVO;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovSsoSecureEncryptUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;


/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovLoginController {

	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "loginService")
    private EgovLoginService loginService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    @Resource(name = "EgovMpmService")
	private EgovMpmService egovMpmService;
    
    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService 	cmmntyService;
    
    protected static final Log LOG = LogFactory.getLog(EgovLoginController.class);
    
    /**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {

    	if(loginVO.getUrl() != null){
    		EgovSessionCookieUtil.setSessionAttribute(request, "returnUrl", loginVO.getUrl());
    	}
    	EgovSessionCookieUtil.setSessionAttribute(request, "returnUrl", loginVO.getUrl());
    	return "cmm/uat/uia/EgovLoginUsr";
    	
	}

    /**
	 * 일반 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogin.do")
    public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model)throws Exception {
    	
    	// 접속IP
    	//String userIp = EgovClntInfo.getClntIP(request);
    	boolean loginSuccess = false;
    	LoginVO resultVO = null;
    	if (loginVO.getId() != null && loginVO.getPassword() != null){
    		// 1. 일반 로그인 처리    		
        	UserManageVO userVO = userManageService.selectLoingUser(loginVO.getId());
        	if(userVO != null) {
				resultVO = loginService.actionLogin(loginVO);
				if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {	//로그인 성공
					loginSuccess = true;
				}    			
    		}
    	}

        if (loginSuccess) {
    	  	// 2. spring security 연동
        	EgovSessionCookieUtil.setSessionAttribute(request, "isMasterLogin", "Y");
            return "redirect:/j_spring_security_check?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getPassword();
        } else {
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
        }
    }
    
    /**
	 * 모바일앱 로그인 사전처리를한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/appLogin.do")
    public String appLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model)throws Exception {
    	
    	// 접속IP
    	//String userIp = EgovClntInfo.getClntIP(request);

    	boolean loginSuccess = false;
    	LoginVO resultVO = null;

    	if (loginVO.getId() != null && loginVO.getPassword() != null){
    		// 1. 일반 로그인 처리
        	UserManageVO userVO = userManageService.selectLoingUser(loginVO.getId());
        	if(userVO != null) {

				resultVO = loginService.actionLogin(loginVO);
	
				if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {	//로그인 성공
					loginSuccess = true;
				}    			
    		}
    	}

    	model.addAttribute("AuthStep", "LOGIN_BEFORE");
        if (loginSuccess) {        	
        	SiteManageDefaultVO siteVO = new SiteManageDefaultVO();
        	siteVO.setSiteId(resultVO.getSiteId());
        	model.addAttribute("siteInfo", siteManageService.selectSiteSimpleInfo(siteVO));        	
        	//model.addAttribute("token", EgovSsoSecureEncryptUtil.generateEncyptToken(EgovSsoSecureEncryptUtil.generateEncyptKey(), resultVO.getId()));
        	model.addAttribute("StepResult", "Y");
        	return "cop/svc/EgovAppLoginResultXml";
        } else {
        	model.addAttribute("StepResult", "N");
        	return "cop/svc/EgovAppLoginResultXml";
        }
    }
    
    
    /**
	 * 모바일앱 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionAppLogin.do")
    public String actionAppLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model)throws Exception {
    	
    	// 접속IP
    	//String userIp = EgovClntInfo.getClntIP(request);

    	boolean loginSuccess = false;
    	LoginVO resultVO = null;

    	if (loginVO.getId() != null && loginVO.getPassword() != null){
    		// 1. 일반 로그인 처리
        	UserManageVO userVO = userManageService.selectLoingUser(loginVO.getId());
        	if(userVO != null) {

				resultVO = loginService.actionLogin(loginVO);
	
				if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {	//로그인 성공
					loginSuccess = true;
				}    			
    		}
    	}

        if (loginSuccess) {
    	  	// 2. spring security 연동
        	EgovSessionCookieUtil.setSessionAttribute(request, "isAppLogin", "Y");
            return "redirect:/j_spring_security_check?j_username=" + resultVO.getId() + "&j_password=" + EgovFileScrty.encode(resultVO.getPassword());
        } else {
        	model.addAttribute("AuthStep", "LOGIN");
        	model.addAttribute("StepResult", "N");
        	return "cop/svc/EgovAppLoginResultXml";
        }
    }
     
    /**
	 * 인증서 로그인을 처리한다
	 * @param vo - 주민번호가 담긴 LoginVO
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionCrtfctLogin.do")
    public String actionCrtfctLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
    		HttpServletRequest request,
    		HttpServletResponse response,
			ModelMap model)
            throws Exception {
    	
    	LoginVO resultVO = null;

    	loginVO.setDn(null);    	
    	resultVO = loginService.actionCrtfctLogin(loginVO);
		    	
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {

        	//System.out.println("login ok ------- spring go :" + "redirect:/j_spring_security_check?j_username=" + resultVO.getId() + "&j_password=" + EgovFileScrty.encode(resultVO.getPassword()));
            // 2. spring security 연동
			EgovSessionCookieUtil.setSessionAttribute(request, "isMasterLogin", "Y");
            return "redirect:/j_spring_security_check?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getPassword();
    		
        } else {
        	//System.out.println("login fail : " + loginVO.getId() + "/" + EgovFileScrty.encode(loginVO.getPassword()));
        	
        	String sessionID 		= request.getSession().getId();
    		String strServerCert 	= "";
    		
    		model.addAttribute("serverCert", strServerCert);
    		model.addAttribute("sessionId", sessionID);
    		
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	model.addAttribute("isDevelopmentMode", propertyService.getBoolean("Globals.isDevelopmentMode"));
        	return "cmm/uat/uia/EgovLoginUsr";
        }
    }
    
    /**
	 * 로그인 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/actionMain.do")
	public String actionMain(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	
		if("Y".equals(EgovSessionCookieUtil.getSessionAttribute(request, "isAppLogin"))) {
			LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    	if(loginVO == null) {
	    		model.addAttribute("AuthStep", "LOGIN");
	        	model.addAttribute("StepResult", "N");
	        	return "cop/svc/EgovAppLoginResultXml";
	    	}
	    	
	    	//인증여부
	    	model.addAttribute("AuthStep", "LOGIN");
        	model.addAttribute("StepResult", "Y");
	    	
	    	//사이트정보
	    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    	model.addAttribute("siteInfo", siteVO);
	    	
	    	//통합캘린더 URL
	    	List<Mpm> calUrlList = new ArrayList<Mpm>();	
	    	MpmVO mnuVO = new MpmVO();
	    	mnuVO.setSiteId(siteVO.getSiteId());	    	
	    	List<Mpm> mpmList = egovMpmService.selectMpmServiceList(mnuVO);	
	    	if(mpmList != null) {
	    		for(int i=0; i < mpmList.size(); i++) {
	    			if("CNTNTS".equals(mpmList.get(i).getCompositionTyCode()) && "CTS04".equals(mpmList.get(i).getCntntsTyCode()) && "PRGCAL".equals(mpmList.get(i).getProgrmId()) && "Y".equals(mpmList.get(i).getExpsrUseAt())) {
	    				calUrlList.add(mpmList.get(i));
	    			}
	    		}
	    	}
	    	model.addAttribute("calUrlList", calUrlList);
	    	
	    	//알림판 URL
	    	BoardVO boardVO = new BoardVO();
	    	boardVO.setSiteId(siteVO.getSiteId());
	    	boardVO.setTrgetId(loginVO.getId());
	    	model.addAttribute("notifyUrlList", cmmntyService.selectSearchCommunityNotifyUrlList(boardVO));
	    	
	    	//사이트목록
	    	model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
			
        	return "cop/svc/EgovAppLoginResultXml";
		} else {
	    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);
	    	if(!isAuthenticated) {
	    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
	        	return "forward:/uat/uia/egovLoginUsr.do";
	    	}
	    	
	    	String returnUrl = (String)EgovSessionCookieUtil.getSessionAttribute(request, "returnUrl");
	    	String main_page = Globals.MAIN_PAGE;
	    	
	    	String modelUrl = main_page;
	    	if(returnUrl == null || "".equals(returnUrl)){
	    		if (main_page.startsWith("/")) {
	    			modelUrl =  "redirect:" + main_page;
	    		}
	    	}else{
	    		modelUrl = "redirect:" + returnUrl;
	    	}
	    	
	    	EgovSessionCookieUtil.removeSessionAttribute(request, "returnUrl");
	    	
	    	return modelUrl;
		}
    	
	}
    
    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	
    	// 1. Security 연동
    	return "redirect:/j_spring_security_logout";
    }
    
    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/ssoActionLogout.do")
	public void ssoActionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	
    	//request.getSession().invalidate();
    }
    
    /**
	 * 로그아웃 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/actionLogoutMain.do")
	public String actionLogoutMain(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	
    	String returnUrl = (String)EgovSessionCookieUtil.getSessionAttribute(request, "returnUrl");
    	String main_page = Globals.MAIN_PAGE;

    	String modelUrl = main_page;
    	if(returnUrl == null || "".equals(returnUrl)){
    		if (main_page.startsWith("/")) {
    			modelUrl =  "redirect:" + main_page;
    		}
    	}else{
    		modelUrl = "redirect:" + returnUrl;
    	}
    	
    	EgovSessionCookieUtil.removeSessionAttribute(request, "returnUrl");
    	
    	return modelUrl;
	}
	
	/**
	 * 로그인 정보를 조회한다.
	 * @param 
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/selectLoginInfo.do")
	  public void manageArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String token = "";
		String loginYn = "N";
		
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			token = user.getSsoToken();
			loginYn = "Y";
		}
		JSONObject jo = new JSONObject();
		jo.put("token", token);
		jo.put("loginYn", loginYn);
		  
		response.setContentType("text/javascript; charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		printwriter.println(jo.toString());
		printwriter.flush();
		printwriter.close();
	  }
	
	/**
	 * 인증서안내 화면으로 들어간다
	 * @return 인증서안내 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovGpkiIssu.do")
	public String gpkiIssuView(ModelMap model) throws Exception {
		return "cmm/uat/uia/EgovGpkiIssu";
	}
	
	/**
	 * 아이디 찾기 인증화면
	 * @param 
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovIdSearchView.do")
	public String egovIdSearch(HttpServletRequest request, ModelMap model) throws Exception {

		return "cmm/uat/uia/EgovIdSearch";
	}
		
	/**
	 * 아이디를 찾는다.
	 * @param 
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovIdSearch.do")
	public String egovIdSearch(@ModelAttribute("searchVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {

        LoginVO resultVO = loginService.searchId(loginVO);

        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
        	loginVO.setId(resultVO.getId());
        	loginVO.setName(resultVO.getName());
        	loginVO.setMobileNo(resultVO.getMobileNo());
        	loginVO.setEmail(resultVO.getEmail());
        	
        	return "cmm/uat/uia/EgovIdSearchComplete";
        } else {
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.idsearch"));
        	
        	return "cmm/uat/uia/EgovIdSearch";
        }
	}


	/**
	 * 비밀번호 찾기 인증화면
	 * @param 
	 * @return 비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovPasswordSearchView.do")
	public String egovPasswordSearch(@ModelAttribute("searchVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {

		if(!EgovStringUtil.isEmpty(loginVO.getId())) {
			UserManageVO userVO = userManageService.selectLoingUser(loginVO.getId());
	    	if(userVO != null) {
	    		model.addAttribute("result", userVO);
	    	} else {
	    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.idsearch"));
	    	}
		}
		return "cmm/uat/uia/EgovPasswordSearch";
	}
	
	
    /**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 주민등록번호가 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/egovPasswordSearch.do")
    public String egovPasswordSearch(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model,
    		HttpServletRequest request)
            throws Exception {

    	// 1. 비밀번호 찾기
    	Map<String, Object> resultList = loginService.searchPassword(loginVO, true);
        boolean result = (Boolean)resultList.get("result");
        
        // 2. 결과 리턴
        if (result) {
        	LoginVO resultVO = (LoginVO)resultList.get("resultVO");
        	boolean sendResult = (Boolean)resultList.get("sendResult");
        	
    		model.addAttribute("resultInfo", resultVO);
    		model.addAttribute("sendResult", sendResult);
    		//model.addAttribute("message", egovMessageSource.getMessage("success.common.pwsearch"));
        	return "cmm/uat/uia/EgovPasswordSearchComplete";
        } else {
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.pwsearch"));
        	return "cmm/uat/uia/EgovPasswordSearch";
        }
    }

}