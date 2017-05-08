package egovframework.com.evt.service;

import java.io.Serializable;

/**
 * @Class Name : ComtneventformaswperVO.java
 * @Description : Comtneventformaswper VO class
 * @Modification Information
 *
 * @author 이호영
 * @since 2011.08.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class ComtneventformaswperVO implements Serializable {
    
    /** ASWPER_ID */
    private String aswperId;
    
    /** REQST_CN */
    private String reqstCn;
    
    /** REQST_ID */
    private String reqstId;
    
    /** SCHDUL_ID */
    private String schdulId;
    
    /** USER_ID */
    private String userId;
    
    public String getAswperId() {
        return this.aswperId;
    }
    
    public void setAswperId(String aswperId) {
        this.aswperId = aswperId;
    }
    
    public String getReqstCn() {
        return this.reqstCn;
    }
    
    public void setReqstCn(String reqstCn) {
        this.reqstCn = reqstCn;
    }
    
    public String getReqstId() {
        return this.reqstId;
    }
    
    public void setReqstId(String reqstId) {
        this.reqstId = reqstId;
    }
    
    public String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(String schdulId) {
        this.schdulId = schdulId;
    }
    
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
}
