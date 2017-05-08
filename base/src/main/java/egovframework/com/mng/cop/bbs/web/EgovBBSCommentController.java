package egovframework.com.mng.cop.bbs.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cop.bbs.service.Comment;
import egovframework.com.cop.bbs.service.CommentVO;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 댓글관리 서비스 컨트롤러 클래스
 * 
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 * 
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller("mngEgovBBSCommentController")
public class EgovBBSCommentController {
  
	@Resource(name = "EgovBBSCommentService")
	protected EgovBBSCommentService bbsCommentService;
  
	@Resource(name = "propertiesService")
	protected EgovPropertyService   propertyService;
  
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
  
	@Autowired
	private DefaultBeanValidator beanValidator;
  
	Logger log = Logger.getLogger(this.getClass());

/**
 * XSS 방지 처리.
 * 
 * @param data
 * @return
 */
protected String unscript(String data) {
  if(data == null || data.trim().equals("")) {
    return "";
  }
  
  String ret = data;
  
  ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
  ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
  
  ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
  ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
  
  ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
  ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
  
  // ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
  // ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
  
  ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
  ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");
  
  return ret;
}

  /**
   * 댓글관리 목록 조회를 제공한다.
   * 
   * @param boardVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/selectCommentList.do")
  public String selectCommentList(@ModelAttribute("searchVO") CommentVO commentVO, ModelMap model, String urlPrefix, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  try {
	    // 수정 처리된 후 댓글 등록 화면으로 처리되기 위한 구현
	    if(commentVO.isModified()) {
	    	commentVO.setCommentNo(null);
	    	commentVO.setCommentCn("");
	    }
	    
	    // 수정을 위한 처리
	    if(commentVO.getCommentNo() != null) {
	    	return "forward:/mng/cop/bbs/selectSingleComment.do";
	    }
	    
	    model.addAttribute("type", commentVO.getType()); // head or body
	    
	    if(commentVO.getType().equals("head")) {
	    	return "mng/cop/bbs/default/EgovCommentList";
	    }
	    // //----------------------------------------
	    
	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);
	    if(isAuthenticated) {
	      LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	      
	      model.addAttribute("sessionUniqId", user.getId());
	      model.addAttribute("sessionUniqNm", user.getName());
	      
	      commentVO.setWrterNm(user.getName());
	    }
	    
	    commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
	    commentVO.setSubPageSize(propertyService.getInt("pageSize"));
	    
	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(commentVO.getSubPageIndex());
	    paginationInfo.setRecordCountPerPage(commentVO.getSubPageUnit());
	    paginationInfo.setPageSize(commentVO.getSubPageSize());
	    
	    commentVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
	    commentVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
	    commentVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	    
	    Map<String, Object> map = bbsCommentService.selectCommentList(commentVO);
	    int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	    
	    paginationInfo.setTotalRecordCount(totCnt);
	    
	    model.addAttribute("resultList", map.get("resultList"));
	    model.addAttribute("resultCnt", map.get("resultCnt"));
	    model.addAttribute("paginationInfo", paginationInfo);
	    
	    commentVO.setCommentCn(""); // 등록 후 댓글 내용 처리
	  } catch(Exception ex) {
		  ex.printStackTrace();
	  }
    return "mng/cop/bbs/default/EgovCommentList";
  }
  
  /**
   * 댓글을 등록한다.
   * 
   * @param commentVO
   * @param comment
   * @param bindingResult
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/insertComment.do")
  public String insertComment(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	if(request.getSession().getAttribute("sessionCommentVO") != null && comment.getCommentCn().equals((String)request.getSession().getAttribute("sessionCommentVO"))) {
		return "forward:/mng/cop/bbs/selectBoardArticle.do";
	}
	    
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    beanValidator.validate(comment, bindingResult);
    if(bindingResult.hasErrors()) {
      model.addAttribute("msg", "댓글 작성자 및  내용은 필수 입력값입니다.");
      
      return "forward:/mng/cop/bbs/selectBoardArticle.do";
    }
    
	  comment.setFrstRegisterId(user.getId());
	  comment.setWrterNm(user.getName());
	  comment.setCommentCn(unscript(comment.getCommentCn()));
	  bbsCommentService.insertComment(comment);
	  
	  request.getSession().setAttribute("sessionCommentVO", comment.getCommentCn());
	  
	  commentVO.setCommentCn("");
	  commentVO.setCommentNo(null);
    
    
    return "forward:/mng/cop/bbs/selectBoardArticle.do";
  }
  
  /**
   * 댓글에 댓글을 등록한다
   * @param commentVO
   * @param comment
   * @param bindingResult
   * @param model
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/insertReplyComment.do")
  public String insertReplyComment(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	if(request.getSession().getAttribute("sessionCommentVO") != null && comment.getCommentCn().equals((String)request.getSession().getAttribute("sessionCommentVO"))) {
		return "forward:/mng/cop/bbs/selectBoardArticle.do";
	}
	    
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    beanValidator.validate(comment, bindingResult);
    if(bindingResult.hasErrors()) {
      model.addAttribute("msg", "댓글 작성자 및  내용은 필수 입력값입니다.");
      
      return "forward:/mng/cop/bbs/selectBoardArticle.do";
    }
    
    	commentVO.setFrstRegisterId(user.getId());
    	commentVO.setWrterNm(user.getName());
    	commentVO.setCommentCn(unscript(commentVO.getCommentCn()));
      
      bbsCommentService.insertReplyComment(commentVO);
      
      request.getSession().setAttribute("sessionCommentVO", comment.getCommentCn());
      
      commentVO.setCommentCn("");
      commentVO.setCommentNo(null);
        
    return "forward:/mng/cop/bbs/selectBoardArticle.do";
  }
  
  /**
   * 댓글을 삭제한다.
   * 
   * @param commentVO
   * @param comment
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/deleteComment.do")
  public String deleteComment(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);
    
    if(isAuthenticated) {
    	commentVO.setLastUpdusrId(user.getId());
    	bbsCommentService.deleteComment(commentVO);
    }
    
    commentVO.setCommentCn("");
    commentVO.setCommentNo(null);
    
    return "forward:/mng/cop/bbs/selectBoardArticle.do";
  }
    
  /**
   * 댓글 수정 페이지로 이동한다.
   * 
   * @param commentVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/selectSingleComment.do")
  public String selectSingleComment(@ModelAttribute("searchVO") CommentVO commentVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    model.addAttribute("type", commentVO.getType()); // head or body
    
    if(commentVO.getType().equals("head")) {
      return "mng/cop/bbs/default/EgovCommentList";
    }
    // //----------------------------------------
    
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
    commentVO.setWrterNm(user.getName());
    
    commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
    commentVO.setSubPageSize(propertyService.getInt("pageSize"));
    
    PaginationInfo paginationInfo = new PaginationInfo();
    paginationInfo.setCurrentPageNo(commentVO.getSubPageIndex());
    paginationInfo.setRecordCountPerPage(commentVO.getSubPageUnit());
    paginationInfo.setPageSize(commentVO.getSubPageSize());
    
    commentVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
    commentVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
    commentVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    
    Map<String, Object> map = bbsCommentService.selectCommentList(commentVO);
    int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    
    paginationInfo.setTotalRecordCount(totCnt);
    
    model.addAttribute("resultList", map.get("resultList"));
    model.addAttribute("resultCnt", map.get("resultCnt"));
    model.addAttribute("paginationInfo", paginationInfo);
    
    Comment data = bbsCommentService.selectComment(commentVO);
    
    commentVO.setCommentNo(data.getCommentNo());
    commentVO.setNttNo(data.getNttNo());
    commentVO.setWrterNm(data.getWrterNm());
    commentVO.setCommentCn(data.getCommentCn());
    commentVO.setUseAt(data.getUseAt());
    commentVO.setFrstRegisterPnttm(data.getFrstRegisterPnttm());
    
    request.getSession().setAttribute("sessionVO", commentVO);
    
    return "mng/cop/bbs/default/EgovCommentList";
  }
  
  /**
   * 댓글을 수정한다.
   * 
   * @param commentVO
   * @param comment
   * @param bindingResult
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/mng/cop/bbs/updateComment.do")
  public String updateCommentList(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	if(request.getSession().getAttribute("sessionVO") == null) {
		return "forward:/mng/cop/bbs/selectBoardArticle.do";
	}
	  
    LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(request, response);
    
    beanValidator.validate(comment, bindingResult);
    if(bindingResult.hasErrors()) {
      model.addAttribute("msg", "댓글 작성자 및  내용은 필수 입력값입니다.");
      
      return "forward:/mng/cop/bbs/selectBoardArticle.do";
    }
    
    if(isAuthenticated) {
      comment.setLastUpdusrId(user.getId());
      
      bbsCommentService.updateComment(comment);
      
      commentVO.setCommentCn("");
      commentVO.setCommentNo(null);
      
      request.getSession().removeAttribute("sessionVO");
    }
    
    return "forward:/mng/cop/bbs/selectBoardArticle.do";
  }

}
