package egovframework.com.cop.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.bbs.service.CtgryMaster;
import egovframework.com.cop.bbs.service.CtgryMasterVO;

/**
 * @Class Name : ComtnbbsctgrymasterDAO.java
 * @Description : Comtnbbsctgrymaster DAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("BBSCtgryMasterDAO")
public class BBSCtgryMasterDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSCTGRYMASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        return (String)insert("comtnbbsctgrymasterDAO.insertComtnbbsctgrymaster_S", vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        update("comtnbbsctgrymasterDAO.updateComtnbbsctgrymaster_S", vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        delete("comtnbbsctgrymasterDAO.deleteComtnbbsctgrymaster_S", vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 조회한 COMTNBBSCTGRYMASTER
	 * @exception Exception
	 */
    public CtgryMaster selectComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        return (CtgryMaster) selectByPk("comtnbbsctgrymasterDAO.selectComtnbbsctgrymaster_S", vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRYMASTER 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<CtgryMaster> selectComtnbbsctgrymasterList(CtgryMasterVO searchVO) throws Exception {
        return list("comtnbbsctgrymasterDAO.selectComtnbbsctgrymasterList_D", searchVO);
    }

    /**
	 * COMTNBBSCTGRYMASTER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRYMASTER 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgrymasterListTotCnt(CtgryMasterVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnbbsctgrymasterDAO.selectComtnbbsctgrymasterListTotCnt_S", searchVO);
    }

}
