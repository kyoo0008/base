package egovframework.com.sts.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.sts.service.StatsVO;
import egovframework.com.uss.umt.service.UserDefaultVO;

/**
 * 화면 통계 검색 DAO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Repository("scrinStatsDAO")
public class ScrinStatsDAO extends EgovAbstractDAO {

	/**
	 * 화면 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public List<StatsVO> selectScrinStats(StatsVO vo) throws Exception {
        return list("ScrinStatsDAO.selectScrinStats", vo);
    }
		
	/**
	 * 마일리지 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public List<StatsVO> selectMlgStats(StatsVO vo) throws Exception {
        return list("MlgStatsDAO.selectMlgStats", vo);
    }    
    
	/**
	 * 이벤트 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public List<StatsVO> selectEvtStats(StatsVO vo) throws Exception {
        return list("EvtStatsDAO.selectEvtStats", vo);
    }
	
	/**
	 * 사용자별 이벤트 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public List<StatsVO> selectEvtStatsList(UserDefaultVO vo) throws Exception {
        return list("EvtStatsDAO.selectEvtUserStats", vo);
    }
	
	/**
     *  사용자별 이벤트 통계 갯수를 조회한다.
     * @param vo 검색조건
     * @return int 사용자 총갯수
     */
    public int selectEvtStatsListCnt(UserDefaultVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("EvtStatsDAO.selectEvtUserStatsCnt", vo);
    }
    
    /**
	 * 게시물 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public List<StatsVO> selectBbsStats(StatsVO vo) throws Exception {
        return list("BbsStatsDAO.selectBbsStats", vo);
    }   
	
	/**
	 * 회원가입 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public StatsVO selectMbrStats(StatsVO vo) throws Exception {
        return (StatsVO) selectByPk("StatsDAO.selectMbrStats", vo);
    } 
	
	/**
	 * 커뮤니티개설 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
    public StatsVO selectCmyStats(StatsVO vo) throws Exception {
        return (StatsVO) selectByPk("StatsDAO.selectCmyStats", vo);
    } 
	
}
