package egovframework.com.mng.sym.mpm.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovMpmHistoryService;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 메뉴 관리 컨트롤러 클래스
 * 
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see 
 */
@Controller
public class EgovMpmController {
  
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SiteManageService")
	private EgovSiteManageService siteManageService;
	
	@Resource(name = "EgovMpmService")
	private EgovMpmService egovMpmService;
	
	@Resource(name="EgovMpmHistoryService")
    private EgovMpmHistoryService mpmHistoryService;
  
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
  
	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;
  
	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
  
	@Autowired
	private DefaultBeanValidator beanValidator;

  /**
   * 메뉴 목록을 조회한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/mng/sym/mpm/selectMpmList.do")
  public String selectMpmList(@ModelAttribute("searchVO") MpmVO mnuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
      
	  /*
	  List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
	  
	  if(EgovStringUtil.isEmpty(mnuVO.getSiteId())) {
		  if(siteList != null && siteList.size() > 0) {
			  mnuVO.setSiteId(siteList.get(0).getSiteId());
		  }
	  }
	  
	  model.addAttribute("siteList", siteList);
	  */
	  
	  if(!Globals.MENU_AUTO_MAKE_SITE_ID.equals(mnuVO.getSiteId())) {
		  LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		  if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			  mnuVO.setSiteId(loginVO.getSiteId());
		  }
	  }
	  
	  model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
	  
	  /*
	  if(!EgovStringUtil.isEmpty(mnuVO.getSiteId())) {
		  model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
	  }
	  */
	  return "mng/sym/mpm/EgovMpmList";
  }
  
  
  /**
   * 메뉴 등록을 위한 등록페이지로 이동한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/sym/mpm/addMpm.do")
  public String addMpm(@ModelAttribute("searchVO") MpmVO mnuVO, SiteManageDefaultVO siteVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
	  model.addAttribute("siteInfo", siteManageService.selectSiteDetail(siteVO));
	  
	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM911");		
	  model.addAttribute("progList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM910");
	  model.addAttribute("mnuCntsList", cmmUseService.selectCmmCodeDetail(ccvo));
	  	
	  BoardMasterVO masterVO = new BoardMasterVO();
	  masterVO.setSiteId(mnuVO.getSiteId());
	  model.addAttribute("bbsList", bbsAttrbService.selectAllBBSMasteInf(masterVO));
	  
	  if(Globals.MENU_AUTO_MAKE_SITE_ID.equals(siteVO.getSiteId())) {
		  ccvo = new ComDefaultCodeVO();
		  ccvo.setCodeId("COM912");
		  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(ccvo));
	  }
		  
      model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
      
      mnuVO.setSortOrdr(egovMpmService.selectBoardArticleListCnt(mnuVO));
      
      mnuVO.setTakeMenuId(egovMpmService.selectMenuIdGnr());
      model.addAttribute("mnuVO", mnuVO);
      
      
      
	  request.getSession().setAttribute("sessionVO", mnuVO);
	  
	  return "mng/sym/mpm/EgovMpmRegist"; 
  }
    
  /**
   * 메뉴를 등록한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping("/mng/sym/mpm/insertMpm.do")
  public String insertMpm(final MultipartHttpServletRequest multiRequest, SiteManageDefaultVO siteVO, @ModelAttribute("searchVO") MpmVO mnuVO, @ModelAttribute("mnu") Mpm mnu, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    
	if(request.getSession().getAttribute("sessionVO") == null) {
		return "forward:/mng/sym/mpm/selectMpmList.do";
	}
    
    beanValidator.validate(mnu, bindingResult);
    
    if(bindingResult.hasErrors()) {
    	
    	model.addAttribute("siteInfo", siteManageService.selectSiteDetail(siteVO));
    	
    	ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  	ccvo.setCodeId("COM911");		
	  	model.addAttribute("progList", cmmUseService.selectCmmCodeDetail(ccvo));
	  	  
	  	ccvo = new ComDefaultCodeVO();
	  	ccvo.setCodeId("COM910");
	  	model.addAttribute("mnuCntsList", cmmUseService.selectCmmCodeDetail(ccvo));
		
		BoardMasterVO masterVO = new BoardMasterVO();
		masterVO.setSiteId(mnuVO.getSiteId());
		model.addAttribute("bbsList", bbsAttrbService.selectAllBBSMasteInf(masterVO));
		
		if(Globals.MENU_AUTO_MAKE_SITE_ID.equals(siteVO.getSiteId())) {
			  ccvo = new ComDefaultCodeVO();
			  ccvo.setCodeId("COM912");
			  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(ccvo));
		}
		
	    model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
		
    	return "mng/sym/mpm/EgovMpmRegist";
    }
    
    List<FileVO> result = null;    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if(!files.isEmpty()) {
    	result = fileUtil.directParseFileInf(files, "MENU_", 0, "Menu.fileStorePath", mnuVO.getSiteId());
    	
    	if(result != null) {
	    	for(int index=0; index < result.size(); index++) {
	    		FileVO file = result.get(index);
	    		if(file.getFormNm().startsWith("image")) {
	    			mnuVO.setImageFileNm(file.getStreFileNm());
	    		}
	    	}
    	}
    }
    
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    mnuVO.setFrstRegisterId(user.getId());
    
	egovMpmService.insertMpm(mnuVO);

	request.getSession().removeAttribute("sessionVO");
    
    return "forward:/mng/sym/mpm/selectMpmList.do";
  }
    
  /**
   *  메뉴 수정을 위한 수정페이지로 이동한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/sym/mpm/forUpdateMpm.do")
  public String forUpdateMpm(@ModelAttribute("searchVO") MpmVO mnuVO, SiteManageDefaultVO siteVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
	  model.addAttribute("siteInfo", siteManageService.selectSiteDetail(siteVO));
	  
	  MpmVO vo = egovMpmService.selectMpm(mnuVO);
	  
	  model.addAttribute("mnuVO", vo);
	  
	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM911");		
	  model.addAttribute("progList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM910");
	  model.addAttribute("mnuCntsList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  BoardMasterVO masterVO = new BoardMasterVO();
	  masterVO.setSiteId(mnuVO.getSiteId());
	  model.addAttribute("bbsList", bbsAttrbService.selectAllBBSMasteInf(masterVO));
	  
	  if(Globals.MENU_AUTO_MAKE_SITE_ID.equals(siteVO.getSiteId())) {
		  ccvo = new ComDefaultCodeVO();
		  ccvo.setCodeId("COM912");
		  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(ccvo));
	  }
	  
      model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
      
      model.addAttribute("MenuFileStoreWebPath", propertyService.getString("Menu.fileStoreWebPath"));
	  
      request.getSession().setAttribute("sessionVO", mnuVO);
      
	  return "mng/sym/mpm/EgovMpmRegist"; 
  }
    
  /**
   * 메뉴를 수정한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping("/mng/sym/mpm/updateMpm.do")
  public String updateMpm(final MultipartHttpServletRequest multiRequest, SiteManageDefaultVO siteVO, @ModelAttribute("searchVO") MpmVO mnuVO, @ModelAttribute("mnu") Mpm mnu, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    
	if(request.getSession().getAttribute("sessionVO") == null) {
		return "forward:/mng/sym/mpm/selectMpmList.do";
	}
    
    beanValidator.validate(mnu, bindingResult);
    
    if(bindingResult.hasErrors()) {
       
    	model.addAttribute("siteInfo", siteManageService.selectSiteDetail(siteVO));
    	
  	  	ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
  	  	ccvo.setCodeId("COM911");		
  	  	model.addAttribute("progList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
  	  	ccvo = new ComDefaultCodeVO();
  	  	ccvo.setCodeId("COM910");
  	  	model.addAttribute("mnuCntsList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
  	  	BoardMasterVO masterVO = new BoardMasterVO();
  	  	masterVO.setSiteId(mnuVO.getSiteId());
  	  	model.addAttribute("bbsList", bbsAttrbService.selectAllBBSMasteInf(masterVO));
	    
  	  	if(Globals.MENU_AUTO_MAKE_SITE_ID.equals(siteVO.getSiteId())) {
		  ccvo = new ComDefaultCodeVO();
		  ccvo.setCodeId("COM912");
		  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(ccvo));
  	  	}
  	  
  	  	model.addAttribute("mpmList", egovMpmService.selectMpmList(mnuVO));
  	  	
  	  	model.addAttribute("MenuFileStoreWebPath", propertyService.getString("Menu.fileStoreWebPath"));
  	  
  	  	return "mng/sym/mpm/EgovMpmRegist";
    }
    
    List<FileVO> result = null;    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if(!files.isEmpty()) {
    	result = fileUtil.directParseFileInf(files, "MENU_", 0, "Menu.fileStorePath", mnuVO.getSiteId());
    	
    	if(result != null) {
	    	for(int index=0; index < result.size(); index++) {
	    		FileVO file = result.get(index);
	    		if(file.getFormNm().startsWith("image")) {
	    			mnuVO.setImageFileNm(file.getStreFileNm());
	    		}
	    	}
    	}
    }
    
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    mnuVO.setLastUpdusrId(user.getId());
      
	egovMpmService.updateMpm(mnuVO);

	request.getSession().removeAttribute("sessionVO");
	
    return "forward:/mng/sym/mpm/selectMpmList.do";
  }
  
  /**
   * 메뉴를 삭제한다.
   * 
   * @param mnuVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/sym/mpm/deleteMpm.do")
  public String deleteMpm(@ModelAttribute("searchVO") MpmVO mnuVO, @ModelAttribute("mnu") Mpm mnu, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	  mnu.setLastUpdusrId(user.getId());
	  
      egovMpmService.deleteMpm(mnuVO);

    // status.setComplete();
    return "forward:/mng/sym/mpm/selectMpmList.do";
  }
  
  /**
   * 메뉴를 이동한다.
   * 
   * @param mnuVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/sym/mpm/updateMpmSortOrdr.do")
  public void updateMpmSortOrdr(@ModelAttribute("searchVO") MpmVO mnuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
      	int updateCnt = egovMpmService.updateMpmSortOrdr(mnuVO);
      
      	JSONObject jObj = new JSONObject();
      	jObj.put("updateCnt", updateCnt);
	  	
	  	response.setContentType("text/javascript; charset=utf-8");
	  	PrintWriter printwriter = response.getWriter();
	  	printwriter.println(jObj.toString());
	  	printwriter.flush();
		printwriter.close();
    //return "forward:/mng/sym/mpm/selectMpmList.do";
  }
  
  
  @RequestMapping(value="/mng/sym/mpm/selectMpmHistoryList.do")
  public String selectBbsTemplateHistoryList(@ModelAttribute("searchVO") MpmVO searchVO, 
  		ModelMap model)
          throws Exception {
  	
  		/** EgovPropertyService.sample */
  		searchVO.setPageUnit(propertyService.getInt("pageUnit"));
  		searchVO.setPageSize(propertyService.getInt("pageSize"));
  	
  		/** pageing */
  		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		model.addAttribute("resultList", mpmHistoryService.selectMpmHistoryList(searchVO));
      
		int totCnt = mpmHistoryService.selectMpmHistoryListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
      
		return "/mng/sym/mpm/EgovMpmHistoryList";
  } 
  
  @RequestMapping("/mng/sym/mpm/selectMpmHistory.do")
  public String selectBbsTemplateHistory(@ModelAttribute("searchVO") MpmVO searchVO, Model model, HttpServletRequest request) throws Exception {
      	
	  	ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  	ccvo.setCodeId("COM911");		
	  	model.addAttribute("progList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  	ccvo = new ComDefaultCodeVO();
	  	ccvo.setCodeId("COM910");
	  	model.addAttribute("mnuCntsList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  	BoardMasterVO masterVO = new BoardMasterVO();
	  	masterVO.setSiteId(searchVO.getSiteId());
	  	model.addAttribute("bbsList", bbsAttrbService.selectAllBBSMasteInf(masterVO));
	  
	  	//model.addAttribute("mpmList", egovMpmService.selectMpmList(searchVO));
      
      	model.addAttribute("MenuFileStoreWebPath", propertyService.getString("Menu.fileStoreWebPath"));
      
     	model.addAttribute("mnuVO", mpmHistoryService.selectMpmHistory(searchVO));
      
      	return "/mng/sym/mpm/EgovMpmHistoryView";
  }
  
  @RequestMapping("/mng/sym/mpm/updateMpmRollBack.do")
  public String updateLytTemplateRollBack(@ModelAttribute("searchVO") MpmVO searchVO, Model model, HttpServletRequest request) throws Exception {
      
	  	MpmVO his = mpmHistoryService.selectMpmHistory(searchVO);
  		if(his != null) {
  			his.setSiteId(searchVO.getSiteId());
  			egovMpmService.updateMpm(his);
  		
  			model.addAttribute("rollbackComplete", "Y");
  		}
      
  		return "forward:/mng/sym/mpm/selectMpmHistoryList.do";
  }
  
  @RequestMapping("/mng/sym/mpm/previewMpm.do")
  public String previewMpm(@ModelAttribute("searchVO") MpmVO searchVO, Model model, HttpServletRequest request) throws Exception {
      
	  egovMpmService.previewPublish(searchVO);
	  
	  model.addAttribute("result", searchVO.getMenuWebPath());
	  
	  return "/mng/sym/mpm/EgovMpmPreview";
  }	  
  
  @RequestMapping("/mng/sym/sit/updateMpmMenuNm.do")
  public void updateMpmMenuNm(@ModelAttribute("searchVO") MpmVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
      
	  searchVO.setHtmlUseAt("N");
	  int iCount = egovMpmService.updateMpmMenuNm(searchVO);
	  
	  JSONObject jObj = new JSONObject();
	  if(iCount != 0) {
  		jObj.put("updateCount", iCount);
	    jObj.put("menuId", searchVO.getMenuId());
	    jObj.put("menuNm", searchVO.getMenuNm());
  	  } else {
  		jObj.put("updateCount", "0");
  	  }
	  response.setContentType("text/javascript; charset=utf-8");
	  PrintWriter printwriter = response.getWriter();
	  printwriter.println(jObj.toString());
	  printwriter.flush();
	  printwriter.close();
  }	  
}
