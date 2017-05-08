package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.LytSourcVO;
import egovframework.com.cop.com.service.LytSourc;

/**
 * @Class Name : EgovLytSourcService
 * @Description : EgovLytSourcService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovLytSourcService {
	
	/**
	 * COMTNLYTSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLytSourc(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlytsourcVO
	 * @return void형
	 * @exception Exception
	 */
    void updateLytSourc(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLytSourc(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURC
	 * @exception Exception
	 */
    LytSourc selectLytSourc(LytSourc vo) throws Exception;
    
    /**
	 * COMTNLYTSOURC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURC 목록
	 * @exception Exception
	 */
    List<LytSourc> selectLytSourcList(LytSourcVO searchVO) throws Exception;
    
    /**
	 * COMTNLYTSOURC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURC 총 갯수
	 * @exception
	 */
    int selectLytSourcListCnt(LytSourcVO searchVO);
    
    public void publishCreate(LytSourc vo) throws Exception ;
    
}
