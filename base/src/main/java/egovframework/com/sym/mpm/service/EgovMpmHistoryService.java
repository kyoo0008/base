package egovframework.com.sym.mpm.service;

import java.util.List;
/**
 * @Class Name : EgovMpmHistoryService
 * @Description : EgovMpmHistoryService Business class
 * @Modification Information
 *
 * @author 정정욱
 * @since 2012-09-25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EgovMpmHistoryService {
	
	/**
	 * COMTHSITEMNUHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 Mpm
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMpmHistory(Mpm vo) throws Exception ;

    /**
	 * COMTHSITEMNUHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 Mpm
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMpmHistory(Mpm vo) throws Exception ;
    /**
	 * COMTHSITEMNUHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MpmVO
	 * @return 조회한 COMTHSITEMNUHISTORY
	 * @exception Exception
	 */
    public MpmVO selectMpmHistory(MpmVO vo) throws Exception ;

    /**
	 * COMTHSITEMNUHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTHSITEMNUHISTORY 목록
	 * @exception Exception
	 */
    public List<Mpm> selectMpmHistoryList(MpmVO searchVO) throws Exception ;
    /**
	 * COMTHSITEMNUHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTHSITEMNUHISTORY 총 갯수
	 * @exception
	 */
    public int selectMpmHistoryListCnt(MpmVO searchVO) ;
    
}
