package egovframework.com.evt.service;

import java.io.Serializable;


/******************************************************
 * @Class Name : ComtneventaswperVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 이벤트 참여자 VO
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 30.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 30.        이호영             first generated
*********************************************************/
@SuppressWarnings("serial")
public class ComtneventaswperVO implements Serializable {
    
    /** ASWPER_ID */
    private String aswperId;
    
    /** QESITM_ID */
    private String qesitmId;
    
    /** ASWPER_SN */
    private Integer aswperSn;
    
    /** CHOICE_CNSR */
    private Integer choiceCnsr;
    
    /** ESSAY_CNSR */
    private String essayCnsr;
    
    /** USER_ID */
    private String userId;
    
    /** SCHDUL_ID */
    private String schdulId;
    
    public String getAswperId() {
        return this.aswperId;
    }
    
    public void setAswperId(String aswperId) {
        this.aswperId = aswperId;
    }
    
    public String getQesitmId() {
        return this.qesitmId;
    }
    
    public void setQesitmId(String qesitmId) {
        this.qesitmId = qesitmId;
    }
    
    public Integer getAswperSn() {
        return this.aswperSn;
    }
    
    public void setAswperSn(Integer aswperSn) {
        this.aswperSn = aswperSn;
    }
    
    public Integer getChoiceCnsr() {
        return this.choiceCnsr;
    }
    
    public void setChoiceCnsr(Integer choiceCnsr) {
        this.choiceCnsr = choiceCnsr;
    }
    
    public String getEssayCnsr() {
        return this.essayCnsr;
    }
    
    public void setEssayCnsr(String essayCnsr) {
        this.essayCnsr = essayCnsr;
    }
    
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(String schdulId) {
        this.schdulId = schdulId;
    }
    
}
