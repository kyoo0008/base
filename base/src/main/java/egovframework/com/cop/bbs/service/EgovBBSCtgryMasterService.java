package egovframework.com.cop.bbs.service;

import java.util.List;
import egovframework.com.cop.bbs.service.CtgryMasterVO;
import egovframework.com.cop.bbs.service.CtgryMaster;

/**
 * @Class Name : ComtnbbsctgrymasterService.java
 * @Description : Comtnbbsctgrymaster Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovBBSCtgryMasterService {
	
	/**
	 * COMTNBBSCTGRYMASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertComtnbbsctgrymaster(CtgryMaster vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRYMASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형
	 * @exception Exception
	 */
    void updateComtnbbsctgrymaster(CtgryMaster vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRYMASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComtnbbsctgrymaster(CtgryMaster vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRYMASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 조회한 COMTNBBSCTGRYMASTER
	 * @exception Exception
	 */
    CtgryMaster selectComtnbbsctgrymaster(CtgryMaster vo) throws Exception;
    
    /**
	 * COMTNBBSCTGRYMASTER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRYMASTER 목록
	 * @exception Exception
	 */
    List<CtgryMaster> selectComtnbbsctgrymasterList(CtgryMasterVO searchVO) throws Exception;
    
    /**
	 * COMTNBBSCTGRYMASTER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRYMASTER 총 갯수
	 * @exception
	 */
    int selectComtnbbsctgrymasterListTotCnt(CtgryMasterVO searchVO);
    
}
