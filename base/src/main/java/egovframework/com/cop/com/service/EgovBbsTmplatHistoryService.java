package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.BbsTmplatVO;
import egovframework.com.cop.com.service.BbsTmplat;

/**
 * @Class Name : EgovBbsTmplatHistoryService
 * @Description : EgovBbsTmplatHistoryService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBbsTmplatHistoryService {
	
	/**
	 * COMTNBBSTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertBbsTmplatHistory(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteBbsTmplatHistory(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLATHISTORY
	 * @exception Exception
	 */
    BbsTmplat selectBbsTmplatHistory(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLATHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLATHISTORY 목록
	 * @exception Exception
	 */
    List<BbsTmplat> selectBbsTmplatHistoryList(BbsTmplatVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLATHISTORY 총 갯수
	 * @exception
	 */
    int selectBbsTmplatHistoryListCnt(BbsTmplatVO searchVO);
    
}
