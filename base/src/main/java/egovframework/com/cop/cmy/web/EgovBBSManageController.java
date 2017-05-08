package egovframework.com.cop.cmy.web;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.Board;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.Ctgry;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSCtgryService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.com.utl.fcc.service.EgovHttpUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29	한성곤	
 * 
 * </pre>
 */
@Controller("EgovCmyBBSManageController")
public class EgovBBSManageController {
  
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService          bbsMngService;
  
	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;
  
	@Resource(name = "EgovBBSCtgryService")
	private EgovBBSCtgryService           ctgryService;
	
	@Resource(name = "SiteManageService")
	EgovSiteManageService 				  siteManageService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService            fileMngService;
  
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil               fileUtil;
  
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService     cmmUseService;
  
	@Resource(name = "egovMessageSource")
	EgovMessageSource                     egovMessageSource;
	
	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService 	cmmntyService;
	
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
    
     ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
     ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
    
    ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
    ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");
    
    return ret;
  }
  
  
  /**
   * 게시물에 대한 목록을 조회한다.
   * 
   * @param boardVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/selectBoardList.do")
  public String selectBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
      PaginationInfo paginationInfo = new PaginationInfo();
    
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  model.addAttribute("siteInfo", siteVO);
	  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
    
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	  
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
        
		// 페이징 정보 설정
	    boardVO.setPageUnit(propertyService.getInt("pageUnit"));
	    boardVO.setPageSize(propertyService.getInt("pageSize"));
	    boardVO.setCtgrymasterId(master.getCtgrymasterId());
	    
	    if("BBSA02".equals(master.getBbsAttrbCode())) {
	    	// 페이징 정보 설정
		    boardVO.setPageUnit(propertyService.getInt("photoPageUnit"));
		    boardVO.setPageSize(propertyService.getInt("photoPageSize"));
		    
	    } else {
	    	//공지게시물 가져오기
	    	BoardVO noticeVO = new BoardVO();
	    	noticeVO.setBbsId(boardVO.getBbsId());
	    	noticeVO.setCommentUseAt(master.getCommentUseAt());
	    	noticeVO.setSearchNoticeAt("Y");
	    	noticeVO.setFirstIndex(0);
	    	noticeVO.setRecordCountPerPage(9999);
	    
	    	model.addAttribute("noticeList", bbsMngService.selectBoardArticles(noticeVO));
	    }
	    
	    paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	    paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	    paginationInfo.setPageSize(boardVO.getPageSize());
	    
	    boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	    boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	    boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	      
		boardVO.setCommentUseAt(master.getCommentUseAt());
		boardVO.setBbsAttrbCode(master.getBbsAttrbCode());
		
        List<BoardVO> resultList = bbsMngService.selectBoardArticles(boardVO);
        int totCnt = bbsMngService.selectBoardArticlesCnt(boardVO);
        
        paginationInfo.setTotalRecordCount(totCnt);
        
        if(!EgovStringUtil.isEmpty(master.getCtgrymasterId())) {
        	Ctgry ctgry = new Ctgry();
			ctgry.setCtgrymasterId(master.getCtgrymasterId());
			model.addAttribute("boardCateList", ctgryService.selectComtnbbsctgryList(ctgry));
			model.addAttribute("boardCateLevel", ctgryService.selectComtnbbsctgryLevel(ctgry));
        }
        
        
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", totCnt);
        model.addAttribute("brdMstrVO", master);
        
        LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);  	  
  	  	if(user != null) {  		  
  	  		CommunityUser cmmntyUser = new CommunityUser();
  	  		cmmntyUser.setSiteId(siteVO.getSiteId());
  	  		cmmntyUser.setEmplyrId(user.getId());
  	  		cmmntyUser.setCmmntyId(boardVO.getTrgetId());
  	  		model.addAttribute("USER_INFO", cmmntyService.selectSingleCommunityUserInf(cmmntyUser));	//사용자 정보
  	  	}
      }
	  
	  model.addAttribute("paginationInfo", paginationInfo);
	  
    
    return "cop/cmy/bbs/cmy_001/EgovNoticeList";
  }
  
  /**
   * 게시물에 대한 상세 정보를 조회한다.
   * 
   * @param boardVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/selectBoardArticle.do")
  public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  model.addAttribute("siteInfo", siteVO);
	  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
        
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {

		  model.addAttribute("brdMstrVO", master);
		  CommunityUser resultInfo = null;
		  int SE_CODE = 1;
			  
		  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);  	  
	  	  if(user != null) {
	  		  CommunityUser cmmntyUser = new CommunityUser();	
	  		  cmmntyUser.setSiteId(siteVO.getSiteId());
	  		  cmmntyUser.setEmplyrId(user.getId());
	  		  cmmntyUser.setCmmntyId(boardVO.getTrgetId());
	  		  resultInfo = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
	  		  if(resultInfo != null) {
	  			  model.addAttribute("USER_INFO", resultInfo);	//사용자 정보	  			  
	  			  SE_CODE = Integer.parseInt(resultInfo.getAuthorCode());
	  		  }
	  		  boardVO.setFrstRegisterId(user.getId());
	  	  }
		  
	  	  if(SE_CODE >= Integer.parseInt(master.getInqireAuthor())){
	  		  if(SE_CODE >= 10) {
	  			  boardVO.setAdminAt("Y");
	  		  }
	  		  // 조회수 증가 여부 지정
			  boardVO.setPlusCount(true);
			  boardVO.setCtgrymasterId(master.getCtgrymasterId());
			  model.addAttribute("board", bbsMngService.selectBoardArticle(boardVO));
			  
			  return "cop/cmy/bbs/cmy_001/EgovNoticeInqire";
	  	  } else {
	  		  model.addAttribute("message", egovMessageSource.getMessage("fail.common.select"));
	  		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  	  }
		  
	  }

	  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.access"));
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }

  /**
   * 게시물 등록을 위한 등록페이지로 이동한다.
   * 
   * @param boardVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/addBoardArticle.do")
  public String addBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	  if(!EgovUserDetailsHelper.isAuthenticated(request, response)) {
	      return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
	  }
	  
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  model.addAttribute("siteInfo", siteVO);
	  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
    
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
		  if(!EgovStringUtil.isEmpty(master.getCtgrymasterId())) {
			  Ctgry ctgry = new Ctgry();
			  ctgry.setCtgrymasterId(master.getCtgrymasterId());
			  model.addAttribute("boardCateList", ctgryService.selectComtnbbsctgryList(ctgry));
			  
			  model.addAttribute("boardCateLevel", ctgryService.selectComtnbbsctgryLevel(ctgry));
	      }
		  	    
		  model.addAttribute("brdMstrVO", master);
		  
		  Board board = new Board();
		  model.addAttribute("board", board);
	  
		  request.getSession().setAttribute("sessionVO", boardVO);
		  CommunityUser resultInfo = null;
		  int SE_CODE = 1;
		  
		  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);  	  
	  	  if(user != null) {  		  
	  		CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(siteVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(boardVO.getTrgetId());
			resultInfo = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
			if(resultInfo != null) {
				model.addAttribute("USER_INFO", resultInfo);	//사용자 정보						
				SE_CODE = Integer.parseInt(resultInfo.getAuthorCode());
	  	  	}
	  	  }
	  	  
	  	  if(SE_CODE >= Integer.parseInt(master.getRegistAuthor())){
	  		  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
	  	  } else {
	  		  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.regist"));
	  		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  	  }
	  }

	  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.access"));
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }
  
  /**
   * 게시물을 등록한다.
   * 
   * @param boardVO
   * @param board
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping(value = "/cop/cmy/bbs/insertBoardArticle.do")
  public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, 
		  Board board, BindingResult bindingResult, 
      HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

	  if(request.getSession().getAttribute("sessionVO") == null) {
		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  }
    
	  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
	  beanValidator.validate(board, bindingResult);
    
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
  
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	  
	  int SE_CODE = 1;
	  CommunityUser cmmntyUser = new CommunityUser();	
	  cmmntyUser.setSiteId(siteVO.getSiteId());
	  cmmntyUser.setEmplyrId(user.getId());
	  cmmntyUser.setCmmntyId(boardVO.getTrgetId());
	  cmmntyUser = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
	  if(cmmntyUser != null) {
		  model.addAttribute("USER_INFO", cmmntyUser);	//사용자 정보	  			  
		  SE_CODE = Integer.parseInt(cmmntyUser.getAuthorCode());
	  }
	  
	  if(bindingResult.hasErrors()) {
      
		  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
			  if(!EgovStringUtil.isEmpty(master.getCtgrymasterId())) {
				  Ctgry ctgry = new Ctgry();
				  ctgry.setCtgrymasterId(master.getCtgrymasterId());
				  model.addAttribute("boardCateList", ctgryService.selectComtnbbsctgryList(ctgry));
				  
				  model.addAttribute("boardCateLevel", ctgryService.selectComtnbbsctgryLevel(ctgry));
		      }
			  			  
			  model.addAttribute("brdMstrVO", master);
			  model.addAttribute("siteInfo", siteVO);
			  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
		  }
      
		  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
	  }
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
		  
		  if(SE_CODE >= Integer.parseInt(master.getRegistAuthor())) {
			  String atchFileId = "";
			  
		      List<FileVO> result = null;
		      
		      final Map<String, MultipartFile> files = multiRequest.getFileMap();
		      if(!files.isEmpty()) {
		        result = fileUtil.parseBoardFileInf(files, 0, "", siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
		        atchFileId = fileMngService.insertFileInfs(result);
		      }
			  
		      boardVO.setAtchFileId(atchFileId);
		      boardVO.setFrstRegisterId(user.getId());
		      boardVO.setNtcrNm(user.getName());      
		      boardVO.setNttCn(unscript(boardVO.getNttCn())); // XSS 방지
		      boardVO.setCreatIp(EgovClntInfo.getClntIP(request));
		      boardVO.setEstnData(EgovHttpUtil.getEstnParseData(request));
		      
		      bbsMngService.insertBoardArticle(boardVO, master);
		  }
	  }

	  request.getSession().removeAttribute("sessionVO");
	  
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }
  
  /**
   * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
   * 
   * @param boardVO
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/addReplyBoardArticle.do")
  public String addReplyBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
	  if(!EgovUserDetailsHelper.isAuthenticated(request, response)) {
	      return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
	  }
	  
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  model.addAttribute("siteInfo", siteVO);
	  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
    
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
	    
		  CommunityUser resultInfo = null;
		  int SE_CODE = 1;
		  
		  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);  	  
	  	  if(user != null) {  		  
	  		CommunityUser cmmntyUser = new CommunityUser();	
			cmmntyUser.setSiteId(siteVO.getSiteId());
			cmmntyUser.setEmplyrId(user.getId());
			cmmntyUser.setCmmntyId(boardVO.getTrgetId());
			resultInfo = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
			if(resultInfo != null) {
				model.addAttribute("USER_INFO", resultInfo);	//사용자 정보
				SE_CODE = Integer.parseInt(resultInfo.getAuthorCode());
			}
	  	  }
	  	  
		  if(SE_CODE >= Integer.parseInt(master.getAnswerAuthor())){
			  model.addAttribute("brdMstrVO", master);
			  
			  BoardVO selectVO = new BoardVO();
			  selectVO.setBbsId(master.getBbsId());
			  selectVO.setNttNo(boardVO.getNttNo());
			  selectVO.setAdminAt("Y");
			  
			  selectVO = bbsMngService.selectBoardArticle(selectVO);
			  
			  Board board = new Board();
			  board.setCtgryId(selectVO.getCtgryId());
			  //board.setOrdrCode(selectVO.getOrdrCode());
			  //board.setOrdrCodeDp(BigDecimal.valueOf(selectVO.getOrdrCodeDp().longValue() + 1));
		    
			  if("BBSA11".equals(master.getBbsAttrbCode())) {
				  
				  board.setNttNo(selectVO.getNttNo());
				  board.setNttSj(selectVO.getNttSj());			  
				  if(!EgovStringUtil.isEmpty(selectVO.getEstnData())) {
					  board.setNttCn(selectVO.getEstnParseData().getString("cn"));
				  }
				  board.setAtchFileId(selectVO.getEstnAtchFileId());
				  board.setProcessSttusCode(selectVO.getProcessSttusCode());
				  
				  ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
				  codeVO.setCodeId("COM108");
				  model.addAttribute("qaCodeList", cmmUseService.selectCmmCodeDetail(codeVO));
			  }
			  
			  model.addAttribute("board", board);
		    
			  request.getSession().setAttribute("sessionVO", boardVO);
		  	  
		  	  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
	  	  
	  	  } else {
	  		model.addAttribute("message", egovMessageSource.getMessage("fail.auth.regist"));
	  		return "forward:/cop/cmy/bbs/selectBoardList.do";
	  	  }
	  }
    
	  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.access"));
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }
  
  /**
   * 게시물에 대한 답변을 등록한다.
   * 
   * @param boardVO
   * @param board
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping(value = "/cop/cmy/bbs/replyBoardArticle.do")
  public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, 
		  Board board, BindingResult bindingResult, 
      ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

   
	  if(request.getSession().getAttribute("sessionVO") == null) {
		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  }
    
	  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
	  beanValidator.validate(board, bindingResult);
    
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
  
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	  
	  int SE_CODE = 1;
	  CommunityUser cmmntyUser = new CommunityUser();	
	  cmmntyUser.setSiteId(siteVO.getSiteId());
	  cmmntyUser.setEmplyrId(user.getId());
	  cmmntyUser.setCmmntyId(boardVO.getTrgetId());
	  cmmntyUser = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
	  if(cmmntyUser != null) {
		  model.addAttribute("USER_INFO", cmmntyUser);	//사용자 정보	  			  
		  SE_CODE = Integer.parseInt(cmmntyUser.getAuthorCode());
	  }
	  
	  if(bindingResult.hasErrors()) {

		  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
			  			  
			  model.addAttribute("brdMstrVO", master);
			  
			  if("BBSA11".equals(master.getBbsAttrbCode())) {
				  ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
				  codeVO.setCodeId("COM108");
				  model.addAttribute("qaCodeList", cmmUseService.selectCmmCodeDetail(codeVO));
			  }
		  }
		  
		  model.addAttribute("siteInfo", siteVO);
		  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
      
		  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
	  }
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
		  
		  if(SE_CODE >= Integer.parseInt(master.getAnswerAuthor())) {
			  if(SE_CODE >= 10) {
		    	  boardVO.setAdminAt("Y");
		      }
			  
			  String atchFileId = boardVO.getAtchFileId();;
	  	      
		      final Map<String, MultipartFile> files = multiRequest.getFileMap();
		      
		      
		      if("BBSA11".equals(master.getBbsAttrbCode())) {
		    	  if(!files.isEmpty()) {
		    		  if(EgovStringUtil.isEmpty(atchFileId)) {
		    			  List<FileVO> result = fileUtil.parseBoardFileInf(files, 0, atchFileId, siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
		    			  atchFileId = fileMngService.insertFileInfs(result);
					  } else {
						  FileVO fvo = new FileVO();
						  fvo.setAtchFileId(atchFileId);
						  int cnt = fileMngService.getMaxFileSN(fvo);
						  List<FileVO> _result = fileUtil.parseBoardFileInf(files, cnt, atchFileId, siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
						  fileMngService.updateFileInfs(_result);
					  }
		    		  boardVO.setEstnAtchFileId(atchFileId);
				  }
				  
				  boardVO.setLastAnswrrId(user.getId());
				  boardVO.setLastAnswrrNm(user.getName());
		    	
				  JSONObject jObj = new JSONObject();
				  jObj.put("cn", boardVO.getNttCn());
				  boardVO.setEstnData(jObj.toString());
		    	
				  bbsMngService.updateBoardArticle(boardVO, master, true);
		      } else {
		    	  if(!files.isEmpty()) {
		    		  	List<FileVO> result = fileUtil.parseBoardFileInf(files, 0, "", siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
		  	        	atchFileId = fileMngService.insertFileInfs(result);
		  	      }
		  	      
		    	  boardVO.setAtchFileId(atchFileId);
		    	  boardVO.setFrstRegisterId(user.getId());
		    	  boardVO.setNtcrNm(user.getName());      
		    	  boardVO.setNttCn(unscript(boardVO.getNttCn())); // XSS 방지
		    	  boardVO.setCreatIp(EgovClntInfo.getClntIP(request));
		  	      
		    	  boardVO.setEstnData(EgovHttpUtil.getEstnParseData(request));
		  	      bbsMngService.replyBoardArticle(boardVO, master);
		      }
		  }      
	  }
    
	  request.getSession().removeAttribute("sessionVO");
	  
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }

  /**
   * 게시물 수정을 위한 수정페이지로 이동한다.
   * 
   * @param boardVO
   * @param vo
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/forUpdateBoardArticle.do")
  public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    
	  if(!EgovUserDetailsHelper.isAuthenticated(request, response)) {
	      return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
	  }
	  
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  model.addAttribute("siteInfo", siteVO);
	  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
    
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
		  
		  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		  boardVO.setFrstRegisterId(user.getId());
		  
		  int SE_CODE = 1;
		  CommunityUser cmmntyUser = new CommunityUser();	
		  cmmntyUser.setSiteId(siteVO.getSiteId());
		  cmmntyUser.setEmplyrId(user.getId());
		  cmmntyUser.setCmmntyId(boardVO.getTrgetId());
		  cmmntyUser = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
		  if(cmmntyUser != null) {
			  model.addAttribute("USER_INFO", cmmntyUser);	//사용자 정보	  			  
			  SE_CODE = Integer.parseInt(cmmntyUser.getAuthorCode());
		  }
		  
		  boardVO.setFrstRegisterId(user.getId());
		  
		  if(SE_CODE >= 10) {
			  boardVO.setAdminAt("Y");
		  }
		  
		  if(SE_CODE >= Integer.parseInt(master.getRegistAuthor())){
			  if(!EgovStringUtil.isEmpty(master.getCtgrymasterId())) {
				  Ctgry ctgry = new Ctgry();
				  ctgry.setCtgrymasterId(master.getCtgrymasterId());
				  model.addAttribute("boardCateList", ctgryService.selectComtnbbsctgryList(ctgry));
				  
				  model.addAttribute("boardCateLevel", ctgryService.selectComtnbbsctgryLevel(ctgry));
		      }
		    
			  boardVO.setCtgrymasterId(master.getCtgrymasterId());
			  BoardVO dataVO = bbsMngService.selectBoardArticle(boardVO);
			  		  
			  model.addAttribute("brdMstrVO", master);
			  model.addAttribute("board", dataVO);
			  
			  request.getSession().setAttribute("sessionVO", boardVO);
			  
			  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
		  } else {
	  		  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.regist"));
	  		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  	  }
		  
	  }
	  
	  model.addAttribute("message", egovMessageSource.getMessage("fail.auth.access"));
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }

  /**
   * 게시물에 대한 내용을 수정한다.
   * 
   * @param boardVO
   * @param board
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  @RequestMapping(value = "/cop/cmy/bbs/updateBoardArticle.do")
  public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, 
		  BoardVO board, BindingResult bindingResult, 
      ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	  if(request.getSession().getAttribute("sessionVO") == null) {
		  return "forward:/cop/cmy/bbs/selectBoardList.do";
	  }
    
	  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
	  String atchFileId = boardVO.getAtchFileId();
    
	  beanValidator.validate(board, bindingResult);
    
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());

	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	  
	  int SE_CODE = 1;
	  CommunityUser cmmntyUser = new CommunityUser();	
	  cmmntyUser.setSiteId(siteVO.getSiteId());
	  cmmntyUser.setEmplyrId(user.getId());
	  cmmntyUser.setCmmntyId(boardVO.getTrgetId());	
	  cmmntyUser = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
	  if(cmmntyUser != null) {
		  model.addAttribute("USER_INFO", cmmntyUser);	//사용자 정보	  			  
		  SE_CODE = Integer.parseInt(cmmntyUser.getAuthorCode());
	  }
		
	  if(bindingResult.hasErrors()) {
      
		  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
			  if(!EgovStringUtil.isEmpty(master.getCtgrymasterId())) {
				  Ctgry ctgry = new Ctgry();
				  ctgry.setCtgrymasterId(master.getCtgrymasterId());
				  model.addAttribute("boardCateList", ctgryService.selectComtnbbsctgryList(ctgry));
				  
				  model.addAttribute("boardCateLevel", ctgryService.selectComtnbbsctgryLevel(ctgry));
		      }
			  
			  boardVO.setCtgrymasterId(master.getCtgrymasterId());
			  BoardVO dataVO = bbsMngService.selectBoardArticle(boardVO);
			  
			  model.addAttribute("brdMstrVO", master);
			  model.addAttribute("board", dataVO);
		  }
		  model.addAttribute("siteInfo", siteVO);
		  model.addAttribute("LytFileStoreWebPathByWebFile", propertyService.getString("publish.tmplat.lyt.fileStoreWebPathByWebFile"));
      
		  return "cop/cmy/bbs/cmy_001/EgovNoticeRegist";
	  }
    
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) {
		  
		  if(SE_CODE >= Integer.parseInt(master.getRegistAuthor())) {
		  
			  final Map<String, MultipartFile> files = multiRequest.getFileMap();
			  if(!files.isEmpty()) {
				  if(EgovStringUtil.isEmpty(atchFileId)) {
					  List<FileVO> result = fileUtil.parseBoardFileInf(files, 0, atchFileId, siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
					  atchFileId = fileMngService.insertFileInfs(result);
					  boardVO.setAtchFileId(atchFileId);
				  } else {
					  FileVO fvo = new FileVO();
					  fvo.setAtchFileId(atchFileId);
					  int cnt = fileMngService.getMaxFileSN(fvo);
					  List<FileVO> _result = fileUtil.parseBoardFileInf(files, cnt, atchFileId, siteManageService.selectSiteServiceInfo(request).getSiteId(), boardVO.getBbsId());
					  fileMngService.updateFileInfs(_result);
				  }
			  }
			  
			  if(!"".equals(atchFileId)) {
				  FileVO fvo = new FileVO();
				  fvo.setAtchFileId(atchFileId);
				  List<FileVO> dbFiles = fileMngService.selectFileInfs(fvo);
				  if(dbFiles == null || dbFiles.size() == 0) {
					  boardVO.setAtchFileId("");
					  boardVO.setFileGroupId("");
				  }
			  }
	      
			  if(SE_CODE >= 10) {
		    	  boardVO.setAdminAt("Y");
		      }
			  boardVO.setLastUpdusrId(user.getId());      
			  boardVO.setNttCn(unscript(boardVO.getNttCn())); // XSS 방지
			  boardVO.setEstnData(EgovHttpUtil.getEstnParseData(request));
			  
			  bbsMngService.updateBoardArticle(boardVO, master, false);
		  }
	  }
    
	  request.getSession().removeAttribute("sessionVO");
	  
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }
  
  /**
   * 게시물에 대한 내용을 삭제한다.
   * 
   * @param boardVO
   * @param board
   * @param sessionVO
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cop/cmy/bbs/deleteBoardArticle.do")
  public String deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, BoardVO board, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

	  if(!EgovUserDetailsHelper.isAuthenticated(request, response)) {
		  return "redirect:" + EgovUserDetailsHelper.getRedirectLoginUrl();
	  }
	  
	  LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
    
	  BoardMasterVO vo = new BoardMasterVO();
	  vo.setBbsId(boardVO.getBbsId());
	  vo.setTrgetId(boardVO.getTrgetId());
	  
	  SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	  vo.setSiteId(siteVO.getSiteId());
	  vo.setSysTyCode(siteVO.getSysTyCode());
  
	  BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	  
	  if(master != null && !EgovStringUtil.isEmpty(boardVO.getTrgetId())) { 
		  
		  int SE_CODE = 1;
		  CommunityUser cmmntyUser = new CommunityUser();	
		  cmmntyUser.setSiteId(siteVO.getSiteId());
		  cmmntyUser.setEmplyrId(user.getId());
		  cmmntyUser.setCmmntyId(boardVO.getTrgetId());	
		  cmmntyUser = cmmntyService.selectSingleCommunityUserInf(cmmntyUser);
		  if(cmmntyUser != null) {	  
			  SE_CODE = Integer.parseInt(cmmntyUser.getAuthorCode());
		  }
		  
		  if(SE_CODE >= Integer.parseInt(master.getRegistAuthor())){
			  if(SE_CODE >= 10) {
		    	  boardVO.setAdminAt("Y");
		      }
			  
			  board.setLastUpdusrId(user.getId());      
			  bbsMngService.deleteBoardArticle(board, master);
		  }
	  }
    
	  return "forward:/cop/cmy/bbs/selectBoardList.do";
  }
  
  
}
