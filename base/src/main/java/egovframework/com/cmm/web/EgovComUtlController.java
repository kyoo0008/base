package egovframework.com.cmm.web;

import java.util.List;

import javax.annotation.Resource;

import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;

import egovframework.rte.fdl.property.EgovPropertyService;

import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;
import egovframework.com.cmm.service.AjaxXmlView;

/**
 * @Class Name : EgovComUtlController.java
 * @Description : 공통유틸리티성 작업을 위한 Controller
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.02    조재영          최초 생성
 *
 *  @author 공통서비스 개발팀 조재영
 *  @since 2009.03.02
 *  @version 1.0
 *  @see
 *  
 */
@Controller
public class EgovComUtlController {

    //@Resource(name = "egovUserManageService")
    //private EgovUserManageService egovUserManageService;
	/** cmmUseService */
    @Resource(name="EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /**
	 * Ajax를 이용한 공통코드 처리
     * @throws Exception 
	 */
	@RequestMapping(value="/EgovCommCode.do")
	protected ModelAndView suggestName(@RequestParam("codeId") String codeId) throws Exception{
		 
		ModelAndView model = new ModelAndView(new AjaxXmlView());
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId(codeId);
    	
    	List<CmmnDetailCode> nameList = cmmUseService.selectCmmCodeDetail(vo);
 
		AjaxXmlBuilder ajaxXmlBuilder = new AjaxXmlBuilder();
 
		for(CmmnDetailCode name:nameList){
			ajaxXmlBuilder.addItem(name.getCodeNm(), name.getCode(), false);
		}
		model.addObject("ajaxXml",ajaxXmlBuilder.toString());
		return model;
	}

    /**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/EgovPageLink.do")
	public String moveToPage(@RequestParam("link") String linkPage){
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage==null || linkPage.equals("")){
			link="cmm/egovError";
		}
		return link;
	}

    /**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/EgovPageLink.action")
	public String moveToPage_action(@RequestParam("link") String linkPage){
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage==null || linkPage.equals("")){
			link="cmm/egovError";
		}
		return link;
	}
	
    /**
	 * validato rule dynamic Javascript
	 */
	@RequestMapping("/validator.do")
	public String validate(){
		return "cmm/validator";
	}

}