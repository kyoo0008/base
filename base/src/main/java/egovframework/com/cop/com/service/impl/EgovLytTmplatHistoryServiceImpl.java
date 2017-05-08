package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.com.service.EgovLytTmplatHistoryService;
import egovframework.com.cop.com.service.LytTmplatVO;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.cop.com.service.impl.EgovLytTmplatHistoryDAO;

/**
 * @Class Name : EgovLytTmplatServiceImpl
 * @Description : EgovLytTmplatServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovLytTmplatHistoryService")
public class EgovLytTmplatHistoryServiceImpl extends AbstractServiceImpl implements
        EgovLytTmplatHistoryService {

    @Resource(name="LytTmplatHistoryDAO")
    private EgovLytTmplatHistoryDAO lytTmplatHistoryDAO;
    
    /** ID Generation */
    @Resource(name="egovLytTmplatHistoryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNLYTTMPLATHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytTmplatHistory(LytTmplat vo) throws Exception {
    	vo.setLytTmplatHistId(egovIdGnrService.getNextStringId());    	
    	lytTmplatHistoryDAO.insertLytTmplatHistory(vo);
        return null;
    }

    /**
	 * COMTNLYTTMPLATHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytTmplatHistory(LytTmplat vo) throws Exception {
        lytTmplatHistoryDAO.deleteLytTmplatHistory(vo);
    }

    /**
	 * COMTNLYTTMPLATHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLATHISTORY
	 * @exception Exception
	 */
    public LytTmplat selectLytTmplatHistory(LytTmplat vo) throws Exception {
        LytTmplat resultVO = lytTmplatHistoryDAO.selectLytTmplatHistory(vo);
        
        return resultVO;
    }

    /**
	 * COMTNLYTTMPLATHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLATHISTORY 목록
	 * @exception Exception
	 */
    public List<LytTmplat> selectLytTmplatHistoryList(LytTmplatVO searchVO) throws Exception {
        return lytTmplatHistoryDAO.selectLytTmplatHistoryList(searchVO);
    }

    /**
	 * COMTNLYTTMPLATHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLATHISTORY 총 갯수
	 * @exception
	 */
    public int selectLytTmplatHistoryListCnt(LytTmplatVO searchVO) {
		return lytTmplatHistoryDAO.selectLytTmplatHistoryListCnt(searchVO);
	}
    
}
