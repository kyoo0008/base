package egovframework.com.mng.uss.ion.bnr.web;

import java.util.ArrayList;
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
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.ion.bnr.service.Banner;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller("MngEgovBannerController")
public class EgovBannerController {
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	  
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil  fileUtil;
	  
	@Resource(name = "egovBannerService")
	private EgovBannerService egovBannerService;
	  
	/**
	* Message ID Generation
	*/
	@Resource(name = "egovBannerIdGnrService")
	private EgovIdGnrService egovBannerIdGnrService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService 				  siteManageService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	  
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService     cmmUseService;
	
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	* 배너를 관리하기 위해 등록된 배너목록을 조회한다.
	* 
	* @param bannerVO
	*- 배너 VO
	* @return String - 리턴 URL
	* @throws Exception
	*/
	@RequestMapping(value = "/mng/uss/ion/bnr/selectBannerList.do")
	public String selectBannerList(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		/*
		List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
		  
		if(EgovStringUtil.isEmpty(bannerVO.getSiteId())) {
			if(siteList != null && siteList.size() > 0) {
				bannerVO.setSiteId(siteList.get(0).getSiteId());
			}
		}
		model.addAttribute("siteList", siteList);
		*/
		
		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			bannerVO.setSiteId(loginVO.getSiteId());
		}
		
		// 공통코드를 가져오기 위한 Vo
    	ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("COM109");    
    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(codeVO));
    	
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bannerVO.getPageUnit());
		paginationInfo.setPageSize(bannerVO.getPageSize());
		
		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(!EgovStringUtil.isEmpty(bannerVO.getSiteId())) {
			bannerVO.setBannerList(egovBannerService.selectBannerList(bannerVO));
			
			model.addAttribute("bannerList", bannerVO.getBannerList());
			
			int totCnt = egovBannerService.selectBannerListTotCnt(bannerVO);
			paginationInfo.setTotalRecordCount(totCnt);
		}
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/mng/uss/ion/bnr/EgovBannerList";
	}

	/**
	* 배너등록 화면으로 이동한다.
	* 
	* @param banner
	*        - 배너 model
	* @return String - 리턴 Url
	*/
	@RequestMapping(value = "/mng/uss/ion/bnr/addViewBanner.do")
	public String insertViewBanner(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		model.addAttribute("banner", bannerVO);

		if("BAN001".equals(bannerVO.getBannerTyCode()) || "BAN002".equals(bannerVO.getBannerTyCode())) {
			// 팝업창시작일자(시)
			model.addAttribute("ntceBgndeHH", getTimeHH());
			// 팝업창시작일자(분)
			model.addAttribute("ntceBgndeMM", getTimeMM());
			// 팝업창종료일자(시)
			model.addAttribute("ntceEnddeHH", getTimeHH());
			// 팝업창정료일자(분)
			model.addAttribute("ntceEnddeMM", getTimeMM());
		}
		
		// 공통코드를 가져오기 위한 Vo
    	ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("COM109");    
    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(codeVO));

		request.getSession().setAttribute("sessionVO", bannerVO);

		return "/mng/uss/ion/bnr/EgovBannerRegist";
	}
	
	/**
	* 배너정보를 신규로 등록한다.
	* 
	* @param banner
	*        - 배너 model
	* @return String - 리턴 Url
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mng/uss/ion/bnr/addBanner.do")
	public String insertBanner(final MultipartHttpServletRequest multiRequest, Banner banner, @ModelAttribute("searchVO") BannerVO bannerVO, BindingResult bindingResult, 
			HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/uss/ion/bnr/selectBannerList.do";
		}

		beanValidator.validate(banner, bindingResult); // validation 수행

		if(bindingResult.hasErrors()) {
			model.addAttribute("bannerVO", bannerVO);
			
			// 공통코드를 가져오기 위한 Vo
	    	ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
	    	codeVO.setCodeId("COM109");    
	    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(codeVO));
	    	
			return "/mng/hpg/bnr/EgovBannerRegist";
		} else {

			LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

			List<FileVO> result = null;

			String bannerImage = "";
			String bannerImageFile = "";

			final Map<String, MultipartFile> files = multiRequest.getFileMap();

			if(!files.isEmpty()) {
				result = fileUtil.directParseFileInf(files, "BNR_", 0, "Banner.fileStorePath", bannerVO.getSiteId());

				if(result != null && result.size() > 0) {
					FileVO vo = (FileVO)result.get(0);
					bannerImage = vo.getOrignlFileNm();
					bannerImageFile = vo.getStreFileNm();
				}
			}

			String genId = egovBannerIdGnrService.getNextStringId();
			banner.setBannerId(genId);
			banner.setBannerImage(bannerImage);
			banner.setBannerImageFile(bannerImageFile);
			banner.setFrstRegisterId(user.getId());
			bannerVO.setBannerId(banner.getBannerId());
			model.addAttribute("banner", egovBannerService.insertBanner(banner, bannerVO));

			request.getSession().removeAttribute("sessionVO");

			return "forward:/mng/uss/ion/bnr/selectBannerList.do";

		}
	}
	
	/**
	* 기 등록된 배너정보를 수정한다.
	* 
	* @param banner
	*        - 배너 model
	* @return String - 리턴 Url
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mng/uss/ion/bnr/updtBanner.do")
	public String updateBanner(final MultipartHttpServletRequest multiRequest, Banner banner, @ModelAttribute("searchVO") BannerVO bannerVO, BindingResult bindingResult, 
			HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/uss/ion/bnr/selectBannerList.do";
		}

		beanValidator.validate(banner, bindingResult); // validation 수행

		if(bindingResult.hasErrors()) {
			model.addAttribute("bannerVO", banner);
			
			// 공통코드를 가져오기 위한 Vo
	    	ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
	    	codeVO.setCodeId("COM109");    
	    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(codeVO));
	    	
			return "/mng/uss/ion/bnr/EgovBannerRegist";
		} else {

			LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

			List<FileVO> result = null;

			final Map<String, MultipartFile> files = multiRequest.getFileMap();

			if(!files.isEmpty()) {
				result = fileUtil.directParseFileInf(files, "BNR_", 0, "Banner.fileStorePath", banner.getSiteId());

				if(result != null && result.size() > 0) {
					FileVO vo = (FileVO)result.get(0);
					banner.setBannerImage(vo.getOrignlFileNm());
					banner.setBannerImageFile(vo.getStreFileNm());
					banner.setAtchFile(true);
				} else {
					banner.setAtchFile(false);
				}
			} else {
				banner.setAtchFile(false);
			}

			banner.setLastUpdusrId(user.getId());

			egovBannerService.updateBanner(banner);

			request.getSession().removeAttribute("sessionVO");

			return "forward:/mng/uss/ion/bnr/selectBannerList.do";

		}

	}
	
	/**
	* 등록된 배너의 상세정보를 조회한다.
	* 
	* @param bannerVO
	*        - 배너 Vo
	* @return String - 리턴 Url
	*/
	@RequestMapping(value = "/mng/uss/ion/bnr/getBanner.do")
	public String selectBanner(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		BannerVO vo = egovBannerService.selectBanner(bannerVO);
		
		// 공통코드를 가져오기 위한 Vo
    	ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("COM109");    
    	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(codeVO));

		if("BAN001".equals(vo.getBannerTyCode())) {
			String sNtceBgnde = vo.getNtceBgnde();
			String sNtceEndde = vo.getNtceEndde();
			vo.setNtceBgndeHH(sNtceBgnde.substring(8, 10));
			vo.setNtceBgndeMM(sNtceBgnde.substring(10, 12));
			vo.setNtceEnddeHH(sNtceEndde.substring(8, 10));
			vo.setNtceEnddeMM(sNtceEndde.substring(10, 12));

			// 팝업창시작일자(시)
			model.addAttribute("ntceBgndeHH", getTimeHH());
			// 팝업창시작일자(분)
			model.addAttribute("ntceBgndeMM", getTimeMM());
			// 팝업창종료일자(시)
			model.addAttribute("ntceEnddeHH", getTimeHH());
			// 팝업창정료일자(분)
			model.addAttribute("ntceEnddeMM", getTimeMM());
		}

		model.addAttribute("banner", vo);
		
		model.addAttribute("BannerFileStoreWebPath", propertyService.getString("Banner.fileStoreWebPath"));

		request.getSession().setAttribute("sessionVO", bannerVO);

		return "/mng/uss/ion/bnr/EgovBannerRegist";
	}
	
	/**
	* 기 등록된 배너정보를 삭제한다.
	* 
	* @param banner
	*        Banner
	* @return String
	* @exception Exception
	*/
	@RequestMapping(value = "/mng/uss/ion/bnr/removeBanner.do")
	public String deleteBanner(Banner banner, @ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		banner.setLastUpdusrId(user.getId());
		egovBannerService.deleteBanner(banner);
		return "forward:/mng/uss/ion/bnr/selectBannerList.do";
	}
	
	/**
	* 시간을 LIST를 반환한다.
	* 
	* @return List
	* @throws
	*/
	private List<ComDefaultCodeVO> getTimeHH() {
		ArrayList<ComDefaultCodeVO> listHH = new ArrayList<ComDefaultCodeVO>();
		for(int i = 0; i <= 24; i++) {
			String sHH = "";
			String strI = String.valueOf(i);
			if(i < 10) {
				sHH = "0" + strI;
			} else {
				sHH = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sHH);
			codeVO.setCodeNm(sHH);

			listHH.add(codeVO);
		}

		return listHH;
	}

	/**
	* 분을 LIST를 반환한다.
	* 
	* @return List
	* @throws
	*/
	private List<ComDefaultCodeVO> getTimeMM() {
		ArrayList<ComDefaultCodeVO> listMM = new ArrayList<ComDefaultCodeVO>();
		for(int i = 0; i <= 60; i++) {

			String sMM = "";
			String strI = String.valueOf(i);
			if(i < 10) {
				sMM = "0" + strI;
			} else {
				sMM = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sMM);
			codeVO.setCodeNm(sMM);

			listMM.add(codeVO);
		}
		return listMM;
	}

	/**
	* 0을 붙여 반환
	* 
	* @return String
	* @throws
	*/
	public String DateTypeIntForString(int iInput) {
		String sOutput = "";
		if(Integer.toString(iInput).length() == 1) {
			sOutput = "0" + Integer.toString(iInput);
		} else {
			sOutput = Integer.toString(iInput);
		}

		return sOutput;
	}
}
