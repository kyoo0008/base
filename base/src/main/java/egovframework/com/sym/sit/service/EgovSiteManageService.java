package egovframework.com.sym.sit.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.com.sym.ext.service.EgovOrgCodeVO;

/**
 * 
 * 사이트정보를 처리하는 클래스
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
public interface EgovSiteManageService {
	    
	
	/**
     * 사이트기관코드정보를 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public SiteManageVO selectSiteSimpleInfo(SiteManageDefaultVO vo) throws Exception;
    
	/**
     * 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    public List<SiteManageVO> selectSiteSimpleList() throws Exception;
    
    /**
     * [교과코드] 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    public List<SiteManageVO> selectSiteListForOrgCode(EgovOrgCodeVO vo) throws Exception;
    
    /**
     * 도메인으로 부터 사이트정보 를 조회한다.
     */
    public void selectSiteListBinding(String domain, long fileLastModified) throws Exception;
	
    /**
     * 모든사이트정보 를 조회한다.
     */
	public HashMap<String, SiteManageVO> getSiteHash() ;
	/**
	 * 요청 도메인으로 부터 사이트정보 조회한다.
	 * @param request - 사용자요청정보
	 * @return SiteManageVO
	 * @exception Exception
	 */
	SiteManageVO selectSiteServiceInfo(HttpServletRequest request) throws Exception;
	
	/**
	 * SITE_ID로 부터 사이트정보 조회한다.
	 * @param request - 사용자요청정보
	 * @return SiteManageVO
	 * @exception Exception
	 */
    public SiteManageVO selectSiteServiceInfoBySiteId(String siteId) throws Exception;
    
    /**
     * 사이트정보를 상세조회한다.
     * @param vo
     * @return	글 내용
     * @throws Exception
     */
	SiteManageVO selectSiteDetail(SiteManageDefaultVO vo) throws Exception;
    
    /**
     * 사이트목록을 조회한다.
     * @param searchVO
     * @return 글 목록
     * @throws Exception
     */
	List<SiteManageVO> selectSiteList(SiteManageDefaultVO searchVO) throws Exception;
    
    /**
     * 사이트정보 총 갯수를 조회한다.
     * @param searchVO
     * @return	총 갯수
     */
    int selectSiteListTotCnt(SiteManageDefaultVO searchVO);
    
    /**
	 * 메뉴아이디를 생성한다.
	 */
	public String selectSiteIdGnr() throws Exception;
	
	/**
	 * 사이트정보를 등록한다.
	 * @param vo
	 * @throws Exception
	 */
    void insertSiteInfo(SiteManageVO vo, SiteMainContentsManageVO mainContentsVO) throws Exception;
    

	/**
	 * 사이트정보를 수정한다.
	 * @param vo
	 * @throws Exception
	 */
    void updateSiteInfo(SiteManageVO vo, SiteMainContentsManageVO mainContentsVO) throws Exception;
    
	/**
	 * 사이트정보를 삭제한다.
	 * @param vo
	 * @throws Exception
	 */
    void deleteSiteInfo(SiteManageVO vo) throws Exception;
    
    /**
	 * 보안설정을 배치처리한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void batchScrtySetup(SiteManageVO vo) throws Exception ;
    
    /**
	 * 보안정책을 배치처리한다.
	 * @param vo - 수정할 정보가 담긴 SiteManageVO
	 * @exception Exception
	 */
    public void batchScrtyPolicy(SiteManageVO vo) throws Exception ;
    
    public void publishCreate(SiteManageVO vo, String action) throws Exception;
    
}
