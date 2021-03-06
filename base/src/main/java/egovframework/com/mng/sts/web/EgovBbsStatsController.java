package egovframework.com.mng.sts.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sts.service.EgovScrinStatsService;
import egovframework.com.sts.service.StatsVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * 화면 통계 검색 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.19
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovBbsStatsController {
		
	/**
	 * EgovConectStatsService
	 */
	@Resource(name = "scrinStatsService")
    private EgovScrinStatsService scrinStatsService;
		
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovBbsStatsController.class);
    
    /**
	 * 게시물 통계를 조회한다
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/sts/selectBbsStats.do")
	public String selectBbsStats(@ModelAttribute("statsVO") StatsVO statsVO,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	/*
    	List<SiteManageVO> siteList = siteManageService.selectSiteSimpleList();		  
		if(EgovStringUtil.isEmpty(statsVO.getSearchSiteId())) {
			if(siteList != null && siteList.size() > 0) {
				statsVO.setSearchSiteId(siteList.get(0).getSiteId());
			}
		}			  
		model.addAttribute("siteList", siteList);
		*/
    	
    	LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
		if(!EgovStringUtil.isEmpty(loginVO.getSiteId())) {		  
			statsVO.setSiteId(loginVO.getSiteId());
		}
		
		if(!EgovStringUtil.isEmpty(statsVO.getSiteId())) {
	    	List<StatsVO> scrinStats = this.selectBbsStatsData(statsVO);
					
			model.addAttribute("scrinStats", scrinStats);
		}
        return "/mng/sts/EgovBbsStats";
	}
    
    /**
	 * 게시물 통계를 엑셀로 다운로드 한다
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/sts/selectBbsStatsExcel.do")
	public ModelAndView selectBbsStatsExcel(@ModelAttribute("statsVO") StatsVO statsVO,
			ModelMap model) throws Exception {

    	Map<String, Object> map = new HashMap<String, Object>(); 
    	List<String> columMap = new ArrayList<String>();
    	List<Object> valueMap = new ArrayList<Object>();
    	
    	columMap.add("사이트");
    	columMap.add("구분");
    	columMap.add("게시판");
    	columMap.add("생성");
    	columMap.add("조회");
    	columMap.add("다운로드");
    	
		List<StatsVO> scrinStats = this.selectBbsStatsData(statsVO);
		if(scrinStats != null) {
			StatsVO tmpVO = null;
			Map<String, Object> tmpMap = null;
			for(int i=0; i < scrinStats.size(); i++) {
				tmpVO = scrinStats.get(i);
				
				tmpMap = new HashMap<String, Object>(); 
				tmpMap.put("사이트", tmpVO.getSiteNm());
				tmpMap.put("구분", tmpVO.getGbNm());				
				tmpMap.put("게시판", tmpVO.getBbsNm());
				tmpMap.put("생성", tmpVO.getCreatCo());
				tmpMap.put("조회", tmpVO.getTotInqireCo());
				tmpMap.put("다운로드", tmpVO.getDwldCo());
				
				valueMap.add(tmpMap);
			}
		}
		map.put("title", "게시물통계");
		map.put("columMap", columMap);
		map.put("valueMap", valueMap);
		
		
		
		return new ModelAndView("excelDownloadView", "dataMap", map);
	}
    
    private List<StatsVO> selectBbsStatsData(StatsVO statsVO) throws Exception {
    	
    	if(EgovStringUtil.isEmpty(statsVO.getPdKind()) || EgovStringUtil.isEmpty(statsVO.getFromDate())) {
    		String today = EgovDateUtil.getToday();
    		statsVO.setPdKind("D");
    		statsVO.setFromDate(EgovDateUtil.convertDate(today, "0000", "yyyyMM") + "01");
    		statsVO.setToDate(today);
    	}
    	
    	if(EgovStringUtil.isEmpty(statsVO.getStatsKind())) {
    		statsVO.setStatsKind("H");
    	}
    	
    	return scrinStatsService.selectBbsStats(statsVO);
    }
}