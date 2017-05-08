package egovframework.com.cop.com.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.cop.com.service.BbsSourcVO;

/**
 * @Class Name : EgovBbsSourcDAO
 * @Description : EgovBbsSourcDAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("BbsSourcDAO")
public class EgovBbsSourcDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsSourc(BbsSourc vo) throws Exception {
        return (String)insert("BbsSourcDAO.insertBbsSourc", vo);
    }

    /**
	 * COMTNBBSSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbssourcVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateBbsSourc(BbsSourc vo) throws Exception {
        update("BbsSourcDAO.updateBbsSourc", vo);
    }

    /**
	 * COMTNBBSSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsSourc(BbsSourc vo) throws Exception {
        delete("BbsSourcDAO.deleteBbsSourc", vo);
    }

    /**
	 * COMTNBBSSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURC
	 * @exception Exception
	 */
    public BbsSourc selectBbsSourc(BbsSourc vo) throws Exception {
        return (BbsSourc) selectByPk("BbsSourcDAO.selectBbsSourc", vo);
    }

    /**
	 * COMTNBBSSOURC 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSSOURC 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<BbsSourc> selectBbsSourcList(BbsSourcVO searchVO) throws Exception {
        return list("BbsSourcDAO.selectBbsSourcList", searchVO);
    }

    /**
	 * COMTNBBSSOURC 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSSOURC 총 갯수
	 * @exception
	 */
    public int selectBbsSourcListCnt(BbsSourcVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("BbsSourcDAO.selectBbsSourcListCnt", searchVO);
    }

}
