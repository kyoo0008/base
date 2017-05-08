package egovframework.com.mng.cop.bbs.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.CtgryMaster;
import egovframework.com.cop.bbs.service.EgovBBSCtgryMasterService;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.cop.com.service.EgovBbsSourcService;
import egovframework.com.cop.com.service.EgovBbsTmplatService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sec.ram.service.EgovAuthorManageService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 게시판 속성관리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.12  이삼섭          최초 생성
 *   2009.06.26	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 * 
 * </pre>
 */
@Controller("mngEgovBBSAttributeManageController")
public class EgovBBSAttributeManageController {
	
	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService             cmmUseService;
	
	@Resource(name = "egovAuthorManageService")
	private EgovAuthorManageService egovAuthorManageService;
	
	@Resource(name = "EgovBBSCtgryMasterService")
    private EgovBBSCtgryMasterService egovBBSCtgryMasterService;
	
	@Resource(name = "EgovBbsTmplatService")
    private EgovBbsTmplatService bbsTmplatService;
	
	@Resource(name = "EgovBbsSourcService")
    private EgovBbsSourcService bbsSourcService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
	  
	@Autowired
	private DefaultBeanValidator          beanValidator;
	  
	
	Logger log = Logger.getLogger(this.getClass());
	  
	  
	  
	  /**
	   * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
	   * 
	   * @param boardMasterVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/addBBSMaster.do")
	  public String addBBSMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    		  
		  //model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
		  
		  ComDefaultCodeVO vo = new ComDefaultCodeVO();
		  vo.setCodeId("COM912");	    
		  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
	    
		  model.addAttribute("authList", egovAuthorManageService.selectAuthorAllList(null));
	    
		  CtgryMaster ctgrymasterVO = new CtgryMaster();
		  ctgrymasterVO.setSiteId(boardMasterVO.getSiteId());
		  ctgrymasterVO.setSysTyCode(boardMasterVO.getSysTyCode());
		  ctgrymasterVO.setFirstIndex(0);
		  ctgrymasterVO.setRecordCountPerPage(999999999);
		  model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
	   
		  model.addAttribute("boardMaster", boardMasterVO);	    
		  
		  model.addAttribute("fileStoreTemplateWebPathByPreFile", propertyService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
		  model.addAttribute("fileStoreSourcWebPathByPreFile", propertyService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
	    
		  request.getSession().setAttribute("sessionVO", boardMasterVO);
		    
		  return "mng/cop/bbs/EgovBoardMstrRegist";
	  }
	  
	  /**
	   * 신규 게시판 마스터 정보를 등록한다.
	   * 
	   * @param boardMasterVO
	   * @param boardMaster
	   * @param status
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/insertBBSMasterInf.do")
	  public String insertBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	    
		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/SelectBBSMasterInfs.do";
		}
		  
		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	    beanValidator.validate(boardMaster, bindingResult);
	    if(bindingResult.hasErrors()) {
	      
	    	//model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
	    	
	    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
		    vo.setCodeId("COM912");	    
		    model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
		   
		    model.addAttribute("authList", egovAuthorManageService.selectAuthorAllList(null));
		    
		    CtgryMaster ctgrymasterVO = new CtgryMaster();
		    ctgrymasterVO.setSiteId(boardMasterVO.getSiteId());
			ctgrymasterVO.setSysTyCode(boardMasterVO.getSysTyCode());
		    ctgrymasterVO.setFirstIndex(0);
		    ctgrymasterVO.setRecordCountPerPage(999999999);
		    model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
		    
		    model.addAttribute("fileStoreTemplateWebPathByPreFile", propertyService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
			model.addAttribute("fileStoreSourcWebPathByPreFile", propertyService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
		    
		    return "mng/cop/bbs/EgovBoardMstrRegist";
	    }
	    
	    boardMaster.setFrstRegisterId(loginVO.getId());
	    bbsAttrbService.insertBBSMastetInf(boardMaster);
	    
	    request.getSession().removeAttribute("sessionVO");

	    
	    return "forward:/mng/cop/bbs/SelectBBSMasterInfs.do";
	  }
	  
	  /**
	   * 게시판 마스터 목록을 조회한다.
	   * 
	   * @param boardMasterVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/SelectBBSMasterInfs.do")
	  public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	   
		  /*
		  List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
		  
		  if(EgovStringUtil.isEmpty(boardMasterVO.getSiteId())) {
			  if(siteList != null && siteList.size() > 0) {
				  boardMasterVO.setSiteId(siteList.get(0).getSiteId());
			  }
		  }			  
		  model.addAttribute("siteList", siteList);
		  */
		  
		  if(EgovStringUtil.isEmpty(boardMasterVO.getSiteId())) {
			  LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
			  if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
				  boardMasterVO.setSiteId(loginVO.getSiteId());
			  }
		  }
		  boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
		  boardMasterVO.setPageSize(propertyService.getInt("pageSize"));
	    
		  PaginationInfo paginationInfo = new PaginationInfo();
	    
		  paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
		  paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
		  paginationInfo.setPageSize(boardMasterVO.getPageSize());
	    
		  boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		  boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
		  boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	    
		  if(!EgovStringUtil.isEmpty(boardMasterVO.getSiteId())) {
			  Map<String, Object> map = bbsAttrbService.selectBBSMasterInfs(boardMasterVO);
			  int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		    
			  paginationInfo.setTotalRecordCount(totCnt);
		    
			  model.addAttribute("resultList", map.get("resultList"));
			  model.addAttribute("resultCnt", map.get("resultCnt"));
		  }
		  model.addAttribute("paginationInfo", paginationInfo);
	    
		  return "mng/cop/bbs/EgovBoardMstrList";
	  }
	  
	  /**
	   * 게시판 마스터 상세내용을 조회한다.
	   * 
	   * @param boardMasterVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/SelectBBSMasterInf.do")
	  public String selectBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		  //model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
		  
		  ComDefaultCodeVO vo = new ComDefaultCodeVO();
		  vo.setCodeId("COM912");	    
		  model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
		
		  model.addAttribute("authList", egovAuthorManageService.selectAuthorAllList(null));
	    
		  CtgryMaster ctgrymasterVO = new CtgryMaster();
		  ctgrymasterVO.setSiteId(searchVO.getSiteId());
		  ctgrymasterVO.setSysTyCode(searchVO.getSysTyCode());
		  ctgrymasterVO.setFirstIndex(0);
		  ctgrymasterVO.setRecordCountPerPage(999999999);
		  model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
	    	    
		  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(searchVO);
		  model.addAttribute("boardMaster", master);
		  
		  if(!EgovStringUtil.isEmpty(master.getTmplatId())) {
			  BbsTmplat bbsTmplat = new BbsTmplat();
			  bbsTmplat.setBbsTmplatId(master.getTmplatId());
			  
			  model.addAttribute("bbsTmplatVO", bbsTmplatService.selectBbsTmplat(bbsTmplat));
		  }
		  
		  if(!EgovStringUtil.isEmpty(master.getSourcId())) {
			  BbsSourc bbsSourc = new BbsSourc();
			  bbsSourc.setBbsSourcId(master.getSourcId());
			  
			  model.addAttribute("bbsSourcVO", bbsSourcService.selectBbsSourc(bbsSourc));
		  }
		  
		  model.addAttribute("fileStoreTemplateWebPathByPreFile", propertyService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
		  model.addAttribute("fileStoreSourcWebPathByPreFile", propertyService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
	    
		  request.getSession().setAttribute("sessionVO", searchVO);
	    
		  return "mng/cop/bbs/EgovBoardMstrRegist";
	  }
	  
	  /**
	   * 게시판 마스터 정보를 수정한다.
	   * 
	   * @param boardMasterVO
	   * @param boardMaster
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/UpdateBBSMasterInf.do")
	  public String updateBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/SelectBBSMasterInfs.do";
		}
		  
	    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	    beanValidator.validate(boardMaster, bindingResult);
	    if(bindingResult.hasErrors()) {
	    	
	    	//model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
	    	
	    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
			vo.setCodeId("COM912");	    
			model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
			
			model.addAttribute("authList", egovAuthorManageService.selectAuthorAllList(null));
			
			CtgryMaster ctgrymasterVO = new CtgryMaster();
			ctgrymasterVO.setSiteId(boardMasterVO.getSiteId());
			ctgrymasterVO.setSysTyCode(boardMasterVO.getSysTyCode());
		    ctgrymasterVO.setFirstIndex(0);
		    ctgrymasterVO.setRecordCountPerPage(999999999);
		    model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
		    
		    BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(boardMasterVO);
			model.addAttribute("boardMaster", master);
			  
			if(!EgovStringUtil.isEmpty(master.getTmplatId())) {
				  BbsTmplat bbsTmplat = new BbsTmplat();
				  bbsTmplat.setBbsTmplatId(master.getTmplatId());
				  
				  model.addAttribute("bbsTmplatVO", bbsTmplatService.selectBbsTmplat(bbsTmplat));
			  }
			
			if(!EgovStringUtil.isEmpty(master.getSourcId())) {
				  BbsSourc bbsSourc = new BbsSourc();
				  bbsSourc.setBbsSourcId(master.getSourcId());
				  
				  model.addAttribute("bbsSourcVO", bbsSourcService.selectBbsSourc(bbsSourc));
			  }
		    
			model.addAttribute("fileStoreTemplateWebPathByPreFile", propertyService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
			model.addAttribute("fileStoreSourcWebPathByPreFile", propertyService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
	      
	      return "mng/cop/bbs/EgovBoardMstrRegist";
	    }
	    
	      boardMaster.setLastUpdusrId(user.getId());
	      bbsAttrbService.updateBBSMasterInf(boardMaster);

	      request.getSession().removeAttribute("sessionVO");
	      
	    return "forward:/mng/cop/bbs/SelectBBSMasterInfs.do";
	  }
	  
	  /**
	   * 게시판 마스터 정보를 삭제한다.
	   * 
	   * @param boardMasterVO
	   * @param boardMaster
	   * @param status
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/mng/cop/bbs/DeleteBBSMasterInf.do")
	  public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	      boardMaster.setLastUpdusrId(user.getId());
	      bbsAttrbService.deleteBBSMasterInf(boardMaster);

	    // status.setComplete();
	    return "forward:/mng/cop/bbs/SelectBBSMasterInfs.do";
	  }
	  
	  
}
