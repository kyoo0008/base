package egovframework.com.sym.ccm.zip.service;

import java.util.List;
import egovframework.com.sym.ccm.zip.service.RdnmZipVO;
import egovframework.com.sym.ccm.zip.service.RdnmZip;

/**
 * @Class Name : RdnmZipService.java
 * @Description : RdnmZip Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121130
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovCcmRdnmZipManageService {
	
	/**
	 * COMTNRDNMADRZIP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 RdnmZipVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertRdnmZip(RdnmZip vo) throws Exception;
    
    /**
	 * COMTNRDNMADRZIP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 RdnmZipVO
	 * @return void형
	 * @exception Exception
	 */
    void updateRdnmZip(RdnmZip vo) throws Exception;
    
    /**
	 * COMTNRDNMADRZIP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 RdnmZipVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteRdnmZip(RdnmZip vo) throws Exception;
    
    /**
	 * COMTNRDNMADRZIP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    RdnmZip selectRdnmZip(RdnmZip vo) throws Exception;
    
    /**
	 * 시도명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    List<String> selectCtprvnNm(RdnmZipVO searchVO) throws Exception ;
    
    /**
	 * 시군구명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    List<String> selectSignguNm(RdnmZipVO searchVO) throws Exception;
    
    /**
	 * COMTNRDNMADRZIP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNRDNMADRZIP 목록
	 * @exception Exception
	 */
    List<RdnmZipVO> selectRdnmZipList(RdnmZipVO searchVO) throws Exception;
    
    /**
	 * COMTNRDNMADRZIP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNRDNMADRZIP 총 갯수
	 * @exception
	 */
    int selectRdnmZipListTotCnt(RdnmZipVO searchVO);
    
}
