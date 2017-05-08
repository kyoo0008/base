package egovframework.com.cmm.service;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.com.utl.fcc.service.EgovStringUtil;

/**
 * @Class Name : FileVO.java
 * @Description : 파일정보 처리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
public class FileVO implements Serializable {

    /**
	 * 첨부파일 아이디
	 */
    public String atchFileId = "";
    /**
	 * 생성일자
	 */
    public java.util.Date creatDt;
    /**
	 * 파일내용
	 */
    public String fileCn = "";
    /**
	 * 파일확장자
	 */
    public String fileExtsn = "";
    /**
	 * 파일크기
	 */
    public String fileMg = "";
    /**
	 * 파일연번
	 */
    public String fileSn = "";
    /**
	 * 파일저장경로
	 */
    public String fileStreCours = "";
    /**
	 * 원파일명
	 */
    public String orignlFileNm = "";
    /**
	 * 저장파일명
	 */
    public String streFileNm = "";
    
    /**
	 * 폼명
	 */
    public String formNm = "";
    
    /**
	 * 임시파일그룹ID
	 */
    public String fileGroupId = "";
    
    /**
	 * 임시파일ID
	 */
    public String tmprFileId = "";
    
    /**
	 * 파일갯수
	 */
    public int fileSnCount = 0;
    
    /**
	 * 프로그램ID
	 */
    public String progrmId = "";
    
    /**
	 * 사용여부
	 */
    public String useAt = "Y";
    
    /**
	 * 확장파일여부
	 */
    public String estnAt = "";
    
    /**
	 * 총파일크기
	 */
    public String totalFileMg = "0";
    
    /**
	 * 총파일갯수
	 */
    public String totalFileCount = "0";
    
    /**
	 * 첨부파일아이디리스트
	 */
    private List<String> atchFileIdArr;
    
    /** 이전 첨부파일아이디 */
    private String oldAtchFileId;

    /**
	 * atchFileId attribute를 리턴한다.
	 * @return  the atchFileId
	 */
    public String getAtchFileId() {
	return atchFileId;
    }

    /**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId  the atchFileId to set
	 */
    public void setAtchFileId(String atchFileId) {
	this.atchFileId = atchFileId;
    }

    /**
	 * creatDt attribute를 리턴한다.
	 * @return  the creatDt
	 */
    public java.util.Date getCreatDt() {
	return creatDt;
    }

    /**
	 * creatDt attribute 값을 설정한다.
	 * @param creatDt  the creatDt to set
	 */
    public void setCreatDt(java.util.Date creatDt) {
	this.creatDt = creatDt;
    }

    /**
	 * fileCn attribute를 리턴한다.
	 * @return  the fileCn
	 */
    public String getFileCn() {
	return fileCn;
    }

    /**
	 * fileCn attribute 값을 설정한다.
	 * @param fileCn  the fileCn to set
	 */
    public void setFileCn(String fileCn) {
	this.fileCn = fileCn;
    }

    /**
	 * fileExtsn attribute를 리턴한다.
	 * @return  the fileExtsn
	 */
    public String getFileExtsn() {
	return fileExtsn;
    }

    /**
	 * fileExtsn attribute 값을 설정한다.
	 * @param fileExtsn  the fileExtsn to set
	 */
    public void setFileExtsn(String fileExtsn) {
	this.fileExtsn = fileExtsn;
    }

    /**
	 * fileMg attribute를 리턴한다.
	 * @return  the fileMg
	 */
    public String getFileMg() {
	return fileMg;
    }

    /**
	 * fileMg attribute 값을 설정한다.
	 * @param fileMg  the fileMg to set
	 */
    public void setFileMg(String fileMg) {
	this.fileMg = fileMg;
    }

    /**
	 * fileSn attribute를 리턴한다.
	 * @return  the fileSn
	 */
    public String getFileSn() {
	return fileSn;
    }

    /**
	 * fileSn attribute 값을 설정한다.
	 * @param fileSn  the fileSn to set
	 */
    public void setFileSn(String fileSn) {
	this.fileSn = fileSn;
    }

    /**
	 * fileStreCours attribute를 리턴한다.
	 * @return  the fileStreCours
	 */
    public String getFileStreCours() {
	return fileStreCours;
    }

    /**
	 * fileStreCours attribute 값을 설정한다.
	 * @param fileStreCours  the fileStreCours to set
	 */
    public void setFileStreCours(String fileStreCours) {
	this.fileStreCours = fileStreCours;
    }

    /**
	 * orignlFileNm attribute를 리턴한다.
	 * @return  the orignlFileNm
	 */
    public String getOrignlFileNm() {
	return orignlFileNm;
    }

    /**
	 * orignlFileNm attribute 값을 설정한다.
	 * @param orignlFileNm  the orignlFileNm to set
	 */
    public void setOrignlFileNm(String orignlFileNm) {
	this.orignlFileNm = orignlFileNm;
    }

    /**
	 * streFileNm attribute를 리턴한다.
	 * @return  the streFileNm
	 */
    public String getStreFileNm() {
	return streFileNm;
    }

    /**
	 * streFileNm attribute 값을 설정한다.
	 * @param streFileNm  the streFileNm to set
	 */
    public void setStreFileNm(String streFileNm) {
	this.streFileNm = streFileNm;
    }
    
    /**
	 * formNm attribute를 리턴한다.
	 * @return  the formNm
	 */
    public String getFormNm() {
	return formNm;
    }

    /**
	 * formNm attribute 값을 설정한다.
	 * @param formNm  the formNm to set
	 */
    public void setFormNm(String formNm) {
	this.formNm = formNm;
    }

    public String getFileGroupId() {
		return fileGroupId;
	}

	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}

	public String getTmprFileId() {
		return tmprFileId;
	}

	public void setTmprFileId(String tmprFileId) {
		this.tmprFileId = tmprFileId;
	}

	public int getFileSnCount() {
		return fileSnCount;
	}

	public void setFileSnCount(int fileSnCount) {
		this.fileSnCount = fileSnCount;
	}

	public String getProgrmId() {
		return progrmId;
	}

	public void setProgrmId(String progrmId) {
		this.progrmId = progrmId;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getEstnAt() {
		return estnAt;
	}

	public void setEstnAt(String estnAt) {
		this.estnAt = estnAt;
	}

	public String getTotalFileMg() {
		return totalFileMg;
	}

	public void setTotalFileMg(String totalFileMg) {
		this.totalFileMg = totalFileMg;
	}

	public String getTotalFileCount() {
		return totalFileCount;
	}

	public void setTotalFileCount(String totalFileCount) {
		this.totalFileCount = totalFileCount;
	}

	public String getFileMgByByteConvert() {
		return EgovStringUtil.byteConverter(fileMg);
	}
	
	
	public List<String> getAtchFileIdArr() {
		return atchFileIdArr;
	}

	public void setAtchFileIdArr(List<String> atchFileIdArr) {
		this.atchFileIdArr = atchFileIdArr;
	}

	public String getOldAtchFileId() {
		return oldAtchFileId;
	}

	public void setOldAtchFileId(String oldAtchFileId) {
		this.oldAtchFileId = oldAtchFileId;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
}
