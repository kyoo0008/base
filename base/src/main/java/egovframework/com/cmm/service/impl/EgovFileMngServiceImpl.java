package egovframework.com.cmm.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : EgovFileMngServiceImpl.java
 * @Description : 파일정보의 관리를 위한 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Service("EgovFileMngService")
public class EgovFileMngServiceImpl extends AbstractServiceImpl implements EgovFileMngService {

    @Resource(name = "FileManageDAO")
    private FileManageDAO fileMngDAO;
    
    @Resource(name = "egovFileIdGnrService")
    private EgovIdGnrService fileIdgenService;

    Logger log = Logger.getLogger(this.getClass());

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInfs(java.util.List)
     */
    public int deleteFileInfs(List<FileVO> fvoList) throws Exception {
	return fileMngDAO.deleteFileInfs(fvoList);
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInf(egovframework.com.cmm.service.FileVO)
     */
    public String insertFileInf(FileVO fvo) throws Exception {
    	String atchFileId = fvo.getAtchFileId();
    	
    	fileMngDAO.insertFileInf(fvo);
    	
    	return atchFileId;
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInfs(java.util.List)
     */
    public String insertFileInfs(List<FileVO> fvoList) throws Exception {
	String atchFileId = "";
	
	if (fvoList.size() != 0) {
	    atchFileId = fileMngDAO.insertFileInfs(fvoList);
	}
	
	return atchFileId;
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInfs(egovframework.com.cmm.service.FileVO)
     */
    public List<FileVO> selectFileInfs(FileVO fvo) throws Exception {
	return fileMngDAO.selectFileInfs(fvo);
    }
    
    /**
     * thume이미지가 존재하지 않을때
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInfs(egovframework.com.cmm.service.FileVO)
     */
    public FileVO selectFileInfByFileNm(FileVO fvo) throws Exception {
    	return fileMngDAO.selectFileInfByFileNm(fvo);
    }
    

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#updateFileInfs(java.util.List)
     */
    public void updateFileInfs(List<FileVO> fvoList) throws Exception {
	//Delete & Insert
	fileMngDAO.updateFileInfs(fvoList);
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInf(egovframework.com.cmm.service.FileVO)
     */
    public int deleteFileInf(FileVO fvo) throws Exception {
    	
    	FileVO vo = selectFileInf(fvo);
    	if(vo != null) {
    		EgovFormBasedFileUtil.deleteFile(vo.fileStreCours + File.separator + vo.streFileNm);
    	}
    	
    	int iResult = fileMngDAO.deleteFileInf(fvo);
    	
    	//프로그램모듈의 첨부파일아이디 업데이트
    	if(!EgovStringUtil.isEmpty(fvo.getProgrmId())) {
	    	int iCount = fileMngDAO.getFileCount(fvo);
	    	if(iCount == 0) {
	    		fileMngDAO.deleteProgrmFileId(fvo);
	    	}
    	}
    	return iResult;
    }

    /**
     * 여러개의 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInf(egovframework.com.cmm.service.FileVO)
     */
    public void deleteFileInfs(String atchFileId) throws Exception {
    	
    	FileVO fvo = new FileVO();
    	fvo.setAtchFileId(atchFileId);
    	
    	FileVO dbVO = null;
    	List<FileVO> fileList = selectFileInfs(fvo);
    	if(fileList != null && fileList.size() > 0) {
			for(int i = 0; i < fileList.size(); i++) {
				dbVO = fileList.get(i);
				EgovFormBasedFileUtil.deleteFile(dbVO.fileStreCours + File.separator + dbVO.streFileNm);
			}
		}
    	
    	deleteAllFileInf(fvo);
    }
    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileMaster(FileVO fvo) throws Exception {
	return fileMngDAO.selectFileMaster(fvo);
    }
    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInf(egovframework.com.cmm.service.FileVO)
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception {
	return fileMngDAO.selectFileInf(fvo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#getMaxFileSN(egovframework.com.cmm.service.FileVO)
     */
    public int getMaxFileSN(FileVO fvo) throws Exception {
	return fileMngDAO.getMaxFileSN(fvo);
    }

    /**
     * 파일 갯수를 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getFileCount(FileVO fvo) throws Exception {
	return fileMngDAO.getFileCount(fvo);
    }
    
    /**
     * 전체 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteAllFileInf(egovframework.com.cmm.service.FileVO)
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception {
	fileMngDAO.deleteAllFileInf(fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileListByFileNm(egovframework.com.cmm.service.FileVO)
     */
    public Map<String, Object> selectFileListByFileNm(FileVO fvo) throws Exception {
	List<FileVO>  result = fileMngDAO.selectFileListByFileNm(fvo);
	int cnt = fileMngDAO.selectFileListCntByFileNm(fvo);

	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.FileVO)
     */
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception {
	return fileMngDAO.selectImageFileList(vo);
    }
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInf(FileVO fvo) throws Exception {
	return fileMngDAO.selectTempFileInf(fvo);
    }
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInfByAtchFileIdAndFileSn(FileVO fvo) throws Exception {
	return fileMngDAO.selectTempFileInfByAtchFileIdAndFileSn(fvo);
    }
    
    /**
     * 임시 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public FileVO insertTempFileInf(FileVO vo) throws Exception {
    	fileMngDAO.insertTempFileInf(vo);
    	
    	FileVO dbVO = selectTempFileInf(vo);    	
    	EgovFormBasedFileUtil.renameFile(dbVO.fileStreCours, vo.streFileNm, dbVO.getStreFileNm());
    	
    	return dbVO;
    }
    
    /**
     * 하나의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public FileVO deleteTempFileInf(FileVO fvo) throws Exception {
    	
    	FileVO vo = selectTempFileInf(fvo);
    	if(vo != null) {
    		EgovFormBasedFileUtil.deleteFile(vo.fileStreCours + File.separator + vo.streFileNm);
    	}
    	fileMngDAO.deleteTempFileInf(fvo);
    	return vo;
    }
    
    /**
     * 임시 파일로 부터 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public FileVO insertFileInfsByTemp(FileVO vo) throws Exception {
    	
    	if(!EgovStringUtil.isEmpty(vo.getFileGroupId())) {	    	
    		if(EgovStringUtil.isEmpty(vo.getAtchFileId())) {
    			vo.setAtchFileId(vo.getFileGroupId());
	    		fileMngDAO.insertFileInfsByTempMaster(vo);
	    	}

	    	fileMngDAO.insertFileInfsByTempDetail(vo);
	    	
	    	fileMngDAO.deleteFileDetailByTemp(vo);
    	}
    	
    	int iCount = fileMngDAO.getFileCount(vo);
		if(iCount == 0) {
			vo.setAtchFileId("");
			vo.setFileGroupId("");
		}
    	
    	return vo;
    }
    
    /**
     * 여러 개의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileDetailByTemp(FileVO fvo) throws Exception {
    	return fileMngDAO.deleteFileDetailByTemp(fvo);
    }
    
    /**
     * 첨부파일의 총용량과 갯수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileDetailTotalInfo(FileVO fvo) throws Exception {
    	return fileMngDAO.selectFileDetailTotalInfo(fvo);
    }
    
    /**
     * 관리용 첨부파일을 복사한다.
     * 
     * @param articleList
     * @throws Exception
     */
    public List<BoardVO> updateFileManageCopy(List<BoardVO> articleList) throws Exception {
    	
    	BoardVO board = null;
    	FileVO fileVO = null;
    	List<String> atchFileIdArr = new ArrayList<String>();
    	List<FileVO> masterList = new ArrayList<FileVO>();
    	for(int i = 0; i < articleList.size(); i++) {
    		board = articleList.get(i);
    		if(!EgovStringUtil.isEmpty(board.getAtchFileId())) {
    			atchFileIdArr.add(board.getAtchFileId());
    			fileVO = new FileVO();
    			fileVO.setAtchFileId(board.getAtchFileId());
    			masterList.add(fileVO);
    		}
    	}
    	
    	if(atchFileIdArr.size() > 0) {
	    	fileVO =  new FileVO();
	    	fileVO.setAtchFileIdArr(atchFileIdArr);
	    	
	  	  	List<FileVO> fileList = fileMngDAO.selectFileManageCopyList(fileVO);
	  	  	if(fileList != null && fileList.size() > 0) {
	  	  		updateNewFileIdGen(masterList, fileList);
	  	  		copyFiles(fileList);
	  	  		
	  	  		for(int i = 0; i < articleList.size(); i++) {
	  	  			board = articleList.get(i);
		  	  		if(!EgovStringUtil.isEmpty(board.getAtchFileId())) {
			  	  		for(int m = 0; m < masterList.size(); m++) {
			  	  			fileVO = fileList.get(m);
			  	  			if(board.getAtchFileId().equals(fileVO.getOldAtchFileId())) {
			  	  				board.setAtchFileId(fileVO.getAtchFileId());
			  	  				break;
			  	  			}
			  	  		}
		    		}
	  	  		}
	  	  			  	  		
	  	  		fileMngDAO.insertFileBatch(masterList, fileList);
	  	  	}
    	}
  	  	
  	  	return articleList;
    }
    
    /**
     *  첨부파일을 물리적으로 복사한다.
     * 
     * @param fileList
     */
    public List<FileVO> copyFiles(List<FileVO> fileList) throws Exception {
    	FileVO file = null;
    	String newStreFileNm = null;
    	for(int i = 0; i < fileList.size(); i++) {
    		file = fileList.get(i);
    		newStreFileNm = file.getAtchFileId() + "_" + file.getFileSn();
    		FileCopyUtils.copy(new File(file.getFileStreCours(), file.getStreFileNm()), new File(file.getFileStreCours(), newStreFileNm));
    		file.setStreFileNm(newStreFileNm);
    	}
    	
    	return fileList;
    }
    /**
     *  첨부파일아이디를 재배치한다.
     * 
     * @param fileList
     */
    public void updateNewFileIdGen(List<FileVO> masterList, List<FileVO> fileList) throws Exception {
    	String newAtchFileId = null;
    	FileVO masterVO = null;
    	for(int i = 0; i < masterList.size(); i++) {
    		
    		newAtchFileId = fileIdgenService.getNextStringId();
    		
    		masterVO = masterList.get(i);
    		masterVO.setOldAtchFileId(masterVO.getAtchFileId());
    		masterVO.setAtchFileId(newAtchFileId);
    		
    		updateNewFileIdGen(fileList, masterVO.getOldAtchFileId(), newAtchFileId);
    		
    	}
  		
    }
    
    /**
     *  첨부파일아이디를 재배치한다.
     * 
     * @param fileList
     * @param oldAtchFileId
     * @param newAtchFileId
     */
    public void updateNewFileIdGen(List<FileVO> fileList, String oldAtchFileId, String newAtchFileId) throws Exception {
  	
    	FileVO file = null;
    	for(int i = 0; i < fileList.size(); i++) {
    		file = fileList.get(i);
	  		if(oldAtchFileId.equals(file.getAtchFileId())) {
	  			file.setAtchFileId(newAtchFileId);
	  			file.setOldAtchFileId(oldAtchFileId);
	  		}
	  	}
    }
}
