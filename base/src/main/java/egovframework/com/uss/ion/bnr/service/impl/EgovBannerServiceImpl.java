/**
 * 개요
 * - 배너에 대한 ServiceImpl 클래스를 정의한다.
 * 
 * 상세내용
 * - 배너에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * - 배너의 조회기능은 목록조회, 상세조회로 구분된다.
 * @author 이문준
 * @version 1.0
 * @created 03-8-2009 오후 2:07:12
 */

package egovframework.com.uss.ion.bnr.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.FileVO;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uss.ion.bnr.service.Banner;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.bnr.service.EgovBannerService;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;

@Service("egovBannerService")
public class EgovBannerServiceImpl implements EgovBannerService {

	@Resource(name="bannerDAO")
    private BannerDAO bannerDAO;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	private HashMap<String, SiteManageVO> bannerHash = new HashMap<String, SiteManageVO>();
	
	/**
	 * 배너를 관리하기 위해 등록된 배너목록을 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return List - 배너 목록
	 */
	public List<BannerVO> selectBannerList(BannerVO bannerVO) throws Exception{
		return bannerDAO.selectBannerList(bannerVO);
	}

	/**
	 * 배너목록 총 갯수를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return int - 배너 카운트 수
	 */
	public int selectBannerListTotCnt(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectBannerListTotCnt(bannerVO);
	}
	
	/**
	 * 등록된 배너의 상세정보를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return BannerVO - 배너 VO
	 */
	public BannerVO selectBanner(BannerVO bannerVO) throws Exception{
		return bannerDAO.selectBanner(bannerVO);
	}

	/**
	 * 배너정보를 신규로 등록한다.
	 * @param banner - 배너 model
	 */
	public BannerVO insertBanner(Banner banner, BannerVO bannerVO) throws Exception{
        bannerDAO.insertBanner(banner);
        
        publishBannerChangeLog(banner.getSiteId(), "bannerCreate");
        
        return selectBanner(bannerVO);
	}

	/**
	 * 기 등록된 배너정보를 수정한다.
	 * @param banner - 배너 model
	 */
	public void updateBanner(Banner banner) throws Exception{
        bannerDAO.updateBanner(banner);
        
        publishBannerChangeLog(banner.getSiteId(), "bannerUpdate");
	}

	/**
	 * 기 등록된 배너정보를 삭제한다.
	 * @param banner - 배너 model
	 */
	public void deleteBanner(Banner banner) throws Exception {
		deleteBannerFile(banner);
        bannerDAO.deleteBanner(banner);
        
        publishBannerChangeLog(banner.getSiteId(), "bannerDelete");
	}

	/**
	 * 기 등록된 배너정보의 이미지파일을 삭제한다.
	 * @param banner - 배너 model
	 */
	public void deleteBannerFile(Banner banner) throws Exception{
		FileVO fileVO = (FileVO)bannerDAO.selectBannerFile(banner);
		try {
			File file = new File(fileVO.getFileStreCours()+fileVO.getStreFileNm());
			file.delete();
		} catch(Exception e) {}
	}

	/**
	 * 배너가 특정화면에 반영된 결과를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return BannerVO - 배너 VO
	 */
	public List<BannerVO> selectBannerResult(BannerVO bannerVO) throws Exception{
		return bannerDAO.selectBannerResult(bannerVO);
	}

	/**
	 * 서비스 배너목록을 조회한다.
	 * @param bannerVO - 배너 Vo
	 * @return List - 배너 목록
	 * @exception Exception
	 */
	public void selectBannerServiceListBinding(SiteManageVO siteVO, BannerVO vo) throws Exception {
		
		List<BannerVO> bannerList = bannerDAO.selectBannerServiceList(vo);
		if(bannerList == null) {
			if(this.bannerHash.containsKey(vo.getSiteId())) {
	    		this.bannerHash.remove(vo.getSiteId());
	    	}
		} else {
			siteVO.setBannerList(bannerList);
			
	    	if(this.bannerHash.containsKey(vo.getSiteId())) {
	    		this.bannerHash.remove(vo.getSiteId());
	    	}
	    	
	    	this.bannerHash.put(vo.getSiteId(), siteVO);
		}
	}
	
	/**
     * 서비스용 팝업존배너 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectPopupZoneServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN001");
	}
	
	/**
     * 서비스용 배너존배너 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectBannerZoneServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN002");
	}
	
	/**
     * 서비스용 퀵배너 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectQuickZoneServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN003");
	}
	
	/**
     * 메인용 배너 타입1 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectMainBannerType1ServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN004");
	}
	
	/**
     * 메인용 배너 타입2 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectMainBannerType2ServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN005");
	}
	
	/**
     * 서비스용 서브배너 목록을 조회한다.
     * 
     * @param vo
     */
	public List<BannerVO> selectSubBannerServiceList(BannerVO vo) throws Exception {
		return selectBannerServiceList(selectBannerServiceList(vo), "BAN006");
	}
	
	/**
     * 서비스용 배너유형별 목록을 조회한다.
     * 
     * @param BannerVO
     */
    public List<BannerVO> selectBannerServiceList(List<BannerVO> bannerList, String bannerTyCode) throws Exception {
    	
    	List<BannerVO> result = new ArrayList<BannerVO>();
    	if(bannerList != null && bannerList.size() > 0) {
    		for(int i = 0; i < bannerList.size(); i++) {
    			if(bannerList.get(i).getBannerTyCode().equals(bannerTyCode)) {
    				//팝업존은 시간을 체크한다.
    				if("BAN001".equals(bannerTyCode)) {
    					long el = Long.parseLong(bannerList.get(i).getNtceEndde());
    					long cl = Long.parseLong(EgovDateUtil.getToday("yyyyMMddHHmm"));
    					if(cl <= el) {
    						result.add(bannerList.get(i));
    					}
    				} else {
    					result.add(bannerList.get(i));
    				}
				}
    		}
    	}
    	
    	return result;
    }
    
	/**
     * 서비스용 배너정보 목록을 조회한다.
     * 
     * @param BannerVO
     */
    public List<BannerVO> selectBannerServiceList(BannerVO vo) throws Exception {
    	
    	if(!EgovStringUtil.isEmpty(vo.getSiteId())) {
	    	if(!this.bannerHash.containsKey(vo.getSiteId())) {
	    		
	    		SiteManageVO newSiteVO = new SiteManageVO();
	    		newSiteVO.setSiteId(vo.getSiteId());
	    		newSiteVO.setBannerLastModified(this.getPublishFileLastModified(vo.getSiteId()));
	    		
	    		this.selectBannerServiceListBinding(newSiteVO, vo);
	    		
	    	} else {
	    	
	    		long fileLastModified = this.getPublishFileLastModified(vo.getSiteId());
	    		SiteManageVO siteVO = this.bannerHash.get(vo.getSiteId());	    		
	    		if(siteVO.getBannerLastModified() < fileLastModified) {
	    			siteVO.setBannerLastModified(fileLastModified);
					this.selectBannerServiceListBinding(siteVO, vo);
				}
	    	}
	    	
	    	if(this.bannerHash.containsKey(vo.getSiteId())) {
	    		return this.bannerHash.get(vo.getSiteId()).getBannerList();
	    	}
    	}
    	
    	return null;
    }
    
    public void publishBannerChangeLog(String siteId, String action) throws Exception {		
    	EgovFormBasedFileUtil.saveFile(this.propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("banLogChangeFileName"), siteId + " " + action);
    }
    
    public long getPublishFileLastModified(String siteId) {
    	long fileLastModified = 0L;
    	String fileNm = propertyService.getString("publish.mnu.fileStorePathByJspFile") + "/" + siteId + "/" + propertyService.getString("banLogChangeFileName");
		File file  = new File(fileNm);
		if(file.exists()) {
			fileLastModified = file.lastModified();
		}
		
		return fileLastModified;
    }

}