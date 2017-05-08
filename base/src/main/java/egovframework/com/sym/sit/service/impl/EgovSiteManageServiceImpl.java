package egovframework.com.sym.sit.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.Globals;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.sym.ext.service.EgovOrgCodeVO;
import egovframework.com.sym.mpm.service.EgovMpmService;
import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteMainContentsManageVO;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 
 * 사이트정보를 처리하는 구현 클래스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *
 * </pre>
 */
@Service("SiteManageService")
public class EgovSiteManageServiceImpl extends AbstractServiceImpl implements
        EgovSiteManageService {

    @Resource(name="SiteManageDAO")
    private SiteManageDAO siteManageDAO;
    
    @Resource(name = "EgovMpmService")
	private EgovMpmService egovMpmService;
    
    @Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;
    
    @Resource(name="egovSiteManageIdGnrService")
	private EgovIdGnrService idgenService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	private HashMap<String, SiteManageVO> siteHash = new HashMap<String, SiteManageVO>();
	

	/**
     * 사이트기관코드정보를 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public SiteManageVO selectSiteSimpleInfo(SiteManageDefaultVO vo) throws Exception {
    	
        return siteManageDAO.selectSiteSimpleInfo(vo);
        
    }
	
	/**
     * 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    public List<SiteManageVO> selectSiteSimpleList() throws Exception {
    	
        return siteManageDAO.selectSiteSimpleList();
        
    }
    
    /**
     * [교과코드] 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    public List<SiteManageVO> selectSiteListForOrgCode(EgovOrgCodeVO vo) throws Exception {
    	
        return siteManageDAO.selectSiteListForOrgCode(vo);
        
    }
    
	 /**
     * 도메인으로 부터 사이트정보 를 조회한다.
     */
    public void selectSiteListBinding(String domain, long fileLastModified) throws Exception {
    		
		SiteManageDefaultVO searchVO = new SiteManageDefaultVO();
		searchVO.setSearchDomain(domain);		
		SiteManageVO siteVO = siteManageDAO.selectSiteByDomain(searchVO);

		if(siteVO == null) {
			if(this.siteHash.containsKey(domain)) {
				this.siteHash.remove(domain);
			}
		} else {
			if(fileLastModified == 0L) {
				fileLastModified = this.getPublishFileLastModified(siteVO.getSiteId());
			}
			
			siteVO.setLastModified(fileLastModified);
	    	
	    	if(this.siteHash.containsKey(domain)) {
	    		this.siteHash.remove(domain);
	    	}
	    	
	    	this.siteHash.put(domain, siteVO);
		}
    }

    /**
     * 모든사이트정보 를 조회한다.
     */
	public HashMap<String, SiteManageVO> getSiteHash() {
		return siteHash;
	}

	/**
	 * 요청 도메인으로 부터 사이트정보 조회한다.
	 * @param request - 사용자요청정보
	 * @return SiteManageVO
	 * @exception Exception
	 */
    public SiteManageVO selectSiteServiceInfo(HttpServletRequest request) throws Exception {
    	
    	String domain = request.getServerName();
    	
    	return selectSiteServiceInfo(domain);
    	
    }
        
    public SiteManageVO selectSiteServiceInfo(String domain) throws Exception {

    	if(!this.siteHash.containsKey(domain)) {
    		this.selectSiteListBinding(domain, 0L);
    		
    	} else {
	    	SiteManageVO siteVO = this.siteHash.get(domain);
	    	long fileLastModified = this.getPublishFileLastModified(siteVO.getSiteId());
	    	if(siteVO.getLastModified() < fileLastModified) {
				this.selectSiteListBinding(domain, fileLastModified);
			}
    	}
    	
    	return this.siteHash.get(domain);
    }
    
    /**
	 * SITE_ID로 부터 사이트정보 조회한다.
	 * @param request - 사용자요청정보
	 * @return SiteManageVO
	 * @exception Exception
	 */
    public SiteManageVO selectSiteServiceInfoBySiteId(String siteId) throws Exception {
    	
    	SiteManageVO siteVO = null;
    	for (Iterator<String> iterator = this.siteHash.keySet().iterator(); iterator.hasNext();) {
    		siteVO = this.siteHash.get(iterator.next());
    		if(siteId.equals(siteVO.getSiteId())) {
    			return siteVO;
    		}
    	}
    	
    	return siteVO;
    }
        
    /**
	 * 사이트상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 SiteManageVO
	 * @return 조회한 글
	 * @exception Exception
	 */
    public SiteManageVO selectSiteDetail(SiteManageDefaultVO vo) throws Exception {
        SiteManageVO resultVO = siteManageDAO.selectSiteDetail(vo);
        return resultVO;
    }

    /**
	 * 사이트정보 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    public List<SiteManageVO> selectSiteList(SiteManageDefaultVO searchVO) throws Exception {
        return siteManageDAO.selectSiteList(searchVO);
    }

    /**
	 * 사이트정보 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
    public int selectSiteListTotCnt(SiteManageDefaultVO searchVO) {
		return siteManageDAO.selectSiteListTotCnt(searchVO);
	}
    
    /**
	 * 메뉴아이디를 생성한다.
	 */
	public String selectSiteIdGnr() throws Exception {
		return idgenService.getNextStringId();
	}
    
	/**
	 * 사이트정보를 등록한다.
	 * @param vo - 등록할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void insertSiteInfo(SiteManageVO vo, SiteMainContentsManageVO mainContentsVO) throws Exception {
		    	
    	siteManageDAO.insertSiteInfo(vo);  
    	
    	List<String> bbsIdList = new ArrayList<String>();
    	if("Y".equals(vo.getAutoMakeMenuAt())) {
    		MpmVO autoMakeMpmSearchVO = new MpmVO();
    		autoMakeMpmSearchVO.setSiteId(Globals.MENU_AUTO_MAKE_SITE_ID);    		
    		List<Mpm> mpmList = egovMpmService.selectFullMpmList(autoMakeMpmSearchVO);
    		if(mpmList != null && mpmList.size() > 0) {
    			mpmList = egovMpmService.updateNewMenuIdGen(mpmList);
    			
    			Mpm mpm = null;
    			BoardMaster boardMaster = null;
    			for(int i=0; i < mpmList.size(); i++) {
    				mpm = mpmList.get(i);
    				mpm.setSiteId(vo.getSiteId());
    				if(EgovStringUtil.isEmpty(mpm.getUpperMenuId())) {
    					mpm.setMenuNm(vo.getSiteNm());
    				}
    				
    				if("CTS02".equals(mpm.getCntntsTyCode())) {
    					boardMaster = new BoardMaster();
    					boardMaster.setSiteId(vo.getSiteId());
    					boardMaster.setSysTyCode(vo.getSysTyCode());
    					boardMaster.setBbsNm(mpm.getMenuNm());
    					boardMaster.setBbsAttrbCode(mpm.getProgrmId());
    					mpm.setProgrmId(bbsAttrbService.insertBBSMastetInf(boardMaster));
    					
    					if(bbsIdList.size() < 2) {	//2개까지만 넣는다.
    						bbsIdList.add(mpm.getProgrmId());
    					}
    				}
    				
    				mpm.setFrstRegisterId(vo.getFrstRegisterId());
    			}
    			
    			egovMpmService.insertMpmBatch(mpmList);
    		}
    	} else {
	    	MpmVO mpm = new MpmVO();
	        mpm.setMenuNm(vo.getSiteNm());
	        mpm.setSiteId(vo.getSiteId());
	        mpm.setCompositionTyCode("CNTNTS");
	        mpm.setHtmlUseAt("N");
	        //mpm.setHtmlCn(EgovFormBasedFileUtil.readFile(propertyService.getString("publish.tmplat.lyt.ori.fileStorePathByJspFile") + "/sit/index.jsp"));
	        mpm.setFrstRegisterId(vo.getFrstRegisterId());
	        egovMpmService.insertMpm(mpm);
    	}
    	
    	siteManageDAO.deleteSiteMainContents(mainContentsVO);
    	if(mainContentsVO.getBbsIdList() == null || mainContentsVO.getBbsIdList().size() == 0){
    		mainContentsVO.setBbsIdList(bbsIdList);
    	}
    	
    	if(mainContentsVO.getBbsIdList() != null && mainContentsVO.getBbsIdList().size() > 0){
    		SiteMainContentsManageVO imcVO = new SiteMainContentsManageVO();
    		imcVO.setSiteId(mainContentsVO.getSiteId());
			imcVO.setCntntsTyCode("SMCTS01");
    		for(int i = 0; i < mainContentsVO.getBbsIdList().size(); i++) {
    			imcVO.setProgrmId(mainContentsVO.getBbsIdList().get(i));
    			imcVO.setSortOrdr(i);
    			siteManageDAO.insertSiteMainContents(imcVO);
    		}
    	}
    	
    	publishCreate(vo, "siteCreate");
    }
    
	/**
	 * 사이트정보를 수정한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void updateSiteInfo(SiteManageVO vo, SiteMainContentsManageVO mainContentsVO) throws Exception {
    	log.debug(vo.toString());
    	    	           	
    	siteManageDAO.updateSiteInfo(vo);   
    	
    	siteManageDAO.deleteSiteMainContents(mainContentsVO);
    	if(mainContentsVO.getBbsIdList() != null && mainContentsVO.getBbsIdList().size() > 0){
    		SiteMainContentsManageVO imcVO = new SiteMainContentsManageVO();
    		imcVO.setSiteId(mainContentsVO.getSiteId());
			imcVO.setCntntsTyCode("SMCTS01");
    		for(int i = 0; i < mainContentsVO.getBbsIdList().size(); i++) {
    			imcVO.setProgrmId(mainContentsVO.getBbsIdList().get(i));
    			imcVO.setSortOrdr(i);
    			siteManageDAO.insertSiteMainContents(imcVO);
    		}
    	}
    	
    	publishCreate(vo, "siteUpdate");
    }

	/**
	 * 사이트정보를 삭제한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void deleteSiteInfo(SiteManageVO vo) throws Exception {
    	log.debug(vo.toString());
    	    	
    	siteManageDAO.deleteSiteInfo(vo);   
    	
    	publishDelete(vo, "siteDelete");
    }
    
    /**
	 * 보안설정을 배치처리한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void batchScrtySetup(SiteManageVO vo) throws Exception {
    	siteManageDAO.updateBatchScrtySetup(vo);
    }
    
    /**
	 * 보안정책을 배치처리한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void batchScrtyPolicy(SiteManageVO vo) throws Exception {
    	siteManageDAO.updateBatchScrtyPolicy(vo);
    }
    
    public void publishCreate(SiteManageVO vo, String action) throws Exception {
   	 
		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "indvdlInfoPolicy.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\" %>\n" + vo.getIndvdlInfoPolicy());
		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "useStplat.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\" %>\n" + vo.getUseStplat());
		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "emailColctPolicy.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\" %>\n" + vo.getEmailColctPolicy());
		 EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "cpyrhtSttemntSvc.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\" %>\n" + vo.getCpyrhtSttemntSvc());
   	 
		 publishSiteChangeLog(vo, action);
   }
    
    public void publishDelete(SiteManageVO vo, String action) throws Exception {
      	 
       	 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "indvdlInfoPolicy.jsp");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "useStplat.jsp");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "emailColctPolicy.jsp");
 		 EgovFormBasedFileUtil.deleteFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + "cpyrhtSttemntSvc.jsp");
      	 
 		 publishSiteChangeLog(vo, action);
      }
    
    public void publishSiteChangeLog(SiteManageVO vo, String action) throws Exception {		
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + vo.getSiteId() + "/" + propertyService.getString("sitLogChangeFileName"), vo.getSiteId() + " " + action);
    }
    
    public long getPublishFileLastModified(String siteId) {
    	long fileLastModified = 0L;
    	if(!EgovStringUtil.isEmpty(siteId)) {
	    	String fileNm = propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("sitLogChangeFileName");
			File file  = new File(fileNm);
			if(file.exists()) {
				fileLastModified = file.lastModified();
			}
    	}
		
		return fileLastModified;
    }
}
