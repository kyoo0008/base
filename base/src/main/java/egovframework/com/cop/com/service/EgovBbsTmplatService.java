package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.BbsTmplatVO;
import egovframework.com.cop.com.service.BbsTmplat;

/**
 * @Class Name : EgovBbsTmplatService
 * @Description : EgovBbsTmplatService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBbsTmplatService {
	
	/**
	 * COMTNBBSTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertBbsTmplat(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형
	 * @exception Exception
	 */
    void updateBbsTmplat(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteBbsTmplat(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLAT
	 * @exception Exception
	 */
    BbsTmplat selectBbsTmplat(BbsTmplat vo) throws Exception;
    
    /**
	 * COMTNBBSTMPLAT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLAT 목록
	 * @exception Exception
	 */
    List<BbsTmplat> selectBbsTmplatList(BbsTmplatVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSTMPLAT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLAT 총 갯수
	 * @exception
	 */
    int selectBbsTmplatListCnt(BbsTmplatVO searchVO);
    
}
