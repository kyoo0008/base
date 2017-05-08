package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.BbsSourcVO;
import egovframework.com.cop.com.service.BbsSourc;

/**
 * @Class Name : EgovBbsSourcService
 * @Description : EgovBbsSourcService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBbsSourcService {
	
	/**
	 * COMTNBBSSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertBbsSourc(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbssourcVO
	 * @return void형
	 * @exception Exception
	 */
    void updateBbsSourc(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteBbsSourc(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURC
	 * @exception Exception
	 */
    BbsSourc selectBbsSourc(BbsSourc vo) throws Exception;
    
    /**
	 * COMTNBBSSOURC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURC 목록
	 * @exception Exception
	 */
    List<BbsSourc> selectBbsSourcList(BbsSourcVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSSOURC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURC 총 갯수
	 * @exception
	 */
    int selectBbsSourcListCnt(BbsSourcVO searchVO);
    
}
