package egovframework.com.cop.sns.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SnsServiceController {
		
	@RequestMapping("/cop/sns/SendFacebook.do")
	public String SendFacebook(HttpServletRequest request, HttpServletResponse response, Model model) {
		/*
		String currentUrl = request.getParameter("currentUrl");
		String contents = request.getParameter("contents");
		
		String shortUrl = egovHttpUtil.getShortUrl(currentUrl); 
		String facebook = egovHttpUtil.getFaceBookSendUrl(contents, shortUrl);
				
		model.addAttribute("targetUrl", facebook);
		model.addAttribute("snsTitle","페이스북");
		*/
		model.addAttribute("snsTitle","페이스북");
		return "cop/sns/SendSns";
	}
	
	@RequestMapping("/cop/sns/SendTwitter.do")
	public String SendTwitter(HttpServletRequest request, HttpServletResponse response, Model model) {
		/*
		String currentUrl = request.getParameter("currentUrl");
		String contents = request.getParameter("contents");
		
		String shortUrl = egovHttpUtil.getShortUrl(currentUrl); 
		String twitter = egovHttpUtil.getTwitterSendUrl(contents, shortUrl);
		
		model.addAttribute("targetUrl", twitter);
		model.addAttribute("snsTitle","트위터");
		*/
		model.addAttribute("snsTitle","트위터");
		return "cop/sns/SendSns";
	}
	
	@RequestMapping("/cop/sns/SendM2day.do")
	public String SendMe2day(HttpServletRequest request, HttpServletResponse response, Model model) {
		/*
		String currentUrl = request.getParameter("currentUrl");
		String contents = request.getParameter("contents");
		
		String shortUrl = egovHttpUtil.getShortUrl(currentUrl); 
		String me2day = egovHttpUtil.getMe2DaySendUrl(contents, shortUrl);
		
		model.addAttribute("targetUrl", me2day);
		model.addAttribute("snsTitle","미투데이");
		*/
		model.addAttribute("snsTitle","미투데이");
		return "cop/sns/SendSns";
	}
}
