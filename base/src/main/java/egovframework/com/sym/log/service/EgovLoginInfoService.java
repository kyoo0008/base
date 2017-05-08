package egovframework.com.sym.log.service;

import java.util.List;

import egovframework.com.sym.log.service.LoginInfoVO;

/**
 * @Class Name : LoginInfoService.java
 * @Description : LoginInfo Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121127
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovLoginInfoService {
	
	/**
	 * COMTNLOGININFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLoginInfo(LoginInfoVO vo) throws Exception;
    
    /**
	 * COMTNLOGININFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 LoginInfoVO
	 * @return void형
	 * @exception Exception
	 */
    void updateLoginInfo(LoginInfoVO vo) throws Exception;
    
    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLoginInfo(LoginInfoVO vo) throws Exception;
    
    /**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return int
	 * @throws Exception
	 */
	int selectLoginExistsForLoginIdntfcIdCnt(LoginInfoVO vo) throws Exception;
	
	/**
	 * COMTNLOGININFO 목록의 숫자를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	LoginInfoVO selectLoginExistsForSession(LoginInfoVO vo) throws Exception;
	
	/**
	 * COMTNLOGININFO 를 조회한다.
	 * @param loginLog
	 * @return LoginInfoVO
	 * @throws Exception
	 */
	LoginInfoVO selectLoginExistsForSiteId(LoginInfoVO vo) throws Exception;
	
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LoginInfoVO
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    List<LoginInfoVO> selectLoginInfoList(LoginInfoVO vo) throws Exception;
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @return 조회한 COMTNLOGININFO
	 * @exception Exception
	 */
    List<LoginInfoVO> selectLogininfoRemoveTargetList() throws Exception ;
    
    /**
	 * COMTNLOGININFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 LoginInfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLogininfoRemoveTarget() throws Exception;
}
