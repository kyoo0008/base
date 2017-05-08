package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.cop.com.service.BbsTmplatVO;

/**
 * @Class Name : EgovBbsTmplatHistoryDAO
 * @Description : EgovBbsTmplatHistoryDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("BbsTmplatHistoryDAO")
public class EgovBbsTmplatHistoryDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsTmplatHistory(BbsTmplat vo) throws Exception {
        return (String)insert("BbsTmplatHistoryDAO.insertBbsTmplatHistory", vo);
    }

    /**
	 * COMTNBBSTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsTmplatHistory(BbsTmplat vo) throws Exception {
        delete("BbsTmplatHistoryDAO.deleteBbsTmplatHistory", vo);
    }

    /**
	 * COMTNBBSTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLATHISTORY
	 * @exception Exception
	 */
    public BbsTmplat selectBbsTmplatHistory(BbsTmplat vo) throws Exception {
        return (BbsTmplat) selectByPk("BbsTmplatHistoryDAO.selectBbsTmplatHistory", vo);
    }

    /**
	 * COMTNBBSTMPLATHISTORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSTMPLATHISTORY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<BbsTmplat> selectBbsTmplatHistoryList(BbsTmplatVO searchVO) throws Exception {
        return list("BbsTmplatHistoryDAO.selectBbsTmplatHistoryList", searchVO);
    }

    /**
	 * COMTNBBSTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSTMPLATHISTORY 총 갯수
	 * @exception
	 */
    public int selectBbsTmplatHistoryListCnt(BbsTmplatVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("BbsTmplatHistoryDAO.selectBbsTmplatHistoryListCnt", searchVO);
    }

}
