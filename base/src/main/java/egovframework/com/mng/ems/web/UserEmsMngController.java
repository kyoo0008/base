package egovframework.com.mng.ems.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.ems.service.MailMessageVO;
import egovframework.com.ems.service.DirectMailService;

/******************************************************
 * @Class Name : UserEmsMngController.java
 * @Program name : egovframework.com.mng.ems.web
 * @Descriptopn : 메일발송 관리 Controller
 * @version : 1.0.0
 * @author : 비상을꿈꾸며
 * @created date : 2011. 12. 7.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 12. 7.        비상을꿈꾸며      first generated
*********************************************************/

@Controller
public class UserEmsMngController {

	@Resource(name = "directMailService")
    private DirectMailService directMailService;
	
	/**
     * 메일발송 화면
     * @param model 화면모델
     * @return mng/ems/ComtnemsInfo
     * @throws Exception
     */
	@RequestMapping(value = "/mng/ems/selectEmsManage.do")
	public String selectEmsManage(@ModelAttribute("mailMessageVO") MailMessageVO mailMessageVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		return "mng/ems/ComtnemsInfo";
	}

	/**
     * 메일발송
     * @param model 화면모델
     * @return mng/ems/ComtnemsInfo
     * @throws Exception
     */
	@RequestMapping(value = "/mng/ems/addEmsManage.do")
	public String addEmsManage(@ModelAttribute("mailMessageVO") MailMessageVO mailMessageVO, ModelMap model, HttpServletRequest request) throws Exception {

		directMailService.sendManageMail(mailMessageVO);
		
		model.addAttribute("message", "발송 하였습니다.");
		return "forward:/mng/ems/selectEmsManage.do";
	}
}
