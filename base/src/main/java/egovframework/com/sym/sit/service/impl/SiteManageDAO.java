package egovframework.com.sym.sit.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.sym.ext.service.EgovOrgCodeVO;
import egovframework.com.sym.sit.service.SiteMainContentsManageVO;
import egovframework.com.sym.sit.service.SiteManageDefaultVO;
import egovframework.com.sym.sit.service.SiteManageVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 사이트정보를 처리하는 DAO 클래스
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
@Repository("SiteManageDAO")
public class SiteManageDAO extends EgovAbstractDAO {


    /**
     * 사이트 목록에 대한 상세내용을 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public SiteManageVO selectSiteDetail(SiteManageDefaultVO vo) throws Exception {
    	
        return (SiteManageVO) selectByPk("SiteManageDAO.selectSiteDetail", vo);
        
    }
    
    /**
     * 도메인으로 부터 사이트에 대한 상세내용을 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public SiteManageVO selectSiteByDomain(SiteManageDefaultVO vo) throws Exception {
    	
        return (SiteManageVO) selectByPk("SiteManageDAO.selectSiteByDomain", vo);
        
    }
    
    /**
     * 사이트기관코드정보를 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public SiteManageVO selectSiteSimpleInfo(SiteManageDefaultVO vo) throws Exception {
    	
        return (SiteManageVO) selectByPk("SiteManageDAO.selectSiteSimpleInfo", vo);
        
    }
    
    /**
     * 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SiteManageVO> selectSiteSimpleList() throws Exception {
    	
        return list("SiteManageDAO.selectSiteSimpleList", null);
        
    }
    
    /**
     * [교과코드] 사이트간략정보 목록을 조회한다.
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SiteManageVO> selectSiteListForOrgCode(EgovOrgCodeVO vo) throws Exception {
    	
        return list("SiteManageDAO.selectSiteListForOrgCode", vo);
        
    }
    
    /**
     * 사이트정보 목록을 조회한다.
     * @param searchVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SiteManageVO> selectSiteList(SiteManageDefaultVO searchVO) throws Exception {
    	
        return list("SiteManageDAO.selectSiteList", searchVO);
        
    }

    /**
     * 사이트정보 총 갯수를 조회한다.
     * @param searchVO
     * @return
     */
    public int selectSiteListTotCnt(SiteManageDefaultVO searchVO) {
    	
        return (Integer)getSqlMapClientTemplate().queryForObject("SiteManageDAO.selectSiteListTotCnt", searchVO);
        
    }
    
	/**
	 * 사이트정보를 등록한다.
	 * @param vo
	 * @throws Exception
	 */
    public void insertSiteInfo(SiteManageVO vo) throws Exception {
    	
        insert("SiteManageDAO.insertSiteInfo", vo);
        
    }
    
	/**
	 * 사이트정보를 수정한다.
	 * @param vo
	 * @throws Exception
	 */
    public void updateSiteInfo(SiteManageVO vo) throws Exception {
    	
        update("SiteManageDAO.updateSiteInfo", vo);
        
    }

	/**
	 * 사이트정보를 삭제한다.
	 * @param vo
	 * @throws Exception
	 */
    public void deleteSiteInfo(SiteManageVO vo) throws Exception {
    	
        delete("SiteManageDAO.deleteSiteInfo", vo);
        
    }
    
    /**
	 * 메인컨텐츠정보를 등록한다.
	 * @param vo
	 * @throws Exception
	 */
    public void insertSiteMainContents(SiteMainContentsManageVO vo) throws Exception {
    	
        insert("SiteManageDAO.insertSiteMainContents", vo);
        
    }
    
    /**
	 * 사이트정보를 삭제한다.
	 * @param vo
	 * @throws Exception
	 */
    public void deleteSiteMainContents(SiteMainContentsManageVO vo) throws Exception {
    	
        delete("SiteManageDAO.deleteSiteMainContents", vo);
        
    }
    
    /**
	 * 보안설정을 배치처리한다.
	 * @param vo
	 * @throws Exception
	 */
    public void updateBatchScrtySetup(SiteManageVO vo) throws Exception {
    	
        update("SiteManageDAO.updateBatchScrtySetup", vo);
        
    }
    
    /**
	 * 보안설정을 배치처리한다.
	 * @param vo
	 * @throws Exception
	 */
    public void updateBatchScrtyPolicy(SiteManageVO vo) throws Exception {
    	
        update("SiteManageDAO.updateBatchScrtyPolicy", vo);
        
    }
    
}
