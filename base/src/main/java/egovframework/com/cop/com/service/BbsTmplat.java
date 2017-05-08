package egovframework.com.cop.com.service;

import java.io.Serializable;

/**
 * @Class Name : EgovBbsTmplat
 * @Description : EgovBbsTmplat class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class BbsTmplat implements Serializable {
    
    /** BBS_TMPLAT_ID */
    private java.lang.String bbsTmplatId;
        
    /** TMPLAT_SE_CODE */
    private java.lang.String tmplatSeCode;
    
    /** TMPLAT_SE_CODE_NM */
    private java.lang.String tmplatSeCodeNm;
    
    /** TMPLAT_NM */
    private java.lang.String tmplatNm;
    
    /** CSS_SOURC */
    private java.lang.String cssSourc;
    
    /** SCRIPT_SOURC */
    private java.lang.String scriptSourc;
        
    /** PREVEW_FILE_NM */
    private java.lang.String prevewFileNm;
    
    /** USE_AT */
    private java.lang.String useAt;
    
    /** FRST_REGISTER_ID */
    private java.lang.String frstRegisterId;
    
    /** FRST_REGISTER_PNTTM */
    private java.util.Date frstRegisterPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId;
    
    /** LAST_UPDUSR_PNTTM */
    private java.util.Date lastUpdusrPnttm;
    
    /** BBS_TMPLAT_HIST_ID */
    private java.lang.String bbsTmplatHistId;
    
    public java.lang.String getBbsTmplatId() {
        return this.bbsTmplatId;
    }
    
    public void setBbsTmplatId(java.lang.String bbsTmplatId) {
        this.bbsTmplatId = bbsTmplatId;
    }
    
    public java.lang.String getTmplatSeCode() {
		return tmplatSeCode;
	}

	public void setTmplatSeCode(java.lang.String tmplatSeCode) {
		this.tmplatSeCode = tmplatSeCode;
	}

	public java.lang.String getTmplatSeCodeNm() {
		return tmplatSeCodeNm;
	}

	public void setTmplatSeCodeNm(java.lang.String tmplatSeCodeNm) {
		this.tmplatSeCodeNm = tmplatSeCodeNm;
	}

	public java.lang.String getTmplatNm() {
        return this.tmplatNm;
    }
    
    public void setTmplatNm(java.lang.String tmplatNm) {
        this.tmplatNm = tmplatNm;
    }
    
    public java.lang.String getCssSourc() {
        return this.cssSourc;
    }
    
    public void setCssSourc(java.lang.String cssSourc) {
        this.cssSourc = cssSourc;
    }
    
    public java.lang.String getScriptSourc() {
        return this.scriptSourc;
    }
    
    public void setScriptSourc(java.lang.String scriptSourc) {
        this.scriptSourc = scriptSourc;
    }
        
    public java.lang.String getPrevewFileNm() {
		return prevewFileNm;
	}

	public void setPrevewFileNm(java.lang.String prevewFileNm) {
		this.prevewFileNm = prevewFileNm;
	}

	public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }
    
    public java.lang.String getFrstRegisterId() {
        return this.frstRegisterId;
    }
    
    public void setFrstRegisterId(java.lang.String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }
    
    public java.util.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    public java.util.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }

	public java.lang.String getBbsTmplatHistId() {
		return bbsTmplatHistId;
	}

	public void setBbsTmplatHistId(java.lang.String bbsTmplatHistId) {
		this.bbsTmplatHistId = bbsTmplatHistId;
	}
    
}
