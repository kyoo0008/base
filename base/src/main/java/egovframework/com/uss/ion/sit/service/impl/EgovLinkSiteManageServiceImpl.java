package egovframework.com.uss.ion.sit.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uss.ion.sit.service.LinkSiteManageDefaultVO;
import egovframework.com.uss.ion.sit.service.EgovLinkSiteManageService;
import egovframework.com.uss.ion.sit.service.LinkSiteManageVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;


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
@Service("LinkSiteManageService")
public class EgovLinkSiteManageServiceImpl extends AbstractServiceImpl implements EgovLinkSiteManageService {

    @Resource(name="LinkSiteManageDAO")
    private LinkSiteManageDAO siteManageDAO;
        
    /**
	 * ID Generation
	 */    
	@Resource(name="egovLinkSiteManageIdGnrService")
	private EgovIdGnrService idgenService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	private HashMap<String, SiteManageVO> siteHash = new HashMap<String, SiteManageVO>();
    
    /**
	 * 사이트상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 SiteManageVO
	 * @return 조회한 글
	 * @exception Exception
	 */
    public LinkSiteManageVO selectSiteDetail(LinkSiteManageVO vo) throws Exception {
        LinkSiteManageVO resultVO = siteManageDAO.selectSiteDetail(vo);
        
        return resultVO;
    }

    /**
	 * 사이트정보 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    public List<LinkSiteManageVO> selectSiteList(LinkSiteManageDefaultVO searchVO) throws Exception {
        return siteManageDAO.selectSiteList(searchVO);
    }

    /**
	 * 사이트정보 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
    public int selectSiteListTotCnt(LinkSiteManageDefaultVO searchVO) {
		return siteManageDAO.selectSiteListTotCnt(searchVO);
	}
    
	/**
	 * 사이트정보를 등록한다.
	 * @param vo - 등록할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void insertSiteInfo(LinkSiteManageVO vo) throws Exception {
    	log.debug(vo.toString());
    	    	
		String	siteId = idgenService.getNextStringId();

		vo.setLinkSiteId(siteId);
		
    	siteManageDAO.insertSiteInfo(vo);    	
    	
    	publishSiteChangeLog(vo.getSiteId(), "siteCreate");
    }
    
	/**
	 * 사이트정보를 수정한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void updateSiteInfo(LinkSiteManageVO vo) throws Exception {
    	log.debug(vo.toString());
    	    	           	
    	siteManageDAO.updateSiteInfo(vo);    	
    	
    	publishSiteChangeLog(vo.getSiteId(), "siteUpdate");
    }

	/**
	 * 사이트정보를 삭제한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void deleteSiteInfo(LinkSiteManageVO vo) throws Exception {
    	log.debug(vo.toString());
    	    	
    	siteManageDAO.deleteSiteInfo(vo);    
    	
    	publishSiteChangeLog(vo.getSiteId(), "siteDelete");
    }
    
    /**
     * 서비스용 사이트정보 목록을 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public List<LinkSiteManageVO> selectSiteServiceList(LinkSiteManageVO vo) throws Exception {
    	if(!EgovStringUtil.isEmpty(vo.getSiteId())) {
	    	if(!this.siteHash.containsKey(vo.getSiteId())) {
	    		   		
	    		SiteManageVO newSiteVO = new SiteManageVO();
	    		newSiteVO.setSiteId(vo.getSiteId());
	    		newSiteVO.setLinkSiteLastModified(this.getPublishFileLastModified(vo.getSiteId()));
		    	
	    		this.selectLinkSiteServiceListBinding(newSiteVO, vo);
	    		
	    	} else {
	    	
	    		long fileLastModified = this.getPublishFileLastModified(vo.getSiteId());
		    	SiteManageVO siteVO = this.siteHash.get(vo.getSiteId());
		    	if(siteVO.getLinkSiteLastModified() < fileLastModified) {
		    		siteVO.setLinkSiteLastModified(fileLastModified);
					this.selectLinkSiteServiceListBinding(siteVO, vo);
				}
	    	}
	    	
	    	if(this.siteHash.containsKey(vo.getSiteId())) {
	    		return this.siteHash.get(vo.getSiteId()).getLinkSiteList();
	    	}
    	}
    	
    	return null;
    }
    
    /**
     * 서비스용 사이트 목록을 조회한다.
     * 
     * @param vo
     */
    public void selectLinkSiteServiceListBinding(SiteManageVO siteVO, LinkSiteManageVO vo) throws Exception {
    	    	
		List<LinkSiteManageVO> siteList = siteManageDAO.selectSiteServiceList(vo);
		if(siteList == null) {
			if(this.siteHash.containsKey(vo.getSiteId())) {
	    		this.siteHash.remove(vo.getSiteId());
	    	}
		} else {
			siteVO.setLinkSiteList(siteList);
			
	    	if(this.siteHash.containsKey(vo.getSiteId())) {
	    		this.siteHash.remove(vo.getSiteId());
	    	}
	    	
	    	this.siteHash.put(vo.getSiteId(), siteVO);
		}
    }
    
    public void publishSiteChangeLog(String siteId, String action) throws Exception {		
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("lstLogChangeFileName"), siteId + " " + action);
    }
    
    public long getPublishFileLastModified(String siteId) {
    	long fileLastModified = 0L;
    	String fileNm = propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("lstLogChangeFileName");
		File file  = new File(fileNm);
		if(file.exists()) {
			fileLastModified = file.lastModified();
		}
		
		return fileLastModified;
    }
}
