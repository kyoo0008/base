package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.com.service.EgovLytSourcHistoryService;
import egovframework.com.cop.com.service.EgovLytSourcService;
import egovframework.com.cop.com.service.LytSourcVO;
import egovframework.com.cop.com.service.LytSourc;
import egovframework.com.cop.com.service.impl.EgovLytSourcDAO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovLytSourcServiceImpl
 * @Description : EgovLytSourcServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovLytSourcService")
public class EgovLytSourcServiceImpl extends AbstractServiceImpl implements
        EgovLytSourcService {

    @Resource(name="LytSourcDAO")
    private EgovLytSourcDAO lytSourcDAO;
    
    /** ID Generation */
    @Resource(name="egovLytSourcIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
    
    @Resource(name="EgovLytSourcHistoryService")
    private EgovLytSourcHistoryService egovLytSourcHistoryService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * COMTNLYTSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlytsourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytSourc(LytSourc vo) throws Exception {
    	vo.setLytSourcId(egovIdGnrService.getNextStringId());
    	lytSourcDAO.insertLytSourc(vo);
    	
    	egovLytSourcHistoryService.insertLytSourcHistory(vo);
    	
    	this.publishCreate(vo);
    	
        return null;
    }

    /**
	 * COMTNLYTSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlytsourcVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLytSourc(LytSourc vo) throws Exception {
        lytSourcDAO.updateLytSourc(vo);
        
        egovLytSourcHistoryService.insertLytSourcHistory(vo);
        
        this.publishCreate(vo);
    }

    /**
	 * COMTNLYTSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlytsourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytSourc(LytSourc vo) throws Exception {
        lytSourcDAO.deleteLytSourc(vo);
        
        this.publishDelete(vo);        
    }

    /**
	 * COMTNLYTSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlytsourcVO
	 * @return 조회한 COMTNLYTSOURC
	 * @exception Exception
	 */
    public LytSourc selectLytSourc(LytSourc vo) throws Exception {
        LytSourc resultVO = lytSourcDAO.selectLytSourc(vo);
        
        return resultVO;
    }

    /**
	 * COMTNLYTSOURC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURC 목록
	 * @exception Exception
	 */
    public List<LytSourc> selectLytSourcList(LytSourcVO searchVO) throws Exception {
        return lytSourcDAO.selectLytSourcList(searchVO);
    }

    /**
	 * COMTNLYTSOURC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTSOURC 총 갯수
	 * @exception
	 */
    public int selectLytSourcListCnt(LytSourcVO searchVO) {
		return lytSourcDAO.selectLytSourcListCnt(searchVO);
	}
    
    public void publishCreate(LytSourc vo) throws Exception {
   	 
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcHead.jsp", vo.getUpendSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcBottom.jsp", vo.getLptSourc());
   		
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcHead"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".jsp", vo.getMobileUpendSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcBottom"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".jsp", vo.getMobileLptSourc());
   		 
   }
    
    public void publishDelete(LytSourc vo) throws Exception {
    	
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcHead.jsp");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcBottom.jsp");
		 
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcHead"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".jsp");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.lyt.fileStorePathByJspFile") + "/" + vo.getSourcSeCode() + "/" + vo.getLytSourcId() + "/" + "sourcBottom"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".jsp");
      		 
    }
    
}
