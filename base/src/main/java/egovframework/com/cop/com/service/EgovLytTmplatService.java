package egovframework.com.cop.com.service;

import java.util.List;
import egovframework.com.cop.com.service.LytTmplatVO;
import egovframework.com.cop.com.service.LytTmplat;

/**
 * @Class Name : EgovLytTmplatService
 * @Description : EgovLytTmplatService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovLytTmplatService {
	
	/**
	 * COMTNLYTTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertLytTmplat(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형
	 * @exception Exception
	 */
    void updateLytTmplat(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteLytTmplat(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLAT
	 * @exception Exception
	 */
    LytTmplat selectLytTmplat(LytTmplat vo) throws Exception;
    
    /**
	 * COMTNLYTTMPLAT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLAT 목록
	 * @exception Exception
	 */
    List<LytTmplat> selectLytTmplatList(LytTmplatVO searchVO) throws Exception;
    
    /**
	 * COMTNLYTTMPLAT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLAT 총 갯수
	 * @exception
	 */
    int selectLytTmplatListCnt(LytTmplatVO searchVO);
    
    public void publishCreate(LytTmplat vo) throws Exception ;
    
}
