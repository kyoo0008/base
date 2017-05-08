package egovframework.com.mng.cop.cmy.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.cmy.service.Community;
import egovframework.com.cop.cmy.service.CommunityVO;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/******************************************************
 * @Class Name : EgovCommunityManageController.java
 * @Program name : egovframework.com.mng.cop.cmy.web
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 2. 12.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 2. 12.        이호영             first generated
*********************************************************/
@Controller("mngEgovCommunityManageController")
public class EgovCommunityManageController {

	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	/** EgovCmmUseService */
    @Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    /**
     * 운영중인 커뮤니티 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return 
     * @return
     * @throws Exception
     */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/mng/cop/cmy/selectCmmntyUseList.do")
    public String selectCmmntyMainList(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			cmmntyVO.setSiteId(loginVO.getSiteId());
		}
		
		SiteManageDefaultVO siteParamVO = new SiteManageDefaultVO();
		siteParamVO.setSiteId(cmmntyVO.getSiteId());
		model.addAttribute("siteInfo", siteManageService.selectSiteSimpleInfo(siteParamVO));
		  
    	cmmntyVO.setPageUnit(propertyService.getInt("pageUnit"));
		cmmntyVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(cmmntyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmmntyVO.getPageUnit());
		paginationInfo.setPageSize(cmmntyVO.getPageSize());
	
		cmmntyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmmntyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmmntyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		cmmntyVO.setMngrAt("Y");
		HashMap map = (HashMap)cmmntyService.selectCommunityInfs(cmmntyVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "mng/cop/cmy/EgovCmmntyUseList";
    }
	
	/**
     * 커뮤니티 정보 수정 페이지.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/cop/cmy/selectCmmntyUseInfo.do")
    public String selectCmmntyView(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageDefaultVO siteParamVO = new SiteManageDefaultVO();
    	siteParamVO.setSiteId(cmmntyVO.getSiteId());
		SiteManageVO siteVO = siteManageService.selectSiteSimpleInfo(siteParamVO);
		model.addAttribute("siteInfo", siteVO);
		
    	cmmntyVO.setSiteId(siteVO.getSiteId());
    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
    	
    	/** 공통코드 - 커뮤니티구분코드(COM201) */
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM201");
    	model.addAttribute("cmmntySe", cmmUseService.selectCmmCodeDetail(voComCode));
    	
	  	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	  	if(user != null) cmmntyVO.setEmplyrId(user.getId());

	  	cmmntyVO.setMngrAt("Y");
		model.addAttribute("communityVO", cmmntyService.selectCommunityInf(cmmntyVO));

		request.getSession().setAttribute("sessionVO", cmmntyVO);
		return "mng/cop/cmy/EgovCmmntyUseInfo";
    }

    /**
     * 커뮤니티 정보를 수정한다.
     * 
     * @param cmmntyVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/cmy/updtCmmntyUseInf.do")
    public String updtCmmntyInf(final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		Community community,
    		BindingResult bindingResult, ModelMap model,  
    		HttpServletRequest request, HttpServletResponse response) throws Exception {

    	if (request.getSession().getAttribute("sessionVO") == null) return "forward:/mng/cop/cmy/selectCmmntyUseList.do";
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

		beanValidator.validate(community, bindingResult);
		if (bindingResult.hasErrors()) {

			SiteManageDefaultVO siteParamVO = new SiteManageDefaultVO();
	    	siteParamVO.setSiteId(cmmntyVO.getSiteId());
			SiteManageVO siteVO = siteManageService.selectSiteSimpleInfo(siteParamVO);
	    	cmmntyVO.setSiteId(siteVO.getSiteId());
	    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
	    	
	    	/** 공통코드 - 커뮤니티구분코드(COM201) */
			ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
		   	voComCode = new ComDefaultCodeVO();
	    	voComCode.setCodeId("COM201");
	    	List<CmmnDetailCode> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
	    	model.addAttribute("cmmntySe", listComCode);
	    	
			model.addAttribute("communityVO", cmmntyService.selectCommunityInf(cmmntyVO));
			return "mng/cop/cmy/EgovCmmntyUseInfo";
		}

		List<FileVO> result = null;
        
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
          result = fileUtil.directParseFileInf(files, "CMMNTY_", 0, "Cmmnty.fileStorePath", "");
          community.setFileValue(result);
        }
		community.setLastUpdusrId(user.getId());
		
		cmmntyService.updateCommunityInf(community);

		request.getSession().removeAttribute("sessionVO");
		return "forward:/mng/cop/cmy/selectCmmntyUseList.do";
    }
    
    /**
     * 커뮤니티를 폐쇄한다.
     * 
     * @param cmmntyVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/cop/cmy/updtCmmntyClosing.do")
    public String updtCmmntyCls(@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		Community community,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}

    	cmmntyService.deleteCommunityInf(community);

		return "forward:/cop/cmy/selectCmmntyInfs.do";
    }
}
