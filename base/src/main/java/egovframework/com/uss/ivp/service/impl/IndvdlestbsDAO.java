package egovframework.com.uss.ivp.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.uss.ivp.service.IndvdlestbsVO;

/**
 * @Class Name : IndvdlestbsDAO.java
 * @Description : Indvdlestbs DAO Class
 * @Modification Information
 *
 * @author 이호영
 * @since 2012.01.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("IndvdlestbsDAO")
public class IndvdlestbsDAO extends EgovAbstractDAO {

	/**
	 * COMTNINDVDLESTBS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 IndvdlestbsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertIndvdlestbs(IndvdlestbsVO vo) throws Exception {
        return (String)insert("indvdlestbsDAO.insertIndvdlestbs_S", vo);
    }

    /**
	 * COMTNINDVDLESTBS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 IndvdlestbsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteIndvdlestbs(IndvdlestbsVO vo) throws Exception {
        delete("indvdlestbsDAO.deleteIndvdlestbs", vo);
    }
    
    /**
	 * 개인설정  메뉴목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNINDVDLESTBS 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
    public List<MpmVO> selectMyMenuList(IndvdlestbsVO searchVO) throws Exception {
        return list("indvdlestbsDAO.selectMyMenuList", searchVO);
    }

}
