package egovframework.com.mng.uss.ion.sit.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.uss.ion.sit.service.EgovLinkSiteManageService;
import egovframework.com.uss.ion.sit.service.LinkSiteManageVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovCmmUseService;

// 로그인정보 관련
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;

// Validation 관련
import org.springframework.beans.factory.annotation.Autowired;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

/**
 * 사이트정보를 처리하는 Controller 클래스
 * 
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 * 
 * </pre>
 */
@Controller
public class EgovLinkSiteManageController {
  
	protected Log                 log = LogFactory.getLog(this.getClass());
  
	@Resource(name = "SiteManageService")
	EgovSiteManageService 				  siteManageService;
	
	@Resource(name = "LinkSiteManageService")
	private EgovLinkSiteManageService linkSiteManageService;
  
	/**
	 * EgovPropertyService
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
  
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService     cmmUseService;
  
	/**
   * EgovMessageSource
   */
	@Resource(name = "egovMessageSource")
	EgovMessageSource             egovMessageSource;
  
	// Validation 관련
	@Autowired
	private DefaultBeanValidator  beanValidator;
  
  /**
   * 사이트목록을 조회한다.
   * 
   * @param searchVO
   * @param model
   * @return "/mng/uss/ion/sit/EgovSiteListInqire"
   * @throws Exception
   */
  @RequestMapping(value = "/mng/uss/ion/sit/SiteListInqire.do")
  public String selectSiteList(@ModelAttribute("searchVO") LinkSiteManageVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  	/*
	  	List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
	  
		if(EgovStringUtil.isEmpty(searchVO.getSiteId())) {
			if(siteList != null && siteList.size() > 0) {
				searchVO.setSiteId(siteList.get(0).getSiteId());
			}
		}
		model.addAttribute("siteList", siteList);
		*/
	  
	  	LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			searchVO.setSiteId(loginVO.getSiteId());
		}
			
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
    
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    	paginationInfo.setPageSize(searchVO.getPageSize());
    
    	searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    
    	// 공통코드를 가져오기 위한 Vo
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("COM023");
    
    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));

    	if(!EgovStringUtil.isEmpty(searchVO.getSiteId())) {
	    	model.addAttribute("resultList", linkSiteManageService.selectSiteList(searchVO));
	    
	    	int totCnt = linkSiteManageService.selectSiteListTotCnt(searchVO);
	    	paginationInfo.setTotalRecordCount(totCnt);
    	}
    	model.addAttribute("paginationInfo", paginationInfo);
		
    	return "/mng/uss/ion/sit/EgovSiteListInqire";
  }
    
  /**
   * 사이트정보 등록전 단계
   * 
   * @param searchVO
   * @param model
   * @return "/mng/uss/ion/sit/EgovSiteInfoRegist"
   * @throws Exception
   */
  @RequestMapping("/mng/uss/ion/sit/SiteInfoRegistView.do")
  public String insertSiteInfoView(@ModelAttribute("searchVO") LinkSiteManageVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    // 공통코드를 가져오기 위한 Vo
    ComDefaultCodeVO vo = new ComDefaultCodeVO();
    vo.setCodeId("COM023");
    
    model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));
    
    model.addAttribute("linkSite", searchVO);
    
    request.getSession().setAttribute("sessionVO", searchVO);
    
    return "/mng/uss/ion/sit/EgovSiteInfoRegist";
    
  }
  
  /**
   * 사이트정보를 등록한다.
   * 
   * @param searchVO
   * @param siteManageVO
   * @param bindingResult
   * @return "forward:/mng/uss/ion/sit/SiteListInqire.do"
   * @throws Exception
   */
  @RequestMapping("/mng/uss/ion/sit/SiteInfoRegist.do")
  public String insertSiteInfo(@ModelAttribute("searchVO") LinkSiteManageVO searchVO, @ModelAttribute("siteManageVO") LinkSiteManageVO siteManageVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  if(request.getSession().getAttribute("sessionVO") == null) {
		  return "forward:/mng/uss/ion/sit/SiteListInqire.do";
	  }
	  
	    beanValidator.validate(siteManageVO, bindingResult);
	    
	    if(bindingResult.hasErrors()) {
	      
	    	// 공통코드를 가져오기 위한 Vo
	        ComDefaultCodeVO vo = new ComDefaultCodeVO();
	        vo.setCodeId("COM023");
	        
	        model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));
	        
	        return "/uss/olh/wor/EgovSiteInfoRegist";
	      
	    }
	    
	    // 로그인VO에서 사용자 정보 가져오기
	    LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	    String frstRegisterId = loginVO.getId();
	    
	    siteManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
	    siteManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID
	        
	    linkSiteManageService.insertSiteInfo(siteManageVO);
	    
	    request.getSession().removeAttribute("sessionVO");
	    
	    return "forward:/mng/uss/ion/sit/SiteListInqire.do";
  }
  
  /**
   * 사이트정보 수정 전 처리
   * 
   * @param siteId
   * @param searchVO
   * @param model
   * @return "/mng/uss/ion/sit/EgovSiteInfoUpdt"
   * @throws Exception
   */
  @RequestMapping("/mng/uss/ion/sit/SiteInfoUpdtView.do")
  public String updateSiteInfoView(@ModelAttribute("searchVO") LinkSiteManageVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    // 공통코드를 가져오기 위한 Vo
    ComDefaultCodeVO vo = new ComDefaultCodeVO();
    vo.setCodeId("COM023");
    
    model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));
    
    // 변수명은 CoC 에 따라 sampleVO
    model.addAttribute("linkSite", linkSiteManageService.selectSiteDetail(searchVO));
    
    request.getSession().setAttribute("sessionVO", searchVO);
       
    return "/mng/uss/ion/sit/EgovSiteInfoRegist";
  }
  
  /**
   * 사이트정보를 수정한다.
   * 
   * @param searchVO
   * @param siteManageVO
   * @param bindingResult
   * @return "forward:/mng/uss/ion/sit/SiteListInqire.do"
   * @throws Exception
   */
  @RequestMapping("/mng/uss/ion/sit/SiteInfoUpdt.do")
  public String updateSiteInfo(@ModelAttribute("searchVO") LinkSiteManageVO searchVO, @ModelAttribute("siteManageVO") LinkSiteManageVO siteManageVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  if(request.getSession().getAttribute("sessionVO") == null) {
		  return "forward:/mng/uss/ion/sit/SiteListInqire.do";
	  }
	  
    // Validation
    beanValidator.validate(siteManageVO, bindingResult);
    
    if(bindingResult.hasErrors()) {
    	// 공통코드를 가져오기 위한 Vo
        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("COM023");
        
        model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));
        return "/uss/olh/wor/EgovSiteInfoRegist";
      
    }
    
    // 로그인VO에서 사용자 정보 가져오기
    LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    String lastUpdusrId = loginVO.getId();
    
    siteManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID
    
    linkSiteManageService.updateSiteInfo(siteManageVO);
    
    request.getSession().removeAttribute("sessionVO");
    
    return "forward:/mng/uss/ion/sit/SiteListInqire.do";
    
  }
  
  /**
   * 사이트정보를 삭제처리한다.
   * 
   * @param siteManageVO
   * @param searchVO
   * @return "forward:/mng/uss/ion/sit/SiteListInqire.do"
   * @throws Exception
   */
  @RequestMapping("/mng/uss/ion/sit/SiteInfoDelete.do")
  public String deleteSiteInfo(LinkSiteManageVO siteManageVO, @ModelAttribute("searchVO") LinkSiteManageVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
	  // 로그인VO에서 사용자 정보 가져오기
	  LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	  String lastUpdusrId = loginVO.getId();
	    
	  siteManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID
	  linkSiteManageService.deleteSiteInfo(siteManageVO);
    
	  return "forward:/mng/uss/ion/sit/SiteListInqire.do";
  }
  
}
