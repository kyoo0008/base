package egovframework.com.cop.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.cop.bbs.service.Ctgry;
import egovframework.com.cop.bbs.service.CtgryVO;

/**
 * @Class Name : ComtnbbsctgryDAO.java
 * @Description : Comtnbbsctgry DAO Class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("comtnbbsctgryDAO")
public class BBSCtgryDAO extends EgovAbstractDAO {

	/**
	 * COMTNBBSCTGRY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public int insertComtnbbsctgry(Ctgry vo) throws Exception {
        return (Integer)insert("comtnbbsctgryDAO.insertComtnbbsctgry_S", vo);
    }

    /**
	 * COMTNBBSCTGRY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnbbsctgry(Ctgry vo) throws Exception {
        update("comtnbbsctgryDAO.updateComtnbbsctgry_S", vo);
    }

    /**
	 * COMTNBBSCTGRY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnbbsctgry(Ctgry vo) throws Exception {
        delete("comtnbbsctgryDAO.deleteComtnbbsctgry_S", vo);
    }

    /**
	 * COMTNBBSCTGRY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgryVO
	 * @return 조회한 COMTNBBSCTGRY
	 * @exception Exception
	 */
    public Ctgry selectComtnbbsctgry(Ctgry vo) throws Exception {
        return (Ctgry) selectByPk("comtnbbsctgryDAO.selectComtnbbsctgry_S", vo);
    }

    /**
	 * COMTNBBSCTGRY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRY 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<Ctgry> selectComtnbbsctgryList(CtgryVO searchVO) throws Exception {
        return list("comtnbbsctgryDAO.selectComtnbbsctgryList_D", searchVO);
    }

    /**
	 * COMTNBBSCTGRY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgryListTotCnt(CtgryVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnbbsctgryDAO.selectComtnbbsctgryListTotCnt_S", searchVO);
    }
    
    /**
	 * COMTNBBSCTGRY DEPTH를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgryLevel(CtgryVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnbbsctgryDAO.selectComtnbbsctgryLevel", searchVO);
    }
    
    /**
     * 이동할 대상카테고리 정보를 조회 한다.
     * 
     * @param searchVO
     */
    public Ctgry selectTargetSortOrdr(CtgryVO searchVO) throws Exception {
    	return (Ctgry)selectByPk("comtnbbsctgryDAO.selectTargetSortOrdr", searchVO);
    }
    
    /**
     * 정렬순서를 수정한다.
     * 
     * @param searchVO
     */
    public void updateSortOrdr(CtgryVO searchVO) throws Exception {
    	update("comtnbbsctgryDAO.updateSortOrdr", searchVO);
    }	
    
    /**
     * 정렬순서(다음&이전)를 수정한다.
     * 
     * @param searchVO
     */
    public void updateSiblingsSortOrdr(CtgryVO searchVO) throws Exception {
    	update("comtnbbsctgryDAO.updateSiblingsSortOrdr", searchVO);
    }	
    
    /**
	 * 카테고리 다음 레벨 값
	 */
    public int selectComtnbbsctgryNextLevel(CtgryVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnbbsctgryDAO.selectComtnbbsctgryNextLevel", searchVO);
    }
}
