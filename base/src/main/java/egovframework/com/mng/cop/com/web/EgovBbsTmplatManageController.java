package egovframework.com.mng.cop.com.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.com.service.EgovBbsTmplatHistoryService;
import egovframework.com.cop.com.service.EgovBbsTmplatService;
import egovframework.com.cop.com.service.BbsTmplatVO;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovBbsTmplatManageController
 * @Description : EgovBbsTmplatManageController Controller class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class EgovBbsTmplatManageController {

    @Resource(name = "EgovBbsTmplatService")
    private EgovBbsTmplatService bbsTmplatService;
    
    @Resource(name = "EgovBbsTmplatHistoryService")
    private EgovBbsTmplatHistoryService bbsTmplatHistoryService;
    
    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
	
    @RequestMapping(value="/mng/cop/com/selectBbsTemplateList.do")
    public String selectBbsTmplatList(@ModelAttribute("searchVO") BbsTmplatVO searchVO,	ModelMap model) throws Exception {
    	
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
		
        List<BbsTmplat> comtnbbstmplatList = bbsTmplatService.selectBbsTmplatList(searchVO);
        model.addAttribute("resultList", comtnbbstmplatList);
        
        int totCnt = bbsTmplatService.selectBbsTmplatListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM919");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
	    
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovBbsTemplateList";
    } 
    
    @RequestMapping("/mng/cop/com/addBbsTemplate.do")
    public String addBbsTmplat(@ModelAttribute("searchVO") BbsTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	model.addAttribute("bbsTmplatVO", new BbsTmplat());
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM919");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovBbsTemplateRegister";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/insertBbsTemplate.do")
    public String insertBbsTmplat(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BbsTmplatVO searchVO, BbsTmplat bbsTmplat, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectBbsTemplateList.do";
    	}
    	
    	beanValidator.validate(bbsTmplat, bindingResult);
    	
		if (bindingResult.hasErrors()) {	
			
			ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM919");	    
		    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
			
		    return "/mng/cop/com/EgovBbsTemplateRegister";
		}
		
		List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.tmplat.bbs.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			bbsTmplat.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		bbsTmplat.setFrstRegisterId(user.getId());
		
    	bbsTmplatService.insertBbsTmplat(bbsTmplat);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectBbsTemplateList.do";
    }
    
    @RequestMapping("/mng/cop/com/selectBbsTemplate.do")
    public String selectBbsTmplat(@ModelAttribute("searchVO") BbsTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	model.addAttribute("bbsTmplatVO",  bbsTmplatService.selectBbsTmplat(searchVO));
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM919");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
    	
    	model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovBbsTemplateRegister";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("//mng/cop/com/updateBbsTemplate.do")
    public String updateBbsTmplat(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BbsTmplatVO searchVO, BbsTmplat bbsTmplat, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectBbsTemplateList.do";
    	}
    	
    	beanValidator.validate(bbsTmplat, bindingResult);
    	
		if (bindingResult.hasErrors()) {	
			
			ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM919");	    
		    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
			
			model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
			
		    return "/mng/cop/com/EgovBbsTemplateRegister";
		}
		
		List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.tmplat.bbs.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			bbsTmplat.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		bbsTmplat.setLastUpdusrId(user.getId());
		
    	bbsTmplatService.updateBbsTmplat(bbsTmplat);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectBbsTemplateList.do";
    }
    
    @RequestMapping("/mng/cop/com/deleteBbsTemplate.do")
    public String deleteBbsTmplat(@ModelAttribute("searchVO") BbsTmplatVO searchVO, BbsTmplat bbsTmplat, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	bbsTmplat.setLastUpdusrId(user.getId());
    	
    	bbsTmplatService.deleteBbsTmplat(bbsTmplat);
        
    	return "forward:/mng/cop/com/selectBbsTemplateList.do";
    }
    
    @RequestMapping(value="/mng/cop/com/selectBbsTemplateHistoryList.do")
    public String selectBbsTemplateHistoryList(@ModelAttribute("searchVO") BbsTmplatVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
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
		
        List<BbsTmplat> comtnlyttmplatList = bbsTmplatHistoryService.selectBbsTmplatHistoryList(searchVO);
        model.addAttribute("resultList", comtnlyttmplatList);
        
        int totCnt = bbsTmplatHistoryService.selectBbsTmplatHistoryListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mng/cop/com/EgovBbsTemplateHistoryList";
    } 
    
    @RequestMapping("/mng/cop/com/selectBbsTemplateHistory.do")
    public String selectBbsTemplateHistory(@ModelAttribute("searchVO") BbsTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        	    
        model.addAttribute("bbsTmplatVO", bbsTmplatHistoryService.selectBbsTmplatHistory(searchVO));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.bbs.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovBbsTemplateHistoryView";
    }
    
    @RequestMapping("/mng/cop/com/updateBbsTemplateRollBack.do")
    public String updateBbsTemplateRollBack(@ModelAttribute("searchVO") BbsTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	BbsTmplat his = bbsTmplatHistoryService.selectBbsTmplatHistory(searchVO);
    	if(his != null) {
    		bbsTmplatService.updateBbsTmplat(his);
    		model.addAttribute("rollbackComplete", "Y");
    	}
        
    	return "forward:/mng/cop/com/selectBbsTemplateHistoryList.do";
    }
    
    @RequestMapping("/mng/cop/com/selectBbsCopyTemplate.do")
    public void selectBbsCopySource(@ModelAttribute("searchVO") BbsTmplatVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	BbsTmplat vo = bbsTmplatService.selectBbsTmplat(searchVO);
    	
    	JSONObject jObj = new JSONObject();
    	
    	jObj.put("cssSourc", vo.getCssSourc());
    	jObj.put("scriptSourc", vo.getScriptSourc());
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }
}
