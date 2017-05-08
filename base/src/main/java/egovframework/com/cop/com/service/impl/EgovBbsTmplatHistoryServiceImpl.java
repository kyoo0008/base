package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.com.service.BbsTmplatVO;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.cop.com.service.EgovBbsTmplatHistoryService;
import egovframework.com.cop.com.service.impl.EgovBbsTmplatHistoryDAO;

/**
 * @Class Name : EgovBbsTmplatHistoryService
 * @Description : EgovBbsTmplatHistoryService Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBbsTmplatHistoryService")
public class EgovBbsTmplatHistoryServiceImpl extends AbstractServiceImpl implements
EgovBbsTmplatHistoryService {

    @Resource(name="BbsTmplatHistoryDAO")
    private EgovBbsTmplatHistoryDAO bbsTmplatHistoryDAO;
    
    /** ID Generation */
    @Resource(name="egovBbsTmplatHistoryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNBBSTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsTmplatHistory(BbsTmplat vo) throws Exception {
    	vo.setBbsTmplatHistId(egovIdGnrService.getNextStringId());
    	bbsTmplatHistoryDAO.insertBbsTmplatHistory(vo);
        return null;
    }

    /**
	 * COMTNBBSTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsTmplatHistory(BbsTmplat vo) throws Exception {
        bbsTmplatHistoryDAO.deleteBbsTmplatHistory(vo);
    }

    /**
	 * COMTNBBSTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLATHISTORY
	 * @exception Exception
	 */
    public BbsTmplat selectBbsTmplatHistory(BbsTmplat vo) throws Exception {
        BbsTmplat resultVO = bbsTmplatHistoryDAO.selectBbsTmplatHistory(vo);
       
        return resultVO;
    }

    /**
	 * COMTNBBSTMPLATHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLATHISTORY 목록
	 * @exception Exception
	 */
    public List<BbsTmplat> selectBbsTmplatHistoryList(BbsTmplatVO searchVO) throws Exception {
        return bbsTmplatHistoryDAO.selectBbsTmplatHistoryList(searchVO);
    }

    /**
	 * COMTNBBSTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLATHISTORY 총 갯수
	 * @exception
	 */
    public int selectBbsTmplatHistoryListCnt(BbsTmplatVO searchVO) {
		return bbsTmplatHistoryDAO.selectBbsTmplatHistoryListCnt(searchVO);
	}
    
}
