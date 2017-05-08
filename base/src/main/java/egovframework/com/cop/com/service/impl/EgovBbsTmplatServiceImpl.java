package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.cop.com.service.EgovBbsTmplatHistoryService;
import egovframework.com.cop.com.service.EgovBbsTmplatService;
import egovframework.com.cop.com.service.BbsTmplatVO;
import egovframework.com.cop.com.service.BbsTmplat;
import egovframework.com.cop.com.service.impl.EgovBbsTmplatDAO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovBbsTmplatServiceImpl
 * @Description : EgovBbsTmplatServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBbsTmplatService")
public class EgovBbsTmplatServiceImpl extends AbstractServiceImpl implements
        EgovBbsTmplatService {

    @Resource(name="BbsTmplatDAO")
    private EgovBbsTmplatDAO bbsTmplatDAO;
    
    /** ID Generation */
    @Resource(name="egovBbsTmplatIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
    
    @Resource(name="EgovBbsTmplatHistoryService")
    private EgovBbsTmplatHistoryService bbsTmplatHistoryService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * COMTNBBSTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbstmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsTmplat(BbsTmplat vo) throws Exception {
    	vo.setBbsTmplatId(egovIdGnrService.getNextStringId());
    	bbsTmplatDAO.insertBbsTmplat(vo);
    	
    	bbsTmplatHistoryService.insertBbsTmplatHistory(vo);
    	
    	this.publishCreate(vo);
    	
        return null;
    }

    /**
	 * COMTNBBSTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateBbsTmplat(BbsTmplat vo) throws Exception {
        bbsTmplatDAO.updateBbsTmplat(vo);
        
        bbsTmplatHistoryService.insertBbsTmplatHistory(vo);
        
        this.publishCreate(vo);
    }

    /**
	 * COMTNBBSTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbstmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsTmplat(BbsTmplat vo) throws Exception {
        bbsTmplatDAO.deleteBbsTmplat(vo);
        
        this.publishDelete(vo);
    }

    /**
	 * COMTNBBSTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbstmplatVO
	 * @return 조회한 COMTNBBSTMPLAT
	 * @exception Exception
	 */
    public BbsTmplat selectBbsTmplat(BbsTmplat vo) throws Exception {
        BbsTmplat resultVO = bbsTmplatDAO.selectBbsTmplat(vo);
       
        return resultVO;
    }

    /**
	 * COMTNBBSTMPLAT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLAT 목록
	 * @exception Exception
	 */
    public List<BbsTmplat> selectBbsTmplatList(BbsTmplatVO searchVO) throws Exception {
        return bbsTmplatDAO.selectBbsTmplatList(searchVO);
    }

    /**
	 * COMTNBBSTMPLAT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSTMPLAT 총 갯수
	 * @exception
	 */
    public int selectBbsTmplatListCnt(BbsTmplatVO searchVO) {
		return bbsTmplatDAO.selectBbsTmplatListCnt(searchVO);
	}
    
    public void publishCreate(BbsTmplat vo) throws Exception {
      	 
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.bbs.fileStorePathByWebFile") + "/" + vo.getBbsTmplatId() + "/style.css", vo.getCssSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.bbs.fileStorePathByWebFile") + "/" + vo.getBbsTmplatId() + "/script.js", vo.getScriptSourc());
   		 
   }
    
    public void publishDelete(BbsTmplat vo) throws Exception {
    	
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.bbs.fileStorePathByWebFile") + "/" + vo.getBbsTmplatId() + "/style.css");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.bbs.fileStorePathByWebFile") + "/" + vo.getBbsTmplatId() + "/script.js");
      		 
    }
    
}
