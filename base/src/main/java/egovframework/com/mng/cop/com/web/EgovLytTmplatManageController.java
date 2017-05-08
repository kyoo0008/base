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
import egovframework.com.cop.com.service.EgovLytTmplatHistoryService;
import egovframework.com.cop.com.service.EgovLytTmplatService;
import egovframework.com.cop.com.service.LytTmplatVO;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovLytTmplatManageController
 * @Description : EgovLytTmplatManageController Controller class
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
public class EgovLytTmplatManageController {

    @Resource(name = "EgovLytTmplatService")
    private EgovLytTmplatService lytTmplatService;
    
    @Resource(name = "EgovLytTmplatHistoryService")
    private EgovLytTmplatHistoryService lytTmplatHistoryService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    @RequestMapping(value="/mng/cop/com/selectLytTemplateList.do")
    public String selectLytTemplateList(@ModelAttribute("searchVO") LytTmplatVO searchVO, 
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
		
        List<LytTmplat> comtnlyttmplatList = lytTmplatService.selectLytTmplatList(searchVO);
        model.addAttribute("resultList", comtnlyttmplatList);
        
        int totCnt = lytTmplatService.selectLytTmplatListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);        
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("lcasList", cmmUseService.selectCmmCodeDetail(vo));
	    
	    vo.setCodeId("COM917");	    
	    model.addAttribute("mlsfcList", cmmUseService.selectCmmCodeDetail(vo));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovLytTemplateList";
    } 
    
    @RequestMapping("/mng/cop/com/addLytTemplate.do")
    public String addLytTemplate(@ModelAttribute("searchVO") LytTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("lcasList", cmmUseService.selectCmmCodeDetail(vo));
	    
	    vo.setCodeId("COM917");	    
	    model.addAttribute("mlsfcList", cmmUseService.selectCmmCodeDetail(vo));
	    
        model.addAttribute("lytTmplatVO", new LytTmplat());
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovLytTemplateRegister";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/insertLytTemplate.do")
    public String insertLytTemplate(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") LytTmplatVO searchVO, LytTmplat lytTmplat, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectLytTemplateList.do";
    	}
    	
    	beanValidator.validate(lytTmplat, bindingResult);
    	if (bindingResult.hasErrors()) {
		    ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM916");	    
		    model.addAttribute("lcasList", cmmUseService.selectCmmCodeDetail(vo));
		    
		    vo.setCodeId("COM917");	    
		    model.addAttribute("mlsfcList", cmmUseService.selectCmmCodeDetail(vo));
		    
		    return "/mng/cop/com/EgovLytTemplateRegister";
		}
    	
    	List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.tmplat.lyt.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			lytTmplat.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytTmplat.setFrstRegisterId(user.getId());
    	
    	lytTmplatService.insertLytTmplat(lytTmplat);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectLytTemplateList.do";
    }
    
    @RequestMapping("/mng/cop/com/selectLytTemplate.do")
    public String selectLytTemplate(@ModelAttribute("searchVO") LytTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("lcasList", cmmUseService.selectCmmCodeDetail(vo));
	    
	    vo.setCodeId("COM917");	    
	    model.addAttribute("mlsfcList", cmmUseService.selectCmmCodeDetail(vo));
	    
        model.addAttribute("lytTmplatVO", lytTmplatService.selectLytTmplat(searchVO));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovLytTemplateRegister";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/updateLytTemplate.do")
    public String updateLytTemplate(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") LytTmplatVO searchVO, LytTmplat lytTmplat, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectLytTemplateList.do";
    	}
    	
    	beanValidator.validate(lytTmplat, bindingResult);
    	
    	if (bindingResult.hasErrors()) {
			ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM916");	    
		    model.addAttribute("lcasList", cmmUseService.selectCmmCodeDetail(vo));
		    
		    vo.setCodeId("COM917");	    
		    model.addAttribute("mlsfcList", cmmUseService.selectCmmCodeDetail(vo));
		    
		    model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
		    
		    return "/mng/cop/com/EgovLytTemplateRegister";
		}
    	
    	List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.tmplat.lyt.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			lytTmplat.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytTmplat.setLastUpdusrId(user.getId());
    	
    	lytTmplatService.updateLytTmplat(lytTmplat);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectLytTemplateList.do";
    }
    
    @RequestMapping("/mng/cop/com/deleteLytTemplate.do")
    public String deleteLytTemplate(@ModelAttribute("searchVO") LytTmplatVO searchVO, LytTmplat lytTmplat, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytTmplat.setLastUpdusrId(user.getId());
    	
    	lytTmplatService.deleteLytTmplat(lytTmplat);
    	
        return "forward:/mng/cop/com/selectLytTemplateList.do";
    }
    
    
    @RequestMapping(value="/mng/cop/com/selectLytTemplateHistoryList.do")
    public String selectLytTemplateHistoryList(@ModelAttribute("searchVO") LytTmplatVO searchVO, 
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
		
        List<LytTmplat> comtnlyttmplatList = lytTmplatHistoryService.selectLytTmplatHistoryList(searchVO);
        model.addAttribute("resultList", comtnlyttmplatList);
        
        int totCnt = lytTmplatHistoryService.selectLytTmplatHistoryListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mng/cop/com/EgovLytTemplateHistoryList";
    } 
    
    @RequestMapping("/mng/cop/com/selectLytTemplateHistory.do")
    public String selectLytTemplateHistory(@ModelAttribute("searchVO") LytTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        	    
        model.addAttribute("lytTmplatVO", lytTmplatHistoryService.selectLytTmplatHistory(searchVO));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovLytTemplateHistoryView";
    }
    
    @RequestMapping("/mng/cop/com/updateLytTemplateRollBack.do")
    public String updateLytTemplateRollBack(@ModelAttribute("searchVO") LytTmplatVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	LytTmplat his = lytTmplatHistoryService.selectLytTmplatHistory(searchVO);
    	if(his != null) {
    		lytTmplatService.updateLytTmplat(his);
    		
    		model.addAttribute("rollbackComplete", "Y");
    	}
        
    	return "forward:/mng/cop/com/selectLytTemplateHistoryList.do";
    }
       
    @RequestMapping("/mng/cop/com/selectLytCopyTemplate.do")
    public void selectLytCopySource(@ModelAttribute("searchVO") LytTmplatVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	LytTmplat vo = lytTmplatService.selectLytTmplat(searchVO);
    	
    	JSONObject jObj = new JSONObject();
    	
    	jObj.put("cssSourc", vo.getCssSourc());
    	jObj.put("scriptSourc", vo.getScriptSourc());
    	jObj.put("mobileCssSourc", vo.getMobileCssSourc());
    	jObj.put("mobileScriptSourc", vo.getMobileScriptSourc());
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }


}
