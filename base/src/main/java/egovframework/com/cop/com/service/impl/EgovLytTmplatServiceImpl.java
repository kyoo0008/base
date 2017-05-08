package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.com.service.EgovLytTmplatHistoryService;
import egovframework.com.cop.com.service.EgovLytTmplatService;
import egovframework.com.cop.com.service.LytTmplatVO;
import egovframework.com.cop.com.service.LytTmplat;
import egovframework.com.cop.com.service.impl.EgovLytTmplatDAO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

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

@Service("EgovLytTmplatService")
public class EgovLytTmplatServiceImpl extends AbstractServiceImpl implements
        EgovLytTmplatService {

    @Resource(name="LytTmplatDAO")
    private EgovLytTmplatDAO lytTmplatDAO;
    
    /** ID Generation */
    @Resource(name="egovLytTmplatIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
    
    @Resource(name="EgovLytTmplatHistoryService")
    private EgovLytTmplatHistoryService egovLytTmplatHistoryService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * COMTNLYTTMPLAT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnlyttmplatVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertLytTmplat(LytTmplat vo) throws Exception {
    	vo.setLytTmplatId(egovIdGnrService.getNextStringId());
    	lytTmplatDAO.insertLytTmplat(vo);
    	
    	egovLytTmplatHistoryService.insertLytTmplatHistory(vo);
    	
    	this.publishCreate(vo);
    	
        return null;
    }

    /**
	 * COMTNLYTTMPLAT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateLytTmplat(LytTmplat vo) throws Exception {
        lytTmplatDAO.updateLytTmplat(vo);
        
        egovLytTmplatHistoryService.insertLytTmplatHistory(vo);
        
        this.publishCreate(vo);
    }

    /**
	 * COMTNLYTTMPLAT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnlyttmplatVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteLytTmplat(LytTmplat vo) throws Exception {
        lytTmplatDAO.deleteLytTmplat(vo);
        
        this.publishDelete(vo);        
    }

    /**
	 * COMTNLYTTMPLAT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnlyttmplatVO
	 * @return 조회한 COMTNLYTTMPLAT
	 * @exception Exception
	 */
    public LytTmplat selectLytTmplat(LytTmplat vo) throws Exception {
        LytTmplat resultVO = lytTmplatDAO.selectLytTmplat(vo);
        
        return resultVO;
    }

    /**
	 * COMTNLYTTMPLAT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLAT 목록
	 * @exception Exception
	 */
    public List<LytTmplat> selectLytTmplatList(LytTmplatVO searchVO) throws Exception {
        return lytTmplatDAO.selectLytTmplatList(searchVO);
    }

    /**
	 * COMTNLYTTMPLAT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNLYTTMPLAT 총 갯수
	 * @exception
	 */
    public int selectLytTmplatListCnt(LytTmplatVO searchVO) {
		return lytTmplatDAO.selectLytTmplatListCnt(searchVO);
	}
    
    public void publishCreate(LytTmplat vo) throws Exception {
   	 
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "style.css", vo.getCssSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "script.js", vo.getScriptSourc());
   		
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "style"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".css", vo.getMobileCssSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "script"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".js", vo.getMobileScriptSourc());
   		 
   }
    
    public void publishDelete(LytTmplat vo) throws Exception {
    	
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "style.css");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "script.js");
		 
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "style"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".css");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.tmplat.lyt.fileStorePathByWebFile") + "/" + vo.getTmplatLcasCode() + "/" + vo.getLytTmplatId() + "/" + "script"+Globals.PUBLISH_MOBILE_APPEND_FREFIX+".js");
      		 
    }
    
}
