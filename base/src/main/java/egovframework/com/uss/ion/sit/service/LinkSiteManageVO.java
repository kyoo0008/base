package egovframework.com.uss.ion.sit.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class LinkSiteManageVO extends LinkSiteManageDefaultVO implements Serializable {
	
    /**
	 * 사이트 ID
	 */
    private String siteId;
    
    /**
	 * 시스템타입코드
	 */
    private String sysTyCode;
    
    /**
	 * 링크사이트 ID
	 */
    private String linkSiteId;
    
    /**
	 * 링크사이트 URL
	 */
    private String linkSiteUrl;
    
    /**
	 * 링크사이트명
	 */
    private String linkSiteNm;
    
    /**
	 * 링크사이트설명
	 */
    private String linkSiteDc;
    
    /**
	 * 사이트주제분류코드
	 */
    private String siteThemaClCode;

    /**
	 * 사이트주제분류명
	 */
    private String siteThemaClNm;
    
    /**
	 * 활성여부
	 */
    private String actvtyAt = "Y";
    
    /**
	 * 사용여부
	 */
    private String useAt;
    
    /**
	 * 최초등록시점
	 */
    private java.util.Date frstRegisterPnttm;

    /**
	 * 최초등록자ID
	 */
    private String frstRegisterId;

    /**
	 * 최종수정시점
	 */
    private java.util.Date lastUpdusrPnttm;

    /**
	 * 최종수정자ID
	 */
    private String lastUpdusrId;

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

	public String getLinkSiteId() {
		return linkSiteId;
	}

	public void setLinkSiteId(String linkSiteId) {
		this.linkSiteId = linkSiteId;
	}

	public String getLinkSiteUrl() {
		return linkSiteUrl;
	}

	public void setLinkSiteUrl(String linkSiteUrl) {
		this.linkSiteUrl = linkSiteUrl;
	}

	public String getLinkSiteNm() {
		return linkSiteNm;
	}

	public void setLinkSiteNm(String linkSiteNm) {
		this.linkSiteNm = linkSiteNm;
	}

	public String getLinkSiteDc() {
		return linkSiteDc;
	}

	public void setLinkSiteDc(String linkSiteDc) {
		this.linkSiteDc = linkSiteDc;
	}

	public String getSiteThemaClCode() {
		return siteThemaClCode;
	}

	public void setSiteThemaClCode(String siteThemaClCode) {
		this.siteThemaClCode = siteThemaClCode;
	}

	public String getSiteThemaClNm() {
		return siteThemaClNm;
	}

	public void setSiteThemaClNm(String siteThemaClNm) {
		this.siteThemaClNm = siteThemaClNm;
	}

	public String getActvtyAt() {
		return actvtyAt;
	}

	public void setActvtyAt(String actvtyAt) {
		this.actvtyAt = actvtyAt;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public java.util.Date getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	public java.util.Date getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}
    
	
   
}
