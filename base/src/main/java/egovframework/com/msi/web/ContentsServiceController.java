package egovframework.com.msi.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.msi.service.ContentsServiceVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import egovframework.com.uss.ion.sit.service.EgovLinkSiteManageService;
import egovframework.com.uss.ion.sit.service.LinkSiteManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.com.evt.service.ComtnschdulinfoService;
import egovframework.com.evt.service.ComtnschdulinfoVO;

/**
 * 컨텐츠 서비스 컨트롤러 클래스
 * 
 * @author 정정욱
 * @since 2011.05.24
 * @version 1.0
 * @see 
 */
@Controller
public class ContentsServiceController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;
		
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "comtnschdulinfoService")
    private ComtnschdulinfoService comtnschdulinfoService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "EgovMpmService")
	private EgovMpmService egovMpmService;
	
	@Resource(name = "egovBannerService")
	EgovBannerService egovBannerService;
	
	@Resource(name = "egovPopupManageService")
	private EgovPopupManageService egovPopupManageService;
	
	@Resource(name = "LinkSiteManageService")
	EgovLinkSiteManageService egovLinkSiteManageService;
			
	@RequestMapping(value = "/msi/ctn/mpmService.do")
	public String mpmService(Map<String, String> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		
		String groupTy = commandMap.get("groupTy");		
		String adminYn = null;
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			adminYn = user.getAdminAt();
		}
			
		model.addAttribute("resultList", this.egovMpmService.getCustomSiteMpmList(siteVO, user, groupTy, adminYn));
		
		model.addAttribute("MenuFileStoreWebPath", propertyService.getString("Menu.fileStoreWebPath"));
		
	    
		return "/msi/web/smart_001/svc/mpmService";
	}
	
	@RequestMapping(value = "/msi/ctn/searchBoardService.do")
	public String searchBoardService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    BoardVO boardVO = new BoardVO();
	    boardVO.setBbsId(ctsVO.getTableId());
	    
	    SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    if(!siteVO.getSiteId().equals(propertyService.getString("baseSiteId"))) {
        	boardVO.setSiteId(siteVO.getSiteId());
        }
        LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			boardVO.setSearchAuth(user.getUserSe());
		}
	    	      
        boardVO.setPageUnit(Integer.parseInt(ctsVO.getItemCount()));
        boardVO.setPageSize(1);
        
        PaginationInfo paginationInfo = new PaginationInfo();
        
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
        
        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
		if("gallery".equals(ctsVO.getViewType())) {
			boardVO.setBbsAttrbCode("BBSA02");
		}
		
		//BoardVO resetVO = null;
        List<BoardVO> list = bbsMngService.selectSearchBoardArticleList(boardVO);
        /*
        for(int i = 0; i < list.size(); i++) {
    		resetVO = list.get(i);
    		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
    	}	
       	*/
        model.addAttribute("resultList", list);
	    
	    return "/msi/svc/searchBoardService";
	  }
	
	@RequestMapping(value = "/msi/ctn/boardService.do")
	public String boardService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request) throws Exception {
	    BoardVO boardVO = new BoardVO();
	    boardVO.setBbsId(ctsVO.getTableId());
	    	      
        boardVO.setPageUnit(Integer.parseInt(ctsVO.getItemCount()));
        boardVO.setPageSize(1);
        
        PaginationInfo paginationInfo = new PaginationInfo();
        
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
        
        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
		if("gallery".equals(ctsVO.getViewType())) {
			boardVO.setBbsAttrbCode("BBSA02");
		}
		
        List<BoardVO> list = bbsMngService.selectBoardArticles(boardVO);
       
        model.addAttribute("resultList", list);
	    
	    return "/msi/svc/boardService";
	  }
	

	@RequestMapping(value = "/msi/ctn/eventService.do")
	public String eventService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, 
			ComtnschdulinfoVO comtnschdulinfoVO,
			Map<String, Object> commandMap, 
			ModelMap model, HttpServletRequest request) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
        
		comtnschdulinfoVO.setPageUnit(Integer.parseInt(ctsVO.getItemCount()));
		comtnschdulinfoVO.setPageSize(1);
        
        paginationInfo.setCurrentPageNo(comtnschdulinfoVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(comtnschdulinfoVO.getPageUnit());
        paginationInfo.setPageSize(comtnschdulinfoVO.getPageSize());
        
        comtnschdulinfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        comtnschdulinfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
        comtnschdulinfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        String menuId = (String)commandMap.get("linkMenuId");

	    if(!(menuId==null || "".equals(menuId))){
	    	comtnschdulinfoVO.setSearchCondition("99");
	    }
	    
	    if("gallery".equals(ctsVO.getViewType())){
	    	//comtnschdulinfoVO.setEventTy("Y");
	    }
        
		List<?> comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfoList_D(comtnschdulinfoVO);

        //이벤트 웹경로.
	    model.addAttribute("EventFileStoreWebPath", propertyService.getString("Event.fileStoreWebPath"));
        model.addAttribute("resultList", comtnschdulinfoList);

		return "/msi/svc/eventService";
	}
	
	
	@RequestMapping(value = "/msi/ctn/bannerService.do")
	public String bannerService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    
	    List<BannerVO> resultList = null;
		BannerVO bannerVO = new BannerVO();
	    bannerVO.setSiteId(siteVO.getSiteId());
	    bannerVO.setSysTyCode(siteVO.getSysTyCode());
	    if("PopupZone".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectPopupZoneServiceList(bannerVO);
	    } else if("BannerZone".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectBannerZoneServiceList(bannerVO);
	    } else if("QuickZone".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectQuickZoneServiceList(bannerVO);
	    } else if("MainBannerType1".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectMainBannerType1ServiceList(bannerVO);
	    } else if("MainBannerType2".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectMainBannerType2ServiceList(bannerVO);
	    } else if("SubBanner".equals(ctsVO.getTableId())) {
	    	resultList = egovBannerService.selectSubBannerServiceList(bannerVO);
	    } 
	    if(resultList != null) {
	    	model.addAttribute("resultList", resultList);
	    }
	    model.addAttribute("BannerFileStoreWebPath", propertyService.getString("Banner.fileStoreWebPath"));
	    
	    return "/msi/svc/bannerService";
	}
	
	@RequestMapping(value = "/msi/ctn/menuService.do")
	public String menuService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request) throws Exception {
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	    
		return "/msi/svc/menuService";
	}
	
	@RequestMapping(value = "/msi/ctn/popupService.do")
	public String popupService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    
		PopupManageVO popupManageVO = new PopupManageVO();
		popupManageVO.setSiteId(siteVO.getSiteId());
		popupManageVO.setSysTyCode(siteVO.getSysTyCode());
	    model.addAttribute("popupList", egovPopupManageService.selectPopupServiceList(popupManageVO));
	    
		return "/msi/svc/popupService";
	}
	
	@RequestMapping(value = "/msi/ctn/linkSiteService.do")
	public String linkSiteService(@ModelAttribute("searchVO") ContentsServiceVO ctsVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    
		LinkSiteManageVO linkSiteVO = new LinkSiteManageVO();
	    linkSiteVO.setSiteId(siteVO.getSiteId());
	    linkSiteVO.setSysTyCode(siteVO.getSysTyCode());
	    model.addAttribute("linkSiteList", egovLinkSiteManageService.selectSiteServiceList(linkSiteVO));
	    
		return "/msi/svc/linkSiteService";
	}
	
}
