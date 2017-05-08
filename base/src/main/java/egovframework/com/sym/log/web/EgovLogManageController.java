package egovframework.com.sym.log.web;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.sym.log.service.EgovLogManageService;
import egovframework.com.sym.log.service.LoginLog;
import egovframework.com.sym.log.service.WebLog;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EgovLogManageController.java
 * @Description : 시스템 로그정보를 관리하기 위한 컨트롤러 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭  최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Controller
public class EgovLogManageController {

	/**
	 * @uml.property  name="logManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="EgovLogManageService")
	private EgovLogManageService logManageService;
	
	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="propertiesService")
	protected EgovPropertyService propertyService;	
	
	/**
	 * 로그인 로그 목록 조회
	 * 
	 * @param loginLog
	 * @return sym/log/EgovLoginLogList
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/SelectLoginLogList.do")
	public String selectLoginLogInf(@ModelAttribute("searchVO") LoginLog loginLog, 
			ModelMap model) throws Exception{

		loginLog.setPageUnit(propertyService.getInt("pageUnit"));
		loginLog.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(loginLog.getPageIndex());
		paginationInfo.setRecordCountPerPage(loginLog.getPageUnit());
		paginationInfo.setPageSize(loginLog.getPageSize());
		
		loginLog.setFirstIndex(paginationInfo.getFirstRecordIndex());
		loginLog.setLastIndex(paginationInfo.getLastRecordIndex());
		loginLog.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		HashMap _map = (HashMap)logManageService.selectLoginLogInf(loginLog);
		int totCnt = Integer.parseInt((String)_map.get("resultCnt"));
		
		model.addAttribute("resultList", _map.get("resultList"));
		model.addAttribute("resultCnt", _map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "sym/log/EgovLoginLogList";
	}
	
	/**
	 * 로그인 로그 상세 조회
	 * 
	 * @param loginLog
	 * @param model
	 * @return sym/log/EgovLoginLogInqire
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/InqireLoginLog.do")
	public String selectLoginLog(@ModelAttribute("searchVO") LoginLog loginLog, 
			@RequestParam("logId") String logId,
			ModelMap model) throws Exception{
		
		loginLog.setLogId(logId.trim());
		
		LoginLog vo = logManageService.selectLoginLog(loginLog);
		model.addAttribute("result", vo);
		return "sym/log/EgovLoginLogInqire";
	}


	/**
	 * 웹 로그 목록 조회
	 * 
	 * @param webLog
	 * @return sym/log/EgovWebLogList
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/SelectWebLogList.do")
	public String selectWebLogInf(@ModelAttribute("searchVO") WebLog webLog, 
			ModelMap model) throws Exception{

		webLog.setPageUnit(propertyService.getInt("pageUnit"));
		webLog.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(webLog.getPageIndex());
		paginationInfo.setRecordCountPerPage(webLog.getPageUnit());
		paginationInfo.setPageSize(webLog.getPageSize());
		
		webLog.setFirstIndex(paginationInfo.getFirstRecordIndex());
		webLog.setLastIndex(paginationInfo.getLastRecordIndex());
		webLog.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		HashMap _map = (HashMap)logManageService.selectWebLogInf(webLog);
		int totCnt = Integer.parseInt((String)_map.get("resultCnt"));
		
		model.addAttribute("resultList", _map.get("resultList"));
		model.addAttribute("resultCnt", _map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "sym/log/EgovWebLogList";
	}
	
	/**
	 * 웹 로그 상세 조회
	 * 
	 * @param webLog
	 * @param model
	 * @return sym/log/EgovWebLogInqire
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/log/InqireWebLog.do")
	public String selectWebLog(@ModelAttribute("searchVO") WebLog webLog, 
			@RequestParam("requstId") String requstId,
			ModelMap model) throws Exception{
		
		webLog.setRequstId(requstId.trim());
		
		WebLog vo = logManageService.selectWebLog(webLog);
		model.addAttribute("result", vo);
		return "sym/log/EgovWebLogInqire";
	}

}
