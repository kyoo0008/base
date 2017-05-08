package egovframework.com.uss.ion.sit.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.uss.ion.sit.service.LinkSiteManageDefaultVO;
import egovframework.com.uss.ion.sit.service.LinkSiteManageVO;

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
@Repository("LinkSiteManageDAO")
public class LinkSiteManageDAO extends EgovAbstractDAO {


    /**
     * 사이트 목록에 대한 상세내용을 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    public LinkSiteManageVO selectSiteDetail(LinkSiteManageVO vo) throws Exception {
    	
        return (LinkSiteManageVO) selectByPk("LinkSiteManageDAO.selectSiteDetail", vo);
        
    }

    /**
     * 사이트정보 목록을 조회한다.
     * @param searchVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkSiteManageVO> selectSiteList(LinkSiteManageDefaultVO searchVO) throws Exception {
    	
        return list("LinkSiteManageDAO.selectSiteList", searchVO);
        
    }

    /**
     * 사이트정보 총 갯수를 조회한다.
     * @param searchVO
     * @return
     */
    public int selectSiteListTotCnt(LinkSiteManageDefaultVO searchVO) {
    	
        return (Integer)getSqlMapClientTemplate().queryForObject("LinkSiteManageDAO.selectSiteListTotCnt", searchVO);
        
    }
    
	/**
	 * 사이트정보를 등록한다.
	 * @param vo
	 * @throws Exception
	 */
    public void insertSiteInfo(LinkSiteManageVO vo) throws Exception {
    	
        insert("LinkSiteManageDAO.insertSiteInfo", vo);
        
    }
    
	/**
	 * 사이트정보를 수정한다.
	 * @param vo
	 * @throws Exception
	 */
    public void updateSiteInfo(LinkSiteManageVO vo) throws Exception {
    	
        update("LinkSiteManageDAO.updateSiteInfo", vo);
        
    }

	/**
	 * 사이트정보를 삭제한다.
	 * @param vo
	 * @throws Exception
	 */
    public void deleteSiteInfo(LinkSiteManageVO vo) throws Exception {
    	
        delete("LinkSiteManageDAO.deleteSiteInfo", vo);
        
    }
    
    /**
     * 서비스용 사이트정보 목록을 조회한다.
     * @param searchVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkSiteManageVO> selectSiteServiceList(LinkSiteManageDefaultVO searchVO) throws Exception {
    	
        return list("LinkSiteManageDAO.selectSiteServiceList", searchVO);
        
    }
    
}
