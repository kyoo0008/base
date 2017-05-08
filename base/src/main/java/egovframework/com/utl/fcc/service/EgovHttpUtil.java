package egovframework.com.utl.fcc.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import egovframework.rte.fdl.property.EgovPropertyService;

@Component("EgovHttpUtil")
public class EgovHttpUtil {

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
		
	public String getTwitterSendUrl(String message, String url) {
		String retUrl = null;
		try {
			retUrl = "http://twitter.com/?status=" + URLEncoder.encode(message, "UTF-8") + "+" + url;
		} catch(Exception e) {
			
		}
		
		return retUrl;
	}
	
	public String getFaceBookSendUrl(String message, String url) {
		String retUrl = null;
		try {
			retUrl = "http://www.facebook.com/sharer.php?u=" + url + "&t=" + URLEncoder.encode(message, "UTF-8");
		} catch(Exception e) {
			
		}
		
		return retUrl;
	}
	
	public String getMe2DaySendUrl(String message, String url) {
		String retUrl = null;
		try {
			retUrl = "http://me2day.net/posts/new?new_post[body]=" + URLEncoder.encode(message, "UTF-8") + "+" + url;
		} catch(Exception e) {
			
		}
		
		return retUrl;
	}
	
	public static void setIsMobile(HttpServletRequest request) {
		request.getSession().setAttribute("IS_MOBILE", true);
	}
	
	public static void removeIsMobile(HttpServletRequest request) {
		if(request.getSession().getAttribute("IS_MOBILE") != null) {
			request.getSession().removeAttribute("IS_MOBILE");
		}
	}
	
	public static void setIsMobileCancled(HttpServletRequest request) {
		request.getSession().setAttribute("IS_MOBILE_CANCLE", true);
	}
	
	public static void removeIsMobileCancled(HttpServletRequest request) {
		if(request.getSession().getAttribute("IS_MOBILE_CANCLE") != null) {
			request.getSession().removeAttribute("IS_MOBILE_CANCLE");
		}
	}
	
	public static boolean getIsMobile(HttpServletRequest request) {
		boolean isMobile = false;
		if(request.getSession().getAttribute("IS_MOBILE") != null) {
			isMobile = true;//(Boolean)request.getSession().getAttribute("IS_MOBILE");
		}
		if(!isMobile) {
			if(checkMobileHeader(request) && request.getSession().getAttribute("IS_MOBILE_CANCLE") == null) {
				isMobile = true;
			}
		}
	
		return isMobile;		
	}
	
	public static boolean checkMobileHeader(HttpServletRequest request) {
		boolean isMobile = false;
		String[] chkList = {"IPHONE","IPOD","ITOUCH","MOBILE","IEMOBILE"};
		String user_agent = request.getHeader("user-agent");
		if(user_agent != null) {
			String br_info = user_agent.toUpperCase();
			
			for(int i=0; i<chkList.length; i++) {
				if(br_info.indexOf(chkList[i]) != -1) {
					isMobile = true;
					break;
				}
			}
		}
		
		return isMobile;
	}
	
	
	/**
	 * 모바일 종류를 리턴 by moon 2011.12.13
	 * @param request
	 * @return
	 */
	public static String getMobileType(HttpServletRequest request) {
		String result = "NONE";
		String[] chkList = {"IPHONE","IPOD","ITOUCH","IPAD","MOBILE","IEMOBILE"};
		String user_agent = request.getHeader("user-agent");
		if(user_agent != null) {
			String br_info = user_agent.toUpperCase();
			for(int i=0; i<chkList.length; i++) {
				if(br_info.indexOf(chkList[i]) != -1) {
					result = chkList[i];
					break;
				}
			}
		}
		return result;
	}
	
	public static void HttpSend(String url) {
		HttpURLConnection con = null;
		BufferedReader br = null;
		Log log = LogFactory.getLog(EgovHttpUtil.class);
		try {
			URL reqUrl = new URL(url);
			con = (HttpURLConnection)reqUrl.openConnection();
			con.setConnectTimeout(10000);
			if(con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStreamReader isr = new InputStreamReader(con.getInputStream());
				br = new BufferedReader(isr);
				String temp = null;
				while((temp = br.readLine()) != null) {
					log.debug("****************HttpSend:" + temp);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(br != null) {
				try {
					br.close();
				} catch(Exception e1) {
					
				}
			}
			if(con != null) {
				try {
					con.disconnect();
				} catch(Exception e1) {
					
				}
			}
		}
	}
	
	public static String getEstnParseData(HttpServletRequest request) {
		JSONObject jObj = null;
		jObj = new JSONObject();
	    Enumeration en = request.getParameterNames();
	    while(en.hasMoreElements()) {
	    	String str = (String)en.nextElement();
	    	if(str.startsWith("estn")) {
	    		jObj.put(str, request.getParameter(str));
	    	}
	    }
	    if(!jObj.isEmpty()) {
	    	return jObj.toString();
	    }
	    return null;
	}
}
