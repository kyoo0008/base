package egovframework.com.sym.mpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : MpmHistoryDAO
 * @Description : MpmHistoryDAO DAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 2012-09-25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("MpmHistoryDAO")
public class MpmHistoryDAO extends EgovAbstractDAO {

	/**
	 * COMTHSITEMNUHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComthsitemnuhistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMpmHistory(Mpm vo) throws Exception {
        return (String)insert("MpmHistoryDAO.insertMpmHistory", vo);
    }

    /**
	 * COMTHSITEMNUHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComthsitemnuhistoryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMpmHistory(Mpm vo) throws Exception {
        delete("MpmHistoryDAO.deleteMpmHistory", vo);
    }

    /**
	 * COMTHSITEMNUHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComthsitemnuhistoryVO
	 * @return 조회한 COMTHSITEMNUHISTORY
	 * @exception Exception
	 */
    public MpmVO selectMpmHistory(MpmVO vo) throws Exception {
        return (MpmVO) selectByPk("MpmHistoryDAO.selectMpmHistory", vo);
    }

    /**
	 * COMTHSITEMNUHISTORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTHSITEMNUHISTORY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<Mpm> selectMpmHistoryList(MpmVO searchVO) throws Exception {
        return list("MpmHistoryDAO.selectMpmHistoryList", searchVO);
    }

    /**
	 * COMTHSITEMNUHISTORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTHSITEMNUHISTORY 총 갯수
	 * @exception
	 */
    public int selectMpmHistoryListCnt(MpmVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("MpmHistoryDAO.selectMpmHistoryListCnt", searchVO);
    }

}
