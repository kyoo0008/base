package egovframework.com.sym.log.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.sym.log.service.DataUseLog;
import egovframework.com.sym.log.service.EgovLogManageService;
import egovframework.com.sym.log.service.LoginLog;
import egovframework.com.sym.log.service.WebLog;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : EgovLogManageServiceImpl.java
 * @Description : 시스템 로그 관리를 위한 서비스 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Service("EgovLogManageService")
public class EgovLogManageServiceImpl extends AbstractServiceImpl implements
		EgovLogManageService {

	@Resource(name="logManageDAO")
	private LogManageDAO logManageDAO;	
	
    /**
	 * ID Generation
	 */    
	@Resource(name="egovLoginLogIdGnrService")
	private EgovIdGnrService egovLoginLogIdGnrService;

	@Resource(name="egovWebLogIdGnrService")
	private EgovIdGnrService egovWebLogIdGnrService;
	
	@Resource(name="egovDataUseLogIdGnrService")
	private EgovIdGnrService egovDataUseLogIdGnrService;

	/**
	 * 접속로그를 기록한다.
	 * 
	 * @param LoginLog
	 */
	public void logInsertLoginLog(LoginLog loinLog) throws Exception {
		// TODO Auto-generated method stub
		String logId = egovLoginLogIdGnrService.getNextStringId();
		loinLog.setLogId(logId);
		
		logManageDAO.logInsertLoginLog(loinLog);    	

	}

	/**
	 * 시스템 로그정보를 요약한다.
	 * 
	 * @param 
	 */
	public void logInsertSysLogSummary()
			throws Exception {
		// TODO Auto-generated method stub

		logManageDAO.logInsertSysLogSummary();    	
	}

	/**
	 * 웹 로그를 기록한다.
	 * 
	 * @param WebLog
	 */
	public void logInsertWebLog(WebLog webLog) throws Exception {
		// TODO Auto-generated method stub
		String requstId = egovWebLogIdGnrService.getNextStringId();
		webLog.setRequstId(requstId);
		
		logManageDAO.logInsertWebLog(webLog);    	
	}

	/**
	 * 웹 로그정보를 요약한다.
	 * 
	 * @param 
	 */
	public void logInsertWebLogSummary()
			throws Exception {
		// TODO Auto-generated method stub

		logManageDAO.logInsertWebLogSummary();    	
	}

	/**
	 * 송수신 로그정보를 요약한다.
	 * 
	 * @param 
	 */
	public void logInsertTrsmrcvLogSummary()
			throws Exception {
		// TODO Auto-generated method stub
		
		logManageDAO.logInsertTrsmrcvLogSummary();    	
	}
	
	/**
	 * 사용자 로그정보를 생성한다.
	 * 
	 * @param 
	 */
	public void logInsertUserLog() throws Exception {
		// TODO Auto-generated method stub

		logManageDAO.logInsertUserLog();    	
	}

	/**
	 * 접속로그를 조회한다.
	 * 
	 * @param loginLog
	 * @return loginLog
	 * @throws Exception 
	 */
	public LoginLog selectLoginLog(LoginLog loginLog) throws Exception{
		
		return logManageDAO.selectLoginLog(loginLog);
	}	

	/**
	 * 접속로그 목록을 조회한다.
	 * 
	 * @param LoginLog
	 */
	public Map selectLoginLogInf(LoginLog loinLog) throws Exception {
		// TODO Auto-generated method stub
		List _result = logManageDAO.selectLoginLogInf(loinLog);
		int _cnt = logManageDAO.selectLoginLogInfCnt(loinLog);
		 
		Map<String, Object> _map = new HashMap();
		_map.put("resultList", _result);
		_map.put("resultCnt", Integer.toString(_cnt));
		 
		return _map;
	}

	/**
	 * 웹 로그정보를 조회한다.
	 * 
	 * @param webLog
	 * @return webLog
	 * @throws Exception 
	 */
	public WebLog selectWebLog(WebLog webLog) throws Exception{
		
		return logManageDAO.selectWebLog(webLog);
	}	

	/**
	 * 웹 로그정보 목록을 조회한다.
	 * 
	 * @param WebLog
	 */
	public Map selectWebLogInf(WebLog webLog) throws Exception {
		// TODO Auto-generated method stub

		List _result = logManageDAO.selectWebLogInf(webLog);
		int _cnt = logManageDAO.selectWebLogInfCnt(webLog);
		 
		Map<String, Object> _map = new HashMap();
		_map.put("resultList", _result);
		_map.put("resultCnt", Integer.toString(_cnt));
		 
		return _map;
	}


	/**
	 * 마일리지 로그정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertMlgLogSummary() throws Exception{
		logManageDAO.logInsertMlgLogSummary();
	}
	
	/**
	 * 게시물정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertBbsSummary() throws Exception{
		logManageDAO.logInsertBbsSummary();
	}
	
	/**
	 * 데이터사용 로그를 기록한다.
	 * 
	 * @param DataUseLog
	 * @return
	 * @throws Exception 
	 */
	public void logInsertDataUseLog(DataUseLog dataUseLog) throws Exception{
		dataUseLog.setDtaUseId(egovDataUseLogIdGnrService.getNextStringId());
		logManageDAO.logInsertDataUseLog(dataUseLog);
	}
}
