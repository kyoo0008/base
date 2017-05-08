package egovframework.com.cop.cmy.web;

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
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.com.cop.cmy.service.CommunityMnuVO;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
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
@Controller("EgovBBSAttributeManageController")
public class EgovBBSAttributeManageController {

	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;
		
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService             cmmUseService;
		
	@Resource(name = "EgovBBSCtgryMasterService")
    private EgovBBSCtgryMasterService egovBBSCtgryMasterService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
	  
	@Autowired
	private DefaultBeanValidator          beanValidator;
	  
	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;	// 커뮤니티 관리자 권한 확인
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService 				  siteManageService;
    
	
	Logger log = Logger.getLogger(this.getClass());
	  
	  
	/**
     * 커뮤니티 관리자 및 동호회 운영자 권한을 확인한다.
     * 
     * @param boardMaster
     * @throws EgovBizException
     */
    protected void checkAuthority(BoardMaster boardMaster, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);	
		if (!isAuthenticated) {
		    throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
		}
		
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		
		String targetId = boardMaster.getTrgetId();
		
		if (targetId.startsWith("CMMNTY_")) {
		    CommunityUser cmmntyUser = new CommunityUser();
		    
		    cmmntyUser.setCmmntyId(boardMaster.getTrgetId());
		    cmmntyUser.setEmplyrId(user.getId());
		    
		    if (!cmmntyService.isManager(cmmntyUser)) {
			throw new EgovBizException("해당 커뮤니티 관리자만 사용하실 수 있습니다.");
		    }
		} else {
		    throw new EgovBizException("대상ID 정보가 정확하지 않습니다.");
		}
    }
	
	  /**
	   * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
	   * 
	   * @param boardMasterVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/cop/cmy/bbs/addBBSMaster.do")
	  public String addBBSMaster(@ModelAttribute("searchVO") CommunityMnuVO cmmntyMnu, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		checkAuthority(cmmntyMnu, request, response);	// server-side 권한 확인
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
				
	    ComDefaultCodeVO vo = new ComDefaultCodeVO();
	    vo.setCodeId("COM912");	    
	    model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
	    
	    model.addAttribute("authList", cmmntyService.selectAuthorAllList(null));
	    
	    CtgryMaster ctgrymasterVO = new CtgryMaster();
	    ctgrymasterVO.setFirstIndex(0);
	    ctgrymasterVO.setRecordCountPerPage(999999999);
	    model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
	    
	    model.addAttribute("boardMaster", cmmntyMnu);	    

	    request.getSession().setAttribute("sessionVO", cmmntyMnu);
	    
	    return "cop/cmy/bbs/EgovBoardMstrRegist";
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
	  @RequestMapping("/cop/cmy/bbs/insertBBSMasterInf.do")
	  public String insertBBSMasterInf(@ModelAttribute("searchVO") CommunityMnuVO cmmntyMnu, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	    
		checkAuthority(cmmntyMnu, request, response);	// server-side 권한 확인
		  
		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
		}
		  
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		cmmntyMnu.setSiteId(siteVO.getSiteId());
		cmmntyMnu.setSysTyCode(siteVO.getSysTyCode());
		  
		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	    beanValidator.validate(cmmntyMnu, bindingResult);
	    if(bindingResult.hasErrors()) {
	      
	    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
		    vo.setCodeId("COM912");	    
		    model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
		    
		    model.addAttribute("authList", cmmntyService.selectAuthorAllList(null));
		    
		    CtgryMaster ctgrymasterVO = new CtgryMaster();
		    ctgrymasterVO.setFirstIndex(0);
		    ctgrymasterVO.setRecordCountPerPage(999999999);
		    model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
		    
		    model.addAttribute("siteInfo", siteVO);
		    model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		    
		    return "cop/cmy/bbs/EgovBoardMstrRegist";
	    }
	    
	    cmmntyMnu.setFrstRegisterId(loginVO.getId());
	    cmmntyMnu.setRegistSeCode("REGC06");
	    cmmntyService.insertBBSMasterInf(cmmntyMnu);
	    
	    request.getSession().removeAttribute("sessionVO");

	    
	    return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
	  }
	  	  
	  /**
	   * 게시판 마스터 상세내용을 조회한다.
	   * 
	   * @param boardMasterVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/cop/cmy/bbs/SelectBBSMasterInf.do")
	  public String selectBBSMasterInf(@ModelAttribute("searchVO") CommunityMnuVO cmmntyMnu, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		checkAuthority(cmmntyMnu, request, response);	// server-side 권한 확인
		  
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		cmmntyMnu.setSiteId(siteVO.getSiteId());
		cmmntyMnu.setSysTyCode(siteVO.getSysTyCode());
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM912");	    
		model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
		
	    model.addAttribute("authList", cmmntyService.selectAuthorAllList(null));
	    
	    model.addAttribute("boardMaster", cmmntyService.selectCmmntyMasterInf(cmmntyMnu));
	    
	    request.getSession().setAttribute("sessionVO", cmmntyMnu);
	    	    
	    return "cop/cmy/bbs/EgovBoardMstrRegist";
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
	  @RequestMapping("/cop/cmy/bbs/updateBBSMasterInf.do")
	  public String updateBBSMasterInf(@ModelAttribute("searchVO") CommunityMnuVO cmmntyMnu, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		checkAuthority(cmmntyMnu, request, response);	// server-side 권한 확인
		  
		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
		}
		  
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		cmmntyMnu.setSiteId(siteVO.getSiteId());
		cmmntyMnu.setSysTyCode(siteVO.getSysTyCode());
		
	    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	    beanValidator.validate(cmmntyMnu, bindingResult);
	    if(bindingResult.hasErrors()) {
	    	
	    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
			vo.setCodeId("COM912");	    
			model.addAttribute("attrbList", cmmUseService.selectCmmCodeDetail(vo));
			
			model.addAttribute("authList", cmmntyService.selectAuthorAllList(null));
			
			CtgryMaster ctgrymasterVO = new CtgryMaster();
		    ctgrymasterVO.setFirstIndex(0);
		    ctgrymasterVO.setRecordCountPerPage(999999999);
		    model.addAttribute("ctgrymasterList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(ctgrymasterVO));
		    
		    model.addAttribute("siteInfo", siteVO);
		    model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	      
	      return "cop/cmy/bbs/EgovBoardMstrRegist";
	    }
	    
	    cmmntyMnu.setLastUpdusrId(user.getId());
	    cmmntyService.updateBBSMasterInf(cmmntyMnu);

	      request.getSession().removeAttribute("sessionVO");
	      
	    return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
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
	  @RequestMapping("/cop/cmy/bbs/DeleteBBSMasterInf.do")
	  public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		checkAuthority(boardMasterVO, request, response);	// server-side 권한 확인
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		boardMaster.setSiteId(siteVO.getSiteId());
		boardMaster.setSysTyCode(siteVO.getSysTyCode());
		
	    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	      boardMaster.setLastUpdusrId(user.getId());
	      bbsAttrbService.deleteBBSMasterInf(boardMaster);

	    return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
	  }
	  
	  
}
