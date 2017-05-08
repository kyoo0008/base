package egovframework.com.uss.ivp.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.string.EgovStringUtil;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.ivp.service.EgovIndvdlestbsService;
import egovframework.com.uss.ivp.service.IndvdlestbsVO;

@Controller
public class EgovIndvdlestbsController {
    
    @Resource(name = "IndvdlestbsService")
    private EgovIndvdlestbsService indvdlestbsService;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
    /**
	 * 메뉴 목록을 조회한다. 
	 * @param searchVO - 조회할 정보가 담긴 IndvdlestbsVO
	 * @return "uss/ivp/IndvdlestbsList"
	 * @exception Exception
	 */
    @RequestMapping(value="/uss/ivp/selectMymenuList.do")
    public String selectComtnindvdlestbsList(@ModelAttribute("searchVO") IndvdlestbsVO searchVO, 
    		HttpServletRequest request, HttpServletResponse response,
    		ModelMap model)
            throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user != null) {
    		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    		if(siteVO != null) {
				searchVO.setUserId(user.getId());
				searchVO.setSiteId(siteVO.getSiteId());
				model.addAttribute("myMpmList", indvdlestbsService.selectMyMenuList(searchVO));
    		}
    	}
		
        return "uss/ivp/ComtnindvdlestbsList";
    } 
        
    @RequestMapping("/uss/ivp/insertMyMenu.do")
    public String addMenu(@ModelAttribute("searchVO") IndvdlestbsVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
            throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user != null && !EgovStringUtil.isEmpty(searchVO.getTrgetId())) {
    		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    		if(siteVO != null) {
    			searchVO.setUserId(user.getId()); 
    			searchVO.setSiteId(siteVO.getSiteId());
    			searchVO.setTrgetTyCode("MNU");
    			searchVO.setFrstRegisterId(user.getId());
			    indvdlestbsService.insertIndvdlestbs(searchVO);
    		}
    	}
    	
    	return "forward:/uss/ivp/selectMymenuList.do";
    }
        
    @RequestMapping("/uss/ivp/deleteMyMenu.do")
    public String deleteMenu(@ModelAttribute("searchVO") IndvdlestbsVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
            throws Exception {
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user != null && !EgovStringUtil.isEmpty(searchVO.getTrgetId())) {
    		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    		if(siteVO != null) {
    			searchVO.setUserId(user.getId()); 
    			searchVO.setSiteId(siteVO.getSiteId());
    			searchVO.setTrgetTyCode("MNU");
			    indvdlestbsService.deleteIndvdlestbs(searchVO);
    		}
    	}
    	
    	return "forward:/uss/ivp/selectMymenuList.do";
    }
    
}
