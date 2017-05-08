package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.LytSourcVO;
import egovframework.com.cop.com.service.LytSourc;

/**
 * @Class Name : EgovLytSourcHistoryService
 * @Description : EgovLytSourcHistoryService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovLytSourcHistoryService {
	
	/**
	 * COMTNLYTSOURCHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLytSourcHistory(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURCHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLytSourcHistory(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURCHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURCHISTORY
	 * @exception Exception
	 */
    LytSourc selectLytSourcHistory(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURCHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURCHISTORY 목록
	 * @exception Exception
	 */
    List<LytSourc> selectLytSourcHistoryList(LytSourcVO searchVO) throws Exception;
    
    /**
	 * COMTNLYTSOURCHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURCHISTORY 총 갯수
	 * @exception
	 */
    int selectLytSourcHistoryListCnt(LytSourcVO searchVO);
    
}
