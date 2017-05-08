package egovframework.com.mng.evt;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.sms.service.EgovSmsInfoService;
import egovframework.com.cop.sms.service.Sms;
import egovframework.com.evt.service.ComtneventadhrncVO;
import egovframework.com.evt.service.ComtneventaswperVO;
import egovframework.com.evt.service.ComtneventcnsrVO;
import egovframework.com.evt.service.ComtneventqesitmexVO;
import egovframework.com.evt.service.ComtneventqesitmVO;
import egovframework.com.evt.service.ComtnschdulinfoDefaultVO;
import egovframework.com.evt.service.ComtnschdulinfoService;
import egovframework.com.evt.service.ComtnschdulinfoVO;
import egovframework.com.evt.service.ComtneventprzwnerVO;
import egovframework.com.evt.service.ComtneventprzwnerDefaultVO;
import egovframework.com.evt.service.ComtneventformaswperVO;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.com.uat.uia.service.LoginVO;

/******************************************************
 * @Class Name : ComtnschdulinfoMngController.java
 * @Program name : egovframework.com.mng.evt
 * @Descriptopn : 충청남도교육연구정보원 스마트충남 기능 개선 구축
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 2. 14.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 2. 14.        이호영             first generated
*********************************************************/

@Controller
public class ComtnschdulinfoMngController {

	/** EgovCmmUseService */
    @Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    /** ComtnschdulinfoService */
    @Resource(name = "comtnschdulinfoService")
    private ComtnschdulinfoService comtnschdulinfoService;
    
    @Autowired	
	private DefaultBeanValidator beanValidator;
    
    /** EgovFileMngUtil */
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
    
    @Resource(name = "EgovFileMngService")
	private EgovFileMngService            fileMngService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "EgovSmsInfoService")
    private EgovSmsInfoService egovSmsInfoService;
    
    @Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;
    
	/**
	 * 스케쥴 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtnschdulinfoDefaultVO
	 * @return "/mng/evt/selectSchdulinfoList"
	 * @exception Exception
	 */
	@RequestMapping(value="/mng/evt/selectSchdulinfoList.do")
    public String selectComtnschdulinfoList(@ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO,  
    		ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		
		LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			searchVO.setSiteId(loginVO.getSiteId());
		}
		
    	searchVO.setAdminYn("Y");
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
		
		List<?> comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfoList_D(searchVO);
        model.addAttribute("resultList", comtnschdulinfoList);
        
        int totCnt = comtnschdulinfoService.selectComtnschdulinfoListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
        return "mng/evt/ComtnschdulinfoMngList";
    } 
    
    /**
     * 스케쥴 등록 화면으로 이동한다.
     * @param model 화면모델
     * @return mng/evt/ComtnschdulinfoMngRegister
     * @throws Exception
     */
    @RequestMapping("/mng/evt/addComtnschdulinfoView.do")
    public String addComtnschdulinfoView(
    		@ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, 
            ComtnschdulinfoVO comtnschdulinfoVO,
            Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	//스케쥴 코드
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("COM020");	//스케쥴 일정분류 코드
 
    	comtnschdulinfoVO.setUseAt("Y");
    	model.addAttribute("codeList",cmmUseService.selectCmmCodeDetail(vo));
    	request.getSession().setAttribute("sessionVO", comtnschdulinfoVO);
        model.addAttribute("comtnschdulinfoVO", comtnschdulinfoVO);
        return "mng/evt/ComtnschdulinfoMngRegister";
    }
    
    /**
     * 스케쥴 등록/수정 처리후 메인화면으로 이동한다.
     * @param model 화면모델
     * @return forward:/mng/evt/selectSchdulinfoList.do
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/evt/processComtnschdulinfo.do")
    public String addComtnschdulinfo(
    		final MultipartHttpServletRequest multiRequest, 
            @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO,
            ComtnschdulinfoVO comtnschdulinfoVO,
            BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	
    	if(request.getSession().getAttribute("sessionVO") == null) {
    		return "forward:/mng/evt/selectSchdulinfoList.do";
    	}
    	beanValidator.validate(comtnschdulinfoVO, bindingResult);
        if(bindingResult.hasErrors()) {
        	//스케쥴 코드
        	ComDefaultCodeVO vo = new ComDefaultCodeVO();
        	vo.setCodeId("COM020");	//스케쥴 일정분류 코드
        	model.addAttribute("codeList",cmmUseService.selectCmmCodeDetail(vo));
        	
        	model.addAttribute("comtnschdulinfoVO", comtnschdulinfoVO);
        	return "mng/evt/ComtnschdulinfoMngRegister";
        }

        if (comtnschdulinfoVO.getQuestionTitleList().size() > 0) {
        	List<ComtneventqesitmVO> questionList = new ArrayList<ComtneventqesitmVO>();
        	int examAndanswerPointer = 0;
        	int typeCount = 0;

        	for (int index=0;index < comtnschdulinfoVO.getQuestionTitleList().size();index++) {
        		ComtneventqesitmVO question = new ComtneventqesitmVO();

        		Integer type = new Integer(comtnschdulinfoVO.getTypeList().get(index).toString());
            	Integer maximum = new Integer(comtnschdulinfoVO.getMaximumList().get(index).toString());
            	
            	question.setQesitmId(comtnschdulinfoVO.getQuestionIdList().get(index).toString());
            	question.setQesitmSn(new Integer(index + 1));
            	question.setQesitmTyCode(type.toString());
            	question.setQesitmSj(comtnschdulinfoVO.getQuestionTitleList().get(index).toString());
            	question.setQesitmCn(comtnschdulinfoVO.getQuestionContentsList().get(index).toString());
            	question.setMxmmAnswerCo(maximum);
            	if(type.intValue() == 1) {	//객관식
            		List<ComtneventqesitmexVO> exampleList = new ArrayList<ComtneventqesitmexVO>();
            		for (int index1 = 0; index1 < maximum; index1++) {
            			ComtneventqesitmexVO example = new ComtneventqesitmexVO();
            			example.setExId(comtnschdulinfoVO.getExampleIdList().get(index1 + examAndanswerPointer).toString());
            			example.setExSn(new Integer(index1 + 1));
            			example.setExCn(comtnschdulinfoVO.getExampleList().get(index1 + examAndanswerPointer).toString());
            			
            			exampleList.add(example);
            		}
            		examAndanswerPointer+=maximum;
            		question.setExampleList(exampleList);
            		//객관식정답
            		List<ComtneventcnsrVO> answerList = new ArrayList<ComtneventcnsrVO>();
            		ComtneventcnsrVO answer = new ComtneventcnsrVO();
            		answer.setCnsrId(comtnschdulinfoVO.getAnswerIdList().get(typeCount).toString());
            		answer.setCnsrSn(1);
            		answer.setChoiseCnsr(new Integer(comtnschdulinfoVO.getAnswerList().get(typeCount).toString()));
            		
            		answerList.add(answer);
            		question.setAnswerList(answerList);
            		typeCount++;
            	} else if(type.intValue() == 2) {	//주관식
            		//주관식정답
            		List<ComtneventcnsrVO> answerList = new ArrayList<ComtneventcnsrVO>();
            		for (int index2 = 0; index2 < maximum; index2++) {
            			ComtneventcnsrVO answer = new ComtneventcnsrVO();
            			answer.setCnsrId(comtnschdulinfoVO.getExampleIdList().get(index2 + examAndanswerPointer).toString());
            			answer.setCnsrSn(new Integer(index2 + 1));
            			answer.setSbjctCnsr(comtnschdulinfoVO.getExampleList().get(index2 + examAndanswerPointer).toString());
            			
            			answerList.add(answer);
            		}
            		examAndanswerPointer+=maximum;
            		question.setAnswerList(answerList);
            	}
            	questionList.add(question);
        	}
        	comtnschdulinfoVO.setQuestionList(questionList);
        }
        List<FileVO> result = null;
        String atchFileId ="";
        
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
        if(!files.isEmpty()) {
          result = fileUtil.directParseFileInf(files, "EVENT_", 0, "Event.fileStorePath", "");
          atchFileId = fileMngService.insertFileInfs(result);
        }        
        if(result != null) {
        	comtnschdulinfoVO.setFileValue(result);
        }

        if (StringUtils.isEmpty(comtnschdulinfoVO.getSchdulId())){
        	comtnschdulinfoVO.setFrstRegisterId(user.getId());
        	comtnschdulinfoService.insertComtnschdulinfo(comtnschdulinfoVO);	//등록
        }else{
        	comtnschdulinfoVO.setLastUpdusrId(user.getId());
        	comtnschdulinfoService.updateComtnschdulinfo(comtnschdulinfoVO);	//수정
        }
        request.getSession().removeAttribute("sessionVO");
        return "forward:/mng/evt/selectSchdulinfoList.do";
    }
    
    /**
     * 스케쥴 수정 화면으로 이동한다.
     * @param model 화면모델
     * @return mng/evt/ComtnschdulinfoMngRegister
     * @throws Exception
     */
    @RequestMapping("/mng/evt/updateComtnschdulinfoView.do")
    public String updateComtnschdulinfoView(
            @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, 
            ComtnschdulinfoVO comtnschdulinfoVO,
            Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	//스케쥴 코드
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("COM020");	//스케쥴 일정분류 코드 
    	comtnschdulinfoVO.setUseAt("Y");
    	model.addAttribute("codeList",cmmUseService.selectCmmCodeDetail(vo));
    	
    	comtnschdulinfoVO.setMngrAt("Y");
    	ComtnschdulinfoVO comtnschdulinfoList = comtnschdulinfoService.selectComtnschdulinfo(comtnschdulinfoVO);
    	model.addAttribute("comtnschdulinfoVO", comtnschdulinfoList);
    	request.getSession().setAttribute("sessionVO", comtnschdulinfoVO);
    	model.addAttribute("comtnschdulItem", comtnschdulinfoService.selectComtnschduInfo(comtnschdulinfoVO));
        	
        return "mng/evt/ComtnschdulinfoMngRegister";
    }
    
    /**
     * 스케쥴 수정처리후 메인화면으로 이동한다.
     * @param model 화면모델
     * @return forward:/mng/evt/selectSchdulinfoList.do
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/mng/evt/updateComtnschdulinfo.do")
    public String updateComtnschdulinfo(
    		final MultipartHttpServletRequest multiRequest, 
            ComtnschdulinfoVO comtnschdulinfoVO,
            @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO,
            BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    	comtnschdulinfoVO.setLastUpdusrId(user.getId());

    	beanValidator.validate(comtnschdulinfoVO, bindingResult);
        if(bindingResult.hasErrors()) {
        	
        	ComDefaultCodeVO vo = new ComDefaultCodeVO();
        	vo.setCodeId("COM020");	//스케쥴 일정분류 코드 
        	comtnschdulinfoVO.setUseAt("Y");
        	model.addAttribute("codeList",cmmUseService.selectCmmCodeDetail(vo));
        	
        	model.addAttribute("comtnschdulinfoVO", comtnschdulinfoVO);
        	return "mng/evt/ComtnschdulinfoMngRegister";
        }
        
    	List<FileVO> result = null;
        
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        String atchFileId = "";
        
        if(!files.isEmpty()) {
          
        	result = fileUtil.directParseFileInf(files, "EVENT_", 0, "Event.fileStorePath", "");

        	atchFileId = fileMngService.insertFileInfs(result);
        }
        
        if(result != null) {
        	comtnschdulinfoVO.setFileValue(result);
        }
    	
        comtnschdulinfoVO.setAtchFileId(atchFileId);
        comtnschdulinfoService.updateComtnschdulinfo(comtnschdulinfoVO);

        return "forward:/mng/evt/selectSchdulinfoList.do";
    }
    
    /**
     * 이벤트 응시현황 목록을 조회한다.
     * @param model 화면모델
     * @return forward:/mng/evt/ComtneventadhrncMngList
     * @throws Exception
     */
	@RequestMapping("/mng/evt/selectComtneventadhrncList.do")
    public String selectComtneventadhrncList(
    		ComtneventadhrncVO comtneventadhrncVO, 
    		@ModelAttribute("searchVO") ComtnschdulinfoVO comtnschdulinfoVO,
            ModelMap model)
            throws Exception {

    	/** EgovPropertyService.sample */
    	comtneventadhrncVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	comtneventadhrncVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(comtneventadhrncVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(comtneventadhrncVO.getPageUnit());
		paginationInfo.setPageSize(comtneventadhrncVO.getPageSize());
		
		comtneventadhrncVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		comtneventadhrncVO.setLastIndex(paginationInfo.getLastRecordIndex());
		comtneventadhrncVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		comtnschdulinfoVO.setMngrAt("Y");
		ComtnschdulinfoVO schdulinfo = comtnschdulinfoService.selectComtnschdulinfo(comtnschdulinfoVO);
		model.addAttribute("comtnschdulinfoVO", schdulinfo);
		
        List<ComtneventadhrncVO> comtneventadhrncList = comtnschdulinfoService.selectComtneventadhrncList(comtneventadhrncVO);
        model.addAttribute("resultList", comtneventadhrncList);
        
        int totCnt = comtnschdulinfoService.selectComtneventadhrncListTotCnt(comtneventadhrncVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "mng/evt/ComtneventadhrncMngList";
    }

	/**
     * 이벤트 응시자를 삭제 한다.
     * @param model 화면모델
     * @return forward:/mng/evt/deleteComtneventadhrnc.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/deleteComtneventadhrnc.do")
    public String deleteComtneventadhrnc(
            ComtnschdulinfoVO comtnschdulinfoVO,
            @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, SessionStatus status)
            throws Exception {
        comtnschdulinfoService.deleteComtneventadhrnc(comtnschdulinfoVO);
        status.setComplete();
        return "forward:/mng/evt/selectComtneventadhrncList.do";
    }
    
	/**
     * 이벤트 응시현황 목록을 엑셀 다운받는다.
     * @param model 화면모델
     * @return forward:/mng/evt/selectSchdulinfoList.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/selectComtneventadhrncExcel.do")
    public String selectComtneventadhrncExcel(
    		@ModelAttribute("searchVO") ComtneventadhrncVO comtneventadhrncVO, 
    		ComtnschdulinfoVO comtnschdulinfoVO,
            ModelMap model)
            throws Exception {

    	comtneventadhrncVO.setFirstIndex(0);
    	comtneventadhrncVO.setRecordCountPerPage(999999999);
    	List<ComtneventadhrncVO> comtneventadhrncList = comtnschdulinfoService.selectComtneventadhrncList(comtneventadhrncVO);

    	model.addAttribute("resultList", comtneventadhrncList);
    	return "mng/evt/ComtneventadhrncExcel";
    }
    
    /**
     * 행사 및 이벤트를 삭제 한다.
     * @param model 화면모델
     * @return forward:/mng/evt/selectSchdulinfoList.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/deleteComtnschdulinfo.do")
    public String deleteComtnschdulinfo(
            ComtnschdulinfoVO comtnschdulinfoVO,
            @ModelAttribute("searchVO") ComtnschdulinfoDefaultVO searchVO, SessionStatus status)
            throws Exception {
        comtnschdulinfoService.deleteComtnschdulinfo(comtnschdulinfoVO);
        status.setComplete();
        return "forward:/mng/evt/selectSchdulinfoList.do";
    }
    
    /**
     * 이벤트를 추첨한다.
     * @param model 화면모델
     * @return forward:/mng/evt/addComtneventprzwner.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/addComtneventprzwner.do")
    public String addComtneventprzwner(
            ComtneventprzwnerVO comtneventprzwnerVO,
            @ModelAttribute("searchVO") ComtneventprzwnerDefaultVO searchVO,
            SessionStatus status, ModelMap model)
            throws Exception {
    	model.addAttribute("message", "추첨을 완료 하였습니다. ");
    	comtnschdulinfoService.insertComtneventprzwner(comtneventprzwnerVO);
        status.setComplete();
        return "forward:/mng/evt/selectComtneventprzwnerList.do";
    }
    
    /**
     * 이벤트 당첨자를 수동 추첨한다.
     * @param model 화면모델
     * @return forward:/mng/evt/addComtneventprzwnerhopr.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/addComtneventprzwnerhopr.do")
    public String addComtneventprzwnerhopr(
            ComtneventprzwnerVO comtneventprzwnerVO,
            @ModelAttribute("searchVO") ComtneventprzwnerDefaultVO searchVO,
            SessionStatus status)
            throws Exception {
    	comtnschdulinfoService.insertComtneventprzwnerhopr(comtneventprzwnerVO);
    	status.setComplete();
    	return "forward:/mng/evt/selectComtneventadhrncList.do";
    }
    
    /**
     * 이벤트 당첨자를 수동 취소한다.
     * @param model 화면모델
     * @return forward:/mng/evt/delComtneventprzwner.do
     * @throws Exception
     */
    @RequestMapping("/mng/evt/delComtneventprzwner.do")
    public String delComtneventprzwnerList(
            ComtneventprzwnerVO comtneventprzwnerVO,
            @ModelAttribute("searchVO") ComtneventprzwnerDefaultVO searchVO,
            SessionStatus status)
            throws Exception {
    	comtnschdulinfoService.delComtneventprzwner(comtneventprzwnerVO);
    	status.setComplete();
    	return "forward:/mng/evt/selectComtneventprzwnerList.do";
    }
    
    /**
	 * 이벤트 당첨자를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/evt/selectComtneventprzwnerList.do")
    public String selectComtneventprzwnerList(@ModelAttribute("searchVO") ComtneventprzwnerDefaultVO searchVO, 
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
    	
        model.addAttribute("resultList", comtnschdulinfoService.selectComtneventprzwnerList(searchVO));

        int totCnt = comtnschdulinfoService.selectComtneventprzwnerCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mng/evt/ComtneventprzwnerList";
    }
    
    /**
	 * 이벤트 당첨자를 엑셀로 다운받는다.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/evt/selectComtneventprzwnerExcel.do")
    public String selectComtneventprzwnerExcel(@ModelAttribute("searchVO") ComtneventprzwnerDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {

        model.addAttribute("resultList", comtnschdulinfoService.selectComtneventprzwnerList(searchVO));

        return "mng/evt/ComtneventprzwnerExcel";
    }
    
    /**
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
    @RequestMapping("/mng/evt/selectComtneventformaswper.do")
    public String selectComtneventformaswper(
    		ComtneventformaswperVO comtneventformaswperVO, Model model)
            throws Exception {

		model.addAttribute("comtneventformaswperVO", comtnschdulinfoService.selectComtneventformaswper(comtneventformaswperVO));

        return "mng/evt/Comtneventformaswper";
    }
    
    /**
	 * 이벤트 당첨자SMS발송.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/evt/insertEventSms.do")
	public String insertSms(@RequestParam("schdulId") String schdulId, @ModelAttribute("searchVO") Sms sms, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	if (schdulId == null || "".equals(schdulId)){
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
    	}else{
			LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	
			ComtneventprzwnerDefaultVO vo = new ComtneventprzwnerDefaultVO();
			vo.setSchdulId(schdulId);

			sms.setAdminAt("Y"); // 관리자설정
			int iRet = egovSmsInfoService.sendUserSms(user.getId(), sms);
			
			//성공
			if(sms.getRecptnTelno().size() == iRet) {
				model.addAttribute("message", egovMessageSource.getMessage("cop.sms.success"));
			} else {
				if(iRet == 0) {	//모두 실패
					model.addAttribute("message", egovMessageSource.getMessage("cop.sms.fail.mlg"));
				} else {		//일부 실패
					model.addAttribute("message", egovMessageSource.getMessage("cop.sms.fail.mlg.some"));
				}
			}

    	}
		return "forward:/mng/evt/selectComtneventprzwnerList.do";
	}
		
	/**
	 * 이벤트 사용자별 당첨내역을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventprzwnerDefaultVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/evt/selectComtneventprzwnerUserList.do")
    public String selectComtneventprzwnerUserList(@ModelAttribute("searchVO") ComtneventprzwnerDefaultVO comtneventprzwnerDefaultVO, 
    		ModelMap model)
            throws Exception {

    	comtneventprzwnerDefaultVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	comtneventprzwnerDefaultVO.setPageSize(propertiesService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(comtneventprzwnerDefaultVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(comtneventprzwnerDefaultVO.getPageUnit());
        paginationInfo.setPageSize(comtneventprzwnerDefaultVO.getPageSize());
        
        comtneventprzwnerDefaultVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        comtneventprzwnerDefaultVO.setLastIndex(paginationInfo.getLastRecordIndex());
        comtneventprzwnerDefaultVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        model.addAttribute("resultList", comtnschdulinfoService.selectComtneventprzwnerUserList(comtneventprzwnerDefaultVO));
        
        int totCnt = comtnschdulinfoService.selectComtneventprzwnerUserListCnt(comtneventprzwnerDefaultVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "mng/evt/ComtneventprzwnerUserList";
    }
    
    /**
     * 이벤트 사용자별 참여내역을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 ComtneventaswperVO
	 * @return "/mng/evt/ComtneventprzwnerList"
	 * @exception Exception
	 */
    @RequestMapping("/mng/evt/selectComtneventAswper.do")
    public String selectComtneventAswper(
    		ComtneventaswperVO comtneventaswperVO, Model model)
            throws Exception {

		model.addAttribute("resultList", comtnschdulinfoService.selectCommunityAswper(comtneventaswperVO));

        return "mng/evt/ComtneventAswperView";
    }
    
    /**
	 * 설문조사 이벤트 결과 보기 화면.
	 * @param model 화면모델
	 * @return "/evt/ComtnschdulEventResult"
	 * @exception Exception
	 */
    @RequestMapping("/mng/evt/selectComtnschdulResult.do")
    public String selectComtnschdulResult(
    		ComtnschdulinfoVO comtnschdulinfoVO,
    		BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

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

    	return "mng/evt/ComtnschdulEventResult";
    }
    
}
