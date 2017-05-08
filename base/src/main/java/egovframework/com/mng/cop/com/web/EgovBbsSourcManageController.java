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
import egovframework.com.cop.com.service.EgovBbsSourcHistoryService;
import egovframework.com.cop.com.service.EgovBbsSourcService;
import egovframework.com.cop.com.service.BbsSourcVO;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovBbsSourcManageController
 * @Description : EgovBbsSourcManageController Controller class
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
public class EgovBbsSourcManageController {

    @Resource(name = "EgovBbsSourcService")
    private EgovBbsSourcService bbsSourcService;
    
    @Resource(name = "EgovBbsSourcHistoryService")
    private EgovBbsSourcHistoryService bbsSourcHistoryService;
    
    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
	
    @RequestMapping(value="/mng/cop/com/selectBbsSourcList.do")
    public String selectBbsSourcList(@ModelAttribute("searchVO") BbsSourcVO searchVO,	ModelMap model) throws Exception {
    	
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
		
        List<BbsSourc> comtnbbssourcList = bbsSourcService.selectBbsSourcList(searchVO);
        model.addAttribute("resultList", comtnbbssourcList);
        
        int totCnt = bbsSourcService.selectBbsSourcListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM918");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
	    
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovBbsSourcList";
    } 
    
    @RequestMapping("/mng/cop/com/addBbsSourc.do")
    public String addBbsSourc(@ModelAttribute("searchVO") BbsSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	model.addAttribute("bbsSourcVO", new BbsSourc());
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM918");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovBbsSourcRegister";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/insertBbsSourc.do")
    public String insertBbsSourc(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BbsSourcVO searchVO, BbsSourc bbsSourc, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectBbsSourcList.do";
    	}
    	
    	beanValidator.validate(bbsSourc, bindingResult);
    	
		if (bindingResult.hasErrors()) {	
			
			ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM918");	    
		    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
			
		    return "/mng/cop/com/EgovBbsSourcRegister";
		}
		
		List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.sourc.bbs.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			bbsSourc.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		bbsSourc.setFrstRegisterId(user.getId());
		
    	bbsSourcService.insertBbsSourc(bbsSourc);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectBbsSourcList.do";
    }
    
    @RequestMapping("/mng/cop/com/selectBbsSourc.do")
    public String selectBbsSourc(@ModelAttribute("searchVO") BbsSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	model.addAttribute("bbsSourcVO",  bbsSourcService.selectBbsSourc(searchVO));
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM918");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
	    
    	model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovBbsSourcRegister";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("//mng/cop/com/updateBbsSourc.do")
    public String updateBbsSourc(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BbsSourcVO searchVO, BbsSourc bbsSourc, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectBbsSourcList.do";
    	}
    	
    	beanValidator.validate(bbsSourc, bindingResult);
    	
		if (bindingResult.hasErrors()) {	
			
			ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
		    vo.setCodeId("COM918");	    
		    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
			
			model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
			
		    return "/mng/cop/com/EgovBbsSourcRegister";
		}
		
		List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.sourc.bbs.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			bbsSourc.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		bbsSourc.setLastUpdusrId(user.getId());
		
    	bbsSourcService.updateBbsSourc(bbsSourc);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectBbsSourcList.do";
    }
    
    @RequestMapping("/mng/cop/com/deleteBbsSourc.do")
    public String deleteBbsSourc(@ModelAttribute("searchVO") BbsSourcVO searchVO, BbsSourc bbsSourc, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	bbsSourc.setLastUpdusrId(user.getId());
    	
    	bbsSourcService.deleteBbsSourc(bbsSourc);
        
    	return "forward:/mng/cop/com/selectBbsSourcList.do";
    }
    
    @RequestMapping(value="/mng/cop/com/selectBbsSourcHistoryList.do")
    public String selectBbsSourcHistoryList(@ModelAttribute("searchVO") BbsSourcVO searchVO, 
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
		
        List<BbsSourc> comtnlytsourcList = bbsSourcHistoryService.selectBbsSourcHistoryList(searchVO);
        model.addAttribute("resultList", comtnlytsourcList);
        
        int totCnt = bbsSourcHistoryService.selectBbsSourcHistoryListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mng/cop/com/EgovBbsSourcHistoryList";
    } 
    
    @RequestMapping("/mng/cop/com/selectBbsSourcHistory.do")
    public String selectBbsSourcHistory(@ModelAttribute("searchVO") BbsSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        	    
        model.addAttribute("bbsSourcVO", bbsSourcHistoryService.selectBbsSourcHistory(searchVO));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.bbs.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovBbsSourcHistoryView";
    }
    
    @RequestMapping("/mng/cop/com/updateBbsSourcRollBack.do")
    public String updateBbsSourcRollBack(@ModelAttribute("searchVO") BbsSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	BbsSourc his = bbsSourcHistoryService.selectBbsSourcHistory(searchVO);
    	if(his != null) {
    		bbsSourcService.updateBbsSourc(his);
    		model.addAttribute("rollbackComplete", "Y");
    	}
        
    	return "forward:/mng/cop/com/selectBbsSourcHistoryList.do";
    }

    @RequestMapping("/mng/cop/com/selectBbsOriginSource.do")
    public void selectBbsOriginSource(@ModelAttribute("searchVO") BbsSourcVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	JSONObject jObj = new JSONObject();
        
        jObj.put("listSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.bbs.ori.fileStorePathByJspFile") + "/EgovNoticeList.jsp"));
        jObj.put("viewSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.bbs.ori.fileStorePathByJspFile") + "/EgovNoticeInqire.jsp"));
        jObj.put("formSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.bbs.ori.fileStorePathByJspFile") + "/EgovNoticeRegist.jsp"));
        jObj.put("cmSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.bbs.ori.fileStorePathByJspFile") + "/EgovCommentList.jsp"));
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }
    
    @RequestMapping("/mng/cop/com/selectBbsCopySource.do")
    public void selectBbsCopySource(@ModelAttribute("searchVO") BbsSourcVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	BbsSourc vo = bbsSourcService.selectBbsSourc(searchVO);
    	
    	JSONObject jObj = new JSONObject();
    	
    	jObj.put("listSourc", vo.getListSourc());
    	jObj.put("viewSourc", vo.getViewSourc());    	
        jObj.put("formSourc", vo.getFormSourc());
        jObj.put("cmSourc", vo.getCmSourc());
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }
}
