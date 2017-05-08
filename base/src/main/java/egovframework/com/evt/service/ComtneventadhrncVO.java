package egovframework.com.evt.service;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.collections.Factory;
import org.apache.commons.collections.ListUtils;
/******************************************************
 * @Class Name : ComtneventadhrncVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 29.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 29.        이호영             first generated
*********************************************************/

@SuppressWarnings("serial")
public class ComtneventadhrncVO extends ComtneventadhrncDefaultVO{
    
    /** 사이트ID */
    private String siteId = "";
    
	/** 시스템구분 */ 
    private String sysTyCode = "";
    
    /** USER_ID */
    private java.lang.String userId;
    
    /** ADHRNC_NM */
    private java.lang.String adhrncNm;
    
    /** ADHRNC_CTTPC */
    private java.lang.String adhrncCttpc;
    
    /** ADHRNC_ADRES */
    private java.lang.String adhrncAdres;
    
    /** ADHRNC_ZIP */
    private java.lang.String adhrncZip;
    
    /** ADHRNC_EMAIL */
    private java.lang.String adhrncEmail;
    
    /** FRST_REGIST_IP */
    private java.lang.String frstRegisterIp;
    
    /** FRST_REGIST_PNTTM */
    private java.sql.Date frstRegisterPnttm;
    
    /** LAST_UPDUSR_PNTTM */
    private java.sql.Date lastUpdusrPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId;
    
    /** USE_AT */
    private java.lang.String useAt;
    
    /** WNER_AT */
    private java.lang.String wnerAt;
    
    /** SCHDUL_ID */
    private java.lang.String schdulId;
    
    private java.lang.String userTy;
    
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<ComtneventadhrncVO> userAnswerList = ListUtils.lazyList(new ArrayList(), new Factory() {    
	public Object create() {
	      return new ComtneventadhrncVO();
	    }
	 });
	
	public List<ComtneventadhrncVO> getUserAnswerList() {
	    return userAnswerList;
	}
	
	public void setUserAnswerList(List<ComtneventadhrncVO> userAnswerList) {
	    this.userAnswerList = userAnswerList;
	}
    
    public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getSysTyCode() {
		return sysTyCode;
	}

	public void setSysTyCode(String sysTyCode) {
		this.sysTyCode = sysTyCode;
	}
    
    public java.lang.String getUserId() {
        return this.userId;
    }
    
    public void setUserId(java.lang.String userId) {
        this.userId = userId;
    }
    
    public java.lang.String getAdhrncNm() {
        return this.adhrncNm;
    }
    
    public void setAdhrncNm(java.lang.String adhrncNm) {
        this.adhrncNm = adhrncNm;
    }
    
    public java.lang.String getAdhrncCttpc() {
        return this.adhrncCttpc;
    }
    
    public void setAdhrncCttpc(java.lang.String adhrncCttpc) {
        this.adhrncCttpc = adhrncCttpc;
    }
    
    public java.lang.String getAdhrncAdres() {
        return this.adhrncAdres;
    }
    
    public void setAdhrncAdres(java.lang.String adhrncAdres) {
        this.adhrncAdres = adhrncAdres;
    }
    
    public java.lang.String getAdhrncZip() {
        return this.adhrncZip;
    }
    
    public void setAdhrncZip(java.lang.String adhrncZip) {
        this.adhrncZip = adhrncZip;
    }
    
    public java.lang.String getAdhrncEmail() {
        return this.adhrncEmail;
    }
    
    public void setAdhrncEmail(java.lang.String adhrncEmail) {
        this.adhrncEmail = adhrncEmail;
    }
    
    public java.lang.String getFrstRegistIp() {
        return this.frstRegisterIp;
    }
    
    public void setFrstRegistIp(java.lang.String frstRegisterIp) {
        this.frstRegisterIp = frstRegisterIp;
    }
    
    public java.sql.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.sql.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.sql.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.sql.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }
    
    public java.lang.String getWnerAt() {
        return this.wnerAt;
    }
    
    public void setWnerAt(java.lang.String wnerAt) {
        this.wnerAt = wnerAt;
    }
    
    public java.lang.String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(java.lang.String schdulId) {
        this.schdulId = schdulId;
    }

	public java.lang.String getUserTy() {
		return userTy;
	}

	public void setUserTy(java.lang.String userTy) {
		this.userTy = userTy;
	}
    
    
}
