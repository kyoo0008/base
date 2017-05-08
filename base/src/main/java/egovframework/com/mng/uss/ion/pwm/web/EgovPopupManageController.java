package egovframework.com.mng.uss.ion.pwm.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller("MngEgovPopupManageController")
public class EgovPopupManageController {
    protected Log log = LogFactory.getLog(this.getClass());

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "SiteManageService")
	EgovSiteManageService 				  siteManageService;
    
    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovPopupManageService */
    @Resource(name = "egovPopupManageService")
    private EgovPopupManageService egovPopupManageService;
    
    /**
     * 팝업창 목록을 조회한다.
     * @param popupManageVO
     * @param model
     * @return "/mng/uss/ion/pwm/listPopupManage"
     * @throws Exception
     */
    @RequestMapping(value = "/mng/uss/ion/pwm/listPopup.do")
    public String EgovPopupManageList(
            @ModelAttribute("searchVO") PopupManageVO popupManageVO, 
            ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	/*
    	List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();
		  
		if(EgovStringUtil.isEmpty(popupManageVO.getSiteId())) {
			if(siteList != null && siteList.size() > 0) {
				popupManageVO.setSiteId(siteList.get(0).getSiteId());
			}
		}
		model.addAttribute("siteList", siteList);
		*/
    	
    	LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			popupManageVO.setSiteId(loginVO.getSiteId());
		}
		    
        popupManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
        popupManageVO.setPageSize(propertiesService.getInt("pageSize"));

        /** pageing */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(popupManageVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(popupManageVO.getPageUnit());
        paginationInfo.setPageSize(popupManageVO.getPageSize());

        popupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        popupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        popupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        if(!EgovStringUtil.isEmpty(popupManageVO.getSiteId())) {
	        model.addAttribute("resultList", egovPopupManageService.selectPopupList(popupManageVO));
	        
	        int totCnt = (Integer) egovPopupManageService.selectPopupListCount(popupManageVO);
	        paginationInfo.setTotalRecordCount(totCnt);
        }
        model.addAttribute("paginationInfo", paginationInfo);
		
        return "/mng/uss/ion/pwm/EgovPopupList";
    }
    
    
    /**
     * 팝업창을 수정한다.
     * @param searchVO
     * @param popupManageVO
     * @param bindingResult
     * @param model
     * @return 
     *         "/mng/uss/ion/pwm/updtPopupManage"
     * @throws Exception
     */
    @RequestMapping(value = "/mng/uss/ion/pwm/updtPopup.do")
    public String EgovPopupManageUpdt(
            Map commandMap,
            @ModelAttribute("searchVO") PopupManageVO popupManageVO,
            BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 0. Spring Security 사용자권한 처리

        // 로그인 객체 선언
        LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);

        String sLocationUrl = "/mng/uss/ion/pwm/EgovPopupRegist";

        String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

        //팝업창시작일자(시)
        model.addAttribute("ntceBgndeHH", getTimeHH());
        //팝업창시작일자(분)
        model.addAttribute("ntceBgndeMM", getTimeMM());
        //팝업창종료일자(시)
        model.addAttribute("ntceEnddeHH", getTimeHH());
        //팝업창정료일자(분)
        model.addAttribute("ntceEnddeMM", getTimeMM());
        
        if (sCmd.equals("save")) {
        	
        	if(request.getSession().getAttribute("sessionVO") == null) {
        		return "forward:/mng/uss/ion/pwm/listPopup.do";
        	}
        	
            //서버  validate 체크
            beanValidator.validate(popupManageVO, bindingResult);
            if(bindingResult.hasErrors()){
                return sLocationUrl;
            }
            //아이디 설정
            popupManageVO.setLastUpdusrId(loginVO.getId());
            //저장
            egovPopupManageService.updatePopup(popupManageVO);
            
            request.getSession().removeAttribute("sessionVO");
            
            sLocationUrl = "forward:/mng/uss/ion/pwm/listPopup.do";
        } else {
            
            PopupManageVO popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);
            
            String sNtceBgnde = popupManageVOs.getNtceBgnde();
            String sNtceEndde = popupManageVOs.getNtceEndde();
            
            popupManageVOs.setNtceBgndeHH(sNtceBgnde.substring(8, 10));
            popupManageVOs.setNtceBgndeMM(sNtceBgnde.substring(10, 12));
            
            popupManageVOs.setNtceEnddeHH(sNtceEndde.substring(8, 10));
            popupManageVOs.setNtceEnddeMM(sNtceEndde.substring(10, 12));
            
            model.addAttribute("popupManageVO", popupManageVOs);
            
            request.getSession().setAttribute("sessionVO", popupManageVO);
        }

        return sLocationUrl;
    }

    /**
     * 팝업창을 등록한다.
     * @param searchVO
     * @param popupManageVO
     * @param bindingResult
     * @param model
     * @return 
     *         "/mng/uss/ion/pwm/registPopupManage"
     * @throws Exception
     */
    @RequestMapping(value = "/mng/uss/ion/pwm/registPopup.do")
    public String EgovPopupManageRegist(
            Map commandMap,
            @ModelAttribute("searchVO") PopupManageVO popupManageVO,
            BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 로그인 객체 선언
        LoginVO loginVO =  EgovUserDetailsHelper.getAuthenticatedUser(request, response);

        String sLocationUrl = "/mng/uss/ion/pwm/EgovPopupRegist";

        String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");
        
        //팝업창시작일자(시)
        model.addAttribute("ntceBgndeHH", getTimeHH());
        //팝업창시작일자(분)
        model.addAttribute("ntceBgndeMM", getTimeMM());
        //팝업창종료일자(시)
        model.addAttribute("ntceEnddeHH", getTimeHH());
        //팝업창정료일자(분)
        model.addAttribute("ntceEnddeMM", getTimeMM());

        if (sCmd.equals("save")) {
        	
        	if(request.getSession().getAttribute("sessionVO") == null) {
        		return "forward:/mng/uss/ion/pwm/listPopup.do";
        	}
        	
            //서버  validate 체크
            beanValidator.validate(popupManageVO, bindingResult);
            if(bindingResult.hasErrors()){
                return sLocationUrl;
            } 
            //아이디 설정
            popupManageVO.setFrstRegisterId((String)loginVO.getId());
            //저장
            egovPopupManageService.insertPopup(popupManageVO);
            
            request.getSession().removeAttribute("sessionVO");
            
            sLocationUrl = "forward:/mng/uss/ion/pwm/listPopup.do";
        } else {
        	
        	model.addAttribute("popupManageVO", popupManageVO);
        	
	        request.getSession().setAttribute("sessionVO", popupManageVO);
        }
        
        
        
        return sLocationUrl;
    }
    
    /**
     * 팝업창을 삭제한다.
     * @param popupManageVO
     * @param commandMap
     * @param model
     * @return 
     *         "/mng/uss/ion/pwm/detailPopupManage"
     * @throws Exception
     */
    @RequestMapping(value = "/mng/uss/ion/pwm/deletePopup.do")
    public String deletePopup(@ModelAttribute("searchVO") PopupManageVO popupManageVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	LoginVO loginVO =  EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	popupManageVO.setLastUpdusrId(loginVO.getId());
        egovPopupManageService.deletePopup(popupManageVO);

        return "forward:/mng/uss/ion/pwm/listPopup.do";
    }
    
    /**
     * 시간을 LIST를 반환한다.
     * @return  List
     * @throws 
     */
    private List<ComDefaultCodeVO> getTimeHH (){
	    ArrayList<ComDefaultCodeVO> listHH = new ArrayList<ComDefaultCodeVO>();
	    
	    for(int i=0;i <= 24; i++){
	        String sHH = "";
	        String strI = String.valueOf(i);
	        if(i<10){
	                sHH = "0" + strI;
	        }else{
	                sHH = strI;
	        }
	        
	        ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
	        codeVO.setCode(sHH);
	        codeVO.setCodeNm(sHH);
	        
	        listHH.add(codeVO);
	    }
	    
	    return listHH;
    }
    /**
     * 분을 LIST를 반환한다.
     * @return  List
     * @throws 
     */
    private List<ComDefaultCodeVO> getTimeMM (){
	    ArrayList<ComDefaultCodeVO> listMM = new ArrayList<ComDefaultCodeVO>();
	    for(int i=0;i <= 60; i++){
	            
            String sMM = "";
            String strI = String.valueOf(i);
            if(i<10){
                    sMM = "0" + strI;
            }else{
                    sMM = strI;
            }

            ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
            codeVO.setCode(sMM);
            codeVO.setCodeNm(sMM);
            
            listMM.add(codeVO);
	    }
	    return listMM;
    }
    /**
     * 0을 붙여 반환
     * @return  String
     * @throws 
     */
    public String DateTypeIntForString(int iInput){
        String sOutput = "";
        if(Integer.toString(iInput).length() == 1){
                sOutput = "0" + Integer.toString(iInput);
        }else{
                sOutput = Integer.toString(iInput);
        }
                
       return sOutput;
    }
}
