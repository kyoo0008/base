package egovframework.com.evt.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.evt.service.ComtneventformaswperVO;
import egovframework.com.evt.service.ComtneventadhrncVO;
import egovframework.com.evt.service.ComtnschdulinfoService;
import egovframework.com.evt.service.ComtnschdulinfoDefaultVO;
import egovframework.com.evt.service.ComtnschdulinfoVO;
import egovframework.com.evt.service.ComtneventaswperVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.sim.service.EgovClntInfo;

/******************************************************
 * @Class Name : ComtnschdulinfoController.java
 * @Program name : egovframework.com.evt.web
 * @Descriptopn : 충청남도교육연구정보원 스마트충남 기능 개선 구축
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 2. 9.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 2. 9.        이호영             first generated
*********************************************************/

@Controller
public class ComtnschdulinfoController {

    @Resource(name = "comtnschdulinfoService")
    private ComtnschdulinfoService comtnschdulinfoService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovCmmUseService */
    @Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;

    @Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
    
    @Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다. (달력형태)
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/selectSchdulinfoList"
	 * @exception Exception
	 */
    @RequestMapping(value="/evt/selectSchdulinfoCalendar.do")
    public String selectComtnschdulinfoList(@ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
  	  	searchVO.setSiteId(siteVO.getSiteId());
  	  
    	java.util.Calendar cal = java.util.Calendar.getInstance();
    	
    	//오늘날짜(기본)
		int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		int iDay = cal.get(java.util.Calendar.DATE);
		searchVO.setSearchDay(iDay);
		
        //최초 오늘날짜 셋팅 한다.
        if(searchVO.getSearchYear()==0 && searchVO.getSearchMonth()==0){
        	searchVO.setSearchYear(iYear);
        	searchVO.setSearchMonth(iMonth);
        	searchVO.setSearchDay(iDay);
        }
       
    	//공통코드 일정종류
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM020");
    	List<?> listComCode = cmmUseService.selectCmmCodeDetail(voComCode);
    	model.addAttribute("schdulSe", listComCode);

    	//검색 설정
        String sSearchDate = "";
        sSearchDate += Integer.toString(searchVO.getSearchYear());
        int nMonth = searchVO.getSearchMonth()+1;	//달력에서는 0이 1월을 의미
        sSearchDate += Integer.toString(nMonth).length() == 1 ? "0" + Integer.toString(nMonth) :Integer.toString(nMonth); 
        searchVO.setSearchDate(sSearchDate);
        
    	List<?> comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfoList_S(searchVO);

        model.addAttribute("resultCnt", comtnschdulinfoList.size());
        model.addAttribute("resultList", comtnschdulinfoList);
        return "evt/ComtnschdulinfoCalendar";
    } 
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다. (리스트형태)
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/selectSchdulinfoCalendar"
	 * @exception Exception
	 */
    @RequestMapping(value="/evt/selectSchdulinfoList.do")
    public String selectSchdulinfoCalendar(@ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, Map<String, Object> commandMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
  	  	searchVO.setSiteId(siteVO.getSiteId());
  	  	
    	//공통코드 일정종류
		ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	   	voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM020");
    	model.addAttribute("schdulSe", cmmUseService.selectCmmCodeDetail(voComCode));
    	
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
		
		//이벤트 웹경로.
	    model.addAttribute("EventFileStoreWebPath", propertyService.getString("Event.fileStoreWebPath"));
		
	    String menuId = (String)commandMap.get("menuId");
	    if(!(menuId==null || "".equals(menuId))){
	    	searchVO.setSearchCondition("99");
	    }
	    
        model.addAttribute("resultList", comtnschdulinfoService.selectComtnschdulinfoList_D(searchVO));

        int totCnt = comtnschdulinfoService.selectComtnschdulinfoListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "evt/ComtnschdulinfoList";
    } 

    /**
	 * 이벤트 상세내용을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/ComtnschdulinfoView"
	 * @exception Exception
	 */
    @RequestMapping("/evt/selectComtnschdulinfo.do")
    public String selectComtnschdulinfo(@ModelAttribute("searchVO") ComtnschdulinfoVO comtnschdulinfoVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	int evtCheck = 0;
    	
        ComtnschdulinfoVO comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfo(comtnschdulinfoVO);
		model.addAttribute("comtnschdulinfoVO", comtnschdulinfoList);

		//이벤트 참여 여부 조회
		LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		
		if(user != null){
			comtnschdulinfoVO.setUserId(user.getId());
			evtCheck = comtnschdulinfoService.selectComtneventadhrncCnt(comtnschdulinfoVO);
		}
		model.addAttribute("evtCheck", evtCheck);
        return "evt/ComtnschdulinfoView";
    }
    
    /**
	 * 신청이벤트를 출력한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/ComtnschdulinfoView"
	 * @exception Exception
	 */
    @RequestMapping("/evt/selectComtnschdulForm.do")
    public String selectComtnschdulForm(ComtnschdulinfoVO comtnschdulinfoVO, @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	comtnschdulinfoVO.setIsError(false);
    	
		if(StringUtils.isEmpty(comtnschdulinfoVO.getSchdulId())) {	
			comtnschdulinfoVO.setIsError(true);
			comtnschdulinfoVO.setErrorMessage("올바른 경로로 접근하세요");
		}

		if(!comtnschdulinfoVO.getIsError()) {
			if(comtnschdulinfoService.isAnswerDuplicate(comtnschdulinfoVO)) {
				comtnschdulinfoVO.setIsError(true);
				comtnschdulinfoVO.setErrorMessage("이미 참여하셨습니다.");
			}
		}

		model.addAttribute("comtnschdulForm", comtnschdulinfoService.selectComtnschdulForm(comtnschdulinfoVO));
		
		return "evt/ComtnschdulEventForm";
    }
    
    /**
	 * 객관식 또는 주관식 이벤트를 출력한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return "/evt/ComtnschdulEventPop"
	 * @exception Exception
	 */
    @RequestMapping("/evt/selectComtnschdulEvent.do")
    public String selectComtnschdulEvent(ComtnschdulinfoVO comtnschdulinfoVO, @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	comtnschdulinfoVO.setIsError(false);
    	
		if(StringUtils.isEmpty(comtnschdulinfoVO.getSchdulId())) {	
			comtnschdulinfoVO.setIsError(true);
			comtnschdulinfoVO.setErrorMessage("올바른 경로로 접근하세요");
		}

		ComtnschdulinfoVO onlineEvent = null;
		if(!comtnschdulinfoVO.getIsError()) {
			
			onlineEvent = comtnschdulinfoService.selectComtnschduInfo(comtnschdulinfoVO);
			
			if(onlineEvent != null) {

				comtnschdulinfoVO.setUserId(user.getId());
				comtnschdulinfoVO.setSchdulId(onlineEvent.getSchdulId());
				comtnschdulinfoVO.setSchdulClCode(onlineEvent.getSchdulClCode());
				comtnschdulinfoVO.setSchdulBgnde(onlineEvent.getSchdulBgnde());
				comtnschdulinfoVO.setSchdulEndde(onlineEvent.getSchdulEndde());
				comtnschdulinfoVO.setPresnatnDe(onlineEvent.getPresnatnDe());
				comtnschdulinfoVO.setSchdulNm(onlineEvent.getSchdulNm());
				comtnschdulinfoVO.setSchdulCn(onlineEvent.getSchdulCn());
				comtnschdulinfoVO.setUpendStreFileNm(onlineEvent.getUpendStreFileNm());
				comtnschdulinfoVO.setMiddleStreFileNm(onlineEvent.getMiddleStreFileNm());
				comtnschdulinfoVO.setLptStreFileNm(onlineEvent.getLptStreFileNm());
				  
				comtnschdulinfoVO.setQuestionList(onlineEvent.getQuestionList());

			} else {
				comtnschdulinfoVO.setIsError(true);
				comtnschdulinfoVO.setErrorMessage("알수없는 이벤트입니다.");
			}
		}
		model.addAttribute("comtnschdulinfoVO", comtnschdulinfoVO);
		request.getSession().setAttribute("sessionVO", comtnschdulinfoVO);
    	return "evt/ComtnschdulEventPop";
    }

    /**
	 * 신청 이벤트 참여정보를 입력한다.
	 * @param model 화면모델
	 * @return "/evt/ComtnschdulEventFinish"
	 * @exception Exception
	 */
    @RequestMapping("/evt/addComtnschdulPop.do")
    public String addComtnschdulPop(ComtnschdulinfoVO comtnschdulinfoVO, ComtneventformaswperVO comtneventformaswperVO,	BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	comtneventformaswperVO.setUserId(user.getId());

    	comtnschdulinfoService.insertEventFormAswper(comtneventformaswperVO);
    	return "evt/ComtnschdulEventFinish";
    }
    
    /**
	 * 객관식 주관식 이벤트 참여정보를 입력한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/ComtnschdulinfoView"
	 * @exception Exception
	 */
    @RequestMapping("/evt/addComtnschdulEvent.do")
    public String addComtnschdulEvent(@ModelAttribute("searchVO") ComtnschdulinfoDefaultVO comtnschdulinfo, ComtnschdulinfoVO comtnschdulinfoVO, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	if(user == null) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.user.login"));
			return "evt/ComtnschdulEventFinish";
		}

    	ComtneventadhrncVO comtneventadhrncVO = new ComtneventadhrncVO();
    	comtneventadhrncVO.setUserId(user.getId());
    	comtneventadhrncVO.setFrstRegistIp(EgovClntInfo.getClntIP(request));
    	comtneventadhrncVO.setSchdulId(comtnschdulinfoVO.getSchdulId());    	
    	comtneventadhrncVO.setSiteId(siteVO.getSiteId());
    	comtneventadhrncVO.setSysTyCode(siteVO.getSysTyCode());
    	
    	//이벤트 중복 참여여부 체크
    	if(comtnschdulinfoService.isRegDuplicate(comtneventadhrncVO)){
    		comtnschdulinfoVO.setIsError(true);
    		comtnschdulinfoVO.setErrorMessage("이미 참여하셨습니다.");
    		return "evt/ComtnschdulEventFinish";
    	}
    	
    	List<ComtneventaswperVO> answerList = new ArrayList<ComtneventaswperVO>();

    	if (comtnschdulinfoVO.getQuestionIdList().size() > 0) {
    		int essayAnswerPointer = 0;
    		for (int index=0;index < comtnschdulinfoVO.getQuestionIdList().size();index++) {
    			String questionId = comtnschdulinfoVO.getQuestionIdList().get(index).toString();		    	  
    			Integer type = new Integer(comtnschdulinfoVO.getTypeList().get(index).toString());
    			Integer maximum = new Integer(comtnschdulinfoVO.getMaximumList().get(index).toString());
    			
    			if(type.intValue() == 1) {		//객관식
    				ComtneventaswperVO answer = new ComtneventaswperVO();
		    		  
    				answer.setUserId(user.getId());
    				answer.setSchdulId(comtnschdulinfoVO.getSchdulId());
    				answer.setQesitmId(questionId);
    				answer.setAswperSn(new Integer(index + 1));
    				answer.setChoiceCnsr(new Integer(request.getParameter("choiceAnswer_" + (index + 1))));
    				answerList.add(answer);
    			} else if(type.intValue() == 2) {	//주관식

    				for (int index1=0;index1 < maximum;index1++) {
    					ComtneventaswperVO answer = new ComtneventaswperVO();
						answer.setUserId(user.getId());
						answer.setSchdulId(comtnschdulinfoVO.getSchdulId());
						answer.setQesitmId(questionId);
						answer.setAswperSn(new Integer(index1 + 1));
						answer.setEssayCnsr(comtnschdulinfoVO.getEssayAnswerList().get(index1 + essayAnswerPointer).toString());
			    			  
			    		answerList.add(answer);
    				}
    				essayAnswerPointer+=maximum;
    			}
    		}
    		
    		comtnschdulinfoService.addUserAnswerByBatch(comtneventadhrncVO, answerList);
    	}
	    request.getSession().removeAttribute("sessionVO");
        return "evt/ComtnschdulEventFinish";
    }
    
    /**
	 * 설문조사 이벤트 결과 보기 화면.
	 * @param model 화면모델
	 * @return "/evt/ComtnschdulEventResult"
	 * @exception Exception
	 */
    @RequestMapping("/evt/selectComtnschdulResult.do")
    public String selectComtnschdulResult(ComtnschdulinfoVO comtnschdulinfoVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
		ComtnschdulinfoVO onlineEvent = null;	
		onlineEvent = comtnschdulinfoService.selectComtnschduInfoResult(comtnschdulinfoVO);
		
		if(onlineEvent != null) {
			comtnschdulinfoVO.setSchdulId(onlineEvent.getSchdulId());
			comtnschdulinfoVO.setSchdulClCode(onlineEvent.getSchdulClCode());
			comtnschdulinfoVO.setSchdulBgnde(onlineEvent.getSchdulBgnde());
			comtnschdulinfoVO.setSchdulEndde(onlineEvent.getSchdulEndde());
			comtnschdulinfoVO.setPresnatnDe(onlineEvent.getPresnatnDe());
			comtnschdulinfoVO.setSchdulNm(onlineEvent.getSchdulNm());
			comtnschdulinfoVO.setTotalCo(onlineEvent.getTotalCo());
			comtnschdulinfoVO.setQuestionList(onlineEvent.getQuestionList());
		} else {
			comtnschdulinfoVO.setIsError(true);
			comtnschdulinfoVO.setErrorMessage("알수없는 이벤트입니다.");
		}

		model.addAttribute("comtnschdulinfoVO", comtnschdulinfoVO);

    	return "evt/ComtnschdulEventResult";
    }
    
    /**
     * 설문조사 이벤트 결과화면 펼처보기
     * 
     * @param cmmntyVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/evt/selectCommunitySbjctList.do")
    public void selectCmmntyMainList(ComtneventaswperVO comtneventaswperVO, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap map = (HashMap)comtnschdulinfoService.selectCommunitySbjctList(comtneventaswperVO);
		List<ComtneventaswperVO> resultList = (List<ComtneventaswperVO>) map.get("resultList");
		
		ComtneventaswperVO result = null;
		JSONObject jObj = null;
	  	JSONArray jArray = new JSONArray();

	  	if(resultList != null && resultList.size() > 0) {
		  	for(int i=0; i < resultList.size(); i++) {
		  		result = resultList.get(i);
		  		jObj = new JSONObject();
		  		jObj.put("essayCnsr", egovframework.com.utl.fcc.service.EgovStringUtil.isNullToString(result.getEssayCnsr()));
		  		jArray.add(jObj);
		  	}
	  	}
	  	
	  	response.setContentType("text/javascript; charset=utf-8");
	  	PrintWriter printwriter = response.getWriter();
	  	printwriter.println(jArray.toString());
	  	printwriter.flush();
		printwriter.close();
    }
    
    /**
	 * 이벤트 팝업-상세내용을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/evt/ComtnschdulinfoView"
	 * @exception Exception
	 */
    @RequestMapping("/evt/selectComtnschdulinfoPop.do")
    public String selectComtnschdulinfoPop(@ModelAttribute("searchVO") ComtnschdulinfoVO comtnschdulinfoVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
  	  	model.addAttribute("siteInfo", siteVO);
  	  	model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
  	  	
    	comtnschdulinfoVO.setMngrAt("Y");
        ComtnschdulinfoVO comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfo(comtnschdulinfoVO);
		model.addAttribute("comtnschdulinfoVO", comtnschdulinfoList);

        return "evt/popupList";
    }
}
