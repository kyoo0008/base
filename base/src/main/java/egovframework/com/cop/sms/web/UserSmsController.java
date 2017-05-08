package egovframework.com.cop.sms.web;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cop.sms.service.EgovSmsInfoService;
import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * SmsController 컨트롤러 클래스
 *
 */
@Controller
public class UserSmsController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name = "EgovSmsInfoService")
    private EgovSmsInfoService egovSmsInfoService;
		
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
	
	@Resource(name = "egovMessageSource")
	  EgovMessageSource egovMessageSource;
	
	@RequestMapping(value = "/hpg/sms/addSms.do")
	public String addSms(@ModelAttribute("searchVO") SmsVO smsVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(EgovUserDetailsHelper.isAuthenticated(request, response)) {
			
			request.getSession().setAttribute("sessionVO", smsVO);
		}
		
		return "cop/sms/addSms";
	}
	
	@RequestMapping(value = "/hpg/sms/insertSms.do")
	public String insertSms(@ModelAttribute("searchVO") SmsVO smsVO, @RequestParam("returnUrl") String returnUrl, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String smsMessage = "";
		
		if(EgovUserDetailsHelper.isAuthenticated(request, response)) {
			if(request.getSession().getAttribute("sessionVO") == null) {
				  return "redirect:" + returnUrl;
			}
		    
			if(smsVO.getRecptnTelno() == null) {
				smsMessage = "cop.sms.recptnTelno.msg";
				//model.addAttribute("smsMessage", "cop.sms.recptnTelno.msg");
			} else {
				LoginVO user = EgovUserDetailsHelper.getAuthenticatedUser(request, response);
				
				int iRet = egovSmsInfoService.sendUserSms(user.getId(), smsVO);
				
				//성공
				if(smsVO.getRecptnTelno().size() == iRet) {
					smsMessage = "cop.sms.success";
					//model.addAttribute("smsMessage", "cop.sms.success");
				} else {
					if(iRet == 0) {	//모두 실패
						smsMessage = "cop.sms.fail.mlg";
						//model.addAttribute("smsMessage", "cop.sms.fail.mlg");
					} else {		//일부 실패
						smsMessage = "cop.sms.fail.mlg.some";
						//model.addAttribute("smsMessage", "cop.sms.fail.mlg.some");
					}
				}
			}
			
			 request.getSession().removeAttribute("sessionVO");
		} else {
			
			smsMessage = "fail.common.msg";
			//model.addAttribute("smsMessage", "fail.common.login");
		}
		
		
		return "redirect:" + returnUrl +"&smsMessage="+smsMessage;
	}
}
