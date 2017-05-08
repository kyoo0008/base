package egovframework.com.mng.sym.ccm.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 


import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;
import egovframework.com.sym.ccm.ccc.service.CmmnClCode;
import egovframework.com.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.com.uat.uia.service.LoginVO;

import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

/******************************************************
 * @Class Name : EgovCcmCmmnClCodeManageController.java
 * @Program name : egovframework.com.mng.sym.ccm.web
 * @Descriptopn : 공통코드 대분류 관리Controller
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 1. 16.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 1. 16.        이호영             first generated
*********************************************************/

@Controller
public class EgovCcmCmmnClCodeManageController {
	/**
	 * @uml.property  name="cmmnClCodeManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "CmmnClCodeManageService")
    private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;
    
    /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
    
	/**
	 * 공통분류코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnClCode
	 * @param model
	 * @return "forward:/mng/sym/ccm/EgovCcmCmmnClCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/EgovCcmCmmnClCodeRemove.do")
	public String deleteCmmnClCode (@ModelAttribute("loginVO") LoginVO loginVO
			, CmmnClCode cmmnClCode
			, ModelMap model
			) throws Exception {
    	 cmmnClCodeManageService.deleteCmmnClCode(cmmnClCode);
        return "forward:/mng/sym/ccm/EgovCcmCmmnClCodeList.do";
	}

	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnClCode
	 * @param bindingResult
	 * @return "/mng/sym/ccm/EgovCcmCmmnClCodeRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/EgovCcmCmmnClCodeRegist.do")
	public String insertCmmnClCode (@ModelAttribute("searchVO") CmmnClCodeVO searchVO, 
			CmmnClCode cmmnClCode,
			BindingResult bindingResult, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {    

    	if (cmmnClCode.getClCode() == null ||cmmnClCode.getClCode().equals("")) {
    		return "mng/sym/ccm/EgovCcmCmmnClCodeRegist";
    	}

        beanValidator.validate(cmmnClCode, bindingResult);
		if (bindingResult.hasErrors()){
    		return "mng/sym/ccm/EgovCcmCmmnClCodeRegist";
		}
    	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);

    	cmmnClCode.setFrstRegisterId(user.getId());
    	cmmnClCodeManageService.insertCmmnClCode(cmmnClCode);
        return "forward:/mng/sym/ccm/EgovCcmCmmnClCodeList.do";
    }

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnClCode
	 * @param model
	 * @return "mng/sym/ccm/EgovCcmCmmnClCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/mng/sym/ccm/EgovCcmCmmnClCodeDetail.do")
 	public String selectCmmnClCodeDetail (@ModelAttribute("loginVO") LoginVO loginVO
 			, CmmnClCode cmmnClCode
 			, ModelMap model
 			) throws Exception {
		CmmnClCode vo = cmmnClCodeManageService.selectCmmnClCodeDetail(cmmnClCode);
		model.addAttribute("result", vo);
		
		return "mng/sym/ccm/EgovCcmCmmnClCodeDetail";
	}

    /**
	 * 공통분류코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/mng/sym/ccm/EgovCcmCmmnClCodeList"
     * @throws Exception
     */
    @RequestMapping(value="/mng/sym/ccm/EgovCcmCmmnClCodeList.do")
	public String selectCmmnClCodeList (@ModelAttribute("searchVO") CmmnClCodeVO searchVO
			, ModelMap model
			) throws Exception {
    	/** EgovPropertyService.sample */
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
		
        List<?> CmmnCodeList = cmmnClCodeManageService.selectCmmnClCodeList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);
        
        int totCnt = cmmnClCodeManageService.selectCmmnClCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mng/sym/ccm/EgovCcmCmmnClCodeList";
	}

	/**
	 * 공통분류코드를 수정한다.
	 * @param cmmnClCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "mng/sym/ccm/EgovCcmCmmnClCodeModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/EgovCcmCmmnClCodeModify.do")
	public String updateCmmnClCode (@ModelAttribute("administCode") CmmnClCode cmmnClCode
			, BindingResult bindingResult
			, ModelMap model
			, HttpServletRequest request, HttpServletResponse response
			) throws Exception {

    	if (cmmnClCode.getClCode().equals("")) {
    		CmmnClCode vo = cmmnClCodeManageService.selectCmmnClCodeDetail(cmmnClCode);
    		model.addAttribute("cmmnClCode", vo);

    		return "mng/sym/ccm/EgovCcmCmmnClCodeModify";
    	} else {
            beanValidator.validate(cmmnClCode, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnClCode vo = cmmnClCodeManageService.selectCmmnClCodeDetail(cmmnClCode);
        		model.addAttribute("cmmnClCode", vo);

        		return "mng/sym/ccm/EgovCcmCmmnClCodeModify";
    		}
    		
    		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    		
    		cmmnClCode.setLastUpdusrId(user.getId());
	    	cmmnClCodeManageService.updateCmmnClCode(cmmnClCode);
	        return "forward:/mng/sym/ccm/EgovCcmCmmnClCodeList.do";
    	}
    }
}