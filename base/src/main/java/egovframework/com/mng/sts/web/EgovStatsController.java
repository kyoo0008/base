package egovframework.com.mng.sts.web;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.sts.service.EgovScrinStatsService;
import egovframework.com.sts.service.StatsVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * 통계 컨트롤러 클래스
 * @author 주성진
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2012.06.01  주성진          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovStatsController {
	
	/**
	 * EgovStatsService
	 */
	@Resource(name = "scrinStatsService")
    private EgovScrinStatsService scrinStatsService;
		
    /** log */
    protected static final Log LOG = LogFactory.getLog(EgovStatsController.class);
    
    /**
	 * 회원가입 통계를 조회한다
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/sts/selectMbrStats.do")
	public String selectMbrStats(@ModelAttribute("statsVO") StatsVO statsVO, ModelMap model) throws Exception {
		
    	if(EgovStringUtil.isEmpty(statsVO.getFromDate())) {
    		String today = EgovDateUtil.getToday();
    		statsVO.setFromDate(EgovDateUtil.convertDate(today, "0000", "yyyyMM") + "01");
    		statsVO.setToDate(today);
    	}
    	
    	ArrayList<StatsVO> list = new ArrayList<StatsVO>();
    	StatsVO resultVO = null;
    	
    	//교사
    	statsVO.setUserType("T");
    	resultVO = scrinStatsService.selectMbrStats(statsVO);
    	resultVO.setStatsNm("교사");
    	list.add(resultVO);
    	
    	//학부모
    	statsVO.setUserType("P");
    	resultVO = scrinStatsService.selectMbrStats(statsVO);
    	resultVO.setStatsNm("학부모");
    	list.add(resultVO);
    	
    	//학생
    	statsVO.setUserType("S");
    	resultVO = scrinStatsService.selectMbrStats(statsVO);
    	resultVO.setStatsNm("학생");
    	list.add(resultVO);
    	
    	//기타
    	statsVO.setUserType("O");
    	resultVO = scrinStatsService.selectMbrStats(statsVO);
    	resultVO.setStatsNm("기타");
    	list.add(resultVO);
    	
		model.addAttribute("mbrStats", list);
		
        return "/mng/sts/EgovMbrStats";
	}
    
    /**
	 * 커뮤니티개설 통계를 조회한다
	 * @param statsVO StatsVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/sts/selectCmyStats.do")
	public String selectCmyStats(@ModelAttribute("statsVO") StatsVO statsVO, ModelMap model) throws Exception {
		
    	if(EgovStringUtil.isEmpty(statsVO.getFromDate())) {
    		String today = EgovDateUtil.getToday();
    		statsVO.setFromDate(EgovDateUtil.convertDate(today, "0000", "yyyyMM") + "01");
    		statsVO.setToDate(today);
    	}
    	
    	ArrayList<StatsVO> list = new ArrayList<StatsVO>();
    	StatsVO resultVO = null;
    	
    	//커뮤니티개설
    	resultVO = scrinStatsService.selectCmyStats(statsVO);
    	resultVO.setStatsNm("커뮤니티개설수");
    	list.add(resultVO);
    	
		model.addAttribute("cmyStats", list);
		
        return "/mng/sts/EgovCmyStats";
	}
}