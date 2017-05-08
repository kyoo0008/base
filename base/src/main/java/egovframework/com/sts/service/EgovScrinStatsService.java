package egovframework.com.sts.service;

import java.util.List;
import egovframework.com.uss.umt.service.UserDefaultVO;

/**
 * 화면 통계 검색 비즈니스 인터페이스 클래스
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
public interface EgovScrinStatsService {
	
	/**
	 * 화면 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
	List<StatsVO> selectScrinStats(StatsVO vo) throws Exception;
	
	/**
	 * 마일리지 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectMlgStats(StatsVO vo) throws Exception ;
    
    /**
	 * 이벤트 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectEvtStats(StatsVO vo) throws Exception ;
    
    /**
	 * 이벤트 사용자 통계를 조회한다
	 * @param vo UserDefaultVO
	 * @return List
	 * @exception Exception
	 */
    List selectEvtStatsList(UserDefaultVO vo) throws Exception;
    
    /**
	 * 이벤트 사용자 통계갯수를 조회한다.
	 * @param userSearchVO 검색조건
	 * @return 총 사용자갯수(int)
	 * @throws Exception
	 */
	public int selectEvtStatsListCnt(UserDefaultVO vo) throws Exception;
	
	/**
	 * 게시물 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectBbsStats(StatsVO vo) throws Exception;
    
    /**
	 * 회원가입 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
    public StatsVO selectMbrStats(StatsVO vo) throws Exception;
    
    /**
	 * 커뮤니티개설 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
    public StatsVO selectCmyStats(StatsVO vo) throws Exception;
    
}
