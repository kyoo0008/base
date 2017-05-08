package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.BbsSourcVO;
import egovframework.com.cop.com.service.BbsSourc;

/**
 * @Class Name : EgovBbsSourcHistoryService
 * @Description : EgovBbsSourcHistoryService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBbsSourcHistoryService {
	
	/**
	 * COMTNBBSSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertBbsSourcHistory(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteBbsSourcHistory(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURCHISTORY
	 * @exception Exception
	 */
    BbsSourc selectBbsSourcHistory(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURCHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURCHISTORY 목록
	 * @exception Exception
	 */
    List<BbsSourc> selectBbsSourcHistoryList(BbsSourcVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURCHISTORY 총 갯수
	 * @exception
	 */
    int selectBbsSourcHistoryListCnt(BbsSourcVO searchVO);
    
}
