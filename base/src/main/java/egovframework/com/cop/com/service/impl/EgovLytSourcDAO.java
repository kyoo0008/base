package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.cop.com.service.LytSourcVO;

/**
 * @Class Name : EgovLytSourcDAO
 * @Description : EgovLytSourcDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("LytSourcDAO")
public class EgovLytSourcDAO extends EgovAbstractDAO {

	/**
	 * COMTNLYTSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytSourc(LytSourc vo) throws Exception {
        return (String)insert("LytSourcDAO.insertLytSourc", vo);
    }

    /**
	 * COMTNLYTSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlytsourcVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLytSourc(LytSourc vo) throws Exception {
        update("LytSourcDAO.updateLytSourc", vo);
    }

    /**
	 * COMTNLYTSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytSourc(LytSourc vo) throws Exception {
        delete("LytSourcDAO.deleteLytSourc", vo);
    }

    /**
	 * COMTNLYTSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURC
	 * @exception Exception
	 */
    public LytSourc selectLytSourc(LytSourc vo) throws Exception {
        return (LytSourc) selectByPk("LytSourcDAO.selectLytSourc", vo);
    }

    /**
	 * COMTNLYTSOURC 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTSOURC 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<LytSourc> selectLytSourcList(LytSourcVO searchVO) throws Exception {
        return list("LytSourcDAO.selectLytSourcList", searchVO);
    }

    /**
	 * COMTNLYTSOURC 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNLYTSOURC 총 갯수
	 * @exception
	 */
    public int selectLytSourcListCnt(LytSourcVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("LytSourcDAO.selectLytSourcListCnt", searchVO);
    }

}
