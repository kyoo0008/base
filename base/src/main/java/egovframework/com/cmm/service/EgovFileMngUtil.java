package egovframework.com.cmm.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name  : EgovFileMngUtil.java
 * @Description : 메시지 처리 관련 유틸리티
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.02.13       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 */
@Component("EgovFileMngUtil")
public class EgovFileMngUtil {

    public static final int BUFF_SIZE = 4096;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovFileIdGnrService")
    private EgovIdGnrService idgenService;

    Logger log = Logger.getLogger(this.getClass());
    
    String[] denyFileExtentionList = new String[]{"sh", "exe"};

    /**
     * 다이렉트 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> directParseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String storePath, String appendPath) throws Exception {
	int fileKey = fileKeyParam;
	
	String storePathString = "";
	String atchFileIdString = "";

	if ("".equals(storePath) || storePath == null) {
	    storePathString = propertyService.getString("Globals.fileStorePath");
	} else {
	    storePathString = propertyService.getString(storePath);
	}
	
	if (!("".equals(appendPath) || appendPath == null)) {
	    storePathString = storePathString + File.separator + appendPath;
	}

	File saveFolder = new File(storePathString);
	
	if (!saveFolder.exists() || saveFolder.isFile()) {
	    saveFolder.mkdirs();
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<FileVO> result  = new ArrayList<FileVO>();
	FileVO fvo;

	boolean isDenyed;
	while (itr.hasNext()) {
	    Entry<String, MultipartFile> entry = itr.next();

	    file = entry.getValue();
	    String orginFileName = file.getOriginalFilename();
	    
	    //--------------------------------------
	    // 원 파일명이 없는 경우 처리
	    // (첨부가 되지 않은 input file type)
	    //--------------------------------------
	    if ("".equals(orginFileName)) {
		continue;
	    }
	    ////------------------------------------

	    String newName = "";
	    String fileExt = "";
	    int index = orginFileName.lastIndexOf(".");
	    if(index != -1) {
	    	fileExt = orginFileName.substring(index + 1);
	    	newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey + "." + fileExt;
	    } else {
	    	newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey;
	    }
	    
	    isDenyed = false;
	    for(int i=0; i < denyFileExtentionList.length; i++) {
	    	if(fileExt.toLowerCase().equals(denyFileExtentionList[i])) {
	    		isDenyed = true;
	    		break;
	    	}
	    }	    
	    if (isDenyed) {
			continue;
		}
	    
	    long _size = file.getSize();

	    if (!"".equals(orginFileName)) {
	    	filePath = storePathString + File.separator + newName;
	    	file.transferTo(new File(filePath));
	    }
	    fvo = new FileVO();
	    fvo.setFileExtsn(fileExt);
	    fvo.setFileStreCours(storePathString);
	    fvo.setFileMg(Long.toString(_size));
	    fvo.setOrignlFileNm(orginFileName);
	    fvo.setStreFileNm(newName);
	    fvo.setAtchFileId(atchFileIdString);
	    fvo.setFileSn(String.valueOf(fileKey));
	    fvo.setFormNm(entry.getKey());

	    //writeFile(file, newName, storePathString);
	    result.add(fvo);
	    
	    fileKey++;
	}

	return result;
    }
    
    /**
     * 일반 게시판 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseBoardFileInf(Map<String, MultipartFile> files, int fileKeyParam, String atchFileId, String aspCode, String bbsId) throws Exception {
    	
    	return parseFileInf(files, "BBS_", fileKeyParam, atchFileId, "Board.fileStorePath", aspCode + File.separator + bbsId);
    }
    
    /**
     * QNA 게시판 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseQnaFileInf(Map<String, MultipartFile> files, int fileKeyParam, String atchFileId, String aspCode) throws Exception {
    	
    	return parseFileInf(files, "QAQ_", fileKeyParam, atchFileId, "Qna.fileStorePath", aspCode);
    }
    
    /**
     * FAQ 게시판 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseFaqFileInf(Map<String, MultipartFile> files, int fileKeyParam, String atchFileId, String aspCode) throws Exception {
    	
    	return parseFileInf(files, "FAQ_", fileKeyParam, atchFileId, "Faq.fileStorePath", aspCode);
    }
    
    /**
     * 자료요청 게시판 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseDtaReqFileInf(Map<String, MultipartFile> files, String fileNmHeader, int fileKeyParam, String atchFileId, String aspCode) throws Exception {
    	
    	return parseFileInf(files, fileNmHeader, fileKeyParam, atchFileId, "DtaReq.fileStorePath", aspCode);
    }
    
    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath, String appendPath) throws Exception {
	int fileKey = fileKeyParam;
	
	String storePathString = "";
	String atchFileIdString = "";

	if ("".equals(storePath) || storePath == null) {
	    storePathString = propertyService.getString("Globals.fileStorePath");
	} else {
	    storePathString = propertyService.getString(storePath);
	}
	
	if (!("".equals(appendPath) || appendPath == null)) {
	    storePathString = storePathString + File.separator + appendPath;
	}

	if ("".equals(atchFileId) || atchFileId == null) {
	    atchFileIdString = idgenService.getNextStringId();
	} else {
	    atchFileIdString = atchFileId;
	}

	File saveFolder = new File(storePathString);
	
	if (!saveFolder.exists() || saveFolder.isFile()) {
	    saveFolder.mkdirs();
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<FileVO> result  = new ArrayList<FileVO>();
	FileVO fvo;

	boolean isDenyed;
	while (itr.hasNext()) {
	    Entry<String, MultipartFile> entry = itr.next();

	    file = entry.getValue();
	    String orginFileName = file.getOriginalFilename();
	    
	    //--------------------------------------
	    // 원 파일명이 없는 경우 처리
	    // (첨부가 되지 않은 input file type)
	    //--------------------------------------
	    if ("".equals(orginFileName)) {
		continue;
	    }
	    
	    ////------------------------------------

	    String fileExt = "";
	    int index = orginFileName.lastIndexOf(".");
	    if(index != -1) {
	    	fileExt = orginFileName.substring(index + 1);
	    } 
	    
	    isDenyed = false;
	    for(int i=0; i < denyFileExtentionList.length; i++) {
	    	if(fileExt.toLowerCase().equals(denyFileExtentionList[i])) {
	    		isDenyed = true;
	    		break;
	    	}
	    }	    
	    if (isDenyed) {
			continue;
		}
	    
	    String newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey;
	    long _size = file.getSize();

	    if (!"".equals(orginFileName)) {
	    	filePath = storePathString + File.separator + newName;
	    	file.transferTo(new File(filePath));
	    }
	    
	    fvo = new FileVO();
	    fvo.setFileExtsn(fileExt);
	    fvo.setFileStreCours(storePathString);
	    fvo.setFileMg(Long.toString(_size));
	    fvo.setOrignlFileNm(orginFileName);
	    fvo.setStreFileNm(newName);
	    fvo.setAtchFileId(atchFileIdString);
	    fvo.setFileSn(String.valueOf(fileKey));
	    fvo.setFormNm(entry.getKey());

	    //writeFile(file, newName, storePathString);
	    result.add(fvo);
	    
	    fileKey++;
	}

	return result;
    }

    /**
     * 첨부파일을 서버에 저장한다.
     * 
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;
	
	try {
	    stream = file.getInputStream();
	    File cFile = new File(stordFilePath);

	    if (!cFile.isDirectory()) {
		boolean _flag = cFile.mkdir();
		if (!_flag) {
		    throw new IOException("Directory creation Failed ");
		}
	    }

	    bos = new FileOutputStream(stordFilePath + File.separator + newName);

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		bos.write(buffer, 0, bytesRead);
	    }
	} catch (FileNotFoundException fnfe) {
	    fnfe.printStackTrace();
	} catch (IOException ioe) {
	    ioe.printStackTrace();
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch (Exception ignore) {
		    log.debug("IGNORED: " + ignore.getMessage());
		}
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch (Exception ignore) {
		    log.debug("IGNORED: " + ignore.getMessage());
		}
	    }
	}
    }	
	
    /**
     * 대용량파일을 Upload 처리한다.
     * 
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     * @throws Exception
     */
    public FileVO uploadStreamLongFiles(InputStream is, FileVO fileVO, boolean firstChunk, boolean lastChunk) throws Exception {
    	
    	File file = new File(fileVO.getFileStreCours() + File.separator + fileVO.getStreFileNm());
    	
    	if(firstChunk) {
	    	if (! file.getParentFile().exists()) {
			    file.getParentFile().mkdirs();
			}
    	}
    	
    	Exception proEx = null;
    	OutputStream os = null;		
		try {
		    os = new FileOutputStream(file, true);
		    
		    int bytesRead = 0;
		    byte[] buffer = new byte[BUFF_SIZE];
		    
		    while ((bytesRead = is.read(buffer, 0, BUFF_SIZE)) != -1) {
		    	os.write(buffer, 0, bytesRead);
		    }
		} catch (FileNotFoundException ex) {
			proEx = ex;
		} catch (IOException ex) {
			proEx = ex;
		} catch(Exception ex) {
			proEx = ex;
		} finally {
		    if (os != null) {
		    	os.close();
		    }
		}
		
		if(proEx != null) {
			throw proEx;
		}
		
		if(lastChunk) {
			
			String fileExt = "";
		    int index = fileVO.getOrignlFileNm().lastIndexOf(".");
		    if(index != -1) {
		    	fileExt = fileVO.getOrignlFileNm().substring(index + 1);
		    } 
		   
		    fileVO.setFileExtsn(fileExt);
		    fileVO.setFileMg(Long.toString(file.length()));	
		}
		
        return fileVO;
    }
}
