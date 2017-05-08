package egovframework.com.cmm.web;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovFileMngController {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "egovFileIdGnrService")
    private EgovIdGnrService fileIdgenService;
    
    Logger log = Logger.getLogger(this.getClass());

    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfs.do")
    public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmm/fms/EgovFileList";
    }
    
    /**
     * 자료요청 완료 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectDtaResFileInfs.do")
    public String selectDtaResFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmm/fms/EgovDtaResFileList";
    }

    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileInfsForUpdate.do")
    public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("param_atchFileId");

	if(!EgovStringUtil.isEmpty(atchFileId)) {
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
	}
	
	model.addAttribute("updateFlag", "Y");
	
	return "cmm/fms/EgovFileList";
    }

    /**
     * 첨부파일에 대한 삭제를 처리한다.
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/deleteFileInfs.do")
    public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl,
	    HttpServletRequest request,
	    HttpServletResponse response,
	    ModelMap model) throws Exception {

	Boolean isAuthenticated = true;//EgovUserDetailsHelper.isAuthenticated(request, response);

	if (isAuthenticated) {
	    fileService.deleteFileInf(fileVO);
	}

	
	if (!EgovStringUtil.isEmpty(returnUrl)) {
	    return "redirect:" + returnUrl;
	} else {
	    return "redirect:/";
	}
   
    }
    
    /**
     * 첨부파일에 대한 삭제를 처리한다.
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/deleteFileInfByAjax.do")
    public void deleteFileInfByJson(@ModelAttribute("searchVO") FileVO fileVO,
	    HttpServletRequest request,
	    HttpServletResponse response,
	    ModelMap model) throws Exception {

    	int iCount = fileService.deleteFileInf(fileVO);
    	
    	JSONObject jObj = new JSONObject();
    	
    	if(iCount != 0) {
    		jObj.put("delCount", iCount);
	    	jObj.put("atchFileId", fileVO.getAtchFileId());
	    	jObj.put("fileSn", fileVO.getFileSn());
    	} else {
    		jObj.put("delCount", "0");
    	}
    	
    	FileVO totalInfoVO = fileService.selectFileDetailTotalInfo(fileVO);
    	jObj.put("totalFileMg", totalInfoVO.getTotalFileMg());
    	jObj.put("totalFileCount", totalInfoVO.getTotalFileCount());
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
  		
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<FileVO> result = fileService.selectImageFileList(fileVO);
	
	model.addAttribute("fileList", result);

	return "cmm/fms/EgovImgFileList";
    }
    
    /**
     * 대용량파일을 Upload 처리한다.
     * 
     * @param fileVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/uploadStreamLongFiles.do")
    public void uploadStreamLongFiles(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String siteId = (String)commandMap.get("siteId");
    	if(EgovStringUtil.isEmpty(siteId)) {
    		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
    		siteId = siteVO.getSiteId();
    	}
    	
    	//String uploadType = (String)commandMap.get("uploadType");
    	String pathKey = (String)commandMap.get("pathKey");
    	String appendPath = (String)commandMap.get("appendPath");
    	String first = (String)commandMap.get("first");
    	String last = (String)commandMap.get("last");
    	
    	String isEdit = (String)commandMap.get("isEdit");
    	String isTempEdit = (String)commandMap.get("isTempEdit");
    	
    	boolean firstChunk = Boolean.parseBoolean(first);
    	boolean lastChunk = Boolean.parseBoolean(last);
    	boolean edit = Boolean.parseBoolean(isEdit);
    	boolean tempEdit = Boolean.parseBoolean(isTempEdit);
    	
    	fileVO.setFileStreCours(propertiesService.getString(pathKey) + File.separator + siteId + File.separator + appendPath);
    	    	
    	FileVO resultVO = fileUtil.uploadStreamLongFiles(request.getInputStream(), fileVO, firstChunk, lastChunk);
    	
    	if(lastChunk) {
    		
    		FileVO dbVO = fileMngService.insertTempFileInf(resultVO);
    		
    		if(edit) {
    			if(tempEdit) {
    				FileVO delVO = fileMngService.selectTempFileInfByAtchFileIdAndFileSn(resultVO);        				
	    			if(delVO != null) {
	    				fileMngService.deleteTempFileInf(delVO);
	    			}
    			} else {
    				fileMngService.deleteFileInf(resultVO);
    			}
			}
    		
    		JSONObject jObj = new JSONObject();     
    		jObj.put("SiteId", siteId);
    		jObj.put("AppendPath", appendPath);
        	jObj.put("AtchFileId", dbVO.getAtchFileId());
        	jObj.put("TmprFileId", dbVO.getTmprFileId());
        	jObj.put("FileName", dbVO.getOrignlFileNm());
        	jObj.put("StreFileNm", dbVO.getStreFileNm() + "." + dbVO.getFileExtsn());
        	jObj.put("FileSn", dbVO.getFileSn());
        	jObj.put("OriginFileSn", resultVO.getFileSn());
        	jObj.put("FileSize", dbVO.getFileMg());
        	jObj.put("IsEdit", isEdit);
        	jObj.put("IsTempEdit", isTempEdit);
        	
        	FileVO totalInfoVO = fileMngService.selectFileDetailTotalInfo(dbVO);
        	jObj.put("TotalFileMg", totalInfoVO.getTotalFileMg());
	    	jObj.put("TotalFileCount", totalInfoVO.getTotalFileCount());
        	
        	response.setContentType("text/javascript; charset=utf-8");
		    PrintWriter printwriter = response.getWriter();
    		printwriter.println(jObj.toString());
    		printwriter.flush();
    		printwriter.close();
		}
    }
        
    /**
     * 대용량파일을 삭제 처리한다.
     * 
     * @param fileVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/deleteStreamLongFileByAjax.do")
    public void deleteStreamLongFileByAjax(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
    	FileVO dbVO = fileMngService.deleteTempFileInf(fileVO);
    	
    	JSONObject jObj = new JSONObject();
    	
    	if(dbVO != null) {
    		jObj.put("delCount", "1");
	    	jObj.put("atchFileId", dbVO.getAtchFileId());
	    	jObj.put("fileSn", dbVO.getFileSn());
	    	
	    	FileVO totalInfoVO = fileService.selectFileDetailTotalInfo(dbVO);
	    	jObj.put("totalFileMg", totalInfoVO.getTotalFileMg());
	    	jObj.put("totalFileCount", totalInfoVO.getTotalFileCount());
    	} else {
    		jObj.put("delCount", "0");
    	}
    	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(jObj.toString());
  	  	printwriter.flush();
  		printwriter.close();
    }
    
    /**
     * 파일ID를 생성환다.
     * 
     * @param fileVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/selectFileIdByAjax.do")
    public void selectFileIdByAjax(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  	
  	  	response.setContentType("text/javascript; charset=utf-8");
  	  	PrintWriter printwriter = response.getWriter();
  	  	printwriter.println(fileIdgenService.getNextStringId());
  	  	printwriter.flush();
  		printwriter.close();
    }
}
