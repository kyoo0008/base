package egovframework.com.cmm.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cop.bbs.service.BoardVO;

/**
 * @Class Name : EgovFileMngService.java
 * @Description : 파일정보의 관리를 위한 서비스 인터페이스
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
public interface EgovFileMngService {

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectFileInfs(FileVO fvo) throws Exception;

    /**
     * thume이미지가 존재하지 않을때
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInfByFileNm(FileVO fvo) throws Exception;
    
    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public String insertFileInf(FileVO fvo) throws Exception;

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fvoList
     * @throws Exception
     */
    public String insertFileInfs(List<FileVO> fvoList) throws Exception;

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fvoList
     * @throws Exception
     */
    public void updateFileInfs(List<FileVO> fvoList) throws Exception;

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fvoList
     * @throws Exception
     */
    public int deleteFileInfs(List<FileVO> fvoList) throws Exception;

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileInf(FileVO fvo) throws Exception;

    /**
     * 여러개의 파일을 삭제한다.
     * 
     */
    public void deleteFileInfs(String atchFileId) throws Exception;
    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileMaster(FileVO fvo) throws Exception;
    
    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception;

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(FileVO fvo) throws Exception;

    /**
     * 파일 갯수를 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getFileCount(FileVO fvo) throws Exception;
    
    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception;

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFileListByFileNm(FileVO fvo) throws Exception;

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception;
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInf(FileVO fvo) throws Exception ;
    
    /**
     * 임시 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectTempFileInfByAtchFileIdAndFileSn(FileVO fvo) throws Exception;
    
    /**
     * 임시 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public FileVO insertTempFileInf(FileVO vo) throws Exception ;
    
    /**
     * 하나의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public FileVO deleteTempFileInf(FileVO fvo) throws Exception ;
    
    /**
     * 임시 파일로 부터 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public FileVO insertFileInfsByTemp(FileVO vo) throws Exception ;
    
    /**
     * 여러 개의 임시 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public int deleteFileDetailByTemp(FileVO fvo) throws Exception ;
    
    /**
     * 첨부파일의 총용량과 갯수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileDetailTotalInfo(FileVO fvo) throws Exception;
    
    /**
     * 관리용 첨부파일을 복사한다.
     * 
     * @param articleList
     * @throws Exception
     */
    public List<BoardVO> updateFileManageCopy(List<BoardVO> articleList) throws Exception;
}
