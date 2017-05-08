package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.sym.sit.service.EgovSiteManageService;
import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 파일 다운로드를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class EgovFileDownloadController {
    
	@Resource(name = "SiteManageService")
	EgovSiteManageService siteManageService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
            
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    /**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);
		
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
		
		if (browser.equals("MSIE")) {
		    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
		    StringBuffer sb = new StringBuffer();
		    for (int i = 0; i < filename.length(); i++) {
			char c = filename.charAt(i);
			if (c > '~') {
			    sb.append(URLEncoder.encode("" + c, "UTF-8"));
			} else {
			    sb.append(c);
			}
		    }
		    encodedFilename = sb.toString();
		} else {
		    //throw new RuntimeException("Not supported browser");
		    throw new IOException("Not supported browser");
		}
		
		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
	
		if ("Opera".equals(browser)){
		    response.setContentType("application/octet-stream;charset=UTF-8");
		}
    }

    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/cmm/fms/FileDown.do")    
    public void cvplFileDownload(Map commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

	    String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		
		String strReturnMsg = "";
		Boolean isAuthenticated = true;//EgovUserDetailsHelper.isAuthenticated();
		
		
		//BigDecimal mlgScore = BigDecimal.ZERO;
		//String nttId = (String)commandMap.get("nttId");
		//String bbsId = (String)commandMap.get("bbsId");
			
		if (isAuthenticated) {
	
		    FileVO fileVO = new FileVO();
		    fileVO.setAtchFileId(atchFileId);
		    fileVO.setFileSn(fileSn);
		    FileVO fvo = null;
		    fvo = fileService.selectFileInf(fileVO);
	
		    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		    int fSize = (int)uFile.length();
	
		    if (fSize > 0) {
				String mimetype = "application/x-msdownload";
		
				//20110210 faq참조하여 알아서 주석처리..
				
				//response.setBufferSize(fSize);
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(fvo.getOrignlFileNm(), request, response);
				//response.setContentLength(fSize);
		
				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close(); 
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
		
				try {
				    in = new BufferedInputStream(new FileInputStream(uFile));
				    out = new BufferedOutputStream(response.getOutputStream());
		
				    FileCopyUtils.copy(in, out);
				    out.flush();
				} catch (Exception ex) {
				    //ex.printStackTrace();
				    // 다음 Exception 무시 처리
				    // Connection reset by peer: socket write error
				    log.debug("IGNORED: " + ex.getMessage());
				} finally {
				    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
				    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
				}
	
		    } else {
		    	//response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
		
				PrintWriter printwriter = response.getWriter();
				printwriter.println("<html>");
				printwriter.println("<script type=\"text/javascript\">alert('파일을 찾을수 없습니다.');window.close();</script>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
				printwriter.println("<br><br><br>");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
		    }
		} else {
			//response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<script type=\"text/javascript\">alert('" + strReturnMsg + "');window.close();</script>");
			printwriter.println("<br><br><br><h2>" + strReturnMsg + "</h2>");
			printwriter.println("<br><br><br>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
    }
    
    
    /**
     * 링크 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/cmm/fms/LinkFileDown.do")    
    public void linkFileDown(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	//사이트설정정보
		SiteManageVO siteVO = siteManageService.selectSiteServiceInfo(request);
		
	    String linkFileRootPath = propertiesService.getString("Link.fileStorePath");
	    String filePath = (String)commandMap.get("filePath");
		
		Boolean isAuthenticated = true;//EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		
		    File uFile = new File(linkFileRootPath + "/" + siteVO.getSiteId(), filePath);
		    int fSize = (int)uFile.length();
	
		    if (fSize > 0) {
				String mimetype = "application/x-msdownload";
		
				//20110210 faq참조하여 알아서 주석처리..
				
				//response.setBufferSize(fSize);
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(uFile.getName(), request, response);
				//response.setContentLength(fSize);
		
				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close(); 
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
		
				try {
				    in = new BufferedInputStream(new FileInputStream(uFile));
				    out = new BufferedOutputStream(response.getOutputStream());
		
				    FileCopyUtils.copy(in, out);
				    out.flush();
				} catch (Exception ex) {
				    //ex.printStackTrace();
				    // 다음 Exception 무시 처리
				    // Connection reset by peer: socket write error
				    log.debug("IGNORED: " + ex.getMessage());
				} finally {
				    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
				    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
				}
	
		    } else {
				response.setContentType("text/html");
		
				PrintWriter printwriter = response.getWriter();
				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + filePath + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
		    }
		}
    }
    
    /**
     * 링크 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/cmm/fms/UrlDownload.do")   
    public void urlDownload(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String mimetype = "application/x-msdownload";
		
		//20110210 faq참조하여 알아서 주석처리..
		
		//response.setBufferSize(fSize);
		response.setContentType(mimetype);
		//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
		setDisposition((String)commandMap.get("fileNm"), request, response);
		//response.setContentLength(fSize);
		
		HttpURLConnection con = null;
		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
			String fileUrl = (String)commandMap.get("url") + URLEncoder.encode((String)commandMap.get("fileNm"), "euc-kr");
			
			URL reqUrl = new URL(fileUrl);
			con = (HttpURLConnection)reqUrl.openConnection();
		    in = new BufferedInputStream(con.getInputStream());
		    out = new BufferedOutputStream(response.getOutputStream());

		    FileCopyUtils.copy(in, out);
		    out.flush();
		} catch (Exception ex) {
			//response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<script type=\"text/javascript\">alert('" + ex.getMessage() + "');window.close();</script>");
			printwriter.println("<br><br><br>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		} finally {
		    if (in != null) {
			try {
			    in.close();
			} catch (Exception ignore) {
			    // no-op
			    log.debug("IGNORED: " + ignore.getMessage());
			}
		    }
		    if (out != null) {
			try {
			    out.close();
			} catch (Exception ignore) {
			    // no-op
			    log.debug("IGNORED: " + ignore.getMessage());
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
    
    /**
     * 링크 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/cmm/fms/UrlDownload2.do")   
    public void urlDownload2(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String mimetype = "application/x-msdownload";
		
		//20110210 faq참조하여 알아서 주석처리..
		
		//response.setBufferSize(fSize);
		response.setContentType(mimetype);
		//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
		setDisposition((String)commandMap.get("fileNm"), request, response);
		//response.setContentLength(fSize);
		
		HttpURLConnection con = null;
		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
			URL reqUrl = new URL((String)commandMap.get("url"));
			con = (HttpURLConnection)reqUrl.openConnection();
		    in = new BufferedInputStream(con.getInputStream() );
		    out = new BufferedOutputStream(response.getOutputStream());

		    FileCopyUtils.copy(in, out);
		    out.flush();
		} catch (Exception ex) {
			//response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<script type=\"text/javascript\">alert('" + ex.getMessage() + "');window.close();</script>");
			printwriter.println("<br><br><br>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		} finally {
		    if (in != null) {
			try {
			    in.close();
			} catch (Exception ignore) {
			    // no-op
			    log.debug("IGNORED: " + ignore.getMessage());
			}
		    }
		    if (out != null) {
			try {
			    out.close();
			} catch (Exception ignore) {
			    // no-op
			    log.debug("IGNORED: " + ignore.getMessage());
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
}
