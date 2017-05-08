package egovframework.com.cop.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.bbs.service.EgovBBSCtgryService;
import egovframework.com.cop.bbs.service.CtgryVO;
import egovframework.com.cop.bbs.service.Ctgry;
import egovframework.com.cop.bbs.service.impl.BBSCtgryDAO;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * @Class Name : ComtnbbsctgryServiceImpl.java
 * @Description : Comtnbbsctgry Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBBSCtgryService")
public class EgovBBSCtgryServiceImpl extends AbstractServiceImpl implements
        EgovBBSCtgryService {

    @Resource(name="comtnbbsctgryDAO")
    private BBSCtgryDAO comtnbbsctgryDAO;
    
    /** ID Generation */
    @Resource(name="egovBbsCtgryIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNBBSCTGRY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertComtnbbsctgry(Ctgry vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCtgryId(id);
    	
    	int ctgryLevel = 0;
    	if(!EgovStringUtil.isEmpty(vo.getUpperCtgryId())){
    		ctgryLevel = comtnbbsctgryDAO.selectComtnbbsctgryNextLevel(vo);
    	}
    	
    	vo.setCtgryLevel(ctgryLevel);
    	comtnbbsctgryDAO.insertComtnbbsctgry(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * COMTNBBSCTGRY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnbbsctgry(Ctgry vo) throws Exception {
        comtnbbsctgryDAO.updateComtnbbsctgry(vo);
    }

    /**
	 * COMTNBBSCTGRY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnbbsctgry(Ctgry vo) throws Exception {
        comtnbbsctgryDAO.deleteComtnbbsctgry(vo);
    }

    /**
	 * COMTNBBSCTGRY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgryVO
	 * @return 조회한 COMTNBBSCTGRY
	 * @exception Exception
	 */
    public Ctgry selectComtnbbsctgry(Ctgry vo) throws Exception {
        Ctgry resultVO = comtnbbsctgryDAO.selectComtnbbsctgry(vo);
        //if (resultVO == null)
        //    throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * COMTNBBSCTGRY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRY 목록
	 * @exception Exception
	 */
	public List<Ctgry> selectComtnbbsctgryList(CtgryVO searchVO) throws Exception {
        return comtnbbsctgryDAO.selectComtnbbsctgryList(searchVO);
    }

    /**
	 * COMTNBBSCTGRY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgryListTotCnt(CtgryVO searchVO) {
		return comtnbbsctgryDAO.selectComtnbbsctgryListTotCnt(searchVO);
	}
    
	/**
	 * COMTNBBSCTGRY DEPTH를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNBBSCTGRY 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgryLevel(CtgryVO searchVO) {
        return comtnbbsctgryDAO.selectComtnbbsctgryLevel(searchVO);
    }
    
    /**
     * 정렬순서를 수정한다.
     * 
     * @param Ctgry
     */
    public void updateSortOrdr(Ctgry vo) throws Exception {
    	//변경되야될 것
    	comtnbbsctgryDAO.updateSortOrdr(vo);
    	
    	//다음 & 이전 꺼
    	comtnbbsctgryDAO.updateSiblingsSortOrdr(vo);
    	/*
    	int sourceSortOrdr = vo.getSortOrdr();
    	Ctgry targetCtgry = comtnbbsctgryDAO.selectTargetSortOrdr(vo);
    	
    	if(targetCtgry != null) {
    		vo.setSortOrdr(targetCtgry.getSortOrdr());
    		comtnbbsctgryDAO.updateSortOrdr(vo);
    		
    		vo.setCtgryId(targetCtgry.getCtgryId());
    		vo.setSortOrdr(sourceSortOrdr);
    		comtnbbsctgryDAO.updateSortOrdr(vo);
    	}
    	*/
    }	
    
    
    
    
}
