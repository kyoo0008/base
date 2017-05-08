package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.com.service.BbsSourcVO;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.cop.com.service.EgovBbsSourcHistoryService;
import egovframework.com.cop.com.service.impl.EgovBbsSourcHistoryDAO;

/**
 * @Class Name : EgovBbsSourcHistoryService
 * @Description : EgovBbsSourcHistoryService Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBbsSourcHistoryService")
public class EgovBbsSourcHistoryServiceImpl extends AbstractServiceImpl implements
EgovBbsSourcHistoryService {

    @Resource(name="BbsSourcHistoryDAO")
    private EgovBbsSourcHistoryDAO bbsSourcHistoryDAO;
    
    /** ID Generation */
    @Resource(name="egovBbsSourcHistoryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNBBSSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsSourcHistory(BbsSourc vo) throws Exception {
    	vo.setBbsSourcHistId(egovIdGnrService.getNextStringId());
    	bbsSourcHistoryDAO.insertBbsSourcHistory(vo);
        return null;
    }

    /**
	 * COMTNBBSSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsSourcHistory(BbsSourc vo) throws Exception {
        bbsSourcHistoryDAO.deleteBbsSourcHistory(vo);
    }

    /**
	 * COMTNBBSSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURCHISTORY
	 * @exception Exception
	 */
    public BbsSourc selectBbsSourcHistory(BbsSourc vo) throws Exception {
        BbsSourc resultVO = bbsSourcHistoryDAO.selectBbsSourcHistory(vo);
       
        return resultVO;
    }

    /**
	 * COMTNBBSSOURCHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURCHISTORY 목록
	 * @exception Exception
	 */
    public List<BbsSourc> selectBbsSourcHistoryList(BbsSourcVO searchVO) throws Exception {
        return bbsSourcHistoryDAO.selectBbsSourcHistoryList(searchVO);
    }

    /**
	 * COMTNBBSSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURCHISTORY 총 갯수
	 * @exception
	 */
    public int selectBbsSourcHistoryListCnt(BbsSourcVO searchVO) {
		return bbsSourcHistoryDAO.selectBbsSourcHistoryListCnt(searchVO);
	}
    
}
