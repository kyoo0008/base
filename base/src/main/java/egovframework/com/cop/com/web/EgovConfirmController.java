package egovframework.com.cop.com.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.cop.com.service.ConfirmHistory;
import egovframework.com.cop.com.service.ConfirmHistoryVO;
import egovframework.com.cop.com.service.EgovConfirmManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 승인정보 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.4.10  이삼섭          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovConfirmController {

    @Resource(name = "EgovConfirmManageService")
    private EgovConfirmManageService confmService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;	// 커뮤니티 관리자 권한 확인
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
    
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 커뮤니티 운영자 권한을 확인한다.
     * 
     * @param history
     * @throws EgovBizException
     */
    protected void checkAuthority(ConfirmHistory history, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String targetId = history.getTrgetId();
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	
	if (user == null) {
	    throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
	}
	
	if (targetId.startsWith("CMMNTY_")) {
	    CommunityUser cmmntyUser = new CommunityUser();
	    
	    cmmntyUser.setCmmntyId(history.getTrgetId());
	    cmmntyUser.setEmplyrId(user.getId());
	    
	    if (!cmmntyService.isManager(cmmntyUser)) {
		throw new EgovBizException("해당 커뮤니티 관리자만 사용하실 수 있습니다.");
	    }
	} else {
	    throw new EgovBizException("대상ID 정보가 정확하지 않습니다.");
	}
    }

    /**
     * 승인(탈퇴)요청에 대한 목록을 조회한다.
     * 
     * @param historyvO
     * @param sessionVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/selectConfirmRequest.do")
    public String selectConfirmRequest(@ModelAttribute("searchVO") ConfirmHistoryVO historyVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	@SuppressWarnings("unused")
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);

	historyVO.setPageUnit(propertyService.getInt("pageUnit"));
	historyVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(historyVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(historyVO.getPageUnit());
	paginationInfo.setPageSize(historyVO.getPageSize());

	historyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	historyVO.setLastIndex(paginationInfo.getLastRecordIndex());
	historyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	historyVO.setConfmerId(user.getId());

	Map<String, Object> map = confmService.selectConfirmRequest(historyVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));	
	model.addAttribute("paginationInfo", paginationInfo);

	return "cop/com/EgovConfirmList";
    }

    /**
     * 승인(탈퇴)요청 확인 처리를 위해 수정페이지로 이동한다.
     * 
     * @param historyVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/forUpdateConfirmRequest.do")
    public String forUpdateConfirmRequest(@ModelAttribute("searchVO") ConfirmHistoryVO historyVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
	    throws Exception {

    	checkAuthority(historyVO, request, response);	// server-side 권한 확인
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

		historyVO.setConfmerId(user.getId());
		
		CommunityUser cmmntyUser = new CommunityUser();	
		cmmntyUser.setSiteId(siteVO.getSiteId());
		cmmntyUser.setEmplyrId(user.getId());
		cmmntyUser.setCmmntyId(historyVO.getTrgetId());
		model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
		
	    ConfirmHistoryVO vo = confmService.selectSingleConfirmRequest(historyVO);
	    model.addAttribute("historyVO", vo);
	    
		ComDefaultCodeVO comDefaultCodeVO = new ComDefaultCodeVO();		
		comDefaultCodeVO.setCodeId("COM007");		
		model.addAttribute("typeList", cmmUseService.selectCmmCodeDetail(comDefaultCodeVO));
	
		return "cop/com/EgovConfmInfUpdt";
    }

    /**
     * 승인(탈퇴)요청에 대한 확인을 처리한다.
     * 
     * @param history
     * @param sessionVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/updateConfirmRequest.do")
    public String updateConfirmRequest(@ModelAttribute("history") ConfirmHistory history, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	if (! "".equals(history.getTrgetId())) {
	    checkAuthority(history, request, response);	// server-side 권한 확인
	}
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);

	history.setConfmerId(user.getId());
	
	if (isAuthenticated) {
	    confmService.updateConfirmRequest(history);
	}

	if ("".equals(history.getTrgetId())) {
	    return "forward:/cop/com/selectConfirmRequest.do";
	} else {
	    return "forward:/cop/com/selectConfirmRequestByTrget.do";
	}
    }

    /**
     * 커뮤니티/동호회 관리부분에서 승인(탈퇴)요청에 대한 목록을 조회한다.
     * 
     * @param historyvO
     * @param sessionVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/selectConfirmRequestByTrget.do")
    public String selectConfirmRequestByTrget(@ModelAttribute("searchVO") ConfirmHistoryVO historyVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
	    throws Exception {

	checkAuthority(historyVO, request, response);	// server-side 권한 확인
	
	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	model.addAttribute("siteInfo", siteVO);
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	CommunityUser cmmntyUser = new CommunityUser();	
	cmmntyUser.setSiteId(siteVO.getSiteId());
	cmmntyUser.setEmplyrId(user.getId());
	cmmntyUser.setCmmntyId(historyVO.getTrgetId());
	model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보

	historyVO.setPageUnit(propertyService.getInt("pageUnit"));
	historyVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(historyVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(historyVO.getPageUnit());
	paginationInfo.setPageSize(historyVO.getPageSize());

	historyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	historyVO.setLastIndex(paginationInfo.getLastRecordIndex());
	historyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	historyVO.setConfmerId(user.getId());

	Map<String, Object> map = confmService.selectConfirmRequest(historyVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("paginationInfo", paginationInfo);

	return "cop/com/EgovConfirmList";
    }
	
}
