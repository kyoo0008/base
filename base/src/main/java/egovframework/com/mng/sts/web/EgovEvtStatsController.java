package egovframework.com.mng.sts.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.sts.service.EgovScrinStatsService;
import egovframework.com.sts.service.StatsVO;
import egovframework.com.uss.umt.service.UserDefaultVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/******************************************************
 * @Class Name : EgovEvtStatsController.java
 * @Program name : egovframework.com.mng.sts.web
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 10. 15.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 10. 15.        이호영             first generated
*********************************************************/
@Controller
public class EgovEvtStatsController {
	
	/**
	 * EgovConectStatsService
	 * @uml.property  name="scrinStatsService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "scrinStatsService")
    private EgovScrinStatsService scrinStatsService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	    
    /**
	 * 회차별 이벤트 통계를 조회한다.
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/sts/selectEvtStats.do")
	public String selectEvtStats(@ModelAttribute("statsVO") StatsVO statsVO,
			ModelMap model) throws Exception {
    	
    	if(EgovStringUtil.isEmpty(statsVO.getStatsKind())){
    		statsVO.setStatsKind("userTyCode");
    	}
    	
    	if(EgovStringUtil.isEmpty(statsVO.getFromDate()) || EgovStringUtil.isEmpty(statsVO.getToDate())) {
    		String today = EgovDateUtil.getToday();
    		statsVO.setFromDate(EgovDateUtil.convertDate(today, "0000", "yyyyMM") + "01");
    		statsVO.setToDate(today);
    	}

    	List<StatsVO> evtStats = scrinStatsService.selectEvtStats(statsVO);
    	model.addAttribute("evtStats", evtStats);
    	
    	return "/mng/sts/EgovEvtStats";
    }

    /**
	 * 사용자별 이벤트 통계를 조회한다.
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/mng/sts/selectEvtStatUser.do")
	public String selectEvtStatUser(@ModelAttribute("searchVO") UserDefaultVO userDefaultVO, @ModelAttribute("statsVO") StatsVO statsVO,
			ModelMap model) throws Exception {

    	userDefaultVO.setPageUnit(propertiesService.getInt("pageUnit"));
        userDefaultVO.setPageSize(propertiesService.getInt("pageSize"));
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(userDefaultVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(userDefaultVO.getPageUnit());
        paginationInfo.setPageSize(userDefaultVO.getPageSize());
        
        userDefaultVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        userDefaultVO.setLastIndex(paginationInfo.getLastRecordIndex());
        userDefaultVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        model.addAttribute("resultList", scrinStatsService.selectEvtStatsList(userDefaultVO));
        
        int totCnt = scrinStatsService.selectEvtStatsListCnt(userDefaultVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

    	return "/mng/sts/EgovEvtStatsuser";
    }
}
