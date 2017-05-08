package egovframework.com.cmm.service.impl;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : EgovFileMngDAO.java
 * @Description : 파일정보 관리를 위한 데이터 처리 클래스
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
@Repository("FileManageDAO")
public class FileManageDAO extends EgovAbstractDAO {

    Logger log = Logger.getLogger(this.getClass());

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    public String insertFileInfs(List<FileVO> fileList) throws Exception {
	FileVO vo = fileList.get(0);
	String atchFileId = vo.getAtchFileId();
	
	insert("FileManageDAO.insertFileMaster", vo);

	Iterator<FileVO> iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = iter.next();
	    
	    insert("FileManageDAO.insertFileDetail", vo);
	}
	
	return atchFileId;
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(FileVO vo) throws Exception {
	insert("FileManageDAO.insertFileMaster", vo);
	insert("FileManageDAO.insertFileDetail", vo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public void updateFileInfs(List<FileVO> fileList) throws Exception {
	FileVO vo;
	Iterator<FileVO> iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = iter.next();
	    
	    insert("FileManageDAO.insertFileDetail", vo);
	}
    }

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public int deleteFileInfs(List<FileVO> fileList) throws Exception {
    	
    	int cnt = 0;
		Iterator<FileVO> iter = fileList.iterator();
		FileVO vo;
		while (iter.hasNext()) {
		    vo = iter.next();
		    
		    delete("FileManageDAO.deleteFileDetail", vo);
		    
		    cnt++;
		}
	
		return cnt;
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileInf(FileVO fvo) throws Exception {
	return delete("FileManageDAO.deleteFileDetail", fvo);
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileInfs(FileVO vo) throws Exception {
	return list("FileManageDAO.selectFileList", vo);
    }
    
    /**
     * 2013.03.29 이재현
     * thume이미지가 존재하지 않을때
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public FileVO selectFileInfByFileNm(FileVO vo) throws Exception {
    	return (FileVO)selectByPk("FileManageDAO.selectFileInfByFileNm", vo);
    }
    
    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(FileVO fvo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.getMaxFileSN", fvo);
    }
    
    /**
     * 파일 갯수를 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getFileCount(FileVO fvo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.getFileCount", fvo);
    }

    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileMaster(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectFileMaster", fvo);
    }
    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectFileInf", fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception {
    	delete("FileManageDAO.deleteAllFileDetail", fvo);
    	delete("FileManageDAO.deleteFileInf", fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileListByFileNm(FileVO fvo) throws Exception {
	return list("FileManageDAO.selectFileListByFileNm", fvo);
    }

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(FileVO fvo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.selectFileListCntByFileNm", fvo);
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception {
	return list("FileManageDAO.selectImageFileList", vo);
    }
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInf(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectTempFileInf", fvo);
    }
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInfByAtchFileIdAndFileSn(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectTempFileInfByAtchFileIdAndFileSn", fvo);
    }
    
    /**
     * 임시 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertTempFileInf(FileVO vo) throws Exception {
	insert("FileManageDAO.insertTempFileDetail", vo);
    }
    
    /**
     * 하나의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteTempFileInf(FileVO fvo) throws Exception {
    	return delete("FileManageDAO.deleteTempFileDetail", fvo);
    }
    
    /**
     * 임시 파일로 부터 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInfsByTempMaster(FileVO vo) throws Exception {
	insert("FileManageDAO.insertFileMaster", vo);
    }
    
    /**
     * 임시 파일로 부터 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInfsByTempDetail(FileVO vo) throws Exception {
	insert("FileManageDAO.insertFileDetailByTemp", vo);
    }
    
    /**
     * 여러 개의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileDetailByTemp(FileVO fvo) throws Exception {
    	return delete("FileManageDAO.deleteFileDetailByTemp", fvo);
    }
    
    /**
     * 프로그램 첨부파일 ID 를 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteProgrmFileId(FileVO fvo) throws Exception {
    	delete("FileManageDAO.deleteProgrmFileId", fvo);
    }
    
    /**
     * 첨부파일의 총용량과 갯수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileDetailTotalInfo(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectFileDetailTotalInfo", fvo);
    }
    
    /**
     * 관리용 첨부파일 이동을 위한 모든정보를 조회 한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileManageCopyList(FileVO vo) throws Exception {
	return list("FileManageDAO.selectFileManageCopyList", vo);
    }
    
    /**
     * 관리용 첨부파일을 일괄등록한다.
     * 
     * @param commentList
     * @return
     * @throws Exception
     */
    public void insertFileBatch(final List<FileVO> masterList, final List<FileVO> fileList) throws Exception {
    	
    	if(fileList != null && fileList.size() > 0) {
	    	getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              for(int i = 0; i < masterList.size(); i++) {
		            	  insert("FileManageDAO.insertFileMaster", masterList.get(i));
		              }
		              
		              for(int i = 0; i < fileList.size(); i++) {
		            	  insert("FileManageDAO.insertFileDetail", fileList.get(i));
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		    });
    	}
    	
    }
}
