package egovframework.com.sts.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.sts.service.EgovScrinStatsService;
import egovframework.com.sts.service.StatsVO;

/**
 * 화면 통계 검색 비즈니스 구현 클래스
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
@Service("scrinStatsService")
public class EgovScrinStatsServiceImpl extends AbstractServiceImpl implements
	EgovScrinStatsService {

    @Resource(name="scrinStatsDAO")
    private ScrinStatsDAO scrinStatsDAO;
    
    /**
	 * 화면 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
   public List<StatsVO> selectScrinStats(StatsVO vo) throws Exception {
       return scrinStatsDAO.selectScrinStats(vo);
	}
    
    /**
	 * 마일리지 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectMlgStats(StatsVO vo) throws Exception {
        return scrinStatsDAO.selectMlgStats(vo);
    }
    
    /**
	 * 이벤트 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectEvtStats(StatsVO vo) throws Exception {
        return scrinStatsDAO.selectEvtStats(vo);
    }
    
    /**
	 * 사용자별 이벤트 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectEvtStatsList(UserDefaultVO vo) throws Exception {
        return scrinStatsDAO.selectEvtStatsList(vo);
    }
    
    /**
	 * 기 등록된 특정 사용자목록의 전체수를 확인
	 * @param userSearchVO 검색조건
	 * @return 총사용자갯수(int)
	 * @throws Exception
	 */
	public int selectEvtStatsListCnt(UserDefaultVO vo) {
		return scrinStatsDAO.selectEvtStatsListCnt(vo);
	}
	
	/**
	 * 게시물 통계를 조회한다
	 * @param vo StatsVO
	 * @return List
	 * @exception Exception
	 */
    public List<StatsVO> selectBbsStats(StatsVO vo) throws Exception {
        return scrinStatsDAO.selectBbsStats(vo);
    }   
    
    /**
	 * 회원가입 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
    public StatsVO selectMbrStats(StatsVO vo) throws Exception {
        return scrinStatsDAO.selectMbrStats(vo);
    }
    
    /**
	 * 커뮤니티개설 통계를 조회한다
	 * @param vo StatsVO
	 * @return StatsVO
	 * @exception Exception
	 */
    public StatsVO selectCmyStats(StatsVO vo) throws Exception {
        return scrinStatsDAO.selectCmyStats(vo);
    }
    
}
