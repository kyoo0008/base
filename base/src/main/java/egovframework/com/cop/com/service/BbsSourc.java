package egovframework.com.cop.com.service;

import java.io.Serializable;

/**
 * @Class Name : EgovBbsSourc
 * @Description : EgovBbsSourc class
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
public class BbsSourc implements Serializable {
    
    /** BBS_SOURC_ID */
    private java.lang.String bbsSourcId;
        
    /** SOURC_SE_CODE */
    private java.lang.String sourcSeCode;
    
    /** SOURC_SE_CODE_NM */
    private java.lang.String sourcSeCodeNm;
    
    /** SOURC_NM */
    private java.lang.String sourcNm;
    
    /** LIST_SOURC */
    private java.lang.String listSourc;
    
    /** VIEW_SOURC */
    private java.lang.String viewSourc;
    
    /** FORM_SOURC */
    private java.lang.String formSourc;
    
    /** CM_SOURC */
    private java.lang.String cmSourc;
    
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
    
    /** BBS_SOURC_HIST_ID */
    private java.lang.String bbsSourcHistId;
    
    public java.lang.String getBbsSourcId() {
        return this.bbsSourcId;
    }
    
    public void setBbsSourcId(java.lang.String bbsSourcId) {
        this.bbsSourcId = bbsSourcId;
    }
    
    public java.lang.String getSourcSeCode() {
		return sourcSeCode;
	}

	public void setSourcSeCode(java.lang.String sourcSeCode) {
		this.sourcSeCode = sourcSeCode;
	}

	public java.lang.String getSourcSeCodeNm() {
		return sourcSeCodeNm;
	}

	public void setSourcSeCodeNm(java.lang.String sourcSeCodeNm) {
		this.sourcSeCodeNm = sourcSeCodeNm;
	}

	public java.lang.String getSourcNm() {
        return this.sourcNm;
    }
    
    public void setSourcNm(java.lang.String sourcNm) {
        this.sourcNm = sourcNm;
    }
    
    public java.lang.String getListSourc() {
        return this.listSourc;
    }
    
    public void setListSourc(java.lang.String listSourc) {
        this.listSourc = listSourc;
    }
    
    public java.lang.String getViewSourc() {
        return this.viewSourc;
    }
    
    public void setViewSourc(java.lang.String viewSourc) {
        this.viewSourc = viewSourc;
    }
    
    public java.lang.String getFormSourc() {
        return this.formSourc;
    }
    
    public void setFormSourc(java.lang.String formSourc) {
        this.formSourc = formSourc;
    }
    
    public java.lang.String getCmSourc() {
        return this.cmSourc;
    }
    
    public void setCmSourc(java.lang.String cmSourc) {
        this.cmSourc = cmSourc;
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

	public java.lang.String getBbsSourcHistId() {
		return bbsSourcHistId;
	}

	public void setBbsSourcHistId(java.lang.String bbsSourcHistId) {
		this.bbsSourcHistId = bbsSourcHistId;
	}
    
}
