package egovframework.com.mng.sym.ext.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 

import egovframework.com.sym.ext.service.EgovOrgCodeService;
import egovframework.com.sym.ext.service.EgovOrgCodeVO;

@Controller
public class EgovOrgCodeManageController {
	
	@Resource(name = "EgovOrgCodeService")
    private EgovOrgCodeService orgCodeService;
   
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * 코드 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "mng/sym/ext/EgovOrgCodeList"
     * @throws Exception
     */
    @RequestMapping(value="/mng/sym/ext/selectOrgCodeList.do")
	public String selectOrgCodeList(@ModelAttribute("searchVO") EgovOrgCodeVO searchVO
			, ModelMap model
			) throws Exception {
    	
    	model.addAttribute("areaList", orgCodeService.selectOrgAreaList(searchVO));  
    	
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
		
        model.addAttribute("resultList", orgCodeService.selectOrgCodeList(searchVO));        
		paginationInfo.setTotalRecordCount(orgCodeService.selectOrgCodeListTotCnt(searchVO));
		
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mng/sym/ext/EgovOrgCodeList";
	}

}