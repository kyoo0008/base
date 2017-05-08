package egovframework.com.sym.log.service;

import java.io.Serializable;

/**
 * @Class Name : LoginLog.java
 * @Description : 접속 로그 관리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
public class LoginLog implements Serializable {

	/**
	 * SITE 코드
	 */
    private String siteId = "";
    
	/**
	 * 시스템구분코드
	 */
    private String sysTyCode = "";
    
	/**
	 * 로그ID
	 */
	private String logId;

	/**
	 * 사용자ID
	 */
	private String loginId;

	/**
	 * 사용자명
	 */
	private String loginNm;

	/**
	 * 접속IP
	 */
	private String loginIp;

	/**
	 * 접속방식
	 */
	private String loginMthd;

	/**
	 * 에러발생여부
	 */
	private String errOccrrAt;

	/**
	 * 에러코드
	 */
	private String errorCode;

	/**
	 * 생성일시
	 */
	private String creatDt;

	/**
	 * 검색시작일
	 */
	private String searchBgnDe = "";
	/**
	 * 검색조건
	 */
	private String searchCnd = "";
	/**
	 * 검색종료일
	 */
	private String searchEndDe = "";
	/**
	 * 검색단어
	 */
	private String searchWrd = "";
	/**
	 * 정렬순서(DESC,ASC)
	 */
	private String sortOrdr = "";
	
	/**
	 * 검색사용여부
	 */
    private String searchUseYn = "";
    
    /**
	 * 현재페이지
	 */
    private int pageIndex = 1;
    
    /**
	 * 페이지갯수
	 */
    private int pageUnit = 10;
    
    /**
	 * 페이지사이즈
	 */
    private int pageSize = 10;

    /**
	 * firstIndex
	 */
    private int firstIndex = 1;

    /**
	 * lastIndex
	 */
    private int lastIndex = 1;

    /**
	 * recordCountPerPage
	 */
    private int recordCountPerPage = 10;	
		
    /**
	 * rowNo
	 */
	private int rowNo = 0;

	/**
	 * @return
	 */
	public String getLogId() {
		return logId;
	}

	/**
	 * @param logId
	 */
	public void setLogId(String logId) {
		this.logId = logId;
	}

	/**
	 * @return
	 */
	public String getLoginId() {
		return loginId;
	}

	/**
	 * @param loginId
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	/**
	 * @return
	 */
	public String getLoginIp() {
		return loginIp;
	}

	/**
	 * @param loginIp
	 */
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	/**
	 * @return
	 */
	public String getLoginMthd() {
		return loginMthd;
	}

	/**
	 * @param loginMthd
	 */
	public void setLoginMthd(String loginMthd) {
		this.loginMthd = loginMthd;
	}

	/**
	 * @return
	 */
	public String getErrOccrrAt() {
		return errOccrrAt;
	}

	/**
	 * @param errOccrrAt
	 */
	public void setErrOccrrAt(String errOccrrAt) {
		this.errOccrrAt = errOccrrAt;
	}

	/**
	 * @return
	 */
	public String getErrorCode() {
		return errorCode;
	}

	/**
	 * @param errorCode
	 */
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	/**
	 * @return
	 */
	public String getCreatDt() {
		return creatDt;
	}

	/**
	 * @param creatDt
	 */
	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}

	/**
	 * @return
	 */
	public String getSearchBgnDe() {
		return searchBgnDe;
	}

	/**
	 * @param searchBgnDe
	 */
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}

	/**
	 * @return
	 */
	public String getSearchCnd() {
		return searchCnd;
	}

	/**
	 * @param searchCnd
	 */
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	/**
	 * @return
	 */
	public String getSearchEndDe() {
		return searchEndDe;
	}

	/**
	 * @param searchEndDe
	 */
	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	/**
	 * @return
	 */
	public String getSearchWrd() {
		return searchWrd;
	}

	/**
	 * @param searchWrd
	 */
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	/**
	 * @return
	 */
	public String getSortOrdr() {
		return sortOrdr;
	}

	/**
	 * @param sortOrdr
	 */
	public void setSortOrdr(String sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	/**
	 * @return
	 */
	public String getSearchUseYn() {
		return searchUseYn;
	}

	/**
	 * @param searchUseYn
	 */
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	/**
	 * @return
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * @param pageIndex
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * @return
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * @param pageUnit
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * @return
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * @param firstIndex
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * @return
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * @param lastIndex
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * @return
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * @param recordCountPerPage
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	/**
	 * @return
	 */
	public int getRowNo() {
		return rowNo;
	}

	/**
	 * @param rowNo
	 */
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}

	/**
	 * @return
	 */
	public String getLoginNm() {
		return loginNm;
	}

	/**
	 * @param loginNm
	 */
	public void setLoginNm(String loginNm) {
		this.loginNm = loginNm;
	}
	
	/**
	 * sysTyCode attribute를 리턴한다.
	 * @return  the sysTyCode
	 */
    public String getSysTyCode() {
        return sysTyCode;
    }

    /**
	 * sysTyCode attribute 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 */
    public void setSysTyCode(String sysTyCode) {
        this.sysTyCode = sysTyCode;
    }
    
    /**
	 * siteId attribute를 리턴한다.
	 * @return  the siteId
	 */
    public String getSiteId() {
        return siteId;
    }

    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }
	

}
