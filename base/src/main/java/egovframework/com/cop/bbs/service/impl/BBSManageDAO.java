package egovframework.com.cop.bbs.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
 * @author 정정욱
 * @since 2011.9.07
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2011.9.07  정정욱          최초 생성
 *
 * </pre>
 */
@Repository("BBSManageDAO")
public class BBSManageDAO extends EgovAbstractDAO {

    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void insertBoardArticle(BoardVO board) throws Exception {
    	insert("BBSManageDAO.insertBoardArticle", board);
    }

    /**
     * 게시판에 답변 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void replyBoardArticle(BoardVO board) throws Exception {
    	insert("BBSManageDAO.replyBoardArticle", board);
    }
	
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
    	return (BoardVO)selectByPk("BBSManageDAO.selectBoardArticle", boardVO);
    }

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
    	return list("BBSManageDAO.selectBoardArticleList", boardVO);
    }

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectBoardArticleListCnt", boardVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticle(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticle", board);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteBoardArticle(BoardVO board) throws Exception {
    	update("BBSManageDAO.deleteBoardArticle", board);
    }

    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateInqireCo(BoardVO boardVO) throws Exception {
    	update("BBSManageDAO.updateInqireCo", boardVO);
    }
    
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectSearchBoardArticleList(BoardVO boardVO) throws Exception {
    	return list("BBSManageDAO.selectSearchBoardArticleList", boardVO);
    }

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectSearchBoardArticleListCnt(BoardVO boardVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectSearchBoardArticleListCnt", boardVO);
    }
    
    /**
     * 관리용 게시물을 이동시킨다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticlesManageMove(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticlesManageMove", board);
    }
    
    /**
     * 관리용 게시물을 삭제시킨다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticlesManageHide(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticlesManageHide", board);
    }
    
    /**
     * 게시물 한 건을 완전삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteCompleteBoardArticle(BoardVO board) throws Exception {
    	update("BBSManageDAO.deleteCompleteBoardArticle", board);
    }
    
    /**
     * 게시물 한 건을 복구 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void repairBoardArticle(BoardVO board) throws Exception {
    	update("BBSManageDAO.repairBoardArticle", board);
    }
    
    /**
     * 관리용 게시물의 최소정보를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardArticlesManageSimpleList(BoardVO boardVO) throws Exception {
    	return list("BBSManageDAO.selectBoardArticlesManageSimpleList", boardVO);
    }
    
    /**
     * 관리용 게시물의 이동을 위한 모든정보를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> selectBoardArticlesManageCopyList(BoardVO boardVO) throws Exception {
    	return list("BBSManageDAO.selectBoardArticlesManageCopyList", boardVO);
    }
    
    /**
     * 관리용 게시물을 일괄등록한다.
     * 
     * @param articleList
     * @return
     * @throws Exception
     */
    public void insertBoardArticleBatch(final List<BoardVO> articleList) throws Exception {
    	
    	if(articleList != null && articleList.size() > 0) {
	    	getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              for(int i = 0; i < articleList.size(); i++) {
		            	  insert("BBSManageDAO.insertBoardArticle", articleList.get(i));
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		    });
    	}
    	
    }
    
    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticleByNormal(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticleByNormal", board);
    }
    
    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticleByEmptyProcessSttusCode(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticleByEmptyProcessSttusCode", board);
    }
    
    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticleByProcessSttusCode(BoardVO board) throws Exception {
    	update("BBSManageDAO.updateBoardArticleByProcessSttusCode", board);
    }
    
}
