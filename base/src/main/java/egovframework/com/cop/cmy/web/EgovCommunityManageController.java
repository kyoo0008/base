package egovframework.com.cop.cmy.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.cmy.service.Community;
import egovframework.com.cop.cmy.service.CommunityMnuVO;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.CommunityUserVO;
import egovframework.com.cop.cmy.service.CommunityVO;
import egovframework.com.cop.cmy.service.CommunityMnu;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.cop.com.service.ConfirmHistory;
import egovframework.com.cop.com.service.EgovConfirmManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 커뮤니티 정보를 관리하기 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *   -------       --------    ---------------------------
 *   2009. 4. 2  이삼섭          최초 생성
 *   2012. 1. 18 이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
 *
 * </pre>
 */
@Controller("EgovCommunityManageController")
public class EgovCommunityManageController {
	
    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;

    @Resource(name = "EgovConfirmManageService")
    private EgovConfirmManageService confmService;

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

    Logger log = Logger.getLogger(this.getClass());
	
    
    /**
     * 커뮤니티 관리자 권한을 확인한다.
     * 
     * @param history
     * @throws EgovBizException
     */
    protected void checkAuthority(String trgetId, HttpServletRequest request, HttpServletResponse response) throws Exception {

		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		
		if (user == null) {
		    throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
		}
		
		if (trgetId.startsWith("CMMNTY_")) {
		    CommunityUser cmmntyUser = new CommunityUser();
		    
		    cmmntyUser.setCmmntyId(trgetId);
		    cmmntyUser.setEmplyrId(user.getId());
		    
		    if (!cmmntyService.isManager(cmmntyUser)) {
		    	throw new EgovBizException("해당 커뮤니티 관리자만 사용하실 수 있습니다.");
		    }
		} else {
			throw new EgovBizException("대상ID 정보가 정확하지 않습니다.");
		}
    }
    
	/**
     * 커뮤니티 메인에 대한 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyInfs.do")
    public String selectCmmntyInfs(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	/** 사이트 정보 */
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	cmmntyVO.setSiteId(siteVO.getSiteId());
    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
		
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(cmmntyVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());			
			model.addAttribute("USER_SBSCRB", cmmntyService.selectMyCmmntyList(cmmntyUser));	//사용자 가입목록
			model.addAttribute("LOGIN_USER_INFO", user);
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();		
		cmmntyVO.setPageUnit(propertyService.getInt("pageUnit"));
		cmmntyVO.setPageSize(propertyService.getInt("pageSize"));	    
		paginationInfo.setCurrentPageNo(cmmntyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmmntyVO.getRecordCountPerPage());
		paginationInfo.setPageSize(cmmntyVO.getPageSize());	
		cmmntyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmmntyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmmntyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		HashMap<String, Object> map = (HashMap<String, Object>)cmmntyService.selectCommunityInfs(cmmntyVO);		
		model.addAttribute("resultList", map.get("resultList"));
		int resultCnt = Integer.parseInt((String)map.get("resultCnt"));		
		paginationInfo.setTotalRecordCount(resultCnt);
		
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("CmmntyFileStoreWebPath", propertyService.getString("Cmmnty.fileStoreWebPath"));
		
		return "cop/cmy/EgovCmmntyInfs";
    }
    
    /**
     * 커뮤니티 메인에 대한 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/cop/cmy/selectCmmntyJsonList.do")
    public void selectCmmntyMainList(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(cmmntyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmmntyVO.getRecordCountPerPage());
		paginationInfo.setPageSize(cmmntyVO.getPageSize());
	
		cmmntyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmmntyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmmntyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		HashMap map = (HashMap)cmmntyService.selectCommunityInfs(cmmntyVO);
		
		List<CommunityVO> resultList = (List<CommunityVO>) map.get("resultList");
		int resultCnt = Integer.parseInt((String)map.get("resultCnt"));

		CommunityVO result = null;
		JSONObject jObj = null;
	  	JSONArray jArray = new JSONArray();
	  	if(resultList != null && resultList.size() > 0) {
		  	for(int i=0; i < resultList.size(); i++) {
		  		result = resultList.get(i);
		  		jObj = new JSONObject();
		  		jObj.put("cmmntyId", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getCmmntyId()));
		  		jObj.put("cmmntyNm", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getCmmntyNm()));
		  		jObj.put("cmmntyAdres", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getCmmntyAdres()));
		  		jObj.put("cmmntyIntrcn", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getCmmntyIntrcn()));
		  		jObj.put("atchFileIcon", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getAtchFileIcon()));
		  		jObj.put("frstRegisterNm", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getFrstRegisterNm()));
		  		jObj.put("resultCnt", resultCnt);
		  		jObj.put("userCo", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getUserCo()));
		  		jArray.add(jObj);
		  	}
	  	}
	  	
	  	response.setContentType("text/javascript; charset=utf-8");
	  	PrintWriter printwriter = response.getWriter();
	  	printwriter.println(jArray.toString());
	  	printwriter.flush();
		printwriter.close();
    }
    
    /**
     * 커뮤니티 등록을 위한 약관페이지로 이동한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyStplat.do")
    public String selectCmmntyStplat(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	/** 사이트 정보 */
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	model.addAttribute("LOGIN_USER_INFO", user);
    	
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
		request.getSession().setAttribute("sessionVO", cmmntyVO);
		
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		
    	return "cop/cmy/EgovCmmntyStplat";
    }

    /**
     * 커뮤니티 등록을 위한 등록페이지로 이동한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/addCmmntyInf.do")
    public String addCmmntyInf(@ModelAttribute("searchVO") CommunityVO cmmntyVO,  
    		Community community, 
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	/** 사이트 정보 */
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	model.addAttribute("LOGIN_USER_INFO", user);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	
    	if (request.getSession().getAttribute("sessionVO") == null) return "forward:/cop/cmy/selectCmmntyInfs.do";
    	
    	/** 공통코드 - 커뮤니티구분코드(COM201) */
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM201");
    	List<CmmnDetailCode> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
    	model.addAttribute("cmmntySe", listComCode);
    	
	  	if(!"".equals(cmmntyVO.getSearchTy())) community.setCmmntySeCode(cmmntyVO.getSearchTy());
	  	
	  	model.addAttribute("communityVO", community);
	  	
	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  	
    	return "cop/cmy/EgovCmmntyRegist";
    }

    /**
     * 커뮤니티 정보를 등록 개설한다.
     * 
     * @param cmmntyVO
     * @param community
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/cop/cmy/insertCmmntyInf.do")
    public String insertCmmntyInf(final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		Community community,
    		BindingResult bindingResult, 
    		ModelMap model, 
    		HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	if (request.getSession().getAttribute("sessionVO") == null) return "forward:/cop/cmy/selectCmmntyInfs.do";
    	
		//커뮤니티 개설정보 무결성 체크
    	boolean checkCmmnty = true;
    	
		beanValidator.validate(community, bindingResult);
		if (bindingResult.hasErrors()) {
			checkCmmnty = false;
		}

		if(checkCmmnty){
			if (cmmntyService.checkCmmntyNmDplct(cmmntyVO) > 0) {
	    		model.addAttribute("message", "입력하신 커뮤니티명은 이미 사용중입니다. 다른커뮤니티명을 입력하여 주십시오.");		//커뮤니티명 중복확인 체크
	    		checkCmmnty = false;
	    	}
		}
		
		if(checkCmmnty){
			if (cmmntyService.checkCmmntyAdresDplct(cmmntyVO) > 0) {
	    		model.addAttribute("message", "입력하신 커뮤니티 주소는 이미 사용중입니다. 다른커뮤니티 주소를 입력하여 주십시오.");	//커뮤니티 주소 중복확인 체크
	    		checkCmmnty = false;
	    	}
		}
		
		
		if (checkCmmnty) {
			SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
			community.setSiteId(siteVO.getSiteId());
			community.setSysTyCode(siteVO.getSysTyCode());
	
			List<FileVO> result = null;
	
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
		      if(!files.isEmpty()) {
		        result = fileUtil.directParseFileInf(files, "CMMNTY_", 0, "Cmmnty.fileStorePath", "");
		        community.setFileValue(result);
		      }
	
		      LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	
		      community.setEmplyrId(user.getId());
		      community.setFrstRegisterNm(user.getName());
		      community.setUseAt("Y");
		      community.setRegistSeCode("REGC02");
		      community.setFrstRegisterId(user.getId());
			
		    cmmntyService.insertCommunityInf(community);
	
			request.getSession().removeAttribute("sessionVO");
			return "forward:/cmy/"+cmmntyVO.getCmmntyAdres()+".do";
		}else{
			/** 공통코드 - 커뮤니티구분코드(COM201) */
			ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
		   	voComCode = new ComDefaultCodeVO();
	    	voComCode.setCodeId("COM201");
	    	List<CmmnDetailCode> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
	    	model.addAttribute("cmmntySe", listComCode);
	    	
		  	if(!"".equals(cmmntyVO.getSearchTy())) community.setCmmntySeCode(cmmntyVO.getSearchTy());
		    return "cop/cmy/EgovCmmntyRegist";
		}
    }

    /**
     * 커뮤니티 정보 수정을 위한 수정페이지로 이동한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/forUpdateCmmntyInf.do")
    public String forUpdateCmmntyInf(@ModelAttribute("searchVO") CommunityVO cmmntyVO, Community community,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response)
	    throws Exception {

    	checkAuthority(cmmntyVO.getCmmntyId(), request, response);	//권한확인
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	cmmntyVO.setSiteId(siteVO.getSiteId());
    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
    	
    	/** 공통코드 - 커뮤니티구분코드(COM201) */
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM201");
    	model.addAttribute("cmmntySe", cmmUseService.selectCmmCodeDetail(voComCode));
    	
	  	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

		model.addAttribute("communityVO", cmmntyService.selectCommunityInf(cmmntyVO));
		model.addAttribute("LOGIN_USER_INFO", user);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		
		request.getSession().setAttribute("sessionVO", cmmntyVO);
		return "cop/cmy/EgovCmmntyUpdt";
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
    @RequestMapping("/cop/cmy/updtCmmntyInf.do")
    public String updtCmmntyInf(final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		Community community,
    		BindingResult bindingResult, ModelMap model,  
    		HttpServletRequest request, HttpServletResponse response) throws Exception {

    	checkAuthority(cmmntyVO.getCmmntyId(), request, response);	//권한확인
    	
    	if (request.getSession().getAttribute("sessionVO") == null) return "forward:/cmy/"+cmmntyVO.getCmmntyAdres()+".do";
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

		beanValidator.validate(community, bindingResult);
		if (bindingResult.hasErrors()) {

			SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    	cmmntyVO.setSiteId(siteVO.getSiteId());
	    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
	    	
	    	/** 공통코드 - 커뮤니티구분코드(COM201) */
			ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
		   	voComCode = new ComDefaultCodeVO();
	    	voComCode.setCodeId("COM201");
	    	List<CmmnDetailCode> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
	    	model.addAttribute("cmmntySe", listComCode);
	    	
			model.addAttribute("communityVO", cmmntyService.selectCommunityInf(cmmntyVO));

		    return "cop/cmy/EgovCmmntyUpdt";
		}

		if (user != null) {

			List<FileVO> result = null;
	        
	        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	        if(!files.isEmpty()) {
	          result = fileUtil.directParseFileInf(files, "CMMNTY_", 0, "Cmmnty.fileStorePath", "");
	          community.setFileValue(result);
	        }
			community.setLastUpdusrId(user.getId());
			
			cmmntyService.updateCommunityInf(community);
		}
		request.getSession().removeAttribute("sessionVO");
		return "forward:/cmy/"+cmmntyVO.getCmmntyAdres()+".do";
    }
	
    /**
     * 정규식에 의한 페이지 주소 확인
     * 
     * @param url
     */
    public String extractUrlParts(String url) {

		String rVal = "";
		Pattern urlPattern = Pattern.compile("^(/cmy/?)\\/([^#\\s\\?]*)?$");
		Matcher mc = urlPattern.matcher(url);
		   
		if(mc.matches() && mc.group(2) != null && !"".equals(mc.group(2))){
			rVal = mc.group(2).replaceAll(".do", "");
		}
		return rVal;
    }

    /**
     * 커뮤니티 메인페이지의 기본 내용(게시판 4개 표시) 조회한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/cmy/*")
    public String selectCmmntyMainPage(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String cmmntyAdres = extractUrlParts(request.getRequestURI());	//현재 URL정보
    	
    	String cmmntyAdresReult = cmmntyService.selectCmmntyFindId(cmmntyAdres);

		if(cmmntyAdresReult == null || "".equals(cmmntyAdresReult)){
			model.addAttribute("message", "커뮤니티가 개설되어 있지 않거나 존재하지 않는 커뮤니티 입니다.");
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}

		cmmntyVO.setCmmntyId(cmmntyAdresReult);	//커뮤니티 주소 매칭
		
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	cmmntyVO.setSiteId(siteVO.getSiteId());
    	cmmntyVO.setSysTyCode(siteVO.getSysTyCode());
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(cmmntyVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());			 
			model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
			model.addAttribute("LOGIN_USER_INFO", user);
		}

		BoardMasterVO bbsVo = new BoardMasterVO();
		bbsVo.setSiteId(cmmntyVO.getSiteId());
		bbsVo.setSysTyCode(cmmntyVO.getSysTyCode());
		bbsVo.setTrgetId(cmmntyVO.getCmmntyId());

		// 게시판 목록 정보 처리
		List<CommunityMnu> bbsResult = cmmntyService.selectCommunityBbsMaster(cmmntyVO);
	
		model.addAttribute("bbsList", bbsResult);
	
		// 게시물 목록 정보 처리
		BoardVO boardVo = new BoardVO();
		CommunityMnu masterVo = null;
		
		boardVo.setTrgetId(cmmntyVO.getCmmntyId());
		
		//신규 게시물 처리
		boardVo.setRecordCountPerPage(15);
		List<BoardVO> bbsNewResult = cmmntyService.selectBoardNewArticles(boardVo);
		model.addAttribute("bbsNewList", bbsNewResult);
		
		if(bbsResult != null && bbsResult.size() > 0) {
			for (int i = 0; i < bbsResult.size() && i < 4; i++) {
			    masterVo = bbsResult.get(i);
			    boardVo = new BoardVO();
			    boardVo.setTrgetId(cmmntyVO.getCmmntyId());
			    boardVo.setBbsId(masterVo.getBbsId());
			    boardVo.setBbsNm(masterVo.getBbsNm());
			    boardVo.setTmplatId(masterVo.getTmplatId());
	
			    boardVo.setRecordCountPerPage(5);
			    bbsResult.get(i).setAriticleList(cmmntyService.selectBoardNewArticles(boardVo));
			}
		}
	
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	
		return "cop/cmy/EgovCmmntyMainPage";
    }

    /**
     * 커뮤니티 소개 페이지.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyInfo.do")
    public String selectCmmntyView(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	//커뮤니티 정보
		model.addAttribute("cmmntyVO", cmmntyService.selectCommunityInf(cmmntyVO));
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
		return "cop/cmy/EgovCmmntyInfo";
    }

    /**
     * 커뮤니티 사용신청(회원가입) 등록페이지.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyUserBySelf.do")
    public String selectCmmntyUserBySelf(@ModelAttribute("communityUserVO") CommunityUserVO communityUserVO,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	
    	model.addAttribute("LOGIN_USER_INFO", user);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	request.getSession().setAttribute("sessionVO", communityUserVO);
		return "cop/cmy/EgovCmmntyUserBySelf";
    }
    
    /**
     * 커뮤니티 사용신청(회원가입)을 등록한다.
     * 
     * @param communityUserVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/insertCmmntyUserBySelf.do")
    public String insertCmmntyUserBySelf(@ModelAttribute("communityUserVO") CommunityUserVO communityUserVO,
    		BindingResult bindingResult,
    		@ModelAttribute("cmmntyVO") CommunityVO cmmntyVO,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	beanValidator.validate(communityUserVO, bindingResult);
		if (bindingResult.hasErrors()) {
			
			model.addAttribute("LOGIN_USER_INFO", user);
	    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	    	
			return "cop/cmy/EgovCmmntyUserBySelf";
		}
    	
    	if (request.getSession().getAttribute("sessionVO") == null) return "forward:/cop/cmy/selectCmmntyUserBySelf.do";
    	
		String retVal = "";

		communityUserVO.setFrstRegisterId(user.getId());
		communityUserVO.setEmplyrId(user.getId());
		
	    //---------------------------------------------
	    // 재가입정책에 따른 가입 처리 
		// 가입방식 - confmPolicyCode Y:가입신청시 자동승인,  N:확인 후 수동승인
		// 재가입정책 - resbscrbPolicyCode Y:재가입 허용,	N:재가입 불가
	    //---------------------------------------------
		CommunityVO resultInfo = cmmntyService.selectCommunityInf(cmmntyVO);

		if ("Y".equals(resultInfo.getResbscrbPolicyCode()))	communityUserVO.setUseAt("Y");	// 재가입허용시 중복유무 체크
		retVal = cmmntyService.checkCommunityUserInf(communityUserVO);
		
	    if (!retVal.equals("EXIST")) {

			CommunityUser manager = cmmntyService.selectManager(cmmntyVO);
	
			ConfirmHistory history = new ConfirmHistory();
			
			history.setAutoAt(resultInfo.getConfmPolicyCode());					// 자동승인여부
			history.setConfmRqesterId(user.getId()); 							// 요청자 ID
			history.setConfmRqesterNm(user.getName()); 							// 요청자 이름
			history.setConfmRqesterIntrcn(communityUserVO.getUserIntrcn()); 	// 요청자 소개
			history.setConfmerId(manager.getEmplyrId()); 						// 승인자 ID
			history.setConfmTyCode("CF11"); 									// 커뮤니티사용자등록 (커뮤니티사용자등록)
			history.setConfmSttusCode("AP01"); 									// 승인요청(AP01:승인요청 AP02:승인허가 AP03:승인반려)
			history.setOpertTyCode("WC01"); 									// 회원가입
			history.setTrgetJobTyCode("CMY"); 									// 대상작업구분
			history.setTrgetJobId(communityUserVO.getCmmntyId());				// 대상작업 ID
			history.setMyMenuAt(communityUserVO.getMyMenuAt());
	
			int cnt = confmService.countConfirmRequest(history);	//승인중인 건수 중복체크
	
			if (cnt == 0) {
				
				confmService.insertConfirmRequest(history);

				if("Y".equals(resultInfo.getConfmPolicyCode())) {
					retVal = "CMMNTY_MBER_B";	//회원가입 완료
				}else{
					retVal = "CMMNTY_MBER_A";	//회원가입 요청
				}
			} else {
			    retVal = "ING";
			}
	    }else{
	    	if ("N".equals(resultInfo.getResbscrbPolicyCode())){
	    		retVal="CMMNTY_INTRCP";		//재가입 차단메세지
	    	}else{
	    		retVal="CMMNTY_MBER_FC";	//중복가입 메세지
	    	}
	    }

	    cmmntyVO.setResultCode(retVal);
	    request.getSession().removeAttribute("sessionVO");
	    return "forward:/cop/cmy/selectCmmntyMsg.do";
    }

    /**
     * 커뮤니티 탈퇴신청 페이지로 이동한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyUserSecsn.do")
    public String selectCmmntyUserSecsn(@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	model.addAttribute("LOGIN_USER_INFO", user);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
		request.getSession().setAttribute("sessionVO", cmmntyVO);
    	return "cop/cmy/EgovCmmntyUserSecsn";
    }
    
    /**
     * 커뮤니티 탈퇴신청을 처리한다.
     * 
     * @param cmmntyUser
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/deleteCmmntyUserSecsn.do")
    public String deleteCmmntyUserBySelf(@ModelAttribute("cmmntyUser") CommunityUser cmmntyUser, 
    		@ModelAttribute("cmmntyVO") CommunityVO cmmntyVO,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
    	String retVal = "";
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		} else {
			
			if (request.getSession().getAttribute("sessionVO") == null) return "forward:/cop/cmy/selectCmmntyInfs.do";
			
			cmmntyUser.setUseAt("N");
			cmmntyUser.setLastUpdusrId(user.getId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setSecsnDe(EgovDateUtil.getToday());
			
		    ConfirmHistory history = new ConfirmHistory();	    
		    history.setConfmRqesterId(user.getId());
		    history.setConfmerId(cmmntyUser.getEmplyrId());
		    history.setConfmDe(EgovDateUtil.getToday());
		    history.setConfmTyCode("CF12"); //커뮤니티사용자탈퇴
		    history.setConfmSttusCode("AP02"); //승인허가
		    history.setOpertTyCode("WC03"); //회원탈퇴
		    history.setOpertId("");
		    history.setTrgetJobTyCode("CMY");
		    history.setTrgetJobId(cmmntyUser.getCmmntyId());
	
		    confmService.insertConfirmRequest(history);
		    cmmntyService.deleteCommunityUserInf(cmmntyUser);
		    retVal = "DEL_REQ_SUCCESS";
		}

		cmmntyVO.setResultCode(retVal);
		request.getSession().removeAttribute("sessionVO");
	    return "forward:/cop/cmy/selectCmmntyMsg.do";
    }
    
    /**
     * 커뮤니티 폐쇄신청페이지로 이동한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyClosing.do")
    public String selectCmmntyClosing(@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
    	checkAuthority(cmmntyVO.getCmmntyId(), request, response);	//권한확인
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
		request.getSession().setAttribute("sessionVO", cmmntyVO);
		model.addAttribute("LOGIN_USER_INFO", user);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	return "cop/cmy/EgovCmmntyClosing";
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
    @RequestMapping("/cop/cmy/deleteCmmntyClosing.do")
    public String updtCmmntyCls(@ModelAttribute("searchVO") CommunityVO cmmntyVO, 
    		Community community,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	
    	CommunityUser cmmntyUser = new CommunityUser();
	    
	    cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());
	    cmmntyUser.setEmplyrId(user.getId());
	    CommunityUser result = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
	    
	    if(!"Y".equals(result.getMngrAt())){
	    	model.addAttribute("message", "권한이 없습니다.");
			return "forward:/cop/cmy/selectCmmntyInfs.do";
	    }

    	cmmntyService.deleteCommunityInf(community);
    	model.addAttribute("message", "커뮤니티를 정상적으로 폐쇄하였습니다.");
		
		return "forward:/cop/cmy/selectCmmntyInfs.do";
    }

    
    /**
     * 커뮤니티 등록을 위한 커뮤니티명을 중복검색 한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyNmDplct.do")
    public String selectCmmntyNmDplct(@ModelAttribute("cmmntyVO") CommunityVO cmmntyVO, 
    		ModelMap model, HttpServletRequest request) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
    	int cmmntyNmCnt = -1;
    	
    	if(EgovStringUtil.isEmpty(cmmntyVO.getCmmntyNm())){		//커뮤니티명이 입력시에만 중복확인 처리 한다.
    		model.addAttribute("cmmntyNmCnt", cmmntyNmCnt);
    		return "cop/cmy/EgovCmmntyNmDplct";
    	}

    	model.addAttribute("cmmntyNmCnt", cmmntyService.checkCmmntyNmDplct(cmmntyVO));
    	return "cop/cmy/EgovCmmntyNmDplct";
    }
    
    /**
     * 커뮤니티 등록을 위한 커뮤니티 주소를 중복검색 한다.
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyAdresDplct.do")
    public String selectCmmntyAdresDplct(@ModelAttribute("cmmntyVO") CommunityVO cmmntyVO, 
    		ModelMap model, HttpServletRequest request) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
    	int cmmntyAdresCnt = -1;
    	
    	if(EgovStringUtil.isEmpty(cmmntyVO.getCmmntyAdres())){		//커뮤니티주소가 입력시에만 중복확인 처리 한다.
    		model.addAttribute("cmmntyAdresCnt", cmmntyAdresCnt);
    		return "cop/cmy/EgovCmmntyAdresDplct";
    	}

    	model.addAttribute("cmmntyAdresCnt", cmmntyService.checkCmmntyAdresDplct(cmmntyVO));
    	return "cop/cmy/EgovCmmntyAdresDplct";
    }
    
    /**
     * 커뮤니티 메뉴를 순서를 변경한다.
     * 
     * @param mnuVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/updateCmmntySortOrdr.do")
    public String updateMpmSortOrdr(@ModelAttribute("searchVO") CommunityMnu communityMnu, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	checkAuthority(communityMnu.getTrgetId(), request, response);	//권한확인
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	communityMnu.setSiteId(siteVO.getSiteId());
    	communityMnu.setSysTyCode(siteVO.getSysTyCode());
    	communityMnu.setCmmntyId(communityMnu.getTrgetId());
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		communityMnu.setEmplyrId(user.getId());
		cmmntyService.updateCommunitySortOrdr(communityMnu);

      return "forward:/cop/cmy/selectCmmntyMasterInfs.do";
    }
    
    /**
	   * 커뮤니티 게시판 마스터 목록을 조회한다.
	   * 
	   * @param communityMnuVO
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/cop/cmy/selectCmmntyMasterInfs.do")
	  public String selectCmmntyMasterInfs(@ModelAttribute("searchVO") CommunityMnuVO communityMnuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		checkAuthority(communityMnuVO.getTrgetId(), request, response);	//권한확인
		  
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		communityMnuVO.setSiteId(siteVO.getSiteId());
		communityMnuVO.setSysTyCode(siteVO.getSysTyCode());
		
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user == null) {
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}else{
			CommunityUser cmmntyUser = new CommunityUser();
			cmmntyUser.setSiteId(communityMnuVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(communityMnuVO.getTrgetId());
			model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
		}
		
		communityMnuVO.setPageUnit(propertyService.getInt("pageUnit"));
		communityMnuVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(communityMnuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(communityMnuVO.getPageUnit());
		paginationInfo.setPageSize(communityMnuVO.getPageSize());
		
		communityMnuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		communityMnuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		communityMnuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = cmmntyService.selectCmmntyMasterInfs(communityMnuVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cop/cmy/EgovCmybbsMstrList";
	  }
    
    /**
     * 커뮤니티에 대한 처리결과 메세지를 보여준다.
     * 
     * @param cmmntyVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyMsg.do")
    public String selectCmmntyMsg(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "forward:/cop/cmy/selectCmmntyInfs.do";
		}
    	
    	model.addAttribute("LOGIN_USER_INFO", user);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
		return "cop/cmy/EgovCmmntyMsg";
    }
    
    /**
     * 커뮤니티 게시판의 전체검색 결과를 보여준다.
     * 
     * @param cmmntyVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/cmy/selectCmmntyBoardList.do")
    public String selectCmmntyBoardList(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(siteVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());			 
			model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
			model.addAttribute("LOGIN_USER_INFO", user);
		}
		
    	cmmntyVO.setPageUnit(propertyService.getInt("pageUnit"));
    	cmmntyVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(cmmntyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmmntyVO.getPageUnit());
		paginationInfo.setPageSize(cmmntyVO.getPageSize());
		
		cmmntyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmmntyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmmntyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<BoardVO> resultList = cmmntyService.selectCommunityBoardAllArticles(cmmntyVO);
        int totCnt = cmmntyService.selectCommunityBoardAllArticlesCnt(cmmntyVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		
		return "cop/cmy/EgovCommntyBoardList";
    }
}
