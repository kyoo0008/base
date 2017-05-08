package egovframework.com.utl.fcc.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.EgovHttpUtil;
import egovframework.com.utl.fcc.service.EgovQrCodeUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class EgovQrCodeUtilController {

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Resource(name = "EgovHttpUtil")
    protected EgovHttpUtil egovHttpUtil;
	
	protected final Log logger = LogFactory.getLog(getClass());

    @RequestMapping(value="/EgovQrCode.do")
    public void handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	String strText = request.getParameter("text");
    	String strWidth = request.getParameter("width");
    	String strHeight = request.getParameter("height");
    	
    	int width = propertiesService.getInt("qrCodeWidth");
    	int height = propertiesService.getInt("qrCodeHeight");
    	
    	if(!EgovStringUtil.isEmpty(strWidth)) {
    		try {
    			width = Integer.parseInt(strWidth);
    		} catch(Exception e1) {}
    	}
    	
    	if(!EgovStringUtil.isEmpty(strHeight)) {
    		try {
    			height = Integer.parseInt(strHeight);
    		} catch(Exception e1) {}
    	}
    	
    	EgovQrCodeUtil.CreateQrCode(strText, response, width, height);
    	
    	//String url = egovHttpUtil.getShortUrl("http://dev.itshome.co.kr:9010/");
    	
    	//System.out.println("--------------------------------:" + egovHttpUtil.getMe2DaySendUrl("안녕하세요", url));
    }
}