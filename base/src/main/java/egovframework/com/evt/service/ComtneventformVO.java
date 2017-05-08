package egovframework.com.evt.service;

import java.io.Serializable;


/******************************************************
 * @Class Name : ComtneventformVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 31.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 31.        이호영             first generated
*********************************************************/


@SuppressWarnings("serial")
public class ComtneventformVO implements Serializable {
    
    /** REQST_ID */
    private java.lang.String reqstId;
    
    /** REQST_FORM */
    private String reqstForm;
    
    /** SCHDUL_ID */
    private java.lang.String schdulId;
    
    public java.lang.String getReqstId() {
        return this.reqstId;
    }
    
    public void setReqstId(java.lang.String reqstId) {
        this.reqstId = reqstId;
    }
    
    public String getReqstForm() {
        return this.reqstForm;
    }
    
    public void setReqstForm(String reqstForm) {
        this.reqstForm = reqstForm;
    }
    
    public java.lang.String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(java.lang.String schdulId) {
        this.schdulId = schdulId;
    }
    
}
