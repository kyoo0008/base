package egovframework.com.sym.ccm.zip.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.com.sym.ccm.zip.service.EgovCcmRdnmZipManageService;
import egovframework.com.sym.ccm.zip.service.RdnmZipVO;
import egovframework.com.sym.ccm.zip.service.RdnmZip;
import egovframework.com.sym.ccm.zip.service.impl.EgovCcmRdnmZipDAO;

/**
 * @Class Name : RdnmZipServiceImpl.java
 * @Description : RdnmZip Business Implement class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121130
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("RdnmZipManageService")
public class EgovCcmRdnmZipManageServiceImpl extends AbstractServiceImpl implements
	EgovCcmRdnmZipManageService {

    @Resource(name="EgovCcmRdnmZipDAO")
    private EgovCcmRdnmZipDAO rdnmZipManageDAO;
    

	/**
	 * COMTNRDNMADRZIP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 RdnmZipVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertRdnmZip(RdnmZip vo) throws Exception {
    	log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	log.debug(vo.toString());
    	
    	rdnmZipManageDAO.insertRdnmZip(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * COMTNRDNMADRZIP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 RdnmZipVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateRdnmZip(RdnmZip vo) throws Exception {
        rdnmZipManageDAO.updateRdnmZip(vo);
    }

    /**
	 * COMTNRDNMADRZIP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 RdnmZipVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteRdnmZip(RdnmZip vo) throws Exception {
        rdnmZipManageDAO.deleteRdnmZip(vo);
    }

    /**
	 * COMTNRDNMADRZIP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    public RdnmZip selectRdnmZip(RdnmZip vo) throws Exception {
    	return rdnmZipManageDAO.selectRdnmZip(vo);
    }
    
    /**
	 * 시도명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    public List<String> selectCtprvnNm(RdnmZipVO searchVO) throws Exception {
    	return rdnmZipManageDAO.selectCtprvnNm(searchVO);
    }
    
    /**
	 * 시군구명 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 RdnmZipVO
	 * @return 조회한 COMTNRDNMADRZIP
	 * @exception Exception
	 */
    public List<String> selectSignguNm(RdnmZipVO searchVO) throws Exception {
    	return rdnmZipManageDAO.selectSignguNm(searchVO);
    }

    /**
	 * COMTNRDNMADRZIP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNRDNMADRZIP 목록
	 * @exception Exception
	 */
    public List<RdnmZipVO> selectRdnmZipList(RdnmZipVO searchVO) throws Exception {
        return rdnmZipManageDAO.selectRdnmZipList(searchVO);
    }

    /**
	 * COMTNRDNMADRZIP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNRDNMADRZIP 총 갯수
	 * @exception
	 */
    public int selectRdnmZipListTotCnt(RdnmZipVO searchVO) {
		return rdnmZipManageDAO.selectRdnmZipListTotCnt(searchVO);
	}
    
}
