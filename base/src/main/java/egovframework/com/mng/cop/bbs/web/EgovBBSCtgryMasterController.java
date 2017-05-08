package egovframework.com.mng.cop.bbs.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.com.cop.bbs.service.CtgryMaster;
import egovframework.com.cop.bbs.service.EgovBBSCtgryMasterService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

// Servoce 객체에 대한 import 구문
// import (service package).egovBBSCtgryMasterService;
// Vo 객체에 대한 import 구문
// import (vo package).CtgryMaster;
// import (vo package).ComtnbbsctgrymasterVO;

/**
 * @Class Name : ComtnbbsctgrymasterController.java
 * @Description : Comtnbbsctgrymaster Controller class
 * @Modification Information
 *
 * @author 이엠티
 * @since 2011.12.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class EgovBBSCtgryMasterController {
	
    @Resource(name = "EgovBBSCtgryMasterService")
    private EgovBBSCtgryMasterService egovBBSCtgryMasterService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COMTNBBSCTGRYMASTER 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 CtgryMaster
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do")
    public String selectBBSCtgryMasterList(@ModelAttribute("searchVO") CtgryMaster searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	/*
    	List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
		  
		if(EgovStringUtil.isEmpty(searchVO.getSiteId())) {
			if(siteList != null && siteList.size() > 0) {
				searchVO.setSiteId(siteList.get(0).getSiteId());
			}
		}
		model.addAttribute("siteList", siteList);
		*/
    	
    	LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			searchVO.setSiteId(loginVO.getSiteId());
		}
		
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(!EgovStringUtil.isEmpty(searchVO.getSiteId())) {
	        model.addAttribute("resultList", egovBBSCtgryMasterService.selectComtnbbsctgrymasterList(searchVO));
	        
	        int totCnt = egovBBSCtgryMasterService.selectComtnbbsctgrymasterListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
		}
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryMasterList";
    } 
    
    @RequestMapping("/mng/cop/bbs/ctg/addBBSCtgryMaster.do")
    public String addComtnbbsctgrymasterView(@ModelAttribute("searchVO") CtgryMaster searchVO, Model model, HttpServletRequest request) throws Exception {
    	
		//model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
		
    	model.addAttribute("ctgryMaster", searchVO);
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryMasterRegist";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/insertBBSCtgryMaster.do")
    public String addComtnbbsctgrymaster(CtgryMaster ctgryMaster, @ModelAttribute("searchVO") CtgryMaster searchVO, HttpServletRequest request) throws Exception {
        
    	if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do";
		}
    	
    	egovBBSCtgryMasterService.insertComtnbbsctgrymaster(ctgryMaster);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/selectBBSCtgryMaster.do")
    public String selectBBSCtgryMaster(@ModelAttribute("searchVO") CtgryMaster searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	//model.addAttribute("siteList", siteManageService.selectSiteSimpleList());
    	
    	model.addAttribute("ctgryMaster", egovBBSCtgryMasterService.selectComtnbbsctgrymaster(searchVO));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryMasterRegist";
    }

    @RequestMapping("/mng/cop/bbs/ctg/updateBBSCtgryMaster.do")
    public String updateComtnbbsctgrymaster(CtgryMaster ctgryMaster, @ModelAttribute("searchVO") CtgryMaster searchVO, HttpServletRequest request) throws Exception {
        
    	if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do";
		}
    	
    	egovBBSCtgryMasterService.updateComtnbbsctgrymaster(ctgryMaster);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/deleteBBSCtgryMaster.do")
    public String deleteComtnbbsctgrymaster(CtgryMaster ctgryMaster, @ModelAttribute("searchVO") CtgryMaster searchVO) throws Exception {
        egovBBSCtgryMasterService.deleteComtnbbsctgrymaster(ctgryMaster);
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryMasterList.do";
    }

}
