package egovframework.com.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.com.service.BoardUseInf;
import egovframework.com.cop.com.service.impl.BBSUseInfoManageDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 게시판 속성관리를 위한 서비스 구현 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.24  이삼섭          최초 생성
 *   2009.06.26	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 * 
 * </pre>
 */
@Service("EgovBBSAttributeManageService")
public class EgovBBSAttributeManageServiceImpl extends AbstractServiceImpl implements EgovBBSAttributeManageService {
  
 
	@Resource(name = "BBSAttributeManageDAO")
	private BBSAttributeManageDAO    attrbMngDAO;

	@Resource(name = "BBSUseInfoManageDAO")
	private BBSUseInfoManageDAO bbsUseDAO;

	@Resource(name = "egovBBSMstrIdGnrService")
  	private EgovIdGnrService         idgenService;

  
  // //-------------------------------
  
  /**
   * 등록된 게시판 속성정보를 삭제한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#deleteBBSMasterInf(egovframework.com.cop.bbs.brd.service.BoardMaster)
   */
  public void deleteBBSMasterInf(BoardMaster boardMaster) throws Exception {
    attrbMngDAO.deleteBBSMasterInf(boardMaster);
    
    BoardUseInf bdUseInf = new BoardUseInf();	
	bdUseInf.setBbsId(boardMaster.getBbsId());
	bdUseInf.setLastUpdusrId(boardMaster.getLastUpdusrId());
	bbsUseDAO.deleteBBSUseInfByBoardId(bdUseInf);
  }
  
  /**
   * 신규 게시판 속성정보를 생성한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#insertBBSMastetInf(egovframework.com.cop.bbs.brd.service.BoardMaster)
   */
  public String insertBBSMastetInf(BoardMaster boardMaster) throws Exception {
    String bbsId = idgenService.getNextStringId();

    boardMaster.setBbsId(bbsId);    
    attrbMngDAO.insertBBSMasterInf(boardMaster);

    BoardUseInf bdUseInf = new BoardUseInf();
    bdUseInf.setBbsId(bbsId);
    bdUseInf.setTrgetId(boardMaster.getTrgetId());
    bdUseInf.setRegistSeCode(boardMaster.getRegistSeCode());
    bdUseInf.setFrstRegisterId(boardMaster.getFrstRegisterId());
    bdUseInf.setUseAt("Y");
    bbsUseDAO.insertBBSUseInf(bdUseInf);

    return bbsId;
  }
  
  /**
   * 게시판 속성 정보의 목록을 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectAllBBSMasteInf(egovframework.com.cop.bbs.brd.service.BoardMasterVO)
   */
  public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo) throws Exception {
    return attrbMngDAO.selectAllBBSMasteInf(vo);
  }
  
  /**
   * 게시판 속성정보 한 건을 상세조회한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInf(egovframework.com.cop.bbs.brd.service.BoardMasterVO)
   */
  public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO) throws Exception {
    
    BoardMasterVO result = attrbMngDAO.selectBBSMasterInf(searchVO);
    
        
    return result;
    // //-------------------------------
    
  }
  
  
  /**
   * 게시판 속성 정보의 목록을 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInfs(egovframework.com.cop.bbs.brd.service.BoardMasterVO)
   */
  public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception {
    List<BoardMasterVO> result = attrbMngDAO.selectBBSMasterInfs(searchVO);
    int cnt = attrbMngDAO.selectBBSMasterInfsCnt(searchVO);
    
    Map<String, Object> map = new HashMap<String, Object>();
    
    map.put("resultList", result);
    map.put("resultCnt", Integer.toString(cnt));
    
    return map;
  }

  /**
   * 게시판 속성 정보의 전체 목록을 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInfs(egovframework.com.cop.bbs.brd.service.BoardMasterVO)
   */
  public List<BoardMasterVO> selectBBSMasterList(BoardMasterVO searchVO) throws Exception {
    return attrbMngDAO.selectBBSMasterInfs(searchVO);
  }
  
  /**
   * 게시판 속성정보를 수정한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#updateBBSMasterInf(egovframework.com.cop.bbs.brd.service.BoardMaster)
   */
  public void updateBBSMasterInf(BoardMaster boardMaster) throws Exception {
    attrbMngDAO.updateBBSMasterInf(boardMaster);
  }
  
  /**
   * 사용등록이 된 게시판 목록 전체를 불러온다.
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List<BoardMasterVO> selectAllBBSMasterManageInfs(BoardMasterVO vo) throws Exception {
	return attrbMngDAO.selectAllBBSMasterManageInfs(vo);
  }
  
  /**
   * 사용등록이 된 게시판 목록 숫자를 조회한다
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int selectAllBBSMasterManageInfsCnt(BoardMasterVO vo) throws Exception {
	return attrbMngDAO.selectAllBBSMasterManageInfsCnt(vo);
  }
  
}
