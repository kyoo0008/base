package egovframework.com.uss.umt.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import java.sql.SQLException;
import java.util.List;

import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 사용자관리에 관한 데이터 접근 클래스를 정의한다.
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
@Repository("userManageDAO")
public class UserManageDAO extends EgovAbstractDAO{
	
    protected Log log = LogFactory.getLog(this.getClass());

    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(실명인증)
     * @param checkId 중복체크대상 아이디
     * @return int 사용가능여부(아이디 사용회수 )
     */
    public int checkDiDplct(String credtId) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("userManageDAO.checkDiDplct", credtId);
    }
    
    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
     * @param uniqId 상세조회대상 사용자아이디
     * @return UserManageVO 사용자  상세정보
     */
    public UserManageVO checkUserDplct(String credtId) throws Exception {
        return (UserManageVO) selectByPk("userManageDAO.checkUserDplct", credtId);
    }
    
    /**
     * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
     * @param checkId 중복체크대상 아이디
     * @return int 사용가능여부(아이디 사용회수 )
     */
    public int checkIdDplct(String checkId) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("userManageDAO.checkIdDplct", checkId);
    }
    
    /**
     * 화면탈퇴처리를 한다.
     * @param userManageVO
     */
    public int deleteUser(UserManageVO userManageVO) throws Exception {
        return update("userManageDAO.deleteUser", userManageVO);
    }
    
    /**
     * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
     * @param userManageVO 사용자 등록정보
     * @return String result 등록결과 
     */
    public String insertUser(UserManageVO userManageVO) throws Exception {
        return (String)insert("userManageDAO.insertUser", userManageVO);
    }

    /**
     * 기 등록된 사용자 중 검색조건에 맞는 사용자들의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param uniqId 상세조회대상 사용자아이디
     * @return UserManageVO 사용자  상세정보
     */
    public UserManageVO selectUser(String userId) throws Exception {
        return (UserManageVO) selectByPk("userManageDAO.selectUser", userId);
    }

    /**
     * 기 등록된 특정 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    public List<?> selectUserList(UserManageVO userSearchVO) throws Exception {
        return list("userManageDAO.selectUserList", userSearchVO);
    }
    
    /**
	 * 20130225 이재현 회원가입시 학교목록을 조회한다
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    public List<?> selectSchool() throws Exception {
    	return list("userManageDAO.selectSchool", "");
    }

    /**
     * 학교 소속을 및 정보를 갖고 온다
     * @param userSearchVO
     * @return
     * @throws Exception
     */
    public List<?> selectUserSchoolList(UserManageVO userSearchVO) throws Exception {
    	return list("userManageDAO.selectUserSchoolList", userSearchVO);
    }
    
    /**
     * 사용자총 갯수를 조회한다.
     * @param userSearchVO 검색조건
     * @return int 사용자 총갯수
     */
    public int selectUserListTotCnt(UserManageVO userSearchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("userManageDAO.selectUserListTotCnt", userSearchVO);
    }
    
    /**
     * 화면에 조회된 사용자의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
     * @param userManageVO 사용자 수정정보
     */
    public int updateUser(UserManageVO userManageVO) throws Exception {
        return update("userManageDAO.updateUser",userManageVO);
    }
    
    /**
     * 화면에 조회된 사용자의 정보를 변경한다.
     * @param userManageVO
     */
    public int updateManageUser(UserManageVO userManageVO) throws Exception {
    	return update("userManageDAO.updateManageUser", userManageVO);
    }
    
    /**
     * 사용자 암호수정
     * @param passVO 사용자수정정보(비밀번호)
     */
    public int updatePassword(UserManageVO passVO) throws Exception {
    	return update("userManageDAO.updatePassword", passVO);
    }
    
    public UserManageVO selectLoingUser(String userId) throws Exception {
    	return (UserManageVO) selectByPk("userManageDAO.selectLoingUser", userId);
    }
    
    /**
	 * 개인정보 보호를 위한 확인(아이디, 페스워드)
	 * @param passVO 회원의 암호 확인 조회조건정보
	 * @return userManageVO 회원의 암호 확인 조회조건정보
	 * @throws Exception
	 */
    public int selectCheckPassword(UserManageVO userManageVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("userManageDAO.selectCheckPassword", userManageVO);
    }
    
    /**
     * 권한 사용자 목록을 조회한다
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    public List selectUserAuthList(UserManageVO userSearchVO) throws Exception {
        return list("userManageDAO.selectUserAuthList", userSearchVO);
    }
    
    /**
     * 권한 사용자 목록 총 갯수를 조회한다
     * @param userSearchVO 검색조건
     * @return int 사용자 총갯수
     */
    public int selectUserAuthListTotCnt(UserManageVO userSearchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("userManageDAO.selectUserAuthListTotCnt", userSearchVO);
    }

    /**
     * 선택한 사용자 목록을 접속금지 처리 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRhibt(UserManageVO userManageVO) throws Exception {
        update("userManageDAO.updateUserRhibt", userManageVO);
    }
    
    /**
     * 해당 사용자를 접속금지 해제 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRelis(UserManageVO userManageVO) throws Exception {
        update("userManageDAO.updateUserRelis", userManageVO);
    }
    
    /**
     * 임시사용자 데이터를 데이터베이스에 저장
     * @param userTmpList 사용자 등록정보
     */
    public void insertUserTmpBatch(final List<UserManageVO> userTmpList) throws Exception {
    	if(userTmpList != null && userTmpList.size() > 0) {
	    	getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              for(int i = 0; i < userTmpList.size(); i++) {
		            	  insert("userManageDAO.insertUserTmp", userTmpList.get(i));
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		    });
    	}
    }
    
    /**
     * 임시사용자 데이터를 사용자 데이터베이스에 저장
     * @param userManageVO 사용자 등록정보
     * @return String result 등록결과 
     */
    public void insertUserForTmp(UserManageVO userManageVO) throws Exception {
    	insert("userManageDAO.insertUserForTmp", userManageVO);
    }
    
    /**
     * 임시사용자 데이터의 에러목록을 조회한다.
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    @SuppressWarnings("unchecked")
    public List<UserManageVO> selectUserTmpErrorList(UserManageVO userSearchVO) throws Exception {
        return list("userManageDAO.selectUserTmpErrorList", userSearchVO);
    }
    
    /**
     * 임시사용자 데이터의 중복된 아이디목록을 조회한다.
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    @SuppressWarnings("unchecked")
    public List<UserManageVO> selectUserTmpDplctList(UserManageVO userSearchVO) throws Exception {
        return list("userManageDAO.selectUserTmpDplctList", userSearchVO);
    }
    
    /**
     * 임시사용자 데이터를 학사관리 데이터베이스에 저장
     * @param userManageVO 사용자 등록정보
     * @return String result 등록결과 
     */
    public void insertUserTmpForSrm(UserManageVO userManageVO) throws Exception {
    	insert("userManageDAO.insertUserTmpForSrm", userManageVO);
    }
    
    /**
     * 임시사용자 데이터삭제한다.
     * @param userManageVO 사용자 등록정보
     * @return int result 삭제결과 
     */
    public int deleteUserTmp(UserManageVO userManageVO) throws Exception {
    	return delete("userManageDAO.deleteUserTmp", userManageVO);
    }
}