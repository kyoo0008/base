package egovframework.com.uss.ion.sit.service;

import java.util.List;

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
public interface EgovLinkSiteManageService {
	    
    /**
     * 사이트정보를 상세조회한다.
     * @param vo
     * @return	글 내용
     * @throws Exception
     */
	LinkSiteManageVO selectSiteDetail(LinkSiteManageVO vo) throws Exception;
    
    /**
     * 사이트목록을 조회한다.
     * @param searchVO
     * @return 글 목록
     * @throws Exception
     */
	List<LinkSiteManageVO> selectSiteList(LinkSiteManageDefaultVO searchVO) throws Exception;
    
    /**
     * 사이트정보 총 갯수를 조회한다.
     * @param searchVO
     * @return	총 갯수
     */
    int selectSiteListTotCnt(LinkSiteManageDefaultVO searchVO);
    
	/**
	 * 사이트정보를 등록한다.
	 * @param vo
	 * @throws Exception
	 */
    void insertSiteInfo(LinkSiteManageVO vo) throws Exception;
    

	/**
	 * 사이트정보를 수정한다.
	 * @param vo
	 * @throws Exception
	 */
    void updateSiteInfo(LinkSiteManageVO vo) throws Exception;
    
	/**
	 * 사이트정보를 삭제한다.
	 * @param vo
	 * @throws Exception
	 */
    void deleteSiteInfo(LinkSiteManageVO vo) throws Exception;
    
    /**
     * 서비스용 사이트정보 목록을 조회한다.
     * @param searchVO
     * @return
     * @throws Exception
     */
    List<LinkSiteManageVO> selectSiteServiceList(LinkSiteManageVO vo) throws Exception;
    
}
