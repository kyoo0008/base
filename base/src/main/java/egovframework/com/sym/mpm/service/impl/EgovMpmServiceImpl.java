package egovframework.com.sym.mpm.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.sym.mpm.service.EgovMpmHistoryService;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;


/**
 * 메뉴 서비스 구현 클래스
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2010.12.27  정정욱          최초 생성 
 *  
 *  </pre>
 */
@Service("EgovMpmService")
public class EgovMpmServiceImpl extends AbstractServiceImpl implements EgovMpmService {
	
	@Resource(name="MpmManageDAO")
    private MpmDAO mpmManageDAO;
	
	@Resource(name="EgovMpmHistoryService")
    private EgovMpmHistoryService mpmHistoryService;
	
	@Resource(name = "egovMenuIdGnrService")
	private EgovIdGnrService     egovMenuIdGnrService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	private HashMap<String, SiteManageVO> mnuHash = new HashMap<String, SiteManageVO>();
	
	/**
     * 상위메뉴에 대한 하위메뉴 건수를 조회 한다.
     * 
     * @param Mpm
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(Mpm mpm) throws Exception {
    	return mpmManageDAO.selectBoardArticleListCnt(mpm);
    }
    
    /**
     * 임시첨부파일을 정식으로 등록 한다.
     * 
     */
    public String insertFileInfsByTemp(String atchFileId, String fileGroupId) throws Exception {
  	  FileVO fvo = new FileVO();
  	  fvo.setAtchFileId(atchFileId);
  	  fvo.setFileGroupId(fileGroupId);
  	  return fileMngService.insertFileInfsByTemp(fvo).getAtchFileId();
    }
    
	/**
	 * 메뉴정보를 등록한다
	 * @param vo Mpm
	 */
	public String insertMpm(MpmVO mpm) throws Exception {
		if(EgovStringUtil.isEmpty(mpm.getMenuId())) {
			mpm.setMenuId(selectMenuIdGnr());
		}
		
		mpm.setAtchFileId(insertFileInfsByTemp(mpm.getAtchFileId(), mpm.getFileGroupId()));
		mpm.setMobileAtchFileId(insertFileInfsByTemp(mpm.getMobileAtchFileId(), mpm.getMobileFileGroupId()));
		
		mpmManageDAO.insertMpm(mpm);
		
		mpmHistoryService.insertMpmHistory(mpm);
		
		publishCreate(mpm, "mnuCreate", false);
		return "";
	}
	
	/**
	 * 메뉴아이디를 생성한다.
	 */
	public String selectMenuIdGnr() throws Exception {
		return egovMenuIdGnrService.getNextStringId();
	}
		
	/**
     * 전체메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectFullMpmList(MpmVO vo) throws Exception {
    	return mpmManageDAO.selectFullMpmList(vo);
    }
    
	/**
     * 메뉴 목록을 조회 한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectMpmList(MpmVO vo) throws Exception{
        return mpmManageDAO.selectMpmList(vo);
    }
    
    /**
     * 메뉴상세 내용을 조회 한다.
     * 
     * @param MpmVO
     */
    public MpmVO selectMpm(MpmVO vo) throws Exception {
	return mpmManageDAO.selectMpm(vo);
    }
    
    /**
     * 메뉴 속성정보를 수정한다.
     * 
     * @param Mpm
     */
    public void updateMpm(MpmVO mpm) throws Exception{
    	
    	mpm.setAtchFileId(insertFileInfsByTemp(mpm.getAtchFileId(), mpm.getFileGroupId()));
		mpm.setMobileAtchFileId(insertFileInfsByTemp(mpm.getMobileAtchFileId(), mpm.getMobileFileGroupId()));
		
    	mpmManageDAO.updateMpm(mpm);
    	
    	mpmHistoryService.insertMpmHistory(mpm);
    	
    	publishCreate(mpm, "mnuUpdate", false);
    }
    
    /**
     * 메뉴 속성정보를 삭제한다.
     * 
     * @param Mpm
     */
    public void deleteMpm(MpmVO mpm) throws Exception{
    	mpmManageDAO.deleteMpm(mpm);    
    	
    	publishDelete(mpm, "mnuDelete"); 
    }
    
    /**
     * 메뉴 정렬순서를 수정한다.
     * 
     * @param Mpm
     */
    public int updateMpmSortOrdr(MpmVO vo) throws Exception {
	    int updateCnt = mpmManageDAO.updateMpmSortOrdr(vo);
	    if(updateCnt > 0) {
	    	publishMnuChangeLog(vo, "mnuSortOrdr");
	    }
		
		return updateCnt;
    }	
    
    /**
     * 메뉴를 미리보기형식으로 퍼블리싱한다.
     * 
     * @param Mpm
     */
    public void previewPublish(Mpm mpm) throws Exception {
    	publishCreate(mpm, "mnuPublish", true);
    }
    
    /**
     * 서비스용 메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    public void selectMpmServiceListBinding(SiteManageVO siteVO, MpmVO vo) throws Exception {
    	
		List<Mpm> mpmList = mpmManageDAO.selectMpmServiceList(vo);
		if(mpmList == null) {
			if(this.mnuHash.containsKey(vo.getSiteId())) {
	    		this.mnuHash.remove(vo.getSiteId());
	    	}
		} else {
			siteVO.setMpmList(mpmList);
			
			if(this.mnuHash.containsKey(vo.getSiteId())) {
	    		this.mnuHash.remove(vo.getSiteId());
	    	}	    	
	    	this.mnuHash.put(vo.getSiteId(), siteVO);
		}
    }
    
	/**
     * 서비스용 메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectMpmServiceList(MpmVO vo) throws Exception {
    	
    	if(!EgovStringUtil.isEmpty(vo.getSiteId())) {
	    	if(!this.mnuHash.containsKey(vo.getSiteId())) {
	    		
	    		SiteManageVO newSiteVO = new SiteManageVO();
	    		newSiteVO.setSiteId(vo.getSiteId());
	    		newSiteVO.setMpmLastModified(this.getPublishFileLastModified(vo.getSiteId()));
	    		
	    		this.selectMpmServiceListBinding(newSiteVO, vo);
	    		
	    	} else {
	    	
	    		long fileLastModified = this.getPublishFileLastModified(vo.getSiteId());
	    		SiteManageVO siteVO = this.mnuHash.get(vo.getSiteId());	    		
	    		if(siteVO.getMpmLastModified() < fileLastModified) {
	    			siteVO.setMpmLastModified(fileLastModified);
					this.selectMpmServiceListBinding(siteVO, vo);
				}
	    	}
	    	
	    	if(this.mnuHash.containsKey(vo.getSiteId())) {
	    		return this.mnuHash.get(vo.getSiteId()).getMpmList();
	    	}
    	}
    	
    	return null;
    }
    
    /**
     * 사용자 유형에 맞는 메뉴리스트를 조회한다.
     */
	public List<Mpm> getCustomSiteMpmList(SiteManageVO siteVO, LoginVO user, String groupTy, String adminYn) throws Exception {
		
		Mpm mpm = null;
		List<Mpm> resultList = new ArrayList<Mpm>();
		
		MpmVO paramVO = new MpmVO();
		paramVO.setSiteId(siteVO.getSiteId());
		List<Mpm> mpmList = selectMpmServiceList(paramVO);
		
		for(int iMpm=0; iMpm < mpmList.size(); iMpm++) {
			mpm = mpmList.get(iMpm);
			
			if("A".equals(groupTy)) {
				if(mpm.getMenuLevel() == 0) {
					resultList.add(mpm);
				} else {
					if("Y".equals(adminYn) && "Y".equals(mpm.getExpsrUseAt())) {
						resultList.add(mpm);
					} else if(("Y".equals(mpm.getStdntUseAt()) || "Y".equals(mpm.getStdnprntUseAt()) || "Y".equals(mpm.getProfsrUseAt()) || "Y".equals(mpm.getGeneralUseAt())) && "Y".equals(mpm.getExpsrUseAt())) {
						resultList.add(mpm);
					}
				}
			} else if(EgovStringUtil.isEmpty(groupTy) && "Y".equals(mpm.getExpsrUseAt())) {
				if("Y".equals(adminYn)) {
					resultList.add(mpm);
				//} else if("Y".equals(mpm.getStdntUseAt()) || "Y".equals(mpm.getStdnprntUseAt()) || "Y".equals(mpm.getProfsrUseAt()) || "Y".equals(mpm.getGeneralUseAt())) {
				} else if(user == null && "Y".equals(mpm.getGeneralUseAt())) {
					resultList.add(mpm);
				} else if(user != null) {
					if("S".equals(user.getUserTy()) && ("Y".equals(mpm.getStdntUseAt()) || "Y".equals(mpm.getGeneralUseAt()))) {
						resultList.add(mpm);
					} else if("P".equals(user.getUserTy()) && ("Y".equals(mpm.getStdnprntUseAt()) || "Y".equals(mpm.getGeneralUseAt()))) {
						resultList.add(mpm);
					} else if(("T".equals(user.getUserTy()) || "D".equals(user.getUserTy())) && ("Y".equals(mpm.getProfsrUseAt()) || "Y".equals(mpm.getGeneralUseAt()))) {
						resultList.add(mpm);
					}
				}
			} else if("S".equals(groupTy) && "Y".equals(mpm.getExpsrUseAt()) && "Y".equals(mpm.getStdntUseAt())) {
				resultList.add(mpm);
			} else if("P".equals(groupTy) && "Y".equals(mpm.getExpsrUseAt()) && "Y".equals(mpm.getStdnprntUseAt())) {
				resultList.add(mpm);
			} else if(("T".equals(groupTy) || "D".equals(groupTy)) && "Y".equals(mpm.getExpsrUseAt()) && "Y".equals(mpm.getProfsrUseAt())) {
				resultList.add(mpm);
			}
		}
		
		return resultList;
	}
    
	/**
     * 메뉴정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmFind(List<Mpm> mpmList, String menuId) throws Exception {
    	
    	Mpm findMpm = null;
    	
		if(mpmList != null && mpmList.size() > 0) {
			for(int i = 0; i < mpmList.size(); i++) {
				if(mpmList.get(i).getMenuId().equals(menuId)) {
					findMpm = mpmList.get(i);
					break;
				}
			}
		}
    	
    	return findMpm;
    }
    
    /**
     * 현재메뉴정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmCurrent(List<Mpm> mpmList, MpmVO mnuVO) throws Exception {
    	
    	Mpm currMpm = null;
    	
    	if(!EgovStringUtil.isEmpty(mnuVO.getMenuId())) {
    		currMpm = selectMpmFind(mpmList, mnuVO.getMenuId());
    	}
		
    	return currMpm;
    }
    
    /**
     * 현재메뉴의 최상위메뉴의 정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmCurrentRoot(List<Mpm> mpmList, Mpm currMpm) throws Exception {
    	
    	Mpm currRootMpm = null;
    	
    	if(currMpm != null) {
	    	if(!EgovStringUtil.isEmpty(currMpm.getMenuId())) {
				if(mpmList != null && mpmList.size() > 0) {
					for(int i = 0; i < mpmList.size(); i++) {
						if(mpmList.get(i).getMenuLevel() == 1 && mpmList.get(i).getMenuId().equals(currMpm.getMenuPathById().split(">")[1])) {
							currRootMpm = mpmList.get(i);
							break;
						}
					}
				}
	    	}
    	}
		
    	return currRootMpm;
    }
    
    /**
     * 프로그램으로 메뉴의 정보를 조회한다.
     * 
     * @param progrmId
     */
    public Mpm selectMpmProgram(List<Mpm> mpmList, String progrmId) throws Exception {
    	
    	Mpm progrmMpm = null;
    	
    	if(!EgovStringUtil.isEmpty(progrmId)) {
			if(mpmList != null && mpmList.size() > 0) {
				for(int i = 0; i < mpmList.size(); i++) {
					if(progrmId.equals(mpmList.get(i).getProgrmId())) {
						progrmMpm = mpmList.get(i);
						break;
					}
				}
			}
    	}
		
    	return progrmMpm;
    }
    
    /**
     * 메뉴를 일괄등록한다.
     * 
     * @param mpmList
     * @throws Exception
     */
    public void insertMpmBatch(List<Mpm> mpmList) throws Exception {
    	mpmManageDAO.insertMpmBatch(mpmList);
    }
    
    /**
     * 메뉴아이디를 재배치한다.
     * 
     * @param mpmList
     */
    public List<Mpm> updateNewMenuIdGen(List<Mpm> mpmList) throws Exception {

    	Mpm mpm = null;
    	for(int i = 0; i < mpmList.size(); i++) {
    		mpm = mpmList.get(i);
    		updateNewMenuIdGen(mpmList, mpm.getMenuId(), this.selectMenuIdGnr());
		}
		
    	return mpmList;
    }
    
    /**
     * 메뉴아이디를 재배치한다.
     * 
     * @param mpmList
     * @param oldMenuId
     * @param newMenuId
     */
    public void updateNewMenuIdGen(List<Mpm> mpmList, String oldMenuId, String newMenuId) throws Exception {
    	
    	Mpm mpm = null;
    	for(int i = 0; i < mpmList.size(); i++) {
    		mpm = mpmList.get(i);
			if(oldMenuId.equals(mpm.getUpperMenuId())) {
				mpm.setUpperMenuId(newMenuId);
			}
			if(oldMenuId.equals(mpm.getMenuId())) {
				mpm.setMenuId(newMenuId);
			}
		}
    }
        
    /**
     * 서비스용 프로그램ID로 메뉴아이디를 조회한다.
     * 
     * @param MpmVO
     */
    public String selectMpmByProgrmId(MpmVO vo) throws Exception {
    	return mpmManageDAO.selectMpmByProgrmId(vo);
    }
    
    public void publishCreate(Mpm vo, String action, boolean isPreview) throws Exception {
    	 if("Y".equals(vo.getHtmlUseAt())) {
    		 if(EgovStringUtil.isEmpty(vo.getUpperMenuId())) {
        		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "index" + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".jsp", publishHeaderAppend(vo.getHtmlCn()));
        		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "index" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".jsp", publishHeaderAppend(vo.getMobileHtmlCn()));
        	 } else {
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style" + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".css", vo.getStyleCn());
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script" + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".js", vo.getScriptCn());
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".jsp", publishHeaderAppend(vo.getHtmlCn()));
	    		 
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".css", vo.getMobileStyleCn());
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".js", vo.getMobileScriptCn());
	    		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + Globals.PUBLISH_MOBILE_APPEND_FREFIX + (isPreview ? Globals.PUBLISH_PREVEIW_APPEND_FREFIX : "") + ".jsp", publishHeaderAppend(vo.getMobileHtmlCn()));
        	 }    		 
    	 }
    	 
    	 if(!isPreview) {
    		 publishMnuChangeLog(vo, action);
    	 }
    }
    
    public void publishDelete(Mpm vo, String action) throws Exception {
   	 //if("Y".equals(vo.getHtmlUseAt())) {
    	 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style.css");
    	 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style" + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".css");
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script.js");
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script" + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".js");
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + ".jsp");
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".jsp");
  		 
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + ".css");
  		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "style" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".css");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + ".js");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByWebFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + "/" + "script" + Globals.PUBLISH_MOBILE_APPEND_FREFIX + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".js");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + Globals.PUBLISH_MOBILE_APPEND_FREFIX + ".jsp");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + vo.getMenuId() + Globals.PUBLISH_MOBILE_APPEND_FREFIX + Globals.PUBLISH_PREVEIW_APPEND_FREFIX + ".jsp");
   	 //}
    	 publishMnuChangeLog(vo, action);
   }
    
   public String publishHeaderAppend(String cn) {
	   if(cn != null) {
		   if(!(cn.indexOf("%") != -1 && cn.indexOf("@") != -1 && cn.indexOf("language") != -1 && cn.indexOf("java") != -1 && cn.indexOf("charset") != -1 && cn.indexOf("pageEncoding") != -1)) {
			   return Globals.PUBLISH_HEADER + cn;
		   }
	   }
	   
	   return cn;
   }
    
    public void publishMnuChangeLog(Mpm vo, String action) throws Exception {		
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + propertyService.getString("mpmLogChangeFileName"), vo.getMenuId() + " " + action);
    }
    
    public long getPublishFileLastModified(String siteId) {
    	long fileLastModified = 0L;
    	String fileNm = propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("mpmLogChangeFileName");
		File file  = new File(fileNm);
		if(file.exists()) {
			fileLastModified = file.lastModified();
		}
		
		return fileLastModified;
    }
    
    
    
    /**
     * 메뉴명를 수정한다.
     * 
     * @param Mpm
     */
    public int updateMpmMenuNm(Mpm mpm) throws Exception {
    	int iCount = mpmManageDAO.updateMpmMenuNm(mpm);
    	publishCreate(mpm, "mnuUpdate", false);
    	
    	return iCount;
    }	
    
}
