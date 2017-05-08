package egovframework.com.cop.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cop.bbs.service.Ctgry;
import egovframework.com.cop.bbs.service.EgovBBSCtgryMasterService;
import egovframework.com.cop.bbs.service.CtgryMasterVO;
import egovframework.com.cop.bbs.service.CtgryMaster;
import egovframework.com.cop.bbs.service.EgovBBSCtgryService;
import egovframework.com.cop.bbs.service.impl.BBSCtgryMasterDAO;

/**
 * @Class Name : ComtnbbsctgrymasterServiceImpl.java
 * @Description : Comtnbbsctgrymaster Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBBSCtgryMasterService")
public class EgovBBSCtgryMasterServiceImpl extends AbstractServiceImpl implements
        EgovBBSCtgryMasterService {

    @Resource(name="BBSCtgryMasterDAO")
    private BBSCtgryMasterDAO comtnbbsctgrymasterDAO;
    
    @Resource(name = "EgovBBSCtgryService")
    private EgovBBSCtgryService egovBBSCtgryService;
    
    /** ID Generation */
    @Resource(name="egovBBSCtgryMstrIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * COMTNBBSCTGRYMASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
    	//log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCtgrymasterId(id);
    	
    	comtnbbsctgrymasterDAO.insertComtnbbsctgrymaster(vo);
    	
    	Ctgry ctgry = new Ctgry();
    	ctgry.setCtgrymasterId(id);
    	ctgry.setCtgryNm("대분류");
    	egovBBSCtgryService.insertComtnbbsctgry(ctgry);
    	
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * COMTNBBSCTGRYMASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        comtnbbsctgrymasterDAO.updateComtnbbsctgrymaster(vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        comtnbbsctgrymasterDAO.deleteComtnbbsctgrymaster(vo);
    }

    /**
	 * COMTNBBSCTGRYMASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbsctgrymasterVO
	 * @return 조회한 COMTNBBSCTGRYMASTER
	 * @exception Exception
	 */
    public CtgryMaster selectComtnbbsctgrymaster(CtgryMaster vo) throws Exception {
        CtgryMaster resultVO = comtnbbsctgrymasterDAO.selectComtnbbsctgrymaster(vo);
        //if (resultVO == null)
        //    throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * COMTNBBSCTGRYMASTER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRYMASTER 목록
	 * @exception Exception
	 */
    public List<CtgryMaster> selectComtnbbsctgrymasterList(CtgryMasterVO searchVO) throws Exception {
        return comtnbbsctgrymasterDAO.selectComtnbbsctgrymasterList(searchVO);
    }

    /**
	 * COMTNBBSCTGRYMASTER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSCTGRYMASTER 총 갯수
	 * @exception
	 */
    public int selectComtnbbsctgrymasterListTotCnt(CtgryMasterVO searchVO) {
		return comtnbbsctgrymasterDAO.selectComtnbbsctgrymasterListTotCnt(searchVO);
	}
    
}
