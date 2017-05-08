package egovframework.com.uss.ion.pwm.service.impl;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
/**
 * 개요
 * - 팝업창에 대한 ServiceImpl을 정의한다.
 * 
 * 상세내용
 * - 팝업창에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * - 팝업창의 조회기능은 목록조회, 상세조회로, 사용자화면 보기로 구분된다.
 * @author 이창원
 * @version 1.0
 * @created 05-8-2009 오후 2:19:58
 */

@Service("egovPopupManageService")
public class EgovPopupManageServiceImpl extends AbstractServiceImpl implements EgovPopupManageService {

	@Resource(name = "popupManageDAO")
	public PopupManageDAO dao;

    @Resource(name = "egovPopupManageIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
    
    @Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
        
    private HashMap<String, SiteManageVO> popupHash = new HashMap<String, SiteManageVO>();
        
	public EgovPopupManageServiceImpl(){}

	/**
	 * 기 등록된 팝업창정보를 삭제한다.
	 * @param popupManage - 팝업창 model
	 * @return boolean - 반영성공 여부
	 * 
	 * @param popupManage
	 */
	public void deletePopup(PopupManageVO popupManageVO) throws Exception {
	    dao.deletePopup(popupManageVO);
	    
	    publishPopupChangeLog(popupManageVO.getSiteId(), "popupDelete");
	}

	/**
	   * 임시첨부파일을 정식으로 등록 한다.
	   * 
	   */
	  public String insertFileInfsByTemp(PopupManageVO popup) throws Exception {
		  FileVO fvo = new FileVO();
		  fvo.setAtchFileId(popup.getAtchFileId());
		  fvo.setFileGroupId(popup.getFileGroupId());
		  return fileMngService.insertFileInfsByTemp(fvo).getAtchFileId();
	  }
	  
	/**
	 * 팝업창정보를 신규로 등록한다.
	 * @param popupManage - 팝업창 model
	 * @return boolean - 반영성공 여부
	 * 
	 * @param popupManage
	 */
	public void insertPopup(PopupManageVO popupManageVO) throws Exception {
	    String sMakeId = idgenService.getNextStringId();
	    popupManageVO.setPopupId(sMakeId);
	    
	    popupManageVO.setAtchFileId(this.insertFileInfsByTemp(popupManageVO));
	    
	    dao.insertPopup(popupManageVO);
	    
	    publishPopupChangeLog(popupManageVO.getSiteId(), "popupCreate");
	}

    /**
     * 기 등록된 팝업창정보를 수정한다.
     * @param popupManage - 팝업창 model
     * @return boolean - 반영성공 여부
     * 
     * @param popupManage
     */
    public void updatePopup(PopupManageVO popupManageVO) throws Exception {
    	
    	popupManageVO.setAtchFileId(this.insertFileInfsByTemp(popupManageVO));
    	
    	dao.updatePopup(popupManageVO);
        
    	publishPopupChangeLog(popupManageVO.getSiteId(), "popupUpdate");
    }

	/**
	 * 팝업창을 사용자 화면에서 볼수 있는 정보들을 조회한다.
	 * @param popupManageVO - 팝업창 Vo
	 * @return popupManageVO - 팝업창 Vo
	 * 
	 * @param popupManageVO
	 */
	public PopupManageVO selectPopup(PopupManageVO popupManageVO) throws Exception {
		return (PopupManageVO)dao.selectPopup(popupManageVO);
	}

	/**
	 * 팝업창를 관리하기 위해 등록된 팝업창목록을 조회한다.
	 * @param popupManageVO - 팝업창 Vo
	 * @return List - 팝업창 목록
	 * 
	 * @param popupManageVO
	 */
	public List<PopupManageVO> selectPopupList(PopupManageVO popupManageVO) throws Exception {
		return dao.selectPopupList(popupManageVO);
	}
	
	
    /**
     * 팝업창를 관리하기 위해 등록된 팝업창목록을 조회한다.
     * @param popupManageVO - 팝업창 Vo
     * @return List - 팝업창 목록
     * 
     * @param popupManageVO
     */
    public int selectPopupListCount(PopupManageVO popupManageVO) throws Exception {
            return (Integer)dao.selectPopupListCount(popupManageVO);
    }
    
    /**
	 * 서비스 팝업목록을 조회한다.
	 * @param popupManageVO - 팝업 Vo
	 * @return List - 팝업 목록
	 * @exception Exception
	 */
	public void selectPopupServiceListBinding(SiteManageVO siteVO, PopupManageVO vo) throws Exception {
		
		List<PopupManageVO> popupList = dao.selectPopupServiceList(vo);
		if(popupList == null) {
			if(this.popupHash.containsKey(vo.getSiteId())) {
	    		this.popupHash.remove(vo.getSiteId());
	    	}
		} else {
			siteVO.setPopupList(popupList);
			
	    	if(this.popupHash.containsKey(vo.getSiteId())) {
	    		this.popupHash.remove(vo.getSiteId());
	    	}
	    	
	    	this.popupHash.put(vo.getSiteId(), siteVO);
		}
	}
	
    /**
     * 서비스용 팝업 목록을 조회한다.
     * 
     * @param PopupManageVO
     */
    public List<PopupManageVO> selectPopupServiceList(PopupManageVO vo) throws Exception {
    	
    	if(!EgovStringUtil.isEmpty(vo.getSiteId())) {
	    	if(!this.popupHash.containsKey(vo.getSiteId())) {
	    		
	    		SiteManageVO newSiteVO = new SiteManageVO();
	    		newSiteVO.setSiteId(vo.getSiteId());
	    		newSiteVO.setPopupLastModified(this.getPublishFileLastModified(vo.getSiteId()));
	    		
	    		this.selectPopupServiceListBinding(newSiteVO, vo);
	    		
	    	} else {
	    	
	    		long fileLastModified = this.getPublishFileLastModified(vo.getSiteId());
	    		SiteManageVO siteVO = this.popupHash.get(vo.getSiteId());	    		
	    		if(siteVO.getPopupLastModified() < fileLastModified) {
	    			siteVO.setPopupLastModified(fileLastModified);
					this.selectPopupServiceListBinding(siteVO, vo);
				}
	    	}
	    	
	    	if(this.popupHash.containsKey(vo.getSiteId())) {
	    		List<PopupManageVO> result = new ArrayList<PopupManageVO>();
	    		List<PopupManageVO> popupList = this.popupHash.get(vo.getSiteId()).getPopupList();
	    		if(popupList != null && popupList.size() > 0) {
	        		for(int i = 0; i < popupList.size(); i++) {
			    		long el = Long.parseLong(popupList.get(i).getNtceEndde());
						long cl = Long.parseLong(EgovDateUtil.getToday("yyyyMMddHHmm"));
						if(cl <= el) {
							result.add(popupList.get(i));
						}
	    			}
	    		}
	    		return result;
	    	}
    	}
    	
    	return null;
    }
    
    /**
     * 서비스용 팝업을 조회한다.
     * 
     * @param PopupManageVO
     */
    public PopupManageVO selectPopupService(PopupManageVO vo) throws Exception {
    	
    	PopupManageVO popup = null;
    	List<PopupManageVO> popupList = selectPopupServiceList(vo);
    	if(popupList != null && popupList.size() > 0) {
    		for(int i = 0; i < popupList.size(); i++) {
    			if(popupList.get(i).getPopupId().equals(vo.getPopupId())) {
    				popup = popupList.get(i);
    				break;
    			}
    		}
    	}
    	
    	return popup;
    }
    
    public void publishPopupChangeLog(String siteId, String action) throws Exception {		
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("popLogChangeFileName"), siteId + " " + action);
    }
    
    public long getPublishFileLastModified(String siteId) {
    	long fileLastModified = 0L;
    	String fileNm = propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("popLogChangeFileName");
		File file  = new File(fileNm);
		if(file.exists()) {
			fileLastModified = file.lastModified();
		}
		
		return fileLastModified;
    }


}