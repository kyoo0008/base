package egovframework.com.msi.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.fcc.service.EgovHttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/******************************************************
 * @Class Name : EmtMainTemplateController.java
 * @Program name : egovframework.com.msi.web
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 7. 26.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 7. 26.        이호영             first generated
 * 2012. 9. 01.        문동열             
*********************************************************/

@Controller
public class TemplateServiceController {

	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "EgovMpmService")
	private EgovMpmService egovMpmService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
		
	@RequestMapping(value = "/index.do")
	public String index(MpmVO mnuVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		//메인페이지 여부
		model.addAttribute("isMain", "Y");
		return "msi/cntntsService";
	}
		
	@RequestMapping(value = "/msi/tmplatHead.do")
	public String tmplatUpper(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
		
	    /** EgovPropertyService.SiteList */
		mnuVO.setSiteId(siteVO.getSiteId());
		this.modelMpmDataBinding(siteVO, mnuVO, model, true, true);
	    
		return propertyService.getString("publish.sourc.lyt.fileStoreWebPathByJspFile") 
				+ "sit/" 
				+ siteVO.getLytSourcId() 
				+ "/sourcHead" 
				+ (EgovHttpUtil.getIsMobile(request) && "Y".equals(siteVO.getMobileUseAt()) ? Globals.PUBLISH_MOBILE_APPEND_FREFIX : "");
	}
	
	
	@RequestMapping(value = "/msi/tmplatBottom.do")
	public String tmplatBottom(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    mnuVO.setSiteId(siteVO.getSiteId());
		this.modelMpmDataBinding(siteVO, mnuVO, model, true, false);
		
	    return propertyService.getString("publish.sourc.lyt.fileStoreWebPathByJspFile") 
	    		+ "sit/" 
	    		+ siteVO.getLytSourcId() 
	    		+ "/sourcBottom" 
	    		+ (EgovHttpUtil.getIsMobile(request) && "Y".equals(siteVO.getMobileUseAt()) ? Globals.PUBLISH_MOBILE_APPEND_FREFIX : "");
	}
	
	@RequestMapping(value = "/msi/cntntsService.do")
	public String cntnsService(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
		return "msi/cntntsService";
	}
	

	@RequestMapping(value = "/msi/siteMap.do")
	public String siteMap(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    mnuVO.setSiteId(siteVO.getSiteId());
		List<Mpm> mpmList = egovMpmService.selectMpmServiceList(mnuVO);
		
		model.addAttribute("mnMnuList", mpmList);
	    
		return "msi/siteMap";
	  
	}
	
	@RequestMapping(value = "/msi/indvdlInfoPolicy.do")
	public String indvdlInfoPolicy(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    model.addAttribute("ImportUrl", propertyService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/indvdlInfoPolicy");
	    	    
		return "msi/cntntsService";
	  
	}
	
	@RequestMapping(value = "/msi/useStplat.do")
	public String useStplat(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    model.addAttribute("ImportUrl", propertyService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/useStplat");
	    
	    return "msi/cntntsService";
	  
	}
	
	@RequestMapping(value = "/msi/emailColctPolicy.do")
	public String emailColctPolicy(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    model.addAttribute("ImportUrl", propertyService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/emailColctPolicy");
	    
		return "msi/cntntsService";
	  
	}
	
	@RequestMapping(value = "/msi/cpyrhtSttemntSvc.do")
	public String cpyrhtSttemntSvc(MpmVO mnuVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    model.addAttribute("ImportUrl", propertyService.getString("publish.mnu.fileStoreWebPathByJspFile") + siteVO.getSiteId() + "/cpyrhtSttemntSvc");
	    
		return "msi/cntntsService";
	  
	}
	
	@RequestMapping(value = "/msi/goConsulting.do")
	public String goConsulting(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(user == null) {
			return "redirect:/index.do";
		}else {
			return "redirect:http://211.255.2.193:8080";
		}
	}
		
	private void modelMpmDataBinding(SiteManageVO siteVO, MpmVO mnuVO, ModelMap model, boolean publishBinding, boolean mainContentsBinding) throws Exception {
		List<Mpm> mpmList = egovMpmService.selectMpmServiceList(mnuVO);				
		model.addAttribute("mpmList", mpmList);
		
		Mpm currMpm = egovMpmService.selectMpmCurrent(mpmList, mnuVO);
		
		//미리보기일 경우 
		if("Y".equals(mnuVO.getPreviewYn())) {
			if(currMpm != null) {
				mnuVO.setMenuPathByName(currMpm.getMenuPathByName());
				mnuVO.setMenuPathById(currMpm.getMenuPathById());
				mnuVO.setMenuLevel(currMpm.getMenuLevel());
				mnuVO.setMenuLastNodeAt(currMpm.getMenuLastNodeAt());
			} else {
				Mpm uppperMpm = egovMpmService.selectMpmFind(mpmList, mnuVO.getUpperMenuId());
				if(uppperMpm != null) {
					mnuVO.setMenuPathByName(uppperMpm.getMenuPathByName() + ">" + mnuVO.getMenuNm());
					mnuVO.setMenuPathById(uppperMpm.getMenuPathById() + ">" + mnuVO.getMenuId());
					mnuVO.setMenuLevel(uppperMpm.getMenuLevel() + 1);
					mnuVO.setMenuLastNodeAt("Y");
				}
			}
			currMpm = mnuVO;
		}
		
		if(mainContentsBinding && "Y".equals(mnuVO.getIsMain())) {	    	
	    	if(siteVO.getMainContentsList() != null) {
	    		Mpm progrmMpm = null;
		    	for(int i = 0; i < siteVO.getMainContentsList().size(); i ++) {
		    		progrmMpm = egovMpmService.selectMpmProgram(mpmList, siteVO.getMainContentsList().get(i).getProgrmId());
		    		if(progrmMpm != null) {
		    			siteVO.getMainContentsList().get(i).setMenuId(progrmMpm.getMenuId());
		    		}
		    	}
	    	}
	    	
	    }
		
	    model.addAttribute("currMpm", currMpm);
	    
	    model.addAttribute("currRootMpm", egovMpmService.selectMpmCurrentRoot(mpmList, currMpm));
	    
	    if(publishBinding) {
	    	model.addAttribute("MenuFileStoreWebPath", propertyService.getString("Menu.fileStoreWebPath"));
	    	
		    model.addAttribute("MnuFileStoreWebPathByWebFile", propertyService.getString("publish.mnu.fileStoreWebPathByWebFile"));
		    model.addAttribute("MnuFileStoreWebPathByJspFile", propertyService.getString("publish.mnu.fileStoreWebPathByJspFile"));
		    
		    model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		    model.addAttribute("BbsFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.bbs.fileStoreWebPathByWebFile"));
	    }
	}
	
	@RequestMapping(value = "/msi/cmm/tmplatHead.do")
	public String cmmTmplatHead(UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		//사이트설정정보
		//SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		//model.addAttribute("siteInfo", siteVO);
		SiteManageVO siteVO = null;    	
    	if(EgovStringUtil.isEmpty(userManageVO.getSiteId())) {
        	siteVO = siteManageService.selectSiteServiceInfo(request);
        } else  {
        	siteVO = siteManageService.selectSiteServiceInfoBySiteId(userManageVO.getSiteId());
        }
    	
    	if(siteVO != null) {
    		model.addAttribute("siteInfo", siteVO);
    	}
	    
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
		return "msi/cmm/tmplatHead";
	}
	
	
	@RequestMapping(value = "/msi/cmm/tmplatBottom.do")
	public String cmmTmplatBottom(UserManageVO userManageVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		//사이트설정정보
		//SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    //model.addAttribute("siteInfo", siteVO);
		SiteManageVO siteVO = null;    	
    	if(EgovStringUtil.isEmpty(userManageVO.getSiteId())) {
        	siteVO = siteManageService.selectSiteServiceInfo(request);
        } else  {
        	siteVO = siteManageService.selectSiteServiceInfoBySiteId(userManageVO.getSiteId());
        }
    	
    	if(siteVO != null) {
    		model.addAttribute("siteInfo", siteVO);
    	}
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
		return "msi/cmm/tmplatBottom";
	}
	
	@RequestMapping(value = "/msi/sch/tmplatHead.do")
	public String schTmplatHead(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
		return "msi/sch/tmplatHead";
	}
	
	
	@RequestMapping(value = "/msi/sch/tmplatBottom.do")
	public String schTmplatBottom(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
		return "msi/sch/tmplatBottom";
	}
	
}
