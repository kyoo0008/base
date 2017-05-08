package egovframework.com.sym.ccm.zip.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.sym.ccm.zip.service.RdnmZip;
import egovframework.com.sym.ccm.zip.service.RdnmZipVO;

/**
 * @Class Name : RdnmZipDAO.java
 * @Description : RdnmZip DAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121130
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("EgovCcmRdnmZipDAO")
public class EgovCcmRdnmZipDAO extends EgovAbstractDAO {

	/**
	 * COMTNRDNMADRZIP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 RdnmZipVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertRdnmZip(RdnmZip vo) throws Exception {
        return (String)insert("rdnmZipDAO.insertRdnmZip", vo);
    }

    /**
	 * COMTNRDNMADRZIP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 RdnmZipVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateRdnmZip(RdnmZip vo) throws Exception {
        update("rdnmZipDAO.updateRdnmZip", vo);
    }

    /**
	 * COMTNRDNMADRZIP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 RdnmZipVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteRdnmZip(RdnmZip vo) throws Exception {
        delete("rdnmZipDAO.deleteRdnmZip", vo);
    }

    /**
	 * COMTNRDNMADRZIP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    public RdnmZip selectRdnmZip(RdnmZip vo) throws Exception {
        return (RdnmZip) selectByPk("rdnmZipDAO.selectRdnmZip", vo);
    }
    
    /**
	 * 시도명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<String> selectCtprvnNm(RdnmZipVO searchVO) throws Exception {
    	return list("rdnmZipDAO.selectCtprvnNm", searchVO);
    }
    
    /**
	 * 시군구명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<String> selectSignguNm(RdnmZipVO searchVO) throws Exception {
    	return list("rdnmZipDAO.selectSignguNm", searchVO);
    }

    /**
	 * COMTNRDNMADRZIP 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNRDNMADRZIP 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<RdnmZipVO> selectRdnmZipList(RdnmZipVO searchVO) throws Exception {
        return list("rdnmZipDAO.selectRdnmZipList", searchVO);
    }

    /**
	 * COMTNRDNMADRZIP 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNRDNMADRZIP 총 갯수
	 * @exception
	 */
    public int selectRdnmZipListTotCnt(RdnmZipVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("rdnmZipDAO.selectRdnmZipListTotCnt", searchVO);
    }

}
