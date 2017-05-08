package egovframework.com.sym.ext.service;

import java.util.List;

public interface EgovOrgCodeService {

	/**
	 * 지역명 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public List<EgovOrgCodeVO>  selectOrgAreaList(EgovOrgCodeVO searchVO) throws Exception;
	
	/**
	 * ORG_CODE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public List<EgovOrgCodeVO>  selectOrgCodeList(EgovOrgCodeVO searchVO) throws Exception ;

    /**
	 * ORG_CODE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 총 갯수
	 * @exception
	 */
    public int selectOrgCodeListTotCnt(EgovOrgCodeVO searchVO) throws Exception ;
    
    /**
	 * ORG_CODE를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ORG_CODE 목록
	 * @exception Exception
	 */
	public EgovOrgCodeVO selectOrgCode(EgovOrgCodeVO searchVO) throws Exception;
}
