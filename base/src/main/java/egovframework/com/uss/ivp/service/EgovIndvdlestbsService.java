package egovframework.com.uss.ivp.service;

import java.util.List;

import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.uss.ivp.service.IndvdlestbsVO;

public interface EgovIndvdlestbsService {
	
	/**
	 * 선택한 개인 배경화면을 저장한다.
	 * @param vo - 등록할 정보가 담긴 IndvdlestbsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertIndvdlestbs(IndvdlestbsVO vo) throws Exception;
    
    /**
	 * COMTNINDVDLESTBS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 IndvdlestbsVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteIndvdlestbs(IndvdlestbsVO vo) throws Exception;
    
    /**
	 * 개인설정  메뉴목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNINDVDLESTBS 목록
	 * @exception Exception
	 */
    List<MpmVO> selectMyMenuList(IndvdlestbsVO searchVO) throws Exception;
    
}
