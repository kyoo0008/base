package egovframework.com.uss.ion.rsn.web;

import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.com.uss.ion.rsn.service.EgovRssService;
import egovframework.com.uss.ion.rsn.service.RssInfo;
/**
 * RSS서비스를 처리하는 Controller Class 구현
 * @author 공통서비스 장동한
 * @since 2010.06.16
 * @version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.16  장동한          최초 생성
 * 
 * </pre>
 */
@Controller
public class EgovRssController {

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** egovOnlinePollService */
    @Resource(name = "egovRssService")
    private EgovRssService egovRssService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    protected Log log = LogFactory.getLog(this.getClass());

    /**
     * RSS서비스 목록을 상세조회 조회한다.
     * @param rssInfo -RSS서비스 객체
     * @param commandMap -Request Variable
     * @param model -Spring 제공하는 ModelMap
     * @return String -리턴 URL
     * @throws Exception
     */
    @RequestMapping(value = "/uss/ion/rsn/detailRssTagService.do")
    public String EgovRssTagServiceDetail(
            RssInfo rssInfo, 
            Map commandMap,
            ModelMap model) throws Exception {
    		String sBbsId = commandMap.get("bbsId") == null ? "" : (String) commandMap.get("bbsId");
    		
    		if(!"".equals(sBbsId)){
    			Map mapRssInfo = (Map)egovRssService.selectRssTagServiceDetail(rssInfo);
    			if(mapRssInfo != null){
	    			model.addAttribute("mapRssInfo",mapRssInfo);
	    			model.addAttribute("mapRssInfoList", egovRssService.selectRssTagServiceTable(mapRssInfo));
    			}
    		}
        	return "/uss/ion/rsn/EgovRssTagService";
    }
    
    @RequestMapping(value = "/uss/ion/rsn/rssService.do")
    public String EgovRssPopServiceDetail(
            RssInfo rssInfo, 
            Map commandMap,
            ModelMap model) throws Exception {
			model.addAttribute("bbsId",commandMap.get("bbsId"));
        	return "/uss/ion/rsn/EgovRssPopService";
    }
}
