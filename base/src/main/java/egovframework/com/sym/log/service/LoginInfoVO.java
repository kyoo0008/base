package egovframework.com.sym.log.service;

/**
 * @Class Name : LoginInfoVO.java
 * @Description : LoginInfo VO class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121127
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class LoginInfoVO {
    private static final long serialVersionUID = 1L;
    
    /** LOGIN_ID */
    private java.lang.String loginId;
    
    /** LOGIN_IDNTFC_ID */
    private java.lang.String loginIdntfcId;
    
    /** NEW_LOGIN_IDNTFC_ID */
    private java.lang.String newLoginIdntfcId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** LOGIN_IP */
    private java.lang.String loginIp;
    
    /** CREAT_DT */
    private java.util.Date creatDt;
    
    /** SESSION_ID */
    private java.lang.String sessionId;
    
    public java.lang.String getLoginId() {
        return this.loginId;
    }
    
    public void setLoginId(java.lang.String loginId) {
        this.loginId = loginId;
    }
    
    public java.lang.String getLoginIdntfcId() {
        return this.loginIdntfcId;
    }
    
    public void setLoginIdntfcId(java.lang.String loginIdntfcId) {
        this.loginIdntfcId = loginIdntfcId;
    }
    
    public java.lang.String getNewLoginIdntfcId() {
		return newLoginIdntfcId;
	}

	public void setNewLoginIdntfcId(java.lang.String newLoginIdntfcId) {
		this.newLoginIdntfcId = newLoginIdntfcId;
	}

	public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getLoginIp() {
        return this.loginIp;
    }
    
    public void setLoginIp(java.lang.String loginIp) {
        this.loginIp = loginIp;
    }
    
    public java.util.Date getCreatDt() {
        return this.creatDt;
    }
    
    public void setCreatDt(java.util.Date creatDt) {
        this.creatDt = creatDt;
    }

	public java.lang.String getSessionId() {
		return sessionId;
	}

	public void setSessionId(java.lang.String sessionId) {
		this.sessionId = sessionId;
	}
    
}
