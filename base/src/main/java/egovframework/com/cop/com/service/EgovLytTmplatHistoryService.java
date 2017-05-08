package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.LytTmplatVO;
import egovframework.com.cop.com.service.LytTmplat;

/**
 * @Class Name : EgovLytTmplatHistoryService
 * @Description : EgovLytTmplatHistoryService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovLytTmplatHistoryService {
	
	/**
	 * COMTNLYTTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLytTmplatHistory(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLytTmplatHistory(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLATHISTORY
	 * @exception Exception
	 */
    LytTmplat selectLytTmplatHistory(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLATHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLATHISTORY 목록
	 * @exception Exception
	 */
    List<LytTmplat> selectLytTmplatHistoryList(LytTmplatVO searchVO) throws Exception;
    
    /**
	 * COMTNLYTTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLATHISTORY 총 갯수
	 * @exception
	 */
    int selectLytTmplatHistoryListCnt(LytTmplatVO searchVO);
    
}
