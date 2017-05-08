package egovframework.com.mng.cop.bbs.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.Ctgry;
import egovframework.com.cop.bbs.service.EgovBBSCtgryService;
import egovframework.rte.fdl.property.EgovPropertyService;

// Servoce 객체에 대한 import 구문
// import (service package).ComtnbbsctgryService;
// Vo 객체에 대한 import 구문
// import (vo package).ComtnbbsctgryDefaultVO;
// import (vo package).ComtnbbsctgryVO;

/**
 * @Class Name : ComtnbbsctgryController.java
 * @Description : Comtnbbsctgry Controller class
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
public class EgovBBSCtgryController {

    @Resource(name = "EgovBBSCtgryService")
    private EgovBBSCtgryService egovBBSCtgryService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COMTNBBSCTGRY 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ctgry
	 * @return "/mng/cop/bbs/comtnbbsctgry/ComtnbbsctgryList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/cop/bbs/ctg/selectBBSCtgryList.do")
    public String selectBBSCtgryList(@ModelAttribute("searchVO") Ctgry searchVO, ModelMap model) throws Exception {
    	
        model.addAttribute("resultList", egovBBSCtgryService.selectComtnbbsctgryList(searchVO));
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryList";
    } 
    
    @RequestMapping("/mng/cop/bbs/ctg/addBBSCtgry.do")
    public String addBBSCtgryView(@ModelAttribute("searchVO") Ctgry searchVO, Model model, HttpServletRequest request) throws Exception {
    	
    	model.addAttribute("ctgryList", egovBBSCtgryService.selectComtnbbsctgryList(searchVO));
    	
    	model.addAttribute("ctgry", searchVO);
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryRegist";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/insertBBSCtgry.do")
    public String insertBBSCtgry(Ctgry ctgry, @ModelAttribute("searchVO") Ctgry searchVO, HttpServletRequest request) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
		}
    	
    	egovBBSCtgryService.insertComtnbbsctgry(ctgry);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/selectBBSCtgry.do")
    public String updateBBSCtgryView(@ModelAttribute("searchVO") Ctgry searchVO, Model model, HttpServletRequest request) throws Exception {
    	
    	model.addAttribute("ctgryList", egovBBSCtgryService.selectComtnbbsctgryList(searchVO));
    	
    	model.addAttribute("ctgry", egovBBSCtgryService.selectComtnbbsctgry(searchVO));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/bbs/ctg/EgovBBSCtgryRegist";
    }

    @RequestMapping("/mng/cop/bbs/ctg/updateBBSCtgry.do")
    public String updateBBSCtgry(Ctgry ctgry, @ModelAttribute("searchVO") Ctgry searchVO, HttpServletRequest request) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
			return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
		}
    	
    	egovBBSCtgryService.updateComtnbbsctgry(ctgry);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
    }
    
    @RequestMapping("/mng/cop/bbs/ctg/deleteBBSCtgry.do")
    public String deleteBBSCtgry(Ctgry comtnbbsctgryVO, @ModelAttribute("searchVO") Ctgry searchVO) throws Exception {
    	egovBBSCtgryService.deleteComtnbbsctgry(comtnbbsctgryVO);
        return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
    }
    
    /**
     * 카테고리를 이동한다.
     * 
     * @param searchVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/cop/bbs/ctg/updateBBSCtgrySortOrdr.do")
    public String updateBBSCtgrySortOrdr(@ModelAttribute("searchVO") Ctgry searchVO, ModelMap model) throws Exception {
  	  
    	egovBBSCtgryService.updateSortOrdr(searchVO);

    	return "forward:/mng/cop/bbs/ctg/selectBBSCtgryList.do";
    }

}
