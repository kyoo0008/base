package egovframework.com.evt.service;

import java.io.Serializable;


/******************************************************
 * @Class Name : ComtneventqesitmexVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 이벤트 문항보기VO
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
public class ComtneventqesitmexVO implements Serializable {
    
    /** EX_ID */
    private String exId;
    
    /** EX_SN */
    private Integer exSn;
    
    /** EX_CN */
    private String exCn;
    
    /** QESITM_ID */
    private String qesitmId;

    /** qesitUserCo */
    private double qesitUserCo = 0;
    
    
    private String userSta;
    
    public String getExId() {
        return this.exId;
    }
    
    public void setExId(String exId) {
        this.exId = exId;
    }
    
    public Integer getExSn() {
        return this.exSn;
    }
    
    public void setExSn(Integer exSn) {
        this.exSn = exSn;
    }
    
    public String getExCn() {
        return this.exCn;
    }
    
    public void setExCn(String exCn) {
        this.exCn = exCn;
    }
    
    public String getQesitmId() {
        return this.qesitmId;
    }
    
    public void setQesitmId(String qesitmId) {
        this.qesitmId = qesitmId;
    }

    public double getQesitUserCo() {
        return this.qesitUserCo;
    }
    
    public void setQesitUserCo(double qesitUserCo) {
        this.qesitUserCo = qesitUserCo;
    }

	public String getUserSta() {
		return userSta;
	}

	public void setUserSta(String userSta) {
		this.userSta = userSta;
	}
    
    
}
