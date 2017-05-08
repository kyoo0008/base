package egovframework.com.uss.ivp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.com.sym.mpm.service.MpmVO;
import egovframework.com.uss.ivp.service.EgovIndvdlestbsService;
import egovframework.com.uss.ivp.service.IndvdlestbsVO;
import egovframework.com.uss.ivp.service.impl.IndvdlestbsDAO;

@Service("IndvdlestbsService")
public class EgovIndvdlestbsServiceImpl extends AbstractServiceImpl implements
EgovIndvdlestbsService {

    @Resource(name="IndvdlestbsDAO")
    private IndvdlestbsDAO indvdlestbsDAO;
    
	/**
	 * 선택한 개인 배경화면을 저장한다.
	 * @param vo - 등록할 정보가 담긴 IndvdlestbsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertIndvdlestbs(IndvdlestbsVO vo) throws Exception {
    	
    	indvdlestbsDAO.insertIndvdlestbs(vo);
        return null;
    }

    /**
	 * COMTNINDVDLESTBS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 IndvdlestbsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteIndvdlestbs(IndvdlestbsVO vo) throws Exception {
        indvdlestbsDAO.deleteIndvdlestbs(vo);
    }
    
    /**
	 * 개인설정  메뉴목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNINDVDLESTBS 목록
	 * @exception Exception
	 */
    public List<MpmVO> selectMyMenuList(IndvdlestbsVO searchVO) throws Exception {
        return indvdlestbsDAO.selectMyMenuList(searchVO);
    }

}
