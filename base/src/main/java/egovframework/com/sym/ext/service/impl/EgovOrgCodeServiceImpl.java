package egovframework.com.sym.ext.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.sym.ext.service.EgovOrgCodeService;
import egovframework.com.sym.ext.service.EgovOrgCodeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("EgovOrgCodeService")
public class EgovOrgCodeServiceImpl extends AbstractServiceImpl implements EgovOrgCodeService {

    @Resource(name = "orgCodeDAO")
    private OrgCodeDAO orgCodeDAO;

    @Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

    /**
	 * 지역명 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public List<EgovOrgCodeVO>  selectOrgAreaList(EgovOrgCodeVO searchVO) throws Exception {
		searchVO.setBaseBlngCityCd(propertyService.getString("baseBlngEduInstCd"));
		searchVO.setBaseOrgCd(propertyService.getString("baseOrgCd"));
        return orgCodeDAO.selectOrgAreaList(searchVO);
    }
	
	/**
	 * ORG_CODE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public List<EgovOrgCodeVO>  selectOrgCodeList(EgovOrgCodeVO searchVO) throws Exception {
		searchVO.setBaseBlngCityCd(propertyService.getString("baseBlngEduInstCd"));
		searchVO.setBaseOrgCd(propertyService.getString("baseOrgCd"));
        return orgCodeDAO.selectOrgCodeList(searchVO);
    }

    /**
	 * ORG_CODE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 총 갯수
	 * @exception
	 */
    public int selectOrgCodeListTotCnt(EgovOrgCodeVO searchVO) throws Exception {
    	searchVO.setBaseBlngCityCd(propertyService.getString("baseBlngEduInstCd"));
		searchVO.setBaseOrgCd(propertyService.getString("baseOrgCd"));
        return orgCodeDAO.selectOrgCodeListTotCnt(searchVO);
    }
    
    /**
	 * ORG_CODE를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public EgovOrgCodeVO selectOrgCode(EgovOrgCodeVO searchVO) throws Exception {
        return orgCodeDAO.selectOrgCode(searchVO);
    }
}
