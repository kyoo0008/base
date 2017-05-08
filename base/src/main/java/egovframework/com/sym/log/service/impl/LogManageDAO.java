package egovframework.com.sym.log.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.sym.log.service.DataUseLog;
import egovframework.com.sym.log.service.LoginLog;
import egovframework.com.sym.log.service.WebLog;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : LogManageDAO.java
 * @Description : 시스템 로그 관리를 위한 데이터 접근 클래스
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
@Repository("logManageDAO")
public class LogManageDAO extends EgovAbstractDAO {

	/**
	 * 접속로그를 기록한다.
	 * 
	 * @param LoginLog
	 * @return
	 * @throws Exception 
	 */
	public void logInsertLoginLog(LoginLog loginLog) throws Exception{
		insert("LogManageDAO.logInsertLoginLog", loginLog);
	}

	/**
	 * 시스템 로그정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertSysLogSummary() throws Exception{
		insert("LogManageDAO.logInsertSysLogSummary", null);
		delete("LogManageDAO.logDeleteSysLogSummary", null);
	}

	/**
	 * 웹 로그를 기록한다.
	 * 
	 * @param WebLog
	 * @return
	 * @throws Exception 
	 */
	public void logInsertWebLog(WebLog webLog) throws Exception{
		insert("LogManageDAO.logInsertWebLog", webLog);
	}

	/**
	 * 웹 로그정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertWebLogSummary() throws Exception{
		insert("LogManageDAO.logInsertWebLogSummary", null);
		delete("LogManageDAO.logDeleteWebLogSummary", null);
	}

	/**
	 * 송수신 로그정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertTrsmrcvLogSummary() throws Exception{
		insert("LogManageDAO.logInsertTrsmrcvLogSummary", null);
		delete("LogManageDAO.logDeleteTrsmrcvLogSummary", null);
	}

	/**
	 * 사용자 로그정보를 생성한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertUserLog() throws Exception{
		insert("LogManageDAO.logInsertUserLog", null);
	}

	/**
	 * 접속로그를 조회한다.
	 * 
	 * @param loginLog
	 * @return loginLog
	 * @throws Exception 
	 */
	public LoginLog selectLoginLog(LoginLog loginLog) throws Exception{
		
		return (LoginLog) selectByPk("LogManageDAO.selectLoginLog", loginLog);
	}	

	/**
	 * 접속로그를 목록을 조회한다.
	 * 
	 * @param loginLog
	 * @return
	 * @throws Exception 
	 */
	public List selectLoginLogInf(LoginLog loginLog) throws Exception{
		return list("LogManageDAO.selectLoginLogInf", loginLog);
	}

	/**
	 * 접속로그 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return
	 * @throws Exception
	 */
	public int selectLoginLogInfCnt(LoginLog loginLog) throws Exception{
		
		return (Integer)getSqlMapClientTemplate().queryForObject("LogManageDAO.selectLoginLogInfCnt", loginLog);
	}
	
	/**
	 * 웹 로그정보를 조회한다.
	 * 
	 * @param webLog
	 * @return webLog
	 * @throws Exception 
	 */
	public WebLog selectWebLog(WebLog webLog) throws Exception{
		
		return (WebLog) selectByPk("LogManageDAO.selectWebLog", webLog);
	}	

	/**
	 * 웹 로그정보 목록을 조회한다.
	 * 
	 * @param webLog
	 * @return
	 * @throws Exception 
	 */
	public List selectWebLogInf(WebLog webLog) throws Exception{
		return list("LogManageDAO.selectWebLogInf", webLog);
	}

	/**
	 * 웹 로그정보 목록의 숫자를 조회한다.
	 * @param webLog
	 * @return
	 * @throws Exception
	 */
	public int selectWebLogInfCnt(WebLog webLog) throws Exception{
		
		return (Integer)getSqlMapClientTemplate().queryForObject("LogManageDAO.selectWebLogInfCnt", webLog);
	}
	
	/**
	 * 마일리지 로그정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertMlgLogSummary() throws Exception{
		insert("LogManageDAO.logInsertMlgLogSummary", null);
	}
	
	/**
	 * 게시물정보를 요약한다.
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void logInsertBbsSummary() throws Exception{
		insert("LogManageDAO.logInsertBbsSummary", null);
	}
	
	/**
	 * 데이터사용 로그를 기록한다.
	 * 
	 * @param DataUseLog
	 * @return
	 * @throws Exception 
	 */
	public void logInsertDataUseLog(DataUseLog dataUseLog) throws Exception{
		insert("LogManageDAO.logInsertDataUseLog", dataUseLog);
	}
}
