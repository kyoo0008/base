package egovframework.com.evt.service;

import java.io.Serializable;

/******************************************************
 * @Class Name : ComtneventcnsrVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 이벤트 정답VO
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 25.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 25.        이호영             first generated
*********************************************************/

@SuppressWarnings("serial")
public class ComtneventcnsrVO implements Serializable {
    
    /** CNSR_ID */
    private java.lang.String cnsrId;
    
    /** QESITM_ID */
    private java.lang.String qesitmId;
    
    /** CNSR_SN */
    private Integer cnsrSn;
    
    /** CHOISE_CNSR */
    private Integer choiseCnsr;
    
    /** SBJCT_CNSR */
    private java.lang.String sbjctCnsr;
    
    public java.lang.String getCnsrId() {
        return this.cnsrId;
    }
    
    public void setCnsrId(java.lang.String cnsrId) {
        this.cnsrId = cnsrId;
    }
    
    public java.lang.String getQesitmId() {
        return this.qesitmId;
    }
    
    public void setQesitmId(java.lang.String qesitmId) {
        this.qesitmId = qesitmId;
    }
    
    public Integer getCnsrSn() {
        return this.cnsrSn;
    }
    
    public void setCnsrSn(Integer cnsrSn) {
        this.cnsrSn = cnsrSn;
    }
    
    public Integer getChoiseCnsr() {
        return this.choiseCnsr;
    }
    
    public void setChoiseCnsr(Integer choiseCnsr) {
        this.choiseCnsr = choiseCnsr;
    }
    
    public java.lang.String getSbjctCnsr() {
        return this.sbjctCnsr;
    }
    
    public void setSbjctCnsr(java.lang.String sbjctCnsr) {
        this.sbjctCnsr = sbjctCnsr;
    }
    
}
