package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.cop.com.service.BbsTmplatVO;

/**
 * @Class Name : EgovBbsTmplatDAO
 * @Description : EgovBbsTmplatDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("BbsTmplatDAO")
public class EgovBbsTmplatDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsTmplat(BbsTmplat vo) throws Exception {
        return (String)insert("BbsTmplatDAO.insertBbsTmplat", vo);
    }

    /**
	 * COMTNBBSTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateBbsTmplat(BbsTmplat vo) throws Exception {
        update("BbsTmplatDAO.updateBbsTmplat", vo);
    }

    /**
	 * COMTNBBSTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsTmplat(BbsTmplat vo) throws Exception {
        delete("BbsTmplatDAO.deleteBbsTmplat", vo);
    }

    /**
	 * COMTNBBSTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLAT
	 * @exception Exception
	 */
    public BbsTmplat selectBbsTmplat(BbsTmplat vo) throws Exception {
        return (BbsTmplat) selectByPk("BbsTmplatDAO.selectBbsTmplat", vo);
    }

    /**
	 * COMTNBBSTMPLAT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSTMPLAT 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<BbsTmplat> selectBbsTmplatList(BbsTmplatVO searchVO) throws Exception {
        return list("BbsTmplatDAO.selectBbsTmplatList", searchVO);
    }

    /**
	 * COMTNBBSTMPLAT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSTMPLAT 총 갯수
	 * @exception
	 */
    public int selectBbsTmplatListCnt(BbsTmplatVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("BbsTmplatDAO.selectBbsTmplatListCnt", searchVO);
    }

}
