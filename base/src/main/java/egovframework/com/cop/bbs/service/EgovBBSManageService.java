package egovframework.com.cop.bbs.service;

import java.util.List;


/**
 * 게시물 관리를 위한 서비스 인터페이스  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *
 * </pre>
 */
public interface EgovBBSManageService {

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void deleteBoardArticle(BoardVO Board, BoardMaster master) throws Exception;

    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void insertBoardArticle(BoardVO board, BoardMaster master) throws Exception ;
    
    /**
     * 게시판에 답변 게시물을 등록 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.com.cop.bbs.brd.service.Board)
     */
    public void replyBoardArticle(BoardVO board, BoardMaster master) throws Exception ;
    
    /**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;
    
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<BoardVO> selectBoardArticles(BoardVO boardVO) throws Exception;
    
    /**
     * 조건에 맞는 게시물 목록건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectBoardArticlesCnt(BoardVO boardVO) throws Exception;

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void updateBoardArticle(BoardVO Board, BoardMaster master, boolean isEstn) throws Exception;

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<BoardVO> selectSearchBoardArticleList(BoardVO boardVO) throws Exception ;

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectSearchBoardArticleListCnt(BoardVO boardVO) throws Exception ;
    
    /**
     * 관리용 게시물을 이동시킨다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticlesManageMove(BoardVO board) throws Exception ;
    
    /**
     * 관리용 게시물을 복사한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticlesManageCopy(BoardVO board) throws Exception;
    
    /**
     * 관리용 게시물을 삭제한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticlesManageHide(BoardVO board) throws Exception ;
    
    /**
     * 게시물 한 건을 완전삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteCompleteBoardArticle(BoardVO board) throws Exception ;
    
    /**
     * 게시물 한 건을 복구 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void repairBoardArticle(BoardVO board) throws Exception ;
    
}
