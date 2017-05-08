package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.cop.com.service.LytTmplatVO;

/**
 * @Class Name : EgovLytTmplatDAO
 * @Description : EgovLytTmplatDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("LytTmplatDAO")
public class EgovLytTmplatDAO extends EgovAbstractDAO {

	/**
	 * COMTNLYTTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytTmplat(LytTmplat vo) throws Exception {
        return (String)insert("LytTmplatDAO.insertLytTmplat", vo);
    }

    /**
	 * COMTNLYTTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLytTmplat(LytTmplat vo) throws Exception {
        update("LytTmplatDAO.updateLytTmplat", vo);
    }

    /**
	 * COMTNLYTTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytTmplat(LytTmplat vo) throws Exception {
        delete("LytTmplatDAO.deleteLytTmplat", vo);
    }

    /**
	 * COMTNLYTTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLAT
	 * @exception Exception
	 */
    public LytTmplat selectLytTmplat(LytTmplat vo) throws Exception {
        return (LytTmplat) selectByPk("LytTmplatDAO.selectLytTmplat", vo);
    }

    /**
	 * COMTNLYTTMPLAT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTTMPLAT 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LytTmplat> selectLytTmplatList(LytTmplatVO searchVO) throws Exception {
        return list("LytTmplatDAO.selectLytTmplatList", searchVO);
    }

    /**
	 * COMTNLYTTMPLAT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTTMPLAT 총 갯수
	 * @exception
	 */
    public int selectLytTmplatListCnt(LytTmplatVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("LytTmplatDAO.selectLytTmplatListCnt", searchVO);
    }

}
