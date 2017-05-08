package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.cop.com.service.LytSourcVO;

/**
 * @Class Name : EgovLytSourcHistoryDAO
 * @Description : EgovLytSourcHistoryDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("LytSourcHistoryDAO")
public class EgovLytSourcHistoryDAO extends EgovAbstractDAO {

	/**
	 * COMTNLYTSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytSourcHistory(LytSourc vo) throws Exception {
        return (String)insert("LytSourcHistoryDAO.insertLytSourcHistory", vo);
    }

    /**
	 * COMTNLYTSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytSourcHistory(LytSourc vo) throws Exception {
        delete("LytSourcHistoryDAO.deleteLytSourcHistory", vo);
    }

    /**
	 * COMTNLYTSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURCHISTORY
	 * @exception Exception
	 */
    public LytSourc selectLytSourcHistory(LytSourc vo) throws Exception {
        return (LytSourc) selectByPk("LytSourcHistoryDAO.selectLytSourcHistory", vo);
    }

    /**
	 * COMTNLYTSOURCHISTORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTSOURCHISTORY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LytSourc> selectLytSourcHistoryList(LytSourcVO searchVO) throws Exception {
        return list("LytSourcHistoryDAO.selectLytSourcHistoryList", searchVO);
    }

    /**
	 * COMTNLYTSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTSOURCHISTORY 총 갯수
	 * @exception
	 */
    public int selectLytSourcHistoryListCnt(LytSourcVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("LytSourcHistoryDAO.selectLytSourcHistoryListCnt", searchVO);
    }

}
