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
import egovframework.com.cop.com.service.EgovLytSourcHistoryService;
import egovframework.com.cop.com.service.EgovLytSourcService;
import egovframework.com.cop.com.service.LytSourcVO;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovLytSourcManageController
 * @Description : EgovLytSourcManageController Controller class
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
public class EgovLytSourcManageController {

    @Resource(name = "EgovLytSourcService")
    private EgovLytSourcService lytSourcService;
    
    @Resource(name = "EgovLytSourcHistoryService")
    private EgovLytSourcHistoryService lytSourcHistoryService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    @RequestMapping(value="/mng/cop/com/selectLytSourcList.do")
    public String selectLytSourcList(@ModelAttribute("searchVO") LytSourcVO searchVO, 
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
		
        List<LytSourc> comtnlytsourcList = lytSourcService.selectLytSourcList(searchVO);
        model.addAttribute("resultList", comtnlytsourcList);
        
        int totCnt = lytSourcService.selectLytSourcListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovLytSourcList";
    } 
    
    @RequestMapping("/mng/cop/com/addLytSourc.do")
    public String addLytSourc(@ModelAttribute("searchVO") LytSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
    		    
        model.addAttribute("lytSourcVO", new LytSourc());
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovLytSourcRegister";
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/insertLytSourc.do")
    public String insertLytSourc(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") LytSourcVO searchVO, LytSourc lytSourc, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectLytSourcList.do";
    	}
    	
    	beanValidator.validate(lytSourc, bindingResult);
    	if (bindingResult.hasErrors()) {

    		ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
    	    vo.setCodeId("COM916");	    
    	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
    	    
		    return "/mng/cop/com/EgovLytSourcRegister";
		}
    	
    	List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.sourc.lyt.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			lytSourc.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytSourc.setFrstRegisterId(user.getId());
    	
    	lytSourcService.insertLytSourc(lytSourc);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectLytSourcList.do";
    }
    
    @RequestMapping("/mng/cop/com/selectLytSourc.do")
    public String selectLytSourc(@ModelAttribute("searchVO") LytSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
        model.addAttribute("lytSourcVO", lytSourcService.selectLytSourc(searchVO));
        
        ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
	    vo.setCodeId("COM916");	    
	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
	    
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
        
        request.getSession().setAttribute("sessionVO", searchVO);
        
        return "/mng/cop/com/EgovLytSourcRegister";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/cop/com/updateLytSourc.do")
    public String updateLytSourc(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") LytSourcVO searchVO, LytSourc lytSourc, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/cop/com/selectLytSourcList.do";
    	}
    	
    	beanValidator.validate(lytSourc, bindingResult);
    	
    	if (bindingResult.hasErrors()) {
		    
    		ComDefaultCodeVO vo = new ComDefaultCodeVO();	    
    	    vo.setCodeId("COM916");	    
    	    model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(vo));
    	    
		    model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
		    
		    return "/mng/cop/com/EgovLytSourcRegister";
		}
    	
    	List<FileVO> result = null;    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
        	result = fileUtil.directParseFileInf(files, "PRE_", 0, "publish.sourc.lyt.fileStorePathByPreFile", null);
        	
        	if(result != null) {
    	    	for(int index=0; index < result.size(); index++) {
    	    		FileVO file = result.get(index);
    	    		if(file.getFormNm().startsWith("image")) {
    	    			lytSourc.setPrevewFileNm(file.getStreFileNm());
    	    		}
    	    	}
        	}
        }
        
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytSourc.setLastUpdusrId(user.getId());
    	
    	lytSourcService.updateLytSourc(lytSourc);
    	
    	request.getSession().removeAttribute("sessionVO");
    	
        return "forward:/mng/cop/com/selectLytSourcList.do";
    }
    
    @RequestMapping("/mng/cop/com/deleteLytSourc.do")
    public String deleteLytSourc(@ModelAttribute("searchVO") LytSourcVO searchVO, LytSourc lytSourc, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	lytSourc.setLastUpdusrId(user.getId());
    	
    	lytSourcService.deleteLytSourc(lytSourc);
    	
        return "forward:/mng/cop/com/selectLytSourcList.do";
    }
    
    
    @RequestMapping(value="/mng/cop/com/selectLytSourcHistoryList.do")
    public String selectLytSourcHistoryList(@ModelAttribute("searchVO") LytSourcVO searchVO, 
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
		
        List<LytSourc> comtnlytsourcList = lytSourcHistoryService.selectLytSourcHistoryList(searchVO);
        model.addAttribute("resultList", comtnlytsourcList);
        
        int totCnt = lytSourcHistoryService.selectLytSourcHistoryListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/mng/cop/com/EgovLytSourcHistoryList";
    } 
    
    @RequestMapping("/mng/cop/com/selectLytSourcHistory.do")
    public String selectLytSourcHistory(@ModelAttribute("searchVO") LytSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        	    
        model.addAttribute("lytSourcVO", lytSourcHistoryService.selectLytSourcHistory(searchVO));
        
        model.addAttribute("fileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
        
        return "/mng/cop/com/EgovLytSourcHistoryView";
    }
    
    @RequestMapping("/mng/cop/com/updateLytSourcRollBack.do")
    public String updateLytSourcRollBack(@ModelAttribute("searchVO") LytSourcVO searchVO, Model model, HttpServletRequest request) throws Exception {
        
    	LytSourc his = lytSourcHistoryService.selectLytSourcHistory(searchVO);
    	if(his != null) {
    		lytSourcService.updateLytSourc(his);
    		
    		model.addAttribute("rollbackComplete", "Y");
    	}
        
    	return "forward:/mng/cop/com/selectLytSourcHistoryList.do";
    }
   
    @RequestMapping("/mng/cop/com/selectLytOriginSource.do")
    public void selectLytOriginSource(@ModelAttribute("searchVO") LytSourcVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	JSONObject jObj = new JSONObject();
        
        jObj.put("upendSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.lyt.ori.fileStorePathByJspFile") + "/" + searchVO.getSourcSeCode() + "/sourcHead.jsp"));
        jObj.put("lptSourc", EgovFormBasedFileUtil.readFile(propertiesService.getString("publish.sourc.lyt.ori.fileStorePathByJspFile") + "/" + searchVO.getSourcSeCode() + "/sourcBottom.jsp"));
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }
    
    @RequestMapping("/mng/cop/com/selectLytCopySource.do")
    public void selectLytCopySource(@ModelAttribute("searchVO") LytSourcVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	LytSourc vo = lytSourcService.selectLytSourc(searchVO);
    	
    	JSONObject jObj = new JSONObject();
    	
        jObj.put("upendSourc", vo.getUpendSourc());
        jObj.put("lptSourc", vo.getLptSourc());
        jObj.put("mobileUpendSourc", vo.getMobileUpendSourc());
        jObj.put("mobileLptSourc", vo.getMobileLptSourc());
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }


}
