package egovframework.com.sym.mpm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.sym.mpm.service.EgovMpmHistoryService;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.mpm.service.impl.MpmHistoryDAO;

/**
 * @Class Name : EgovMpmHistoryServiceImpl
 * @Description : EgovMpmHistoryServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 2012-09-25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovMpmHistoryService")
public class EgovMpmHistoryServiceImpl extends AbstractServiceImpl implements
        EgovMpmHistoryService {

    @Resource(name="MpmHistoryDAO")
    private MpmHistoryDAO mpmHistoryDAO;
    
    /** ID Generation */
    @Resource(name="egovMenuHistoryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTHSITEMNUHISTORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 Mpm
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMpmHistory(Mpm vo) throws Exception {
    	
    	vo.setMenuHistId(egovIdGnrService.getNextStringId());    	
    	mpmHistoryDAO.insertMpmHistory(vo);
        return null;
    }

    /**
	 * COMTHSITEMNUHISTORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 Mpm
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMpmHistory(Mpm vo) throws Exception {
        mpmHistoryDAO.deleteMpmHistory(vo);
    }

    /**
	 * COMTHSITEMNUHISTORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MpmVO
	 * @return 조회한 COMTHSITEMNUHISTORY
	 * @exception Exception
	 */
    public MpmVO selectMpmHistory(MpmVO vo) throws Exception {
        
        return mpmHistoryDAO.selectMpmHistory(vo);
    }

    /**
	 * COMTHSITEMNUHISTORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTHSITEMNUHISTORY 목록
	 * @exception Exception
	 */
    public List<Mpm> selectMpmHistoryList(MpmVO searchVO) throws Exception {
        return mpmHistoryDAO.selectMpmHistoryList(searchVO);
    }

    /**
	 * COMTHSITEMNUHISTORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTHSITEMNUHISTORY 총 갯수
	 * @exception
	 */
    public int selectMpmHistoryListCnt(MpmVO searchVO) {
		return mpmHistoryDAO.selectMpmHistoryListCnt(searchVO);
	}
    
}
