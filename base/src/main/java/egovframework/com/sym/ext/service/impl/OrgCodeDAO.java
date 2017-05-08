package egovframework.com.sym.ext.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.sym.ext.service.EgovOrgCodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("orgCodeDAO")
public class OrgCodeDAO extends EgovAbstractDAO {
	
	/**
	 * 지역명 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovOrgCodeVO> selectOrgAreaList(EgovOrgCodeVO searchVO) throws Exception {
        return list("OrgCodeDAO.selectOrgAreaList", searchVO);
    }
	
	/**
	 * ORG_CODE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovOrgCodeVO> selectOrgCodeList(EgovOrgCodeVO searchVO) throws Exception {
        return list("OrgCodeDAO.selectOrgCodeList", searchVO);
    }

    /**
	 * ORG_CODE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 총 갯수
	 * @exception
	 */
    public int selectOrgCodeListTotCnt(EgovOrgCodeVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("OrgCodeDAO.selectOrgCodeListTotCnt", searchVO);
    }
    
    /**
	 * ORG_CODE를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public EgovOrgCodeVO selectOrgCode(EgovOrgCodeVO searchVO) throws Exception {
        return (EgovOrgCodeVO)selectByPk("OrgCodeDAO.selectOrgCode", searchVO);
    }
    
}
