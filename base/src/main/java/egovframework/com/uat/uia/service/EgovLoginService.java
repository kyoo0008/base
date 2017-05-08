package egovframework.com.uat.uia.service;

import java.util.List;
import java.util.Map;

import egovframework.com.sym.log.service.LoginInfoVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
public interface EgovLoginService {
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO actionLogin(LoginVO vo) throws Exception;
    
    /**
	 * 인증서 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO actionCrtfctLogin(LoginVO vo) throws Exception;
    
    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO searchId(LoginVO vo) throws Exception;
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    Map<String, Object> searchPassword(LoginVO vo, boolean update) throws Exception;
    
    /**
	 * 아이디로 사용자정보를 찾는다.
	 * @param userId String
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO searchSSOLogin(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * 로그아웃 아이디를 추가한다.
	 * @param userId String
	 * @exception Exception
	 */
    void addLogoutList(LoginInfoVO loginInfoVO) throws Exception ;
    
    /**
	 * 로그아웃 아이디를 삭제한다.
	 * @param userId String
	 * @exception Exception
	 */
    void removeLogoutList(LoginInfoVO loginInfoVO) throws Exception ;
    
    /**
	 * 로그아웃 아이디를 조회한다.
	 * @param userId String
	 * @return boolean
	 * @exception Exception
	 */
    boolean getLogoutListExists(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * COMTNLOGININFO을조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    int selectLoginExistsForLoginIdntfcIdCnt(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    LoginInfoVO selectLoginExistsForSession(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * COMTNLOGININFO을 조회한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    LoginInfoVO selectLoginExistsForSiteId(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * COMTNLOGININFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLoginInfo(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * 로그인한 사이트에 로그아웃을 요청한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    void allSiteLogoutRequest(LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * 로그인 정보를 삭제한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    void deleteLoginInfo (LoginInfoVO loginInfoVO) throws Exception;
    
    /**
	 * 삭제할 로그인 정보조회한다.
	 * @exception Exception
	 */
    List<LoginInfoVO> selectRemoveTargetList() throws Exception ;
    
    /**
	 * 로그인 정보를 삭제한다.
	 * @exception Exception
	 */
    void deleteLogininfoRemoveTarget() throws Exception;
    
    /**
	 * 로그인 정보를 수정한다.
	 * @param vo - 등록할 정보가 담긴 LoginInfoVO
	 * @exception Exception
	 */
    void updateLoginInfo (LoginInfoVO loginInfoVO) throws Exception;
}
