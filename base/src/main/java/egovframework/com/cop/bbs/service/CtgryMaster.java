package egovframework.com.cop.bbs.service;

/**
 * @Class Name : CtgryMasterVO.java
 * @Description : CtgryMaster VO class
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
public class CtgryMaster extends CtgryMasterVO{
    
    /**
	 * SITEID
	 */
    private String siteId = "";
    
    /**
	 * 시스템구분코드
	 */
    private String sysTyCode = "";
    
    /** CTGRYMASTER_ID */
    private java.lang.String ctgrymasterId;
    
    /** CTGRYMASTER_NM */
    private java.lang.String ctgrymasterNm;
    
    /** CREAT_DT */
    private java.sql.Date creatDt;
    
    /** USE_AT */
    private java.lang.String useAt;
    
    public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getSysTyCode() {
		return sysTyCode;
	}

	public void setSysTyCode(String sysTyCode) {
		this.sysTyCode = sysTyCode;
	}

	public java.lang.String getCtgrymasterId() {
        return this.ctgrymasterId;
    }
    
    public void setCtgrymasterId(java.lang.String ctgrymasterId) {
        this.ctgrymasterId = ctgrymasterId;
    }
    
    public java.lang.String getCtgrymasterNm() {
        return this.ctgrymasterNm;
    }
    
    public void setCtgrymasterNm(java.lang.String ctgrymasterNm) {
        this.ctgrymasterNm = ctgrymasterNm;
    }
    
    public java.sql.Date getCreatDt() {
        return this.creatDt;
    }
    
    public void setCreatDt(java.sql.Date creatDt) {
        this.creatDt = creatDt;
    }
    
    public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }
    
}
