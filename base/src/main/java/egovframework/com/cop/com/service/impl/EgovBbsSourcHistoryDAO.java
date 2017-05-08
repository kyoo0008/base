package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.cop.com.service.BbsSourcVO;

/**
 * @Class Name : EgovBbsSourcHistoryDAO
 * @Description : EgovBbsSourcHistoryDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("BbsSourcHistoryDAO")
public class EgovBbsSourcHistoryDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsSourcHistory(BbsSourc vo) throws Exception {
        return (String)insert("BbsSourcHistoryDAO.insertBbsSourcHistory", vo);
    }

    /**
	 * COMTNBBSSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsSourcHistory(BbsSourc vo) throws Exception {
        delete("BbsSourcHistoryDAO.deleteBbsSourcHistory", vo);
    }

    /**
	 * COMTNBBSSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURCHISTORY
	 * @exception Exception
	 */
    public BbsSourc selectBbsSourcHistory(BbsSourc vo) throws Exception {
        return (BbsSourc) selectByPk("BbsSourcHistoryDAO.selectBbsSourcHistory", vo);
    }

    /**
	 * COMTNBBSSOURCHISTORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSSOURCHISTORY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<BbsSourc> selectBbsSourcHistoryList(BbsSourcVO searchVO) throws Exception {
        return list("BbsSourcHistoryDAO.selectBbsSourcHistoryList", searchVO);
    }

    /**
	 * COMTNBBSSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSSOURCHISTORY 총 갯수
	 * @exception
	 */
    public int selectBbsSourcHistoryListCnt(BbsSourcVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("BbsSourcHistoryDAO.selectBbsSourcHistoryListCnt", searchVO);
    }

}
