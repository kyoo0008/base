package egovframework.com.sym.log.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.com.sym.log.service.EgovLoginInfoService;
import egovframework.com.sym.log.service.LoginInfoVO;
import egovframework.com.sym.log.service.impl.EgovLoginInfoDAO;

/**
 * @Class Name : LoginInfoServiceImpl.java
 * @Description : LoginInfo Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121127
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovLoginInfoService")
public class EgovLoginInfoServiceImpl extends AbstractServiceImpl implements
        EgovLoginInfoService {

    @Resource(name="loginInfoDAO")
    private EgovLoginInfoDAO loginInfoDAO;
    
	/**
	 * COMTNLOGININFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLoginInfo(LoginInfoVO vo) throws Exception {
    	
    	loginInfoDAO.insertLoginInfo(vo);
    	    	
        return null;
    }

    /**
	 * COMTNLOGININFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 LoginInfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLoginInfo(LoginInfoVO vo) throws Exception {
        loginInfoDAO.updateLoginInfo(vo);
    }

    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLoginInfo(LoginInfoVO vo) throws Exception {
        loginInfoDAO.deleteLoginInfo(vo);
    }

    /**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return int
	 * @throws Exception
	 */
	public int selectLoginExistsForLoginIdntfcIdCnt(LoginInfoVO vo) throws Exception {		
		return loginInfoDAO.selectLoginExistsForLoginIdntfcIdCnt(vo);
	}
	
	/**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	public LoginInfoVO selectLoginExistsForSession(LoginInfoVO vo) throws Exception {		
		return loginInfoDAO.selectLoginExistsForSession(vo);
	}
	
	/**
	 * COMTNLOGININFO 를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	public LoginInfoVO selectLoginExistsForSiteId(LoginInfoVO vo) throws Exception {		
		return loginInfoDAO.selectLoginExistsForSiteId(vo);
	}
	
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LoginInfoVO
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    public List<LoginInfoVO> selectLoginInfoList(LoginInfoVO vo) throws Exception {
        return loginInfoDAO.selectLoginInfoList(vo);
    }
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    public List<LoginInfoVO> selectLogininfoRemoveTargetList() throws Exception {
        return loginInfoDAO.selectLogininfoRemoveTargetList();
    }
    
    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLogininfoRemoveTarget() throws Exception {
    	loginInfoDAO.deleteLogininfoRemoveTarget();
    }
}
