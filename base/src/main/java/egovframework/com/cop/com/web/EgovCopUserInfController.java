package egovframework.com.cop.com.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.cop.com.service.EgovUserInfManageService;
import egovframework.com.cop.com.service.UserInfVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 협업기능에서 활용하는 사용자 정보 조회용 컨트롤러 클래스
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
 *   2009.4.6  이삼섭          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovCopUserInfController {

    @Resource(name = "EgovUserInfManageService")
    private EgovUserInfManageService userInfService;

    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    Logger log = Logger.getLogger(this.getClass());

    /**
     * 커뮤니티 관리자 및 동호회 운영자 권한을 확인한다.
     * 
     * @param userVO
     * @throws EgovBizException
     */
    protected void checkAuthority(UserInfVO userVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String targetId = userVO.getTrgetId();
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	
	if (user == null) {
	    throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
	}
	
	if (targetId.startsWith("CMMNTY_")) {
	    CommunityUser cmmntyUser = new CommunityUser();
	    
	    cmmntyUser.setCmmntyId(userVO.getTrgetId());
	    cmmntyUser.setEmplyrId(user.getId());
	    
	    if (!cmmntyService.isManager(cmmntyUser)) {
		throw new EgovBizException("해당 커뮤니티 관리자만 사용하실 수 있습니다.");
	    }
	} else {
	    throw new EgovBizException("대상ID 정보가 정확하지 않습니다.");
	}
    }
    
    /**
     * 커뮤니티 사용자 목록을 조회한다.
     * 
     * @param userVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/selectCmmntyUserList.do")
    public String selectCmmntyUserList(@ModelAttribute("searchVO") UserInfVO userVO, Map<String, Object> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    checkAuthority(userVO, request, response);	// server-side 권한 확인
    
    SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	model.addAttribute("siteInfo", siteVO);
	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	
	String popFlag = (String)commandMap.get("PopFlag");
	String returnUrl = "/cop/com/EgovUserList";
	
	if ("Y".equals(popFlag)) returnUrl = "/cop/com/EgovUserListPop";
	
	if (! "Y".equals(popFlag)) checkAuthority(userVO, request, response);	// server-side 권한 확인

	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	CommunityUser cmmntyUser = new CommunityUser();	
	cmmntyUser.setSiteId(siteVO.getSiteId());
	cmmntyUser.setEmplyrId(user.getId());
	cmmntyUser.setCmmntyId(userVO.getTrgetId());
	model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보

	String trgetId = (String)commandMap.get("trgetId");

	userVO.setTrgetId(trgetId);
	userVO.setPageUnit(propertyService.getInt("pageUnit"));
	userVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(userVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(userVO.getPageUnit());
	paginationInfo.setPageSize(userVO.getPageSize());

	userVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	userVO.setLastIndex(paginationInfo.getLastRecordIndex());
	userVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = userInfService.selectCmmntyUserList(userVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("targetMethod", "selectCmmntyUserList");
	model.addAttribute("trgetId", trgetId);
	model.addAttribute("paginationInfo", paginationInfo);
	
	model.addAttribute("authorList", cmmntyService.selectAuthorAllList(null));

	return returnUrl;
    }

    
    /**
     * 커뮤니티 사용정보를 삭제한다.
     * 
     * @param userVO
     * @param commandMap
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/deleteCmmntyUser.do")
    public String deleteCmmntyUser(@ModelAttribute("searchVO") UserInfVO userVO, Map<String, Object> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	checkAuthority(userVO, request, response);	// server-side 권한 확인
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);

	String cmmntyId = (String)commandMap.get("param_cmmntyId");
	String emplyrId = (String)commandMap.get("param_emplyrId");

	CommunityUser cmmntyUser = new CommunityUser();
	
	cmmntyUser.setLastUpdusrId(user.getId());
	cmmntyUser.setCmmntyId(cmmntyId);
	cmmntyUser.setEmplyrId(emplyrId);
	cmmntyUser.setSecsnDe(EgovDateUtil.getToday());
	
	if (isAuthenticated) {
	    cmmntyService.deleteCommunityUserInf(cmmntyUser);
	}

	return "forward:/cop/com/selectCmmntyUserList.do";
    }

    /**
     * 커뮤니티 사용자 정보를 수정한다.
     * 
     * @param userVO
     * @param commandMap
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/reRegistCmmntyUser.do")
    public String reRegisterCmmntyUser(@ModelAttribute("searchVO") UserInfVO userVO, Map<String, Object> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	checkAuthority(userVO, request, response);	// server-side 권한 확인
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);

	String cmmntyId = (String)commandMap.get("param_cmmntyId");
	String emplyrId = (String)commandMap.get("param_emplyrId");

	CommunityUser cmmntyUser = new CommunityUser();
	
	cmmntyUser.setLastUpdusrId(user.getId());
	cmmntyUser.setCmmntyId(cmmntyId);
	cmmntyUser.setEmplyrId(emplyrId);
	cmmntyUser.setUseAt("Y");
	
	if (isAuthenticated) {
	    cmmntyService.updateCommunityUserInf(cmmntyUser);
	}

	return "forward:/cop/com/selectCmmntyUserList.do";
    }

    /**
     * 커뮤니티 사용자 권한정보를 수정한다.
     * 
     * @param userVO
     * @param commandMap
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/authorUpdateCmmntyUser.do")
    public String authorUpdateCmmntyUser(@ModelAttribute("searchVO") UserInfVO userVO, Map<String, Object> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	checkAuthority(userVO, request, response);	// server-side 권한 확인
	
	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);

	String cmmntyId = (String)commandMap.get("param_cmmntyId");
	String emplyrId = (String)commandMap.get("param_emplyrId");
	String authorCode = (String)commandMap.get("param_authorCode");

	CommunityUser cmmntyUser = new CommunityUser();
	
	cmmntyUser.setLastUpdusrId(user.getId());
	cmmntyUser.setCmmntyId(cmmntyId);
	cmmntyUser.setEmplyrId(emplyrId);
	cmmntyUser.setAuthorCode(authorCode);
	
	if (isAuthenticated) {
	    cmmntyService.updateCommunityUserInf(cmmntyUser);
	}

	return "forward:/cop/com/selectCmmntyUserList.do";
    }

    
}
