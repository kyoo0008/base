package egovframework.com.mng.sym.sit.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

// 로그인정보 관련
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.com.service.EgovLytSourcService;
import egovframework.com.cop.com.service.EgovLytTmplatService;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.ext.service.EgovOrgCodeVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteMainContentsManageVO;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;

// Validation 관련
import org.springframework.beans.factory.annotation.Autowired;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

/**
 * 사이트정보를 처리하는 Controller 클래스
 * 
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 * 
 * </pre>
 */
@Controller
public class EgovSiteManageController {
  
	protected Log                 log = LogFactory.getLog(this.getClass());
  
	@Resource(name = "SiteManageService")
	private EgovSiteManageService siteManageService;
  	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovLytTmplatService")
    private EgovLytTmplatService lytTmplatService;
	
	@Resource(name = "EgovLytSourcService")
    private EgovLytSourcService lytSourcService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
  
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	  
	// Validation 관련
	@Autowired
	private DefaultBeanValidator  beanValidator;
  
  
  /**
   * 사이트목록을 조회한다.
   * 
   * @param searchVO
   * @param model
   * @return "/mng/mng/sit/EgovSiteListInqire"
   * @throws Exception
   */
  @RequestMapping(value = "/mng/sym/sit/selectSiteInfoList.do")
  public String selectSiteList(@ModelAttribute("searchVO") SiteManageDefaultVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {	
		if(loginVO.getUserSe().equals("99")) searchVO.setSiteId(null);
		else searchVO.setSiteId(loginVO.getSiteId());
	}
	
    /** EgovPropertyService.SiteList */
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
    
    model.addAttribute("resultList", siteManageService.selectSiteList(searchVO));
    
    int totCnt = siteManageService.selectSiteListTotCnt(searchVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);
    
    return "/mng/sym/sit/EgovSiteListInqire";
  }
  
  /**
   * 사이트정보 등록전 단계
   * 
   * @param searchVO
   * @param model
   * @return "/mng/sym/sit/EgovSiteInfoRegist"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/addSiteInfo.do")
  public String insertSiteInfoView(@ModelAttribute("searchVO") SiteManageDefaultVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM920");		
	  model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  searchVO.setTakeSiteId(siteManageService.selectSiteIdGnr());
	  
	  model.addAttribute("siteManageVO", searchVO);
	  
	  model.addAttribute("tmplatFileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
	  model.addAttribute("sourcFileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
	  
	  request.getSession().setAttribute("sessionVO", searchVO);
    
	  return "/mng/sym/sit/EgovSiteInfoRegist";
    
  }
  
  /**
   * 사이트정보를 등록한다.
   * 
   * @param searchVO
   * @param siteManageVO
   * @param bindingResult
   * @return "forward:/mng/sym/sit/SiteListInqire.do"
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping("/mng/sym/sit/insertSiteInfo.do")
  public String insertSiteInfo(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") SiteManageDefaultVO searchVO, SiteManageVO siteManageVO, SiteMainContentsManageVO mainContentsVO, BindingResult bindingResult, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	if(request.getSession().getAttribute("sessionVO") == null) {
		return "forward:/mng/sym/sit/selectSiteInfoList.do";
	}
	  
    beanValidator.validate(siteManageVO, bindingResult);
    
    if(bindingResult.hasErrors()) {
      
    	ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
  	  	ccvo.setCodeId("COM920");		
  	  	model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(ccvo));
  	  
    	model.addAttribute("tmplatFileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
    	model.addAttribute("sourcFileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
    	
    	return "/mng/sym/sit/EgovSiteInfoRegist";
      
    }
        
    List<FileVO> result = null;    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if(!files.isEmpty()) {
    	result = fileUtil.directParseFileInf(files, "SITE_", 0, "Site.fileStorePath", siteManageVO.getSiteId());
    	
    	if(result != null) {
	    	for(int index=0; index < result.size(); index++) {
	    		FileVO file = result.get(index);
	    		if(file.getFormNm().startsWith("upendLogo")) {
	    			siteManageVO.setUpendLogoFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("lptLogo")) {
	    			siteManageVO.setLptLogoFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("adres")) {
	    			siteManageVO.setAdresFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("peprsntImage")) {
	    			siteManageVO.setPeprsntImageFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("slogan")) {
	    			siteManageVO.setSloganFileNm(file.getStreFileNm());
	    		}
	    	}
    	}
    }
    
    // 로그인VO에서 사용자 정보 가져오기
    LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    String frstRegisterId = loginVO.getId();
    
    siteManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
    
    siteManageService.insertSiteInfo(siteManageVO, mainContentsVO);
    this.batchJobAction(searchVO);
    
    request.getSession().removeAttribute("sessionVO");
    
    return "forward:/mng/sym/sit/selectSiteInfoList.do";
  }
  
  /**
   * 사이트정보 수정 전 처리
   * 
   * @param siteId
   * @param searchVO
   * @param model
   * @return "/mng/sym/sit/EgovSiteInfoRegist"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/selectSiteInfo.do")
  public String updateSiteInfoView(@ModelAttribute("searchVO") SiteManageDefaultVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM920");		
	  model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  SiteManageVO site = siteManageService.selectSiteDetail(searchVO);
	  
  	  model.addAttribute("siteManageVO", site);
    
  	  model.addAttribute("SiteFileStoreWebPath", propertiesService.getString("Site.fileStoreWebPath"));
  	
  	  model.addAttribute("tmplatFileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
  	  model.addAttribute("sourcFileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
  	
  	  if(!EgovStringUtil.isEmpty(site.getLytTmplatId())) {
		  LytTmplat lytTmplat = new LytTmplat();
		  lytTmplat.setLytTmplatId(site.getLytTmplatId());
		  
		  model.addAttribute("lytTmplatVO", lytTmplatService.selectLytTmplat(lytTmplat));
	  }
	  if(!EgovStringUtil.isEmpty(site.getCmyTmplatId())) {
		  LytTmplat lytTmplat = new LytTmplat();
		  lytTmplat.setLytTmplatId(site.getCmyTmplatId());
		  
		  model.addAttribute("cmyTmplatVO", lytTmplatService.selectLytTmplat(lytTmplat));
	  }
	  
	  if(!EgovStringUtil.isEmpty(site.getLytSourcId())) {
		  LytSourc lytSourc = new LytSourc();
		  lytSourc.setLytSourcId(site.getLytSourcId());
		  
		  model.addAttribute("lytSourcVO", lytSourcService.selectLytSourc(lytSourc));
	  }
	  if(!EgovStringUtil.isEmpty(site.getCmySourcId())) {
		  LytSourc lytSourc = new LytSourc();
		  lytSourc.setLytSourcId(site.getCmySourcId());
		  
		  model.addAttribute("cmySourcVO", lytSourcService.selectLytSourc(lytSourc));
	  }

  	  request.getSession().setAttribute("sessionVO", searchVO);
  	
  	  return "/mng/sym/sit/EgovSiteInfoRegist";
  }
  
  /**
   * 사이트정보를 수정한다.
   * 
   * @param searchVO
   * @param siteManageVO
   * @param bindingResult
   * @return "forward:/mng/sym/sit/SiteListInqire.do"
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping("/mng/sym/sit/updateSiteInfo.do")
  public String updateSiteInfo(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") SiteManageDefaultVO searchVO, SiteManageVO siteManageVO, SiteMainContentsManageVO mainContentsVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	if(request.getSession().getAttribute("sessionVO") == null) {
		return "forward:/mng/sym/sit/selectSiteInfoList.do";
	}
	  
    // Validation
    beanValidator.validate(siteManageVO, bindingResult);
    
    if(bindingResult.hasErrors()) {
      
    	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
  	  	  ccvo.setCodeId("COM920");		
  	  	  model.addAttribute("codeList", cmmUseService.selectCmmCodeDetail(ccvo));
  	  
    	  SiteManageVO site = siteManageService.selectSiteDetail(searchVO);
  	  
    	  model.addAttribute("siteManageVO", site);
    	  
    	  model.addAttribute("SiteFileStoreWebPath", propertiesService.getString("Site.fileStoreWebPath"));
    	  
    	  model.addAttribute("tmplatFileStoreWebPathByPreFile", propertiesService.getString("publish.tmplat.lyt.fileStoreWebPathByPreFile"));
    	  model.addAttribute("sourcFileStoreWebPathByPreFile", propertiesService.getString("publish.sourc.lyt.fileStoreWebPathByPreFile"));
    	  
    	  if(!EgovStringUtil.isEmpty(site.getLytTmplatId())) {
      		  LytTmplat lytTmplat = new LytTmplat();
      		  lytTmplat.setLytTmplatId(site.getLytTmplatId());
      		  
      		  model.addAttribute("lytTmplatVO", lytTmplatService.selectLytTmplat(lytTmplat));
      	  }
    	  if(!EgovStringUtil.isEmpty(site.getCmyTmplatId())) {
      		  LytTmplat lytTmplat = new LytTmplat();
      		  lytTmplat.setLytTmplatId(site.getCmyTmplatId());
      		  
      		  model.addAttribute("cmyTmplatVO", lytTmplatService.selectLytTmplat(lytTmplat));
      	  }
    	  if(!EgovStringUtil.isEmpty(site.getLytSourcId())) {
    		  LytSourc lytSourc = new LytSourc();
    		  lytSourc.setLytSourcId(site.getLytSourcId());
    		  
    		  model.addAttribute("lytSourcVO", lytSourcService.selectLytSourc(lytSourc));
    	  }
    	  if(!EgovStringUtil.isEmpty(site.getCmySourcId())) {
    		  LytSourc lytSourc = new LytSourc();
    		  lytSourc.setLytSourcId(site.getCmySourcId());
    		  
    		  model.addAttribute("cmySourcVO", lytSourcService.selectLytSourc(lytSourc));
    	  }
    	  
    	  return "/mng/sym/sit/EgovSiteInfoRegist";
      
    }
    
    List<FileVO> result = null;    
    final Map<String, MultipartFile> files = multiRequest.getFileMap();
    if(!files.isEmpty()) {
    	result = fileUtil.directParseFileInf(files, "SITE_", 0, "Site.fileStorePath", siteManageVO.getSiteId());
    	
    	if(result != null) {
	    	for(int index=0; index < result.size(); index++) {
	    		FileVO file = result.get(index);
	    		if(file.getFormNm().startsWith("upendLogo")) {
	    			siteManageVO.setUpendLogoFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("lptLogo")) {
	    			siteManageVO.setLptLogoFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("adres")) {
	    			siteManageVO.setAdresFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("peprsntImage")) {
	    			siteManageVO.setPeprsntImageFileNm(file.getStreFileNm());
	    		} else if(file.getFormNm().startsWith("slogan")) {
	    			siteManageVO.setSloganFileNm(file.getStreFileNm());
	    		}
	    	}
    	}
    }
    
    // 로그인VO에서 사용자 정보 가져오기
    LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    String lastUpdusrId = loginVO.getId();
    
    siteManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID
    
    siteManageService.updateSiteInfo(siteManageVO, mainContentsVO);
    this.batchJobAction(searchVO);
    
    request.getSession().removeAttribute("sessionVO");
    
    return "forward:/mng/sym/sit/selectSiteInfoList.do";
    
  }
  
  /**
   * 사이트정보를 삭제처리한다.
   * 
   * @param siteManageVO
   * @param searchVO
   * @return "forward:/mng/sym/sit/SiteListInqire.do"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/deleteSiteInfo.do")
  public String deleteSiteInfo(SiteManageVO siteManageVO, @ModelAttribute("searchVO") SiteManageDefaultVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	// 로그인VO에서 사용자 정보 가져오기
	LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	    
	String lastUpdusrId = loginVO.getId();
	    
	siteManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID
    
    siteManageService.deleteSiteInfo(siteManageVO);
    
    return "forward:/mng/sym/sit/selectSiteInfoList.do";
  }
  
  private void batchJobAction(SiteManageDefaultVO searchVO) throws Exception {
	  
	  if("Y".equals(searchVO.getScrtySetupBtcbAt()) || "Y".equals(searchVO.getScrtyPolicyBtcbAt())) {
		  if("Y".equals(searchVO.getScrtySetupBtcbAt())) {
			  siteManageService.batchScrtySetup(searchVO);
		  }
		  if("Y".equals(searchVO.getScrtyPolicyBtcbAt())) {
			  siteManageService.batchScrtyPolicy(searchVO);
		  }
		  
		  String siteId = searchVO.getSiteId();
		  SiteManageVO dbVO = null;
		  List<SiteManageVO> list = siteManageService.selectSiteSimpleList();
		  if(list != null && list.size() > 0) {
			  for(int i=0; i < list.size(); i++) {
				  dbVO = list.get(i);
				  if(!siteId.equals(dbVO.getSiteId())) {
					  searchVO.setSiteId(dbVO.getSiteId());
					  siteManageService.publishCreate(searchVO, "batch");
				  }
			  }
		  }
	  }
  }
  
  
  /**
   * 사이트정보를 조회한다.
   * 
   * @param siteManageVO
   * @param searchVO
   * @return "forward:/mng/sym/sit/selectSiteListForAjax.do"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/selectCommonSiteList.do")
  public String selectCommonSiteList(@ModelAttribute("orgCodeVO") EgovOrgCodeVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  boolean saveAt = false;
	  String siteId = searchVO.getSiteId();
	  if(!"SELECT".equals(searchVO.getInitMode())) {
		  LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		  if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {
			  siteId = loginVO.getSiteId();
			  saveAt = true;
		  }
	  }
	  
	  /*
	  if(!EgovStringUtil.isEmpty(siteId)) {
		  SiteManageDefaultVO siteVO = new SiteManageDefaultVO();
		  siteVO.setSiteId(siteId);
		  SiteManageVO site = siteManageService.selectSiteInstCode(siteVO);
		  searchVO.setOrgCd(site.getInsttCode());			  
		  EgovOrgCodeVO org = orgCodeService.selectOrgCode(searchVO);
		  if(org != null) {
			  searchVO.setSearchBlngEduInstCd(org.getBlngEduInstCd());
			  searchVO.setSchlGrdCd(org.getSchlGrdCd());
		  } else {
			  searchVO.setSearchBlngEduInstCd("ZZZZZZZZZZZZZZZZZZZZ");
		  }
		  
		  searchVO.setSiteId(siteId);
		  searchVO.setSaveAt(saveAt ? "Y" : "N");
		  
	  }
	  model.addAttribute("areaList", orgCodeService.selectOrgAreaList(searchVO));
	  */
	  
	  searchVO.setSchlGrdCd(searchVO.getSearchSchlGrdCd());
	  if(!EgovStringUtil.isEmpty(siteId)) {
		  SiteManageDefaultVO siteVO = new SiteManageDefaultVO();
		  siteVO.setSiteId(siteId);
		  SiteManageVO site = siteManageService.selectSiteSimpleInfo(siteVO);		
		  if(site != null) {
			  searchVO.setSchlGrdCd(site.getInsttCode());
		  }
		  searchVO.setSiteId(siteId);
		  searchVO.setSaveAt(saveAt ? "Y" : "N");
	  }
	  
	  ComDefaultCodeVO ccvo = new ComDefaultCodeVO();
	  ccvo.setCodeId("COM920");		
	  model.addAttribute("schlGrdList", cmmUseService.selectCmmCodeDetail(ccvo));
	  
	  
	  
	  return "/mng/sym/sit/EgovSiteListCommon";
  }
  
  /**
   * 사이트정보를 조회한다.
   * 
   * @param siteManageVO
   * @param searchVO
   * @return "forward:/mng/sym/sit/selectSiteListForAjax.do"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/selectSiteListForAjax.do")
  public void selectSiteListForAjax(@ModelAttribute("orgCodeVO") EgovOrgCodeVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  JSONArray ja = new JSONArray();
	  JSONObject jo = null;
	  List<SiteManageVO> list = siteManageService.selectSiteListForOrgCode(searchVO);
	  if(list != null && list.size() > 0) {
		  for(int i = 0; i < list.size(); i++) {
			  jo = new JSONObject();
			  jo.put("siteId", list.get(i).getSiteId());
			  jo.put("siteUrl", list.get(i).getSiteUrl());
			  jo.put("siteNm", list.get(i).getSiteNm());
			  
			  ja.add(jo);
		  }
	  }
	  
	  response.setContentType("text/javascript; charset=utf-8");
	  PrintWriter printwriter = response.getWriter();
	  printwriter.println(ja.toString());
	  printwriter.flush();
	  printwriter.close();
  }
  
  /**
   * 사이트정보를 세션에 저장한다.
   * 
   * @param siteManageVO
   * @param searchVO
   * @return "forward:/mng/sym/sit/saveSiteInfoForAjax.do"
   * @throws Exception
   */
  @RequestMapping("/mng/sym/sit/saveSiteInfoForAjax.do")
  public void saveSiteInfoForAjax(@ModelAttribute("orgCodeVO") EgovOrgCodeVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	  if("Y".equals(searchVO.getSaveAt())) {
    	  loginVO.setSiteId(searchVO.getSiteId());
      } else {
    	  loginVO.setSiteId("");
      }
	  
	  JSONObject jo = new JSONObject();
	  jo.put("saveAt", searchVO.getSaveAt());
	  
	  response.setContentType("text/javascript; charset=utf-8");
	  PrintWriter printwriter = response.getWriter();
	  printwriter.println(jo.toString());
	  printwriter.flush();
	  printwriter.close();
  }
  
}
