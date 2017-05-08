package egovframework.com.cop.bbs.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.Comment;
import egovframework.com.cop.bbs.service.CommentVO;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 댓글관리를 위한 서비스 구현 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *
 * </pre>
 */
@Service("EgovBBSCommentService")
public class EgovBBSCommentServiceImpl extends AbstractServiceImpl implements EgovBBSCommentService {

    @Resource(name = "BBSCommentDAO")
    private BBSCommentDAO bbsCommentDAO;

    @Resource(name = "egovBbsCommentNoGnrService")
    private EgovIdGnrService idgenService;
        
    /**
     * 댓글에 대한 목록을 조회 한다.
     */
    public Map<String, Object> selectCommentList(CommentVO commentVO) throws Exception {
	List<CommentVO> result = bbsCommentDAO.selectCommentList(commentVO);
	int cnt = bbsCommentDAO.selectCommentListCnt(commentVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }
    
    /**
     * 댓글을 등록한다.
     */
    public void insertComment(Comment comment) throws Exception {
    	comment.setCommentNo(idgenService.getNextBigDecimalId());
    	bbsCommentDAO.insertComment(comment);
    	
    }
    
    /**
     * 댓글의 댓글을 등록한다
     */
    public void insertReplyComment(CommentVO commentVO) throws Exception {
    	commentVO.setCommentNo(idgenService.getNextBigDecimalId());
    	commentVO.setPrntOrdrCode(commentVO.getOrdrCode());
    	commentVO.setOrdrCodeDp(commentVO.getOrdrCodeDp() + 1);
    	bbsCommentDAO.insertReplyComment(commentVO);
    }
    
    /**
     * 댓글을 삭제한다.
     */
    public void deleteComment(CommentVO commentVO) throws Exception {
	bbsCommentDAO.deleteComment(commentVO);
	
    }
    
    /**
     * 모든 댓글을 삭제한다.
     * 
     * @param commentVO
     * @throws Exception
     */
    public void deleteAllComment(CommentVO commentVO) throws Exception {
    bbsCommentDAO.deleteAllComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     */
    public Comment selectComment(CommentVO commentVO) throws Exception {
	return bbsCommentDAO.selectComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     */
    public void updateComment(Comment comment) throws Exception {
	bbsCommentDAO.updateComment(comment);
    }
    
    /**
     * 댓글 패스워드를 가져온다.
     */
    public String getCommentPassword(Comment comment) throws Exception {
	return bbsCommentDAO.getCommentPassword(comment);
    }
    
    /**
     * 내가 작성한 댓글에 대한 목록 건수를 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public int selectMyCommentListCnt(CommentVO commentVO) throws Exception {
	return bbsCommentDAO.selectMyCommentListCnt(commentVO);
    }
    
    /**
     * 관리용 댓글을 복사한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateCommentManageCopy(List<String> nttNoArr, List<BoardVO> articleList) throws Exception {
    	
    	CommentVO commentVO = new CommentVO();
		commentVO.setNttNoArr(nttNoArr);
		
  	  	List<CommentVO> commentList = bbsCommentDAO.selectCommentManageCopyList(commentVO);
  	  	if(commentList != null && commentList.size() > 0) {
  	  		commentList = updateNewCommentNoGen(commentList);
  	  		commentList = updateNewNttNo(commentList, articleList);
  		
  	  		bbsCommentDAO.insertCommentBatch(commentList);
  	  	}
    }
    
    /**
     *  게시물번호를 재배치한다.
     * 
     * @param commentList
     */
    public List<CommentVO> updateNewNttNo(List<CommentVO> commentList, List<BoardVO> articleList) throws Exception {

    	for(int i = 0; i < articleList.size(); i++) {
  			updateNewNttNo(commentList, articleList.get(i).getOldNttNo(), articleList.get(i).getNttNo());
  		}
  		
    	return commentList;
    }
    
    /**
     *  게시물번호를 재배치한다.
     * 
     * @param commentList
     * @param oldNttNo
     * @param newNttNo
     */
    public void updateNewNttNo(List<CommentVO> commentList, BigDecimal oldNttNo, BigDecimal newNttNo) throws Exception {
  	
    	CommentVO comment = null;
    	for(int i = 0; i < commentList.size(); i++) {
    		comment = commentList.get(i);  		
    		if(oldNttNo.equals(comment.getNttNo())) {
    			comment.setNttNo(newNttNo);
    		}
    	}
  	}
    	
    /**
     *  댓글번호를 재배치한다.
     * 
     * @param mpmList
     */
    public List<CommentVO> updateNewCommentNoGen(List<CommentVO> commentList) throws Exception {

    	for(int i = 0; i < commentList.size(); i++) {
    		updateNewCommentNoGen(commentList, commentList.get(i).getCommentNo(), idgenService.getNextBigDecimalId());
    	}
  		
    	return commentList;
    }
    
    /**
     *  댓글번호를 재배치한다.
     * 
     * @param mpmList
     * @param oldMenuId
     * @param newMenuId
     */
    public void updateNewCommentNoGen(List<CommentVO> commentList, BigDecimal oldCommentNo, BigDecimal newCommentNo) throws Exception {
  	
    	CommentVO comment = null;
    	String ordrCode = EgovStringUtil.lpad(oldCommentNo.toString(), 15, "0");
    	for(int i = 0; i < commentList.size(); i++) {
    		comment = commentList.get(i);
	  		if(ordrCode.equals(comment.getOrdrCode().substring(0, 15))) {
	  			comment.setOrdrCode(EgovStringUtil.lpad(newCommentNo.toString(), 15, "0") + comment.getOrdrCode().substring(15));
	  		}
	  		if(oldCommentNo.equals(comment.getCommentNo())) {
	  			comment.setCommentNo(newCommentNo);
	  		}
	  	}
    }
}
