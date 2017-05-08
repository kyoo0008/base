package egovframework.com.cop.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.cop.com.service.EgovBbsSourcHistoryService;
import egovframework.com.cop.com.service.EgovBbsSourcService;
import egovframework.com.cop.com.service.BbsSourcVO;
import egovframework.com.cop.com.service.BbsSourc;
import egovframework.com.cop.com.service.impl.EgovBbsSourcDAO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

/**
 * @Class Name : EgovBbsSourcServiceImpl
 * @Description : EgovBbsSourcServiceImpl Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("EgovBbsSourcService")
public class EgovBbsSourcServiceImpl extends AbstractServiceImpl implements
        EgovBbsSourcService {

    @Resource(name="BbsSourcDAO")
    private EgovBbsSourcDAO bbsSourcDAO;
    
    /** ID Generation */
    @Resource(name="egovBbsSourcIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
    
    @Resource(name="EgovBbsSourcHistoryService")
    private EgovBbsSourcHistoryService bbsSourcHistoryService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * COMTNBBSSOURC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnbbssourcVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertBbsSourc(BbsSourc vo) throws Exception {
    	vo.setBbsSourcId(egovIdGnrService.getNextStringId());
    	bbsSourcDAO.insertBbsSourc(vo);
    	
    	bbsSourcHistoryService.insertBbsSourcHistory(vo);
    	
    	this.publishCreate(vo);
    	
        return null;
    }

    /**
	 * COMTNBBSSOURC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnbbssourcVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateBbsSourc(BbsSourc vo) throws Exception {
        bbsSourcDAO.updateBbsSourc(vo);
        
        bbsSourcHistoryService.insertBbsSourcHistory(vo);
        
        this.publishCreate(vo);
    }

    /**
	 * COMTNBBSSOURC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnbbssourcVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBbsSourc(BbsSourc vo) throws Exception {
        bbsSourcDAO.deleteBbsSourc(vo);
        
        this.publishDelete(vo);
    }

    /**
	 * COMTNBBSSOURC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnbbssourcVO
	 * @return 조회한 COMTNBBSSOURC
	 * @exception Exception
	 */
    public BbsSourc selectBbsSourc(BbsSourc vo) throws Exception {
        BbsSourc resultVO = bbsSourcDAO.selectBbsSourc(vo);
       
        return resultVO;
    }

    /**
	 * COMTNBBSSOURC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURC 목록
	 * @exception Exception
	 */
    public List<BbsSourc> selectBbsSourcList(BbsSourcVO searchVO) throws Exception {
        return bbsSourcDAO.selectBbsSourcList(searchVO);
    }

    /**
	 * COMTNBBSSOURC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNBBSSOURC 총 갯수
	 * @exception
	 */
    public int selectBbsSourcListCnt(BbsSourcVO searchVO) {
		return bbsSourcDAO.selectBbsSourcListCnt(searchVO);
	}
    
    public void publishCreate(BbsSourc vo) throws Exception {
      	 
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeList.jsp", vo.getListSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeInqire.jsp", vo.getViewSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeRegist.jsp", vo.getFormSourc());
   		EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovCommentList.jsp", vo.getCmSourc());
   		 
   }
    
    public void publishDelete(BbsSourc vo) throws Exception {
    	
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeList.jsp");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeInqire.jsp");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovNoticeRegist.jsp");
		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.sourc.bbs.fileStorePathByJspFile") + "/" + vo.getBbsSourcId() + "/" + "EgovCommentList.jsp");
      		 
    }
    
}
