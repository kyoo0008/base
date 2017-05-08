package egovframework.com.cop.svc.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class EgovCopServiceController {

	@Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;
	
    @RequestMapping("/cop/svc/notifyArticleService.do")
    public String notifyArticleService(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	//param : trgetId (사용자ID)
    	if("Y".equals(boardVO.getSearchUseYn())) {
	    	List<BoardVO> resultList = cmmntyService.selectSearchCommunityNotifyArticleList(boardVO);
	    	BoardVO resetVO = null;
	    	for(int i = 0; i < resultList.size(); i++) {
	    		resetVO = resultList.get(i);
	    		resetVO.setNttCn(EgovStringUtil.getNoneHtml(resetVO.getNttCn()));
	    	}
	    	model.addAttribute("resultCount", resultList != null ? resultList.size() : 0);
			model.addAttribute("resultList", resultList);
    	} else {
    		model.addAttribute("resultCount", cmmntyService.selectSearchCommunityNotifyArticleListCnt(boardVO));
    	}
	
    	return "/cop/svc/EgovNotifyArticleXml";
    }

}
