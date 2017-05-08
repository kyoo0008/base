package egovframework.com.uss.ivp.service;

import egovframework.com.cmm.ComDefaultVO;

public class IndvdlestbsVO extends ComDefaultVO {
    private static final long serialVersionUID = 1L;
    
    /** USER_ID */
    private java.lang.String userId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** TRGET_TY_CODE */
    private java.lang.String trgetTyCode;
    
    /** TRGET_ID */
    private java.lang.String trgetId;
    
    /** FRST_REGISTER_PNTTM */
    private java.util.Date frstRegisterPnttm;
    
    /** FRST_REGISTER_ID */
    private java.lang.String frstRegisterId;
    
    /** LAST_UPDUSR_PNTTM */
    private java.util.Date lastUpdusrPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId;
            
    public java.lang.String getUserId() {
        return this.userId;
    }
    
    public void setUserId(java.lang.String userId) {
        this.userId = userId;
    }
    
    public java.lang.String getTrgetTyCode() {
        return this.trgetTyCode;
    }
    
    public void setTrgetTyCode(java.lang.String trgetTyCode) {
        this.trgetTyCode = trgetTyCode;
    }
    
    public java.lang.String getSiteId() {
		return siteId;
	}

	public void setSiteId(java.lang.String siteId) {
		this.siteId = siteId;
	}

	public java.lang.String getTrgetId() {
        return this.trgetId;
    }
    
    public void setTrgetId(java.lang.String trgetId) {
        this.trgetId = trgetId;
    }
    
    public java.util.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.lang.String getFrstRegisterId() {
        return this.frstRegisterId;
    }
    
    public void setFrstRegisterId(java.lang.String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }
    
    public java.util.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }

}
