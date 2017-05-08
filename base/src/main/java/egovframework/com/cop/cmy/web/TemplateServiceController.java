package egovframework.com.cop.cmy.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.CommunityVO;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovHttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/******************************************************
 * @Class Name : TemplateServiceController.java
 * @Program name : egovframework.com.cop.cmy.web
 * @Descriptopn : 커뮤니티 템플릿
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 1. 25.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 1. 25.        이호영             first generated
*********************************************************/

@Controller("CmyTemplateServiceController")
public class TemplateServiceController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@RequestMapping(value = "/cop/cmy/tmplatHead.do")
	public String cmyTmplatHead(@ModelAttribute("searchVO") CommunityVO cmmntyVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	

		if(!"".equals(cmmntyVO.getTrgetId())) cmmntyVO.setCmmntyId(cmmntyVO.getTrgetId());

		/*
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM201");
    	List<CmmnDetailCode> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
    	model.addAttribute("cmmntySe", listComCode);	//공통카테고리
		 */
		
		if(!"Y".equals(request.getParameter("isMain"))) model.addAttribute("cmmntyMnuList", cmmntyService.selectCommunityMenuList(cmmntyVO));		//메뉴정보
    	if(!"".equals(cmmntyVO.getCmmntyId())) model.addAttribute("cmmntyVO", cmmntyService.selectCommunityInfo(cmmntyVO));				//커뮤니티 정보
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    	model.addAttribute("siteInfo", siteVO);
    	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user != null) {
			CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(siteVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());			
			model.addAttribute("USER_SBSCRB", cmmntyService.selectMyCmmntyList(cmmntyUser));	//사용자 가입목록
			model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
		}
		
		model.addAttribute("CmmntyFileStoreWebPath", propertyService.getString("Cmmnty.fileStoreWebPath"));
		
    	return propertyService.getString("publish.sourc.lyt.fileStoreWebPathByJspFile") 
		+ "cmy/" 
		+ siteVO.getCmySourcId() 
		+ "/sourcHead" 
		+ (EgovHttpUtil.getIsMobile(request) && "Y".equals(siteVO.getMobileUseAt()) ? Globals.PUBLISH_MOBILE_APPEND_FREFIX : "");
	}
	
	@RequestMapping(value = "/cop/cmy/tmplatBottom.do")
	public String cmyTmplatBottom(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model, HttpServletRequest request) throws Exception {	
		if(!"".equals(cmmntyVO.getTrgetId())) cmmntyVO.setCmmntyId(cmmntyVO.getTrgetId());
		
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		model.addAttribute("siteInfo", siteVO);
		model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		
		return propertyService.getString("publish.sourc.lyt.fileStoreWebPathByJspFile") 
		+ "cmy/" 
		+ siteVO.getCmySourcId() 
		+ "/sourcBottom" 
		+ (EgovHttpUtil.getIsMobile(request) && "Y".equals(siteVO.getMobileUseAt()) ? Globals.PUBLISH_MOBILE_APPEND_FREFIX : "");
	}
	
}
