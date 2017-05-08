package egovframework.com.msi.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 검색 서비스 컨트롤러 클래스
 * 
 * @author 정정욱
 * @since 2011.05.24
 * @version 1.0
 * @see 
 */
@Controller
public class SearchServiceController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;
	
	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
	
	@RequestMapping("/sch/search.do")
	public String search(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, 
	      HttpServletRequest request, HttpServletResponse response) throws Exception {

		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
	    String searchWrd = boardVO.getSearchWrd() == null ? "" : boardVO.getSearchWrd();
	    
        if(searchWrd.length() >= 2) {
        	
        	boardVO.setSearchWrd(searchWrd);
        	boardVO.setFirstIndex(0);
	        boardVO.setRecordCountPerPage(5);
	        if(!siteVO.getSiteId().equals(propertyService.getString("baseSiteId"))) {
	        	boardVO.setSiteId(siteVO.getSiteId());
	        }
	        LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
  		  	if(user != null) {
  		  		boardVO.setSearchAuth(user.getUserSe());
  		  	}
  		  	
  		  	BoardVO resetVO = null;
  		  
  		  	//홈페이지 게시판
        	List<BoardVO> bbsResultList = bbsMngService.selectSearchBoardArticleList(boardVO);
        	for(int i = 0; i < bbsResultList.size(); i++) {
        		resetVO = bbsResultList.get(i);
        		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
        	}		        
	        model.addAttribute("bbsResultList", bbsResultList);
	        
	        //커뮤니티 게시판
        	List<BoardVO> cmyResultList = cmmntyService.selectSearchCommunityBoardArticleList(boardVO);
        	for(int i = 0; i < cmyResultList.size(); i++) {
        		resetVO = cmyResultList.get(i);
        		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
        	}		        
	        model.addAttribute("cmyResultList", cmyResultList);
        }
	    
	    return "sch/EgovTotalSearch";
	}
	
	@RequestMapping("/sch/bbsSearch.do")
	public String bbsSearch(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, 
	      HttpServletRequest request, HttpServletResponse response) throws Exception {

		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
        PaginationInfo paginationInfo = new PaginationInfo();
        
        String searchWrd = boardVO.getSearchWrd() == null ? "" : boardVO.getSearchWrd();
	    
        if(searchWrd.length() >= 2) {
        	
        	boardVO.setSearchWrd(searchWrd);
        	if(!siteVO.getSiteId().equals(propertyService.getString("baseSiteId"))) {
	        	boardVO.setSiteId(siteVO.getSiteId());
	        }
        	
        	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
  		  	if(user != null) {	  			  
  			  boardVO.setSearchAuth(user.getUserSe());
  		  	}
  		  
        	if(request.getParameter("pageUnit") == null) {
        		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
        	}
        	if(request.getParameter("pageSize") == null) {
        		boardVO.setPageSize(propertyService.getInt("pageSize"));
        	}
	        
	        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	        paginationInfo.setPageSize(boardVO.getPageSize());
	        
	        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	        
        	List<BoardVO> resultList = bbsMngService.selectSearchBoardArticleList(boardVO);
        	BoardVO resetVO = null;
        	for(int i = 0; i < resultList.size(); i++) {
        		resetVO = resultList.get(i);
        		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
        	}
            int totCnt = bbsMngService.selectSearchBoardArticleListCnt(boardVO);
	        
	        paginationInfo.setTotalRecordCount(totCnt);
	        
	        model.addAttribute("resultList", resultList);
        } else {
        	paginationInfo.setTotalRecordCount(0);
        }
                
        model.addAttribute("paginationInfo", paginationInfo);
    
        return "sch/EgovBbsSearch";
	}
	
	@RequestMapping("/sch/cmySearch.do")
	public String cmySearch(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, 
	      HttpServletRequest request, HttpServletResponse response) throws Exception {

		//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
	    model.addAttribute("siteInfo", siteVO);
	    //사이트 설정 웹경로.
	    model.addAttribute("SiteFileStoreWebPath", propertyService.getString("Site.fileStoreWebPath"));
	    
        PaginationInfo paginationInfo = new PaginationInfo();
        
        String searchWrd = boardVO.getSearchWrd() == null ? "" : boardVO.getSearchWrd();
	    
        if(searchWrd.length() >= 2) {
        	
        	boardVO.setSearchWrd(searchWrd);        	
        	if(!siteVO.getSiteId().equals(propertyService.getString("baseSiteId"))) {
	        	boardVO.setSiteId(siteVO.getSiteId());
	        }
        	
        	LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
  		  	if(user != null) {	  			  
  			  boardVO.setSearchAuth(user.getUserSe());
  		  	}
  		  
        	if(request.getParameter("pageUnit") == null) {
        		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
        	}
        	if(request.getParameter("pageSize") == null) {
        		boardVO.setPageSize(propertyService.getInt("pageSize"));
        	}
	        
	        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
	        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
	        paginationInfo.setPageSize(boardVO.getPageSize());
	        
	        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
	        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	        
        	List<BoardVO> resultList = cmmntyService.selectSearchCommunityBoardArticleList(boardVO);
        	BoardVO resetVO = null;
        	for(int i = 0; i < resultList.size(); i++) {
        		resetVO = resultList.get(i);
        		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
        	}
            int totCnt = cmmntyService.selectSearchCommunityBoardArticleListCnt(boardVO);
	        
	        paginationInfo.setTotalRecordCount(totCnt);
	        
	        model.addAttribute("resultList", resultList);
        } else {
        	paginationInfo.setTotalRecordCount(0);
        }
                
        model.addAttribute("paginationInfo", paginationInfo);
    
        return "sch/EgovCmySearch";
	}
	
}
	
