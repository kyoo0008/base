package egovframework.com.sym.ext.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : EgovOrgCodeVO.java
 * @Description : EgovOrgCodeVO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.02    조재영         최초 생성
 *
 *  @author 공통서비스 개발팀 조재영
 *  @since 2009.02.01
 *  @version 1.0
 *  @see 
 *  
 */
@SuppressWarnings("serial")
public class EgovOrgCodeVO implements Serializable {
	
	/** 선택모드여부 */
    private String selectMode = "N";
    
	/**
	 * 검색 지역코드
	*/
	private String searchBlngEduInstCd = "";
	
	/**
	 * 검색 급코드
	*/
	private String searchSchlGrdCd = "";
	
	/**
	 * 기관코드
	*/
	private String orgCd = "";
	
	/**
	 * 대표기관코드
	*/
	private String baseOrgCd = "";
	
	/**
	 * 대표지역코드
	*/
	private String baseBlngCityCd = "";
	
	/**
	 * 지역코드
	*/
	private String blngEduInstCd = "";
	
	/**
	 * 급명
	*/
	private String schlGrdNm = "";
	
	/**
	 * 학교명
	*/
	private String schlNm = "";
	
	/**
	 * 지역명
	*/
	private String schlShrNm = "";
	
	/**
	 * 지역명
	*/
	private String schlGrdCd = "";
	
	/**
	 * 검색조건
	 */
    private String searchCondition = "";
    
    /**
	 * 검색Keyword
	 */
    private String searchKeyword = "";
    
    /**
	 * 검색사용여부
	 */
    private String searchUseYn = "";
    
    /**
	 * 사이트ID
	 */
    private String siteId = "";
    
    /**
	 * 게시판ID
	 */
    private String bbsId = "";
    
    
    /** 저장여부 */
    private String saveAt = "N";
    
    /** 초기화모드 */
    private String initMode = "";
    
    
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
    

	public String getSelectMode() {
		return selectMode;
	}

	public void setSelectMode(String selectMode) {
		this.selectMode = selectMode;
	}

	public String getSearchBlngEduInstCd() {
		return searchBlngEduInstCd;
	}

	public void setSearchBlngEduInstCd(String searchBlngEduInstCd) {
		this.searchBlngEduInstCd = searchBlngEduInstCd;
	}

	public String getSearchSchlGrdCd() {
		return searchSchlGrdCd;
	}

	public void setSearchSchlGrdCd(String searchSchlGrdCd) {
		this.searchSchlGrdCd = searchSchlGrdCd;
	}

	public String getOrgCd() {
		return orgCd;
	}

	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}

	public String getBaseOrgCd() {
		return baseOrgCd;
	}

	public void setBaseOrgCd(String baseOrgCd) {
		this.baseOrgCd = baseOrgCd;
	}

	public String getBaseBlngCityCd() {
		return baseBlngCityCd;
	}

	public void setBaseBlngCityCd(String baseBlngCityCd) {
		this.baseBlngCityCd = baseBlngCityCd;
	}

	public String getBlngEduInstCd() {
		return blngEduInstCd;
	}

	public void setBlngEduInstCd(String blngEduInstCd) {
		this.blngEduInstCd = blngEduInstCd;
	}

	public String getSchlGrdNm() {
		return schlGrdNm;
	}

	public void setSchlGrdNm(String schlGrdNm) {
		this.schlGrdNm = schlGrdNm;
	}

	public String getSchlNm() {
		return schlNm;
	}

	public void setSchlNm(String schlNm) {
		this.schlNm = schlNm;
	}

	public String getSchlShrNm() {
		return schlShrNm;
	}

	public void setSchlShrNm(String schlShrNm) {
		this.schlShrNm = schlShrNm;
	}

	public String getSchlGrdCd() {
		return schlGrdCd;
	}

	public void setSchlGrdCd(String schlGrdCd) {
		this.schlGrdCd = schlGrdCd;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	public String getSaveAt() {
		return saveAt;
	}

	public void setSaveAt(String saveAt) {
		this.saveAt = saveAt;
	}

	public String getInitMode() {
		return initMode;
	}

	public void setInitMode(String initMode) {
		this.initMode = initMode;
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
	public String getSearchCondition() {
        return searchCondition;
    }

    /**
	 * @param searchCondition
	 */
    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    /**
	 * @return
	 */
    public String getSearchKeyword() {
        return searchKeyword;
    }

    /**
	 * @param searchKeyword
	 */
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
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

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
