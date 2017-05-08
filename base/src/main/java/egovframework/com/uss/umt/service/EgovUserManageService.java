package egovframework.com.uss.umt.service;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.InputStream;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.sec.rnc.service.RealhpVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * 사용자관리에 관한 인터페이스클래스를 정의한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
public interface EgovUserManageService  {
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(실명인증키)
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public int checkDiDplct(String credtId) throws Exception ;
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
	 * @param checkId 중복여부 확인대상 실명인증키
	 * @return 사용가능여부
	 * @throws Exception
	 */
	public UserManageVO checkUserDplct(String credtId) throws Exception ;
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public int checkIdDplct(String checkId) throws Exception ;
		
	/**
     * 화면탈퇴처리를 한다.
     * @param userManageVO
     */
    public int deleteUser(UserManageVO userManageVO) throws Exception;
	
	/**
	 * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param mberManageVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public void insertUser(UserManageVO userManageVO) throws Exception ;

	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param uniqId 상세조회대상 업무사용자 아이디
	 * @return userManageVO 업무사용자 상세정보
	 * @throws Exception
	 */
	public UserManageVO selectUser(String userId) throws Exception ;

	/**
	 * 기 등록된 특정 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	public List<?> selectUserList(UserManageVO userSearchVO) throws Exception ;

	/**
	 * 20130225 이재현 회원가입시 학교목록을 조회한다,
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 학교목록 조회한다.
	 * @throws Exception
	 */
	public List<?> selectSchool() throws Exception ;

	/**
	 * 학교소속 정보를 갖고 온다.
	 * @param userSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<?> selectUserSchoolList(UserManageVO userSearchVO) throws Exception;
	
	/**
	 * 기 등록된 특정 사용자목록의 전체수를 확인
	 * @param userSearchVO 검색조건
	 * @return 총사용자갯수(int)
	 * @throws Exception
	 */
	public int selectUserListTotCnt(UserManageVO userSearchVO) throws Exception ;
		
	/**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    public Map<String, Object> updateSendPassword(UserManageVO vo) throws Exception ;
    	
	/**
	 * 화면에 조회된 사용자의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param userManageVO 업무사용자 수정정보
	 * @throws Exception
	 */
	public int updateUser(UserManageVO userManageVO) throws Exception ;
	

    /**
     * 사용자 정보를 수정한다.
     * @param userManageVO 사용자 수정정보
     */
	public int updateManageUser(UserManageVO userManageVO) throws Exception ;
	
	/**
	 * 사용자 암호 수정
	 * @param userManageVO 사용자 수정정보(비밀번호)
	 * @throws Exception
	 */
	public int updatePassword(UserManageVO userManageVO) throws Exception ;
			
	public UserManageVO selectLoingUser(String userId) throws Exception ;
	
	/**
	 * 개인정보 보호를 위한 확인(아이디, 페스워드)
	 * @param passVO 회원의 암호 확인 조회조건정보
	 * @return userManageVO 회원의 암호 확인 조회조건정보
	 * @throws Exception
	 */
    public int selectCheckPassword(UserManageVO userManageVO) throws Exception;
    
	/**
     * 권한 사용자 목록을 조회한다
     * @param userSearchVO 검색조건
     * @return List 업무사용자 목록정보
     */
    public List selectUserAuthList(UserManageVO userSearchVO) throws Exception ;
    
    /**
     * 권한 사용자 총 갯수를 조회한다
     * @param userSearchVO 검색조건
     * @return int 업무사용자 총갯수
     */
    public int selectUserAuthListTotCnt(UserManageVO userSearchVO) throws Exception ;
    
    /**
     * 선택한 사용자 목록을 접속금지 처리 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRhibt(UserManageVO userManageVO) throws Exception ;
    
    /**
     * 해당 사용자를 접속금지 해제 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRelis(UserManageVO userManageVO) throws Exception ;
    
    /** 
	 * 사용자 엑셀파일을 일괄 업로드한다.
	 * @param  vo MenuManageVO  
	 * @param  inputStream InputStream  
	 * @exception Exception
	 */
	public Map<String, Object> insertUserExcelUpload(UserManageVO vo, String fileExt, InputStream inputStream) throws Exception;

}