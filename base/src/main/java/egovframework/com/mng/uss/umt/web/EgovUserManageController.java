package egovframework.com.mng.uss.umt.web;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import egovframework.rte.fdl.property.EgovPropertyService;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


import egovframework.com.cmm.EgovMessageSource;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class EgovUserManageController {
	
	/** EgovMessageSource */
	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	/** EgovUserManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;
    
    /** EgovPropertyService */
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** DefaultBeanValidator */
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    /** EgovFileMngUtil */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	
    
    /**
     * 사용자목록을 조회한다.
     * @param model 화면모델
     * @return mng/usr/EgovMemberList
     * @throws Exception
     */
	@RequestMapping(value = "/mng/usr/EgovMberManage.do")
	  public String selectEgovMberManage(
			  @ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			userManageVO.setSiteId(loginVO.getSiteId());
		}
		
		userManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
		userManageVO.setPageSize(propertiesService.getInt("pageSize"));
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(userManageVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(userManageVO.getPageUnit());
        paginationInfo.setPageSize(userManageVO.getPageSize());
        
        userManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        userManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        userManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        model.addAttribute("resultList", userManageService.selectUserList(userManageVO));
        
        int totCnt = userManageService.selectUserListTotCnt(userManageVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
		return "mng/usr/EgovMemberList";
	}
	
	
	/**
	 * 사용자 등록화면으로 이동한다.
	 * @param userManageVO
	 * @param request
	 * @param model
	 * @return "/mng/usr/EgovMberAddView.do"
	 * @throws Exception
	 */
	
	 @RequestMapping(value = "/mng/usr/EgovMberAddView.do")
	public String EgovMberAddView(
			@ModelAttribute("searchVO") UserDefaultVO searchVO,
    		UserManageVO userManageVO, HttpServletRequest request, ModelMap model) throws Exception{
			 
		 return "mng/usr/EgovMemberIndt";
	}


	/**
     * 사용자 정보를 DB에 입력한다.
     * @param model 화면모델
     * @return forward:/mng/usr/EgovUserSelectIndt.do
     * @throws Exception
     */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mng/usr/EgovUserSelectIndt.do")
    public String EgovUserSelectIndt(
    		final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, 
    		BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response)throws Exception {
			
			//SiteID를 세종특별시평생교육연구원 SiteId로 입력
		    userManageVO.setSiteId("SITE_000000000000001");
			
		    String zip = egovframework.com.utl.fcc.service.EgovStringUtil.removeMinusChar(userManageVO.getZip());
            userManageVO.setZip(zip);
			userManageService.insertUser(userManageVO);

	      return "forward:/mng/usr/EgovMberManage.do";
    }
	 
	 
	
    /**
	 * 사용자목록을 엑셀로 다운받는다.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
	@RequestMapping(value="/mng/usr/EgovMberManageExcel.do")
    public String EgovMberManageExcel(@ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model) throws Exception {

        int totCnt = userManageService.selectUserListTotCnt(userManageVO);
        
        userManageVO.setFirstIndex(0);
        userManageVO.setRecordCountPerPage(totCnt);
    	
    	model.addAttribute("resultList", userManageService.selectUserList(userManageVO));

    	return "mng/usr/EgovMemberListExcel";
    }
	
	/**
     * 사용자정보 수정 화면으로 이동한다.
     * @param model 화면모델
     * @return mng/usr/EgovMemberUpdt
     * @throws Exception
     */
	@RequestMapping(value = "/mng/usr/EgovUserSelectUpdtView.do")
    public String EgovUserSelectUpdtView(
    		@ModelAttribute("searchVO") UserDefaultVO searchVO,
    		UserManageVO userManageVO, HttpServletRequest request, ModelMap model) throws Exception {
    	
    	model.addAttribute("userManageVO", userManageService.selectUser(userManageVO.getUserId()));
    	
    	model.addAttribute("MembersFileStoreWebPath", propertiesService.getString("Members.fileStoreWebPath"));
    	
      return "mng/usr/EgovMemberUpdt";
    }
	
	
	/**
     * 사용자정보 수정 처리 한다.
     * @param model 화면모델
     * @return forward:/mng/usr/EgovUserSelectUpdtView.do
     * @throws Exception
     */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mng/usr/EgovUserSelectUpdt.do")
    public String EgovUserSelectUpdt(
    		final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("searchVO") UserDefaultVO searchVO, 
    		UserManageVO userManageVO, 
    		BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response)throws Exception {
  	  
		// 아이디 체크
		
		
		beanValidator.validate(userManageVO, bindingResult);
    	if (bindingResult.hasErrors()){
    		
        	return "mng/usr/EgovMemberUpdt";
        	
  		}
  		

    	List<FileVO> result = null;
        
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
        if(!files.isEmpty()) {
          result = fileUtil.directParseFileInf(files, "MEM_", 0, "Members.fileStorePath", "");
          if(result != null) {
  	    	for(int index=0; index < result.size(); index++) {
  	    		FileVO file = result.get(index);
  	    		if(file.getFormNm().startsWith("user")) {
  	    			userManageVO.setPhotoOriginalFileNm(file.getOrignlFileNm());
  	    			userManageVO.setPhotoStreFileNm(file.getStreFileNm());
  	    		}
  	    	}
      	  }
        }        
        
        if(!EgovStringUtil.isEmpty(userManageVO.getTel1()) && !EgovStringUtil.isEmpty(userManageVO.getTel2()) && !EgovStringUtil.isEmpty(userManageVO.getTel3())) {
        	userManageVO.setTlphonNo(userManageVO.getTel1() + "-" + userManageVO.getTel2() + "-" + userManageVO.getTel3());
        }
        if(!EgovStringUtil.isEmpty(userManageVO.getPhone1()) && !EgovStringUtil.isEmpty(userManageVO.getPhone2()) && !EgovStringUtil.isEmpty(userManageVO.getPhone3())) {
        	userManageVO.setMoblphonNo(userManageVO.getPhone1() + "-" + userManageVO.getPhone2() + "-" + userManageVO.getPhone3());
        }
        if(!EgovStringUtil.isEmpty(userManageVO.getEmail1()) && !EgovStringUtil.isEmpty(userManageVO.getEmail2())) {
        	userManageVO.setEmailAdres(userManageVO.getEmail1() + "@" + userManageVO.getEmail2());
        }
        
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);

        userManageVO.setLastUpdusrId(user.getId());
        
        userManageVO.setLastUpdusrId(user.getId());
        //userManageVO.setBrthdy(userManageVO.getBrthdy1()+userManageVO.getBrthdy2()+userManageVO.getBrthdy3());
        String zip = egovframework.com.utl.fcc.service.EgovStringUtil.removeMinusChar(userManageVO.getZip());
        userManageVO.setZip(zip);
        
		userManageService.updateManageUser(userManageVO);
		//model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
    	

      return "forward:/mng/usr/EgovMberManage.do";
    }
	
	
	/**
	 * 관리자가 패스워드를 임의로 재발급하고 핸드폰으로 전송 한다.
	 * @param userManageVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return "forward:/mng/usr/SendPassword.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SendPassword.do")
	public String SendPassword(
			@ModelAttribute("searchVO") UserManageVO userManageVO, final HttpServletRequest request, Model model) throws Exception {

		model.addAttribute("target", "searchPasswordBySms");	//SMS모드로 전송한다.

		// 1. 비밀번호 찾기
    	Map<String, Object> resultList = userManageService.updateSendPassword(userManageVO);
    	boolean result = (Boolean)resultList.get("sendResult");
    	
    	// 2. 결과 리턴
        if (result) {
    		model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
        } else {
        	model.addAttribute("message", egovMessageSource.getMessage("fail.request.msg"));
        }
        
        return "mng/usr/SendPassword";
	}
	
	/**
	 * 선택한 사용자 목록을 접속금지/해제 처리 한다.
	 * @param userManageVO
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/mng/usr/EgovMberManageConfrm.do")
	public String mberManageConfrm(@ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model) throws Exception {
		
    	if("N".equals(userManageVO.getConfmAt())) {
    		userManageService.updateUserRhibt(userManageVO);
    	} else if("Y".equals(userManageVO.getConfmAt())) {
    		userManageService.updateUserRelis(userManageVO);
    	}

		//model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
		return "forward:/mng/usr/EgovMberManage.do";
	}
	
	/**
	 * 선택한 사용자 목록을 접속금지/해제 처리 한다.
	 * @param userManageVO
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/mng/usr/EgovMberManageDelete.do")
	public String mberManageDelete(@ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		userManageVO.setLastUpdusrId(user.getId());
		userManageService.deleteUser(userManageVO);

		//model.addAttribute("message", egovMessageSource.getMessage("success.common.process"));
		return "forward:/mng/usr/EgovMberManage.do";
	}
	
	/**
	 * 사용자 엑셀파일을 일괄 업로드한다.
	 * @param userManageVO
	 * @param request
	 * @param model
	 * @return "mng/usr/EgovMberExcelUpload"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/EgovMberExcelUploadView.do")
	public String EgovMberExcelUploadView(@ModelAttribute("searchVO") UserManageVO userManageVO, Model model) throws Exception {
		return "mng/usr/EgovMberExcelUpload";
	}
	/**
	 * 사용자 엑셀파일을 일괄 업로드한다.
	 * @param userManageVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return "mng/usr/EgovMberExcelUpload"
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mng/usr/EgovMberExcelUpload.do")
	public String EgovMberExcelUpload(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") UserManageVO userManageVO, Model model) throws Exception {

		Map<String, Object> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
		
			file = entry.getValue();

			if (!"".equals(file.getOriginalFilename())) {
				int index = file.getOriginalFilename().lastIndexOf(".");
				String fileExt = "";
			    if(index != -1) {
			    	fileExt = file.getOriginalFilename().substring(index + 1).toUpperCase();
			    }
				resultList = userManageService.insertUserExcelUpload(userManageVO, fileExt, file.getInputStream());
				model.addAttribute("message", resultList.get("message"));
				if(resultList.containsKey("dataList")) {
					model.addAttribute("dataList", resultList.get("dataList"));
				}
			}
		}
		
        return "mng/usr/EgovMberExcelUpload";
	}
}
