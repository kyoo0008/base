package egovframework.com.cop.bbs.service;

import java.util.List;
import egovframework.com.cop.bbs.service.CtgryVO;
import egovframework.com.cop.bbs.service.Ctgry;

/**
 * @Class Name : ComtnbbsctgryService.java
 * @Description : Comtnbbsctgry Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBBSCtgryService {
	
	/**
	 * COMTNBBSCTGRY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertComtnbbsctgry(Ctgry vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형
	 * @exception Exception
	 */
    void updateComtnbbsctgry(Ctgry vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComtnbbsctgry(Ctgry vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgryVO
	 * @return 조회한 COMTNBBSCTGRY
	 * @exception Exception
	 */
    Ctgry selectComtnbbsctgry(Ctgry vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRY 목록
	 * @exception Exception
	 */
    List<Ctgry> selectComtnbbsctgryList(CtgryVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSCTGRY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    int selectComtnbbsctgryListTotCnt(CtgryVO searchVO);
    
	/**
	 * COMTNBBSCTGRY DEPTH를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgryLevel(CtgryVO searchVO);
    
    /**
     * 정렬순서를 수정한다.
     * 
     * @param Ctgry
     */
    public void updateSortOrdr(Ctgry vo) throws Exception;
    
    
}
