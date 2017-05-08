package egovframework.com.uat.uia.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

import egovframework.com.sym.log.service.EgovLoginInfoService;
import egovframework.com.sym.log.service.LoginInfoVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.EgovLogoutService;
import egovframework.com.uat.uia.service.LoginVO;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.sim.service.EgovCrypTo;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.cop.sms.service.EgovSmsInfoService;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
@Service("loginService")
public class EgovLoginServiceImpl extends AbstractServiceImpl implements
        EgovLoginService {

    @Resource(name="loginDAO")
    private LoginDAO loginDAO;
    
    @Resource(name = "EgovLoginInfoService")
	private EgovLoginInfoService loginInfoService;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
        
	@Resource(name = "EgovSmsInfoService")
    private EgovSmsInfoService egovSmsInfoService;
	
	HashMap<String, String> logoutList = new HashMap<String, String>();
	
    /**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionLogin(LoginVO vo) throws Exception {
    	
    	// 1. 입력한 비밀번호를 암호화한다.    	
    	String enpassword = EgovCrypTo.encryptPassword(vo.getPassword());
    	vo.setPassword(enpassword);
    	
    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	LoginVO loginVO = loginDAO.actionLogin(vo);
    	
    	// 3. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.getId().equals("") && !loginVO.getPassword().equals("")) {
    		return loginVO;
    	} else {
    		loginVO = new LoginVO();
    	}
    	
    	return loginVO;
    }
    
    /**
	 * 인증서 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionCrtfctLogin(LoginVO vo) throws Exception {
    	
    	// 1. DN값으로 ID, PW를 조회한다.
    	LoginVO loginVO = loginDAO.actionCrtfctLogin(vo);
    	
    	// 3. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.getId().equals("") && !loginVO.getPassword().equals("")) {
    		return loginVO;
    	} else {
    		loginVO = new LoginVO();
    	}
    	
    	return loginVO;
    }
        
    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO searchId(LoginVO vo) throws Exception {

    	// 1. 이름, 이메일주소가 DB와 일치하는 사용자 ID를 조회한다.
    	LoginVO loginVO = loginDAO.searchId(vo);
    	
    	// 2. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.getId().equals("")) {
    		return loginVO;
    	} else {
    		loginVO = null;
    	}
    	
    	return loginVO;
    }
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    public Map<String, Object> searchPassword(LoginVO vo, boolean update) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
            	
    	LoginVO loginVO = loginDAO.searchPassword(vo);
    	if (loginVO == null) {
    		
    		map.put("result", false);
    		
    		return map;
    	}
    	
    	map.put("result", true);
    	map.put("resultVO", loginVO);
    	
    	// 2. 임시 비밀번호를 생성한다.(영+영+숫+영+영+숫+영+영=8자리)
    	String newpassword = "";
    	for (int i = 1; i <= 8; i++) {
    		// 영자
    		if (i % 3 != 0) {
    			newpassword += EgovStringUtil.getRandomStr('a', 'z');
    		// 숫자
    		} else {
    			newpassword += EgovNumberUtil.getRandomNum(0, 9);
    		}
    	}
    	
    	if(update) {
        	
	    	// 3. 임시 비밀번호를 암호화하여 DB에 저장한다.
	    	loginVO.setPassword(EgovCrypTo.encryptPassword(newpassword));
	    	loginDAO.updatePassword(loginVO);
	    	
    		String strMsgSMS = loginVO.getName() + "님의 임시비밀번호는 " + newpassword + " 입니다.";
    		
    		SmsVO smsVO = new SmsVO();
    		
    		List<String> phones = new ArrayList<String>();
    		phones.add(EgovStringUtil.getPhoneNumber(loginVO.getMobileNo()));
    		
    		smsVO.setAdminAt("Y");
    		smsVO.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(Globals.PHONE));
    		smsVO.setRecptnTelno(phones);	//수신전화번호
    		smsVO.setTrnsmitCn(strMsgSMS);	//내용

    		int iRet = egovSmsInfoService.sendUserSms(loginVO.getId(), smsVO);

    		//성공
    		boolean result = false;
			if(smsVO.getRecptnTelno().size() == iRet) {
				result = true;
			}

    		map.put("sendResult", result);
    	}
    	
    	return map;
    }
    
    /**
	 * 아이디로 사용자정보를 찾는다.
	 * @param userId String
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO searchSSOLogin(LoginInfoVO vo) throws Exception {
    	
    	LoginInfoVO loginInfoVO = new LoginInfoVO();
        loginInfoVO.setLoginId(vo.getLoginId());
        loginInfoVO.setSiteId(vo.getSiteId());
        loginInfoVO.setLoginIdntfcId(vo.getLoginIdntfcId());
        //loginInfoVO.setSessionId(sessionId);
        
    	int existsCnt = selectLoginExistsForLoginIdntfcIdCnt(loginInfoVO);
    	if(existsCnt > 0) {
    		LoginInfoVO sessionVO = selectLoginExistsForSession(loginInfoVO);
    		boolean auth = true;
    		if(sessionVO != null && !EgovStringUtil.isEmpty(sessionVO.getLoginId())) {
    			if(!vo.getSessionId().equals(sessionVO.getSessionId())) {
    				auth = false; 
    			}
    		}
    		
    		if(auth) {
    			return loginDAO.searchSSOLogin(vo.getLoginId());
    		}
    	}
    	return null;
    }
    
    /**
	 * 로그아웃 아이디를 추가한다.
	 * @param userId String
	 * @exception Exception
	 */
    public void addLogoutList(LoginInfoVO loginInfoVO) throws Exception {
    	if(!this.logoutList.containsKey(loginInfoVO.getLoginId() + loginInfoVO.getSiteId() + loginInfoVO.getLoginIdntfcId())) {
    		this.logoutList.put(loginInfoVO.getLoginId() + loginInfoVO.getSiteId() + loginInfoVO.getLoginIdntfcId(), loginInfoVO.getSessionId());
    	}
    }
    
    /**
	 * 로그아웃 아이디를 삭제한다.
	 * @param userId String
	 * @exception Exception
	 */
    public void removeLogoutList(LoginInfoVO loginInfoVO) throws Exception {
    	if(this.logoutList.containsKey(loginInfoVO.getLoginId() + loginInfoVO.getSiteId() + loginInfoVO.getLoginIdntfcId())) {
    		this.logoutList.remove(loginInfoVO.getLoginId() + loginInfoVO.getSiteId() + loginInfoVO.getLoginIdntfcId());
    		/*
    		LoginInfoVO loginInfoVO = new LoginInfoVO();
            loginInfoVO.setLoginId(userId);
            loginInfoVO.setSiteId(siteId);
    		loginInfoService.deleteLoginInfo(loginInfoVO);
    		*/
    	}
    }
    
    /**
	 * 로그아웃 아이디를 조회한다.
	 * @param userId String
	 * @return boolean
	 * @exception Exception
	 */
    public boolean getLogoutListExists(LoginInfoVO loginInfoVO) throws Exception {
    	return this.logoutList.containsKey(loginInfoVO.getLoginId() + loginInfoVO.getSiteId() + loginInfoVO.getLoginIdntfcId());
    }
        
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public int selectLoginExistsForLoginIdntfcIdCnt(LoginInfoVO loginInfoVO) throws Exception {
    	
    	return loginInfoService.selectLoginExistsForLoginIdntfcIdCnt(loginInfoVO);
    }
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public LoginInfoVO selectLoginExistsForSession(LoginInfoVO loginInfoVO) throws Exception {
    	
    	return loginInfoService.selectLoginExistsForSession(loginInfoVO);
    }
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public LoginInfoVO selectLoginExistsForSiteId(LoginInfoVO loginInfoVO) throws Exception {
    	
    	return loginInfoService.selectLoginExistsForSiteId(loginInfoVO);
    }
    
    /**
	 * COMTNLOGININFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLoginInfo(LoginInfoVO loginInfoVO) throws Exception {
    	
    	return loginInfoService.insertLoginInfo(loginInfoVO);
    }
    
    /**
	 * 로그인한 사이트에 로그아웃을 요청한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    public void allSiteLogoutRequest(LoginInfoVO loginInfoVO) throws Exception {
    	
    	removeLogoutList(loginInfoVO);
    	
    	//접속된 사이트에 로그아웃 요청
        List<LoginInfoVO> loginInfoList = loginInfoService.selectLoginInfoList(loginInfoVO);
        if(loginInfoList != null && loginInfoList.size() > 0) {
        	List<String> urlList = new ArrayList<String>();
        	List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
        	if(siteList != null) {
		        for(int i=0; i < loginInfoList.size(); i++) {
		        	for(int x=0; x < siteList.size(); x++) {
		        		if(!loginInfoVO.getSiteId().equals(siteList.get(x).getSiteId()) && siteList.get(x).getSiteId().equals(loginInfoList.get(i).getSiteId())) {
		        			urlList.add("http://" + siteList.get(x).getSiteUrl() + "/uat/uia/ssoActionLogout.do?logoutToken=" + loginInfoVO.getLoginIdntfcId());
		        			break;
		        		}
		        	}
		        }
        	}
        	
        	if(urlList.size() > 0 ) {
		        //접속된 사이트에 로그아웃 요청처리
		        Thread th = new Thread(new EgovLogoutService(urlList));
		        th.start();
        	}
        }
    }
    
    /**
	 * 로그인 정보를 삭제한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    public void deleteLoginInfo (LoginInfoVO loginInfoVO) throws Exception {
    	loginInfoService.deleteLoginInfo(loginInfoVO);
    }
    
    /**
	 * 삭제할 로그인 정보조회한다.
	 * @exception Exception
	 */
    public List<LoginInfoVO> selectRemoveTargetList() throws Exception {
    	return loginInfoService.selectLogininfoRemoveTargetList();
    }
    
    /**
	 * 로그인 정보를 삭제한다.
	 * @exception Exception
	 */
    public void deleteLogininfoRemoveTarget() throws Exception {
    	loginInfoService.deleteLogininfoRemoveTarget();
    }
    
    /**
	 * 로그인 정보를 수정한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    public void updateLoginInfo (LoginInfoVO loginInfoVO) throws Exception {
    	loginInfoService.updateLoginInfo(loginInfoVO);
    }
}
