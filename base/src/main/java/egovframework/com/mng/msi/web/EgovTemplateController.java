package egovframework.com.mng.msi.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller("MngEgovTemplateController")
public class EgovTemplateController {
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/**
	 * 관리자 메인 포워딩
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mng/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		
		//사이트 관리로 이동한다.
		return "forward:/mng/sym/sit/selectSiteInfoList.do";
	}
	
	/**
	 * 관리자 상단 메뉴, 좌측메뉴
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mng/template/top.do")
	public String top(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		return "mng/template/top";
	}
	
	/**
	 * 관리자 하단
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mng/template/bottom.do")
	public String bottom(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		return "mng/template/bottom";
	}

	/**
	 * 관리자 팝업 상단
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mng/template/popTop.do")
	public String popTop(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		return "mng/template/popTop";
	}
	
	/**
	 * 관리자 팝업 하단
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mng/template/popBottom.do")
	public String popBottom(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		return "mng/template/popBottom";
	}
}
