package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : EgovImageProcessController.java
 * @Description : 
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 4. 2.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@Controller
public class EgovImageProcessController {
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
    
    Logger log = Logger.getLogger(this.getClass());

    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     * 
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    /*
    @RequestMapping("/cmm/fms/getImage.do")
    public void getImageInf(ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	//@RequestParam("atchFileId") String atchFileId,
	//@RequestParam("fileSn") String fileSn,
	String atchFileId = (String)commandMap.get("atchFileId");
	String fileSn = (String)commandMap.get("fileSn");
	String thumbYn = (String)commandMap.get("thumbYn");
	
	FileVO vo = new FileVO();	
	vo.setAtchFileId(atchFileId);
	vo.setFileSn(fileSn);

	FileVO fvo = fileService.selectFileInf(vo);
	
	File file = null;
	
	if("Y".equals(thumbYn)) {
		String strWidth = (String)commandMap.get("width");
		String strHeight = (String)commandMap.get("height");
		int width = (EgovNumberUtil.getNumberValidCheck(strWidth)) ? EgovStringUtil.zeroConvert(strWidth) : propertiesService.getInt("photoThumbWidth");
		int height = (EgovNumberUtil.getNumberValidCheck(strHeight)) ? EgovStringUtil.zeroConvert(strHeight) : propertiesService.getInt("photoThumbHeight");
		
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm() + "_THUMB." + fvo.getFileExtsn());
		if(!file.exists()) {
			Thumbnails.of(new File(fvo.getFileStreCours(), fvo.getStreFileNm()))
				.size(width, height)
				.toFile(file)
				;
		}
	} else {
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	}
	
	FileInputStream fis = new FileInputStream(file);

	BufferedInputStream in = new BufferedInputStream(fis);
	ByteArrayOutputStream bStream = new ByteArrayOutputStream();

	int imgByte;
	while ((imgByte = in.read()) != -1) {
	    bStream.write(imgByte);
	}
	in.close();
	
	String type = "";

	if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
	    if ("jpg".equals(EgovStringUtil.lowerCase(fvo.getFileExtsn()))) {
		type = "image/jpeg"; //TODO 정말 이런걸까?
	    } else {
		type = "image/" + EgovStringUtil.lowerCase(fvo.getFileExtsn());
	    }
	    type = "image/" + EgovStringUtil.lowerCase(fvo.getFileExtsn());

	} else {
	    log.debug("Image fileType is null.");
	}

	response.setHeader("Content-Type", type);
	response.setContentLength(bStream.size());
	
	bStream.writeTo(response.getOutputStream());
	
	response.getOutputStream().flush();
	response.getOutputStream().close();
	

    }
    */
    
    /**
     * 게시판의 첨부된 이미지에 대한(썸네일) 미리보기 기능을 제공한다.
     * 
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/getImage.do")
    public void getImage(ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	    String fileStorePath = EgovStringUtil.isEmpty((String)commandMap.get("fileStorePath")) ? "Board.fileStorePath" : (String)commandMap.get("fileStorePath");
		String siteId = (String)commandMap.get("siteId");
		String appendPath = (String)commandMap.get("appendPath");
		String atchFileNm = (String)commandMap.get("atchFileNm");
		String thumbYn = (String)commandMap.get("thumbYn");
		String fileExt = "";
	    int index = atchFileNm.lastIndexOf(".");
	    if(index != -1) {
	    	fileExt = atchFileNm.substring(index + 1);
	    	atchFileNm = atchFileNm.substring(0, index);
	    }
	    
	    String resFilePath = propertiesService.getString(fileStorePath) + "/" + siteId+ "/" + appendPath;
	    File file = null;
	    if("Y".equals(thumbYn)) {
			String strWidth = (String)commandMap.get("width");
			String strHeight = (String)commandMap.get("height");
			int width = (EgovNumberUtil.getNumberValidCheck(strWidth)) ? EgovStringUtil.zeroConvert(strWidth) : propertiesService.getInt("photoThumbWidth");
			int height = (EgovNumberUtil.getNumberValidCheck(strHeight)) ? EgovStringUtil.zeroConvert(strHeight) : propertiesService.getInt("photoThumbHeight");
			
			file = new File(resFilePath, atchFileNm + "_THUMB." + fileExt);
			if(!file.exists()) {
				FileVO vo = new FileVO();
				
				vo.setStreFileNm(atchFileNm);
				vo = fileService.selectFileInfByFileNm(vo);
				
				Thumbnails.of(new File(vo.getFileStreCours(), atchFileNm))
					.size(width, height)
					.toFile(file)
					;
			}
	    } else {
	    	file = new File(resFilePath, atchFileNm);
	    }
		
	    if(file.exists()) {
			FileInputStream fis = null;	
			BufferedInputStream in = null;
			ByteArrayOutputStream bStream = null;
		
			try {
				
				fis = new FileInputStream(file);			
				in = new BufferedInputStream(fis);
				bStream = new ByteArrayOutputStream();
				
				int imgByte;
				while ((imgByte = in.read()) != -1) {
				    bStream.write(imgByte);
				}
				
				String type = "";
			
				if (fileExt != null && !"".equals(fileExt)) {
				    if ("jpg".equals(EgovStringUtil.lowerCase(fileExt))) {
					type = "image/jpeg"; //TODO 정말 이런걸까?
				    } else {
					type = "image/" + EgovStringUtil.lowerCase(fileExt);
				    }
				    type = "image/" + EgovStringUtil.lowerCase(fileExt);
			
				} else {
				    log.debug("Image fileType is null.");
				}
			
				response.setHeader("Content-Type", type);
				response.setContentLength(bStream.size());
				
				bStream.writeTo(response.getOutputStream());
				
				response.getOutputStream().flush();
			} catch (FileNotFoundException fnfe) {
				log.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm);
			} catch (IOException ioe) {
				log.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm);
			} catch(Exception e) {
				log.debug("/cmm/fms/getImage.do -- stream error : " + atchFileNm);
			} finally {
				try {response.getOutputStream().close();}catch(Exception ex){}
				if(bStream != null) {
					try {bStream.close();}catch(Exception ex){}
				}
				if(in != null) {
					try {in.close();}catch(Exception ex){}
				}
				if(fis != null) {
					try {fis.close();}catch(Exception ex){}
				}
			}
	    }
    }
    
}
