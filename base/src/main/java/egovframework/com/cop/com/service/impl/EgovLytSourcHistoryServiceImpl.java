package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.com.service.EgovLytSourcHistoryService;
import egovframework.com.cop.com.service.LytSourcVO;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.cop.com.service.impl.EgovLytSourcHistoryDAO;

/**
 * @Class Name : EgovLytSourcServiceImpl
 * @Description : EgovLytSourcServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovLytSourcHistoryService")
public class EgovLytSourcHistoryServiceImpl extends AbstractServiceImpl implements
        EgovLytSourcHistoryService {

    @Resource(name="LytSourcHistoryDAO")
    private EgovLytSourcHistoryDAO lytSourcHistoryDAO;
    
    /** ID Generation */
    @Resource(name="egovLytSourcHistoryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNLYTSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytSourcHistory(LytSourc vo) throws Exception {
    	vo.setLytSourcHistId(egovIdGnrService.getNextStringId());    	
    	lytSourcHistoryDAO.insertLytSourcHistory(vo);
        return null;
    }

    /**
	 * COMTNLYTSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytSourcHistory(LytSourc vo) throws Exception {
        lytSourcHistoryDAO.deleteLytSourcHistory(vo);
    }

    /**
	 * COMTNLYTSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURCHISTORY
	 * @exception Exception
	 */
    public LytSourc selectLytSourcHistory(LytSourc vo) throws Exception {
        LytSourc resultVO = lytSourcHistoryDAO.selectLytSourcHistory(vo);
        
        return resultVO;
    }

    /**
	 * COMTNLYTSOURCHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURCHISTORY 목록
	 * @exception Exception
	 */
    public List<LytSourc> selectLytSourcHistoryList(LytSourcVO searchVO) throws Exception {
        return lytSourcHistoryDAO.selectLytSourcHistoryList(searchVO);
    }

    /**
	 * COMTNLYTSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURCHISTORY 총 갯수
	 * @exception
	 */
    public int selectLytSourcHistoryListCnt(LytSourcVO searchVO) {
		return lytSourcHistoryDAO.selectLytSourcHistoryListCnt(searchVO);
	}
    
}
