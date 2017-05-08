package egovframework.com.evt.service;

import java.io.Serializable;

/******************************************************
 * @Class Name : ComtneventprzwnerVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 충청남도교육연구정보원 스마트충남 기능 개선 구축
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 2. 17.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 02. 07.        이호영             first generated
*********************************************************/

@SuppressWarnings("serial")
public class ComtneventprzwnerVO extends ComtneventprzwnerDefaultVO implements Serializable {
    
    /** FRST_REGIST_PNTTM */
    private String frstRegisterPnttm;
    
    /** USER_ID */
    private String userId;
    
    /** USE_AT */
    private String useAt;
    
    /** SCHDUL_ID */
    private String schdulId;
    
    private String wner;
    
    public String getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(String frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }
    
    public String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(String schdulId) {
        this.schdulId = schdulId;
    }
    public String getWner() {
		return wner;
	}
	
	public void setWner(String wner) {
		this.wner = wner;
	}
}
