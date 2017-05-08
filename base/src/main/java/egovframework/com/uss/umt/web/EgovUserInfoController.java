package egovframework.com.uss.umt.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;

import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;

/******************************************************
 * @Class Name : EgovUserManageController.java
 * @Program name : egovframework.com.uss.umt.web
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 7. 26.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 7. 26.        이호영             first generated
*********************************************************/

@Controller
public class EgovUserInfoController {

	@Resource(name = "SiteManageService")
	private EgovSiteManageService siteManageService;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;


    protected Log log = LogFactory.getLog(this.getClass());

    @Autowired
	private DefaultBeanValidator beanValidator;
    
    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService     cmmUseService;
    
    
    /**
     * 회원구분 선택
     * @param model 화면모델
     * @return cmm/uss/umt/EgovSelectMber
     * @throws Exception
     */
    @RequestMapping("/uss/umt/cmm/EgovSelectMber.do")
    public String selectMber(@ModelAttribute("searchVO") UserManageVO userManageVO, HttpServletRequest request, ModelMap model)
            throws Exception {

        return "cmm/uss/umt/EgovSelectMber";
    }
    
    /**
     * 약관확인
     * @param model 화면모델
     * @return cmm/uss/umt/EgovStplatCnfirm
     * @throws Exception
     */
    @RequestMapping("/uss/umt/cmm/EgovStplatCnfirmMber.do")
    public String stplatCnfirmMber(@ModelAttribute("searchVO") UserManageVO userManageVO, HttpServletRequest request, ModelMap model)
            throws Exception {

    	SiteManageVO siteVO = null;    	
    	if(EgovStringUtil.isEmpty(userManageVO.getSiteId())) {
        	siteVO = siteManageService.selectSiteServiceInfo(request);
        } else  {
        	siteVO = siteManageService.selectSiteServiceInfoBySiteId(userManageVO.getSiteId());
        }
    	if(siteVO != null) {
    		model.addAttribute("UseStplatUrl", propertiesService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/useStplat");
    		model.addAttribute("IndvdlInfoPolicyUrl", propertiesService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/indvdlInfoPolicy");
    	}
    	
    	//이재현 2013.03.11 회원권한 파라미터를 넘긴다.
    	model.addAttribute("user", userManageVO);
    	
        return "cmm/uss/umt/EgovStplatCnfirm";
    }
    
    /**
     * 실명인증
     * @param model 화면모델
     * @return cmm/uss/umt/EgovCertificate
     * @throws Exception
     */
    @RequestMapping("/uss/umt/cmm/EgovCertificate.do")
    public String certificate(@ModelAttribute("searchVO") UserManageVO userManageVO, HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//이재현 2013.03.11 회원권한 파라미터를 넘긴다.
    	model.addAttribute("user", userManageVO);
        return "cmm/uss/umt/EgovCertificate";
    }
    
    /**
     * 사용자등록화면으로 이동한다.
     * @param searchVO 검색조건정보
     * @param request 사용자초기화정보
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserInsert
     * @throws Exception
     */
	@RequestMapping("/uss/umt/user/EgovUserInsertView.do")
     public String insertUserView(@ModelAttribute("userManageVO") UserManageVO userManageVO, HttpServletRequest request, ModelMap model)throws Exception {
    	//실명인증 회원정보
    	String dupInfo = (String)EgovSessionCookieUtil.getSessionAttribute(request, "dupInfo");
    	String realName = (String)EgovSessionCookieUtil.getSessionAttribute(request, "realName");
    	String birthDate = (String)EgovSessionCookieUtil.getSessionAttribute(request, "birthDate");
    	String sex = (String)EgovSessionCookieUtil.getSessionAttribute(request, "sex");
    	    	
		if("".equals(dupInfo) || dupInfo == null || "".equals(realName) || realName == null ){
    		model.addAttribute("message", egovMessageSource.getMessage("sec.real.err"));   //실명확인 결과(일반회원)
    		return "forward:/uss/umt/cmm/EgovSelectMber.do";
    	}

		//동일한 실명인증 데이타가 있는지 검사
    	if (userManageService.checkDiDplct(dupInfo) > 0) {
    		UserManageVO checkVO = userManageService.checkUserDplct(dupInfo);
    		model.addAttribute("message", "이미 "+checkVO.getUserId()+" 아이디로 회원가입을 하셨습니다. 확인 하여 주시길 바랍니다.");
    		return "forward:/uss/umt/cmm/EgovSelectMber.do";
    	}
    	
    	userManageVO.setCredtId(dupInfo);
        userManageVO.setUserNm(realName);
        userManageVO.setBrthdy(birthDate);
        userManageVO.setSexdstn(sex);
        userManageVO.setMoblphonRecptnAt("Y");
        userManageVO.setEmailRecptnAt("Y");
        
        model.addAttribute("resultList", userManageService.selectSchool());
        model.addAttribute(userManageVO);
    	request.getSession().setAttribute("sessionVO", userManageVO);
    	
        return "cmm/uss/umt/EgovUserInsert";
    }
    
    /**
     * 사용자등록처리후 메인화면으로 이동한다.
     * @param userManageVO 사용자등록정보
     * @param bindingResult 입력값검증용 bindingResult
     * @param model 화면모델
     * @return forward:/uss/umt/user/EgovUserManage.do
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/uss/umt/user/EgovUserInsert.do")
    public String insertUser(final MultipartHttpServletRequest multiRequest, @ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request
            )throws Exception {

    	if (request.getSession().getAttribute("sessionVO") == null){
    		model.addAttribute("message", egovMessageSource.getMessage("fail.request.msg"));
    		return "forward:/uss/umt/cmm/EgovSelectMber.do";
    	}
    	
        beanValidator.validate(userManageVO, bindingResult);
    	if (bindingResult.hasErrors()){
            return "cmm/uss/umt/EgovUserInsert";
    	}

    	//실명인증 회원정보
    	String dupInfo = (String)EgovSessionCookieUtil.getSessionAttribute(request, "dupInfo");
    	String realName = (String)EgovSessionCookieUtil.getSessionAttribute(request, "realName");
    	String birthDate = (String)EgovSessionCookieUtil.getSessionAttribute(request, "birthDate");
    	String sex = (String)EgovSessionCookieUtil.getSessionAttribute(request, "sex");
    	userManageVO.setCredtId(dupInfo);
        userManageVO.setUserNm(realName);
        userManageVO.setBrthdy(birthDate);
        userManageVO.setSexdstn(sex);
        
		if("".equals(dupInfo) || dupInfo == null || "".equals(realName) || realName == null ){
    		model.addAttribute("message", egovMessageSource.getMessage("sec.real.err"));   //실명확인 결과(일반회원)
    		return "forward:/uss/umt/cmm/EgovSelectMber.do";
    	}
		
    	if (userManageService.checkIdDplct(userManageVO.getUserId()) > 0) {
    		model.addAttribute("message", egovMessageSource.getMessage("common.isExist.msg"));
    		return "forward:/sec/rnc/EgovRlnmCnfirm.do";
    	} else {

        	List<FileVO> result = null;
            
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            if(!files.isEmpty()) {
              result = fileUtil.directParseFileInf(files, "MEM_", 0, "Members.fileStorePath", "");
            }

            FileVO fvo = null;
            if(result != null && result.size() > 0) {
            	fvo = result.get(0);

            	userManageVO.setPhotoOriginalFileNm(fvo.getOrignlFileNm());
            	userManageVO.setPhotoStreFileNm(fvo.getStreFileNm());
            }
            
            userManageVO.setCredtId(dupInfo);							//실명인증키
            
            if(EgovStringUtil.isEmpty(userManageVO.getSiteId())) {
            	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
            	userManageVO.setSiteId(siteVO.getSiteId());
            }
            
            if(!EgovStringUtil.isEmpty(userManageVO.getTel1()) && !EgovStringUtil.isEmpty(userManageVO.getTel2()) && !EgovStringUtil.isEmpty(userManageVO.getTel3())) {
            	userManageVO.setTlphonNo(userManageVO.getTel1() + "-" + userManageVO.getTel2() + "-" + userManageVO.getTel3());
            }
            if(!EgovStringUtil.isEmpty(userManageVO.getPhone1()) && !EgovStringUtil.isEmpty(userManageVO.getPhone2()) && !EgovStringUtil.isEmpty(userManageVO.getPhone3())) {
            	userManageVO.setMoblphonNo(userManageVO.getPhone1() + "-" + userManageVO.getPhone2() + "-" + userManageVO.getPhone3());
            }
            if(!EgovStringUtil.isEmpty(userManageVO.getEmail1()) && !EgovStringUtil.isEmpty(userManageVO.getEmail2())) {
            	userManageVO.setEmailAdres(userManageVO.getEmail1() + "@" + userManageVO.getEmail2());
            }
            String zip = egovframework.com.utl.fcc.service.EgovStringUtil.removeMinusChar(userManageVO.getZip());
            userManageVO.setZip(zip);
            
            userManageService.insertUser(userManageVO);
            
    		//세션 초기화
            EgovSessionCookieUtil.removeSessionAttribute(request, "dupInfo");
			EgovSessionCookieUtil.removeSessionAttribute(request, "realName");
	    	EgovSessionCookieUtil.removeSessionAttribute(request, "birthDate");
	    	EgovSessionCookieUtil.removeSessionAttribute(request, "sex");

    		request.getSession().removeAttribute("sessionVO");

    		model.addAttribute("mberNm", userManageVO.getUserNm());
    		model.addAttribute("mberId", userManageVO.getUserId());

    		return "cmm/uss/umt/EgovUserInsertComplete";
    	}
    }
    
    /**
     * 입력한 사용자아이디의 중복확인화면 이동
     * @param model 화면모델
     * @return cmm/uss/umt/EgovIdDplctCnfirm
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/EgovIdDplctCnfirmView.do")
    public String checkIdDplctCnfirmView(ModelMap model)
            throws Exception {
        model.addAttribute("checkId", "");
        model.addAttribute("usedCnt", "-1");
        return "cmm/uss/umt/EgovIdDplctCnfirm";
    }
    
    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
     * @param commandMap 파라메터전달용 commandMap
     * @param model 화면모델
     * @return cmm/uss/umt/EgovIdDplctCnfirm
     * @throws Exception
     */
    @RequestMapping(value="/uss/umt/cmm/EgovIdDplctCnfirm.do")
    public String checkIdDplctCnfirm(
    		Map<String, Object> commandMap,
            ModelMap model
            )throws Exception {
        
    	String checkId = (String)commandMap.get("checkId");
    	checkId =  new String(checkId.getBytes("ISO-8859-1"), "UTF-8");
        
    	if (checkId==null || checkId.equals("")) return "forward:/uss/umt/EgovIdDplctCnfirmView.do";
        
        int usedCnt = userManageService.checkIdDplct(checkId);
        model.addAttribute("usedCnt", usedCnt);
        model.addAttribute("checkId", checkId);
        
        return "cmm/uss/umt/EgovIdDplctCnfirm";
    }
    
    
    
    /**
     * 개인정보 보호를 위한 페스워드 인증하면으로 이동한다.
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserConfirm
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserConfirmView.do")
    public String userConfirmView(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

    	LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
    	userManageVO.setUserId(loginVO.getId());
    	
    	model.addAttribute("userManageVO", userManageVO);
      return "cmm/uss/umt/EgovUserConfirm";
    }

	/**
     * 개인정보 보호를 위한 페스워드를 받아 확인한다.
     * @param model 화면모델
     * @return "cmm/uss/umt/EgovUserConfirm"
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserConfirm.do")
    public String userConfirm(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
		
    	//입력한 정보가 맞는지 체크
    	if (userManageService.selectCheckPassword(userManageVO) > 0) {
    		if("secsn".equals(searchVO.getTrgtPge())){
    			//탈퇴화면으로 이동
    			return "forward:/uss/umt/cmm/EgovUserSecsnView.do";
    		}else if("update".equals(searchVO.getTrgtPge())){
    			//사용자정보 수정화면으로 이동
    			return "forward:/uss/umt/cmm/EgovUserUpdateView.do";
    		}else if("password".equals(searchVO.getTrgtPge())){
    			//비밀번호 변경화면으로 이동
    			return "forward:/uss/umt/cmm/EgovUserPasswordUpdateView.do";
    		}
    	}else{
    		model.addAttribute("userManageVO", userManageVO);
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.idpw"));
    		return "cmm/uss/umt/EgovUserConfirm";
    	}
    	
    	return "forward:" + Globals.MAIN_PAGE;
    }

	
	/**
     * 사용자정보 수정 화면으로 이동한다.
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserUpdate
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserUpdateView.do")
    public String EgovUserSelectUpdtView(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
    	userManageVO = userManageService.selectUser(loginVO.getId());
    	
    	model.addAttribute("resultList", userManageService.selectSchool());    	
    	model.addAttribute("userManageVO", userManageVO);
    	
      return "cmm/uss/umt/EgovUserUpdate";
    }
	
	/**
     * 사용자정보 수정 처리 한다.
     * @param model 화면모델
     * @return forward:/
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserUpdate.do")
    public String EgovUserSelectUpdt(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, 
    		BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response)throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
		
		beanValidator.validate(userManageVO, bindingResult);
    	if (bindingResult.hasErrors()){

    		userManageVO = userManageService.selectUser(loginVO.getId());
    		
        	return "cmm/uss/umt/EgovUserUpdate";
  		}
        
    	if(!EgovStringUtil.isEmpty(userManageVO.getTel1()) && !EgovStringUtil.isEmpty(userManageVO.getTel2()) && !EgovStringUtil.isEmpty(userManageVO.getTel3())) {
        	userManageVO.setTlphonNo(userManageVO.getTel1() + "-" + userManageVO.getTel2() + "-" + userManageVO.getTel3());
        }
        if(!EgovStringUtil.isEmpty(userManageVO.getPhone1()) && !EgovStringUtil.isEmpty(userManageVO.getPhone2()) && !EgovStringUtil.isEmpty(userManageVO.getPhone3())) {
        	userManageVO.setMoblphonNo(userManageVO.getPhone1() + "-" + userManageVO.getPhone2() + "-" + userManageVO.getPhone3());
        }
        if(!EgovStringUtil.isEmpty(userManageVO.getEmail1()) && !EgovStringUtil.isEmpty(userManageVO.getEmail2())) {
        	userManageVO.setEmailAdres(userManageVO.getEmail1() + "@" + userManageVO.getEmail2());
        }
        
    	userManageVO.setUserId(loginVO.getId());
        userManageVO.setLastUpdusrId(loginVO.getId());
        userManageVO.setUserSeCode(loginVO.getUserSeCode());
		if(userManageService.updateUser(userManageVO) > 0) {
			model.addAttribute("userManageVO", userManageVO);
			model.addAttribute("result", true);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
		}

		return "cmm/uss/umt/EgovUserUpdate";
    }
	
	/**
     * 회원탈퇴 회면으로 이동한다.
     * @param model 화면모델
     * @return ivp/mpe/ComtnmberSecsn
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserSecsnView.do")
    public String selectComtnmberSecsn(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
      return "cmm/uss/umt/EgovUserSecsn";
    }
	
	/**
     * 회원탈퇴를 처리 한다.
     * @param model 화면모델
     * @return forward:/uat/uia/actionLogout.do
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserSecsn.do")
    public String updateComtnmberSecsn(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
		userManageVO.setUserId(loginVO.getId());

		if(userManageService.deleteUser(userManageVO) > 0) {
			model.addAttribute("result", true);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
		}
		
		return "cmm/uss/umt/EgovUserSecsn";
    }
	
	/**
     * 비밀번호 변경화면으로 이동한다.
     * @param model 화면모델
     * @return cmm/uss/umt/EgovUserPasswordUpdate
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserPasswordUpdateView.do")
    public String userPasswordUpdateView(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
    	return "cmm/uss/umt/EgovUserPasswordUpdate";
    }
	
	/**
     * 비밀번호 변경 한다.
     * @param model 화면모델
     * @return forward:/
     * @throws Exception
     */
	@RequestMapping(value = "/uss/umt/cmm/EgovUserPasswordUpdate.do")
    public String userPasswordUpdate(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(loginVO == null) {
    		return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
  	  	}
    	
		userManageVO.setUserId(loginVO.getId());

		if(userManageService.updatePassword(userManageVO) > 0) {
			model.addAttribute("result", true);
			model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
		}
		return "cmm/uss/umt/EgovUserPasswordUpdate";
    }
	
	@RequestMapping(value="/uss/umt/cmm/selectSchool")
	public String selectSchool(@RequestParam("stTyCode") String stTyCode, Model model ) throws Exception{
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		
		if("SCH01".equals(stTyCode)) {
    		codeVO.setCodeId("CA0014");    	  	
    	}else if("SCH02".equals(stTyCode)) {
    		codeVO.setCodeId("CA0015");    	  	
    	}else if("SCH03".equals(stTyCode)) {
    		codeVO.setCodeId("CA0016");    	  	
    	}
				
		model.addAttribute("schoolList", cmmUseService.selectCmmCodeDetail(codeVO));
		
		return "prg/dat/schoolList";
	}
}
