package egovframework.com.uss.ion.pwm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 개요
 * - 팝업창에 대한 Controller를 정의한다.
 * 
 * 상세내용
 * - 팝업창에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * - 팝업창의 조회기능은 목록조회, 상세조회로, 사용자 화면 보기로 구분된다.
 * @author 이창원
 * @version 1.0
 * @created 05-8-2009 오후 2:19:57
 */
@Controller
public class EgovPopupManageController {

    protected Log log = LogFactory.getLog(this.getClass());

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovPopupManageService */
    @Resource(name = "egovPopupManageService")
    private EgovPopupManageService egovPopupManageService;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
    
    /**
     * 팝업창을 오픈 한다.
     * @param commandMap
     * @param popupManageVO
     * @return 
     * @throws Exception
     */
    @RequestMapping(value = "/uss/ion/pwm/openPopupManage.do")
    public String EgovPopupManagePopupOpen(
    			PopupManageVO popupManageVO,
    			HttpServletRequest request,
                ModelMap model
            ) throws Exception {
        
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
        popupManageVO.setSiteId(siteVO.getSiteId());
        popupManageVO.setSysTyCode(siteVO.getSysTyCode());        
        model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertiesService.getString("Site.fileStorePath"));
	    
    	//상세정보 불러오기
        PopupManageVO popupManageVOs = egovPopupManageService.selectPopupService(popupManageVO);
        if(popupManageVOs == null) {
        	popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);
        }
        model.addAttribute("popupManageVO", popupManageVOs);
 
        return popupManageVOs.getFileUrl();
    }
    
}