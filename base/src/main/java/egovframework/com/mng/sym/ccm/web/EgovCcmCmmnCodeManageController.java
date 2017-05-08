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

import egovframework.com.uat.uia.service.LoginVO;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import egovframework.com.sym.ccm.cca.service.CmmnCode;
import egovframework.com.sym.ccm.cca.service.CmmnCodeVO;

import egovframework.com.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;
import egovframework.com.sym.ccm.ccc.service.CmmnClCodeVO;

import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

/**
 * 
 * 공통코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovCcmCmmnCodeManageController {

	/**
	 * @uml.property  name="cmmnCodeManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "CmmnCodeManageService")
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;

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
	 * 공통코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "forward:/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/cca/EgovCcmCmmnCodeRemove.do")
	public String deleteCmmnCode (CmmnCode cmmnCode
			, ModelMap model
			) throws Exception {
    	cmmnCodeManageService.deleteCmmnCode(cmmnCode);
        return "forward:/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do";
	}

	/**
	 * 공통코드를 등록한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "mng/sym/ccm/cca/EgovCcmCmmnCodeRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/cca/EgovCcmCmmnCodeRegist.do")
	public String insertCmmnCode (@ModelAttribute("searchVO") CmmnClCodeVO searchVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, HttpServletRequest request, HttpServletResponse response
			, ModelMap model
			) throws Exception {    
    	if   (cmmnCode.getClCode() == null
    		||cmmnCode.getClCode().equals("")) {

    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setSearchCondition("CodeList");
            List<?> CmmnCodeList = cmmnClCodeManageService.selectCmmnClCodeList(searchVO);
            
            cmmnCode.setUseAt("Y");
            model.addAttribute("cmmnClCode", CmmnCodeList);
            
    		return "mng/sym/ccm/cca/EgovCcmCmmnCodeRegist";
    	}

        beanValidator.validate(cmmnCode, bindingResult);
		if (bindingResult.hasErrors()){
    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setSearchCondition("CodeList");
            List<?> CmmnCodeList = cmmnClCodeManageService.selectCmmnClCodeList(searchVO);
            model.addAttribute("cmmnClCode", CmmnCodeList);

            return "mng/sym/ccm/cca/EgovCcmCmmnCodeRegist";
		}

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		
    	cmmnCode.setFrstRegisterId(user.getId());
    	cmmnCodeManageService.insertCmmnCode(cmmnCode);
        return "forward:/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do";
    }

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "cmm/mng/sym/ccm/cca/EgovCcmCmmnCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/mng/sym/ccm/cca/EgovCcmCmmnCodeDetail.do")
 	public String selectCmmnCodeDetail (CmmnCode cmmnCode
 			, ModelMap model
 			) throws Exception {
		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
		model.addAttribute("result", vo);
		
		return "mng/sym/ccm/cca/EgovCcmCmmnCodeDetail";
	}

    /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "mng/sym/ccm/cca/EgovCcmCmmnCodeList"
     * @throws Exception
     */
    @RequestMapping(value="/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do")
	public String selectCmmnCodeList (@ModelAttribute("searchVO") CmmnCodeVO searchVO
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
		
        List<?> CmmnCodeList =cmmnCodeManageService.selectCmmnCodeList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);
        
        int totCnt =cmmnCodeManageService.selectCmmnCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mng/sym/ccm/cca/EgovCcmCmmnCodeList";
	}

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "mng/sym/ccm/cca/EgovCcmCmmnCodeModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/mng/sym/ccm/cca/EgovCcmCmmnCodeModify.do")
	public String updateCmmnCode (@ModelAttribute("searchVO") CmmnCodeVO searchVO
			, CmmnCode cmmnCode
			, BindingResult bindingResult
			, ModelMap model
			, HttpServletRequest request, HttpServletResponse response
			) throws Exception {
    	
    	if (cmmnCode.getCodeId().equals("")) {
    		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
    		model.addAttribute("cmmnCode", vo);

    		return "mng/sym/ccm/cca/EgovCcmCmmnCodeModify";
    	} else {
            beanValidator.validate(cmmnCode, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnCode vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
        		model.addAttribute("cmmnCode", vo);

        		return "mng/sym/ccm/cca/EgovCcmCmmnCodeModify";
    		}
    		
    		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    		
    		cmmnCode.setLastUpdusrId(user.getId());
	    	cmmnCodeManageService.updateCmmnCode(cmmnCode);
	        return "forward:/mng/sym/ccm/cca/EgovCcmCmmnCodeList.do";
    	}
    }
}