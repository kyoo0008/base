package egovframework.com.sym.mpm.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 메뉴 관리를 위한 데이터 접근 클래스
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2010.12.27  정정욱          최초 생성
 *
 * </pre>
 */
@Repository("MpmManageDAO")
public class MpmDAO extends EgovAbstractDAO {

   
	/**
     * 상위메뉴에 대한 하위메뉴 건수를 조회 한다.
     * 
     * @param Mpm
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(Mpm mpm) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("MpmManageDAO.selectChildMpmCnt", mpm);
    }
    
    /**
     * 메뉴정보를 등록한다.
     * 
     * @param Mpm
     */
    public void insertMpm(Mpm mpm) throws Exception {
	 insert("MpmManageDAO.insertMpm", mpm);
    }
    
    /**
     * 전체메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    @SuppressWarnings("unchecked")
    public List<Mpm> selectFullMpmList(MpmVO vo) throws Exception {
	return list("MpmManageDAO.selectFullMpmList", vo);
    }
    
    /**
     * 메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    @SuppressWarnings("unchecked")
    public List<Mpm> selectMpmList(MpmVO vo) throws Exception {
	return list("MpmManageDAO.selectMpmList", vo);
    }
    
    /**
     * 메뉴상세 내용을 조회 한다.
     * 
     * @param MpmVO
     */
    public MpmVO selectMpm(MpmVO vo) throws Exception {
	return (MpmVO)selectByPk("MpmManageDAO.selectMpm", vo);
    }
    
    /**
     * 메뉴정보를 수정한다.
     * 
     * @param Mpm
     */
    public void updateMpm(Mpm mpm) throws Exception {
	update("MpmManageDAO.updateMpm", mpm);
    }	
    
    /**
     * 메뉴정보를 삭제한다.
     * 
     * @param Mpm
     */
    public void deleteMpm(Mpm mpm) throws Exception {
    	delete("MpmManageDAO.deleteMpm", mpm);
    }	
    
    /**
     * 모든 서브메뉴정보를 삭제한다.
     * 
     * @param Mpm
     */
    public void deleteAllSbMpm(Mpm mpm) throws Exception {
    	delete("MpmManageDAO.deleteAllSbMpm", mpm);
    }	
    
    /**
     * 메뉴 정렬순서를 수정한다.
     * 
     * @param Mpm
     */
    public int updateMpmSortOrdr(Mpm mpm) throws Exception {
    	return update("MpmManageDAO.updateMpmSortOrdr", mpm);
    }	
    
    
    /**
     * 서비스용 메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    @SuppressWarnings("unchecked")
    public List<Mpm> selectMpmServiceList(MpmVO vo) throws Exception {
	return list("MpmManageDAO.selectMpmServiceList", vo);
    }
    
    /**
     * 서비스용 프로그램ID로 메뉴아이디를 조회한다.
     * 
     * @param MpmVO
     */
    public String selectMpmByProgrmId(MpmVO vo) throws Exception {
	return (String)selectByPk("MpmManageDAO.selectMpmByProgrmId", vo);
    }
    
    
    /**
     * 메뉴명를 수정한다.
     * 
     * @param Mpm
     */
    public int updateMpmMenuNm(Mpm mpm) throws Exception {
    	return update("MpmManageDAO.updateMpmMenuNm", mpm);
    }	
    
    /**
     * 메뉴를 일괄등록한다.
     * 
     * @param mpmList
     * @return
     * @throws Exception
     */
    public void insertMpmBatch(final List<Mpm> mpmList) throws Exception {
    	
    	if(mpmList != null && mpmList.size() > 0) {
	    	getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              for(int i = 0; i < mpmList.size(); i++) {
		            	  insert("MpmManageDAO.insertMpm", mpmList.get(i));
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		    });
    	}
    	
    }
}
