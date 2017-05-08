package egovframework.com.cop.bbs.service;

/**
 * @Class Name : ComtnbbsctgryVO.java
 * @Description : Comtnbbsctgry VO class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20110907
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class Ctgry extends CtgryVO {
    
    /** CTGRY_ID */
    private java.lang.String ctgryId;
    
    /** CTGRYMASTER_ID */
    private java.lang.String ctgrymasterId;
    
    /** UPPER_CTGRY_ID */
    private java.lang.String upperCtgryId;
    
    /** CTGRY_NM */
    private java.lang.String ctgryNm = "";
    
    /** SORT_ORDR */
    private int sortOrdr = 0;
        
    /** USE_AT */
    private java.lang.String useAt;
    
    /**
	 * 경로 - 명
	 */
    private String ctgryPathByName = "";
    
    /**
	 * 경로 - ID
	 */
    private String ctgryPathById = "";
    
    /**
	 * 레벨
	 */
    private int ctgryLevel = 1;
    
    public java.lang.String getCtgryId() {
        return this.ctgryId;
    }
    
    public void setCtgryId(java.lang.String ctgryId) {
        this.ctgryId = ctgryId;
    }
    
    public java.lang.String getCtgrymasterId() {
        return this.ctgrymasterId;
    }
    
    public void setCtgrymasterId(java.lang.String ctgrymasterId) {
        this.ctgrymasterId = ctgrymasterId;
    }
    
    public java.lang.String getUpperCtgryId() {
		return upperCtgryId;
	}

	public void setUpperCtgryId(java.lang.String upperCtgryId) {
		this.upperCtgryId = upperCtgryId;
	}

	public java.lang.String getCtgryNm() {
        return this.ctgryNm;
    }
    
    public void setCtgryNm(java.lang.String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }
        
    public int getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(int sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }

	public String getCtgryPathByName() {
		return ctgryPathByName;
	}

	public void setCtgryPathByName(String ctgryPathByName) {
		this.ctgryPathByName = ctgryPathByName;
	}

	public String getCtgryPathById() {
		return ctgryPathById;
	}

	public void setCtgryPathById(String ctgryPathById) {
		this.ctgryPathById = ctgryPathById;
	}

	public int getCtgryLevel() {
		return ctgryLevel;
	}

	public void setCtgryLevel(int ctgryLevel) {
		this.ctgryLevel = ctgryLevel;
	}
    
}
