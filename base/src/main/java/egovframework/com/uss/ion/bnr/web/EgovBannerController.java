package egovframework.com.uss.ion.bnr.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller("EgovBannerController")
public class EgovBannerController {
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	 
	@Resource(name = "egovBannerService")
	private EgovBannerService egovBannerService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	 
	
	/**
	* 배너를 배너목록을 조회한다.
	* 
	* @param bannerVO
	*- 배너 VO
	* @return String - 리턴 URL
	* @throws Exception
	*/
	@RequestMapping(value = "/uss/ion/bnr/selectBannerList.do")
	public String selectBannerList(@ModelAttribute("bannerVO") BannerVO bannerVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		
		bannerVO.setSiteId(siteVO.getSiteId());
		bannerVO.setSysTyCode(siteVO.getSysTyCode());
		
		model.addAttribute("bannerList", egovBannerService.selectBannerZoneServiceList(bannerVO));
	    
		//배너 웹경로.
	    model.addAttribute("BannerFileStoreWebPath", propertyService.getString("Banner.fileStoreWebPath"));
		
		return "/uss/ion/bnr/EgovBannerList";
	}
}
