package egovframework.com.cop.bbs.service.impl;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.CommentVO;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시물 관리를 위한 서비스 구현 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 * 
 * </pre>
 */
@Service("EgovBBSManageService")
public class EgovBBSManageServiceImpl extends AbstractServiceImpl implements EgovBBSManageService {
  
	@Resource(name = "BBSManageDAO")
	private BBSManageDAO bbsMngDAO;
	
	@Resource(name = "EgovBBSCommentService")
	protected EgovBBSCommentService bbsCommentService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	@Resource(name = "egovBbsNttNoGnrService")
    private EgovIdGnrService idgenService;
  
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	  	
	Logger log = Logger.getLogger(this.getClass());
  
  /**
   * 게시물 한 건을 삭제 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#deleteBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
   */
  public void deleteBoardArticle(BoardVO board, BoardMaster master) throws Exception {
    
	  if(master != null) {
		  board.setBbsAttrbCode(master.getBbsAttrbCode());
	  }
	  
	  
	  FileVO fvo = new FileVO();
    
	  fvo.setAtchFileId(board.getAtchFileId());
    
	  //board.setNttSj("이 글은 작성자에 의해서 삭제되었습니다.");
    
	  bbsMngDAO.deleteBoardArticle(board);
    
	  //if(!"".equals(fvo.getAtchFileId()) || fvo.getAtchFileId() != null) {
	  //  fileService.deleteAllFileInf(fvo);
   	  //}
  }
  
  /**
   * 임시첨부파일을 정식으로 등록 한다.
   * 
   */
  public String insertFileInfsByTemp(BoardVO board) throws Exception {
	  FileVO fvo = new FileVO();
	  fvo.setAtchFileId(board.getAtchFileId());
	  fvo.setFileGroupId(board.getFileGroupId());
	  return fileMngService.insertFileInfsByTemp(fvo).getAtchFileId();
  }
  
  /**
   * 게시판에 게시물을 등록 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
   */
  public void insertBoardArticle(BoardVO board, BoardMaster master) throws Exception {
	  if(board.getNttNo() == null) {
		  board.setNttNo(idgenService.getNextBigDecimalId());
	  }
	  if(master != null) {
		  board.setBbsAttrbCode(master.getBbsAttrbCode());
	  }
	  
	  board.setAtchFileId(this.insertFileInfsByTemp(board));
	  
	  bbsMngDAO.insertBoardArticle(board);
	  
  }
  
  /**
   * 게시판에 답변 게시물을 등록 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
   */
  public void replyBoardArticle(BoardVO board, BoardMaster master) throws Exception {
	  if(board.getNttNo() == null) {
		  board.setNttNo(idgenService.getNextBigDecimalId());
	  }
	  
	  if(master != null) {
		  board.setBbsAttrbCode(master.getBbsAttrbCode());
	  }
	  
	  board.setAtchFileId(this.insertFileInfsByTemp(board));
	  
	  bbsMngDAO.replyBoardArticle(board);
	  
  }
  
  /**
   * 게시물 대하여 상세 내용을 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#selectBoardArticle(egovframework.com.cop.bbs.brd.service.BoardVO)
   */
  public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
    if(boardVO.isPlusCount()) {
    	bbsMngDAO.updateInqireCo(boardVO);
    }
    
    BoardVO resultVO = bbsMngDAO.selectBoardArticle(boardVO);
    
    if (resultVO == null)
        throw processException("info.nodata.msg");
    
    
    return resultVO;
  }
  
  /**
   * 조건에 맞는 게시물 목록을 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#selectBoardArticles(egovframework.com.cop.bbs.brd.service.BoardVO)
   */
  public List<BoardVO> selectBoardArticles(BoardVO boardVO) throws Exception {
	  return bbsMngDAO.selectBoardArticleList(boardVO);
  }
  
  /**
   * 조건에 맞는 게시물 목록건수를 조회 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#selectBoardArticles(egovframework.com.cop.bbs.brd.service.BoardVO)
   */
  public int selectBoardArticlesCnt(BoardVO boardVO) throws Exception {
	  return bbsMngDAO.selectBoardArticleListCnt(boardVO);
  }
  
  /**
   * 게시물 한 건의 내용을 수정 한다.
   * 
   * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#updateBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
   */
  public void updateBoardArticle(BoardVO board, BoardMaster master, boolean isEstn) throws Exception {
	  if(master != null) {
		  board.setBbsAttrbCode(master.getBbsAttrbCode());
	  }
	  
	  String atchFileId = this.insertFileInfsByTemp(board);
	  if(isEstn) {
		  board.setEstnAtchFileId(atchFileId);
	  } else {
		  board.setAtchFileId(atchFileId);
	  }
	  
	  //bbsMngDAO.updateBoardArticle(board);
	  //2012-12-20 알티베이스때문에 업데이트문을 쿼리가 아닌 서비스에서 분기한다.
	  if(!"BBSA11".equals(board.getBbsAttrbCode())) {
		  bbsMngDAO.updateBoardArticleByNormal(board);
	  } else {
		  if(EgovStringUtil.isEmpty(board.getProcessSttusCode())) {
			  bbsMngDAO.updateBoardArticleByEmptyProcessSttusCode(board);
		  } else {
			  bbsMngDAO.updateBoardArticleByProcessSttusCode(board);
		  }
	  }
  }
  
  /**
   * 조건에 맞는 게시물 목록을 조회 한다.
   * 
   * @param boardVO
   * @return
   * @throws Exception
   */
  public List<BoardVO> selectSearchBoardArticleList(BoardVO boardVO) throws Exception {
  	return bbsMngDAO.selectSearchBoardArticleList(boardVO);
  }

  /**
   * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
   * 
   * @param boardVO
   * @return
   * @throws Exception
   */
  public int selectSearchBoardArticleListCnt(BoardVO boardVO) throws Exception {
  	return bbsMngDAO.selectSearchBoardArticleListCnt(boardVO);
  }
  
  /**
   * 관리용 게시물을 이동시킨다.
   * 
   * @param board
   * @throws Exception
   */
  public void updateBoardArticlesManageMove(BoardVO board) throws Exception {
	  bbsMngDAO.updateBoardArticlesManageMove(board);
  }
  
  /**
   * 관리용 게시물을 복사한다.
   * 
   * @param board
   * @throws Exception
   */
  
  public void updateBoardArticlesManageCopy(BoardVO board) throws Exception {
	  /*
	  List<BoardVO> articleList = bbsMngDAO.selectBoardArticlesManageCopyList(board);
	  if(articleList != null && articleList.size() > 0) {
		  articleList = updateNewNttNoGen(articleList);
		  for(int i = 0; i < articleList.size(); i++) {
			  articleList.get(i).setBbsId(board.getTrgetId());
			  articleList.get(i).setCtgryId(board.getCtgryId());
		  }
		  
		  articleList = fileMngService.updateFileManageCopy(articleList);
		  bbsMngDAO.insertBoardArticleBatch(articleList);
		  
		  bbsCommentService.updateCommentManageCopy(board.getNttNoArr(), articleList);
	  }
	  */
  }
  
  /**
   * 게시물번호를 재배치한다.
   * 
   * @param mpmList
   */
  
  public List<BoardVO> updateNewNttNoGen(List<BoardVO> articleList) throws Exception {
	/*
	BoardVO article = null;
  	for(int i = 0; i < articleList.size(); i++) {
  		article = articleList.get(i);
  		updateNewNttNoGen(articleList, article.getNttNo(), idgenService.getNextBigDecimalId());
	}
	*/	
  	return articleList;
  	
  }
  /**
   * 게시물번호를 재배치한다.
   * 
   * @param mpmList
   * @param oldMenuId
   * @param newMenuId
   */
  
  public void updateNewNttNoGen(List<BoardVO> articleList, BigDecimal oldNttNo, BigDecimal newNttNo) throws Exception {
	/*
	BoardVO article = null;
	String ordrCode = EgovStringUtil.lpad(oldNttNo.toString(), 15, "0");
  	for(int i = 0; i < articleList.size(); i++) {
  		article = articleList.get(i);
		if(ordrCode.equals(article.getOrdrCode().substring(0, 15))) {
			article.setOrdrCode(EgovStringUtil.lpad(newNttNo.toString(), 15, "0") + article.getOrdrCode().substring(15));
		}
		if(oldNttNo.equals(article.getNttNo())) {
			article.setNttNo(newNttNo);
			article.setOldNttNo(oldNttNo);
		}
	}
	*/
  }
  
  /**
   * 관리용 게시물을 삭제한다.
   * 
   * @param board
   * @throws Exception
   */
  public void updateBoardArticlesManageHide(BoardVO board) throws Exception {
	  bbsMngDAO.updateBoardArticlesManageHide(board);
  }
  
  /**
   * 게시물 한 건을 완전삭제 한다.
   * 
   * @param board
   * @throws Exception
   */
  public void deleteCompleteBoardArticle(BoardVO board) throws Exception {
	  List<BoardVO> articleList = bbsMngDAO.selectBoardArticlesManageSimpleList(board);
	  if(articleList != null && articleList.size() > 0) {
		  //코멘트먼저 삭제
		  CommentVO commentVO = new CommentVO();
		  commentVO.setNttNoArr(board.getNttNoArr());
		  bbsCommentService.deleteAllComment(commentVO);
		  //게시물삭제
		  bbsMngDAO.deleteCompleteBoardArticle(board);
		  //파일 삭제
		  BoardVO article = null;
		  for(int i = 0; i < articleList.size(); i++) {
			  article = articleList.get(i);
			  if(!EgovStringUtil.isEmpty(article.getAtchFileId())) {
				  fileMngService.deleteFileInfs(article.getAtchFileId());
			  }
		  }
	  }
  }
  
  /**
   * 게시물 한 건을 복구 한다.
   * 
   * @param board
   * @throws Exception
   */
  public void repairBoardArticle(BoardVO board) throws Exception {
	  bbsMngDAO.repairBoardArticle(board);
  }
  
}
