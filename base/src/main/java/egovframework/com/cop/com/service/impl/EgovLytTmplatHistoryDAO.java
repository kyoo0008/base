package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.cop.com.service.LytTmplatVO;

/**
 * @Class Name : EgovLytTmplatHistoryDAO
 * @Description : EgovLytTmplatHistoryDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("LytTmplatHistoryDAO")
public class EgovLytTmplatHistoryDAO extends EgovAbstractDAO {

	/**
	 * COMTNLYTTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytTmplatHistory(LytTmplat vo) throws Exception {
        return (String)insert("LytTmplatHistoryDAO.insertLytTmplatHistory", vo);
    }

    /**
	 * COMTNLYTTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytTmplatHistory(LytTmplat vo) throws Exception {
        delete("LytTmplatHistoryDAO.deleteLytTmplatHistory", vo);
    }

    /**
	 * COMTNLYTTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLATHISTORY
	 * @exception Exception
	 */
    public LytTmplat selectLytTmplatHistory(LytTmplat vo) throws Exception {
        return (LytTmplat) selectByPk("LytTmplatHistoryDAO.selectLytTmplatHistory", vo);
    }

    /**
	 * COMTNLYTTMPLATHISTORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTTMPLATHISTORY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LytTmplat> selectLytTmplatHistoryList(LytTmplatVO searchVO) throws Exception {
        return list("LytTmplatHistoryDAO.selectLytTmplatHistoryList", searchVO);
    }

    /**
	 * COMTNLYTTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTTMPLATHISTORY 총 갯수
	 * @exception
	 */
    public int selectLytTmplatHistoryListCnt(LytTmplatVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("LytTmplatHistoryDAO.selectLytTmplatHistoryListCnt", searchVO);
    }

}
