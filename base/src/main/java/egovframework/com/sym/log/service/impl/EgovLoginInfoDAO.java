package egovframework.com.sym.log.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.sym.log.service.LoginInfoVO;
import egovframework.com.sym.log.service.LoginLog;

/**
 * @Class Name : LoginInfoDAO.java
 * @Description : LoginInfo DAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121127
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("loginInfoDAO")
public class EgovLoginInfoDAO extends EgovAbstractDAO {

	/**
	 * COMTNLOGININFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLoginInfo(LoginInfoVO vo) throws Exception {
        return (String)insert("LoginInfoDAO.insertLoginInfo", vo);
    }

    /**
	 * COMTNLOGININFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 LoginInfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLoginInfo(LoginInfoVO vo) throws Exception {
        update("LoginInfoDAO.updateLoginInfo", vo);
    }

    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLoginInfo(LoginInfoVO vo) throws Exception {
        delete("LoginInfoDAO.deleteLoginInfo", vo);
    }

    /**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return int
	 * @throws Exception
	 */
	public int selectLoginExistsForLoginIdntfcIdCnt(LoginInfoVO vo) throws Exception {		
		return (Integer)getSqlMapClientTemplate().queryForObject("LoginInfoDAO.selectLoginExistsForLoginIdntfcIdCnt", vo);
	}
	
	/**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	public LoginInfoVO selectLoginExistsForSession(LoginInfoVO vo) throws Exception {		
		return (LoginInfoVO)getSqlMapClientTemplate().queryForObject("LoginInfoDAO.selectLoginExistsForSession", vo);
	}
	
	/**
	 * COMTNLOGININFO 를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	public LoginInfoVO selectLoginExistsForSiteId(LoginInfoVO vo) throws Exception {		
		return (LoginInfoVO)getSqlMapClientTemplate().queryForObject("LoginInfoDAO.selectLoginExistsForSiteId", vo);
	}
	
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LoginInfoVO
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LoginInfoVO> selectLoginInfoList(LoginInfoVO vo) throws Exception {
        return list("LoginInfoDAO.selectLoginInfo", vo);
    }
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LoginInfoVO> selectLogininfoRemoveTargetList() throws Exception {
        return list("LoginInfoDAO.selectLogininfoRemoveTargetList", null);
    }
    
    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLogininfoRemoveTarget() throws Exception {
        delete("LoginInfoDAO.deleteLogininfoRemoveTarget", null);
    }
}
