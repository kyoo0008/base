package egovframework.com.sym.sit.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.Factory;
import org.apache.commons.collections.ListUtils;

import egovframework.com.sym.mpm.service.Mpm;
import egovframework.com.uss.ion.bnr.service.BannerVO;
import egovframework.com.uss.ion.pwm.service.PopupManageVO;
import egovframework.com.uss.ion.sit.service.LinkSiteManageVO;

@SuppressWarnings("serial")
public class SiteManageVO implements Serializable {
	    
    /**
	 * 사이트 ID
	 */
    private String siteId;
    
    /**
	 * 시스템타입코드
	 */
    private String sysTyCode;
    
    /**
	 * 사이트 URL
	 */
    private String siteUrl;
    
    /**
	 * 링크사이트명
	 */
    private String siteNm;
    
    /**
	 * 상단로고파일명
	 */
    private String upendLogoFileNm;
    
    /**
	 * 하단로고파일명
	 */
    private String lptLogoFileNm;
    
    /**
	 * 대표이미지파일명
	 */
    private String peprsntImageFileNm;
    
    /**
	 * 슬로건파일명
	 */
    private String sloganFileNm;
    
    /**
	 * 슬로건대체텍스트
	 */
    private String sloganReplcText;
    
    /**
	 * 주소파일명
	 */
    private String adresFileNm;
    
    /**
	 * 주소대체텍스트
	 */
    private String adresReplcText;
    
    /**
	 * 개인정보보호정책
	 */
    private String indvdlInfoPolicy;
    
    /**
	 * 이용약관
	 */
    private String useStplat;
    
    /**
	 * 이메일수집거부저책
	 */
    private String emailColctPolicy;
    
    /**
	 * 레이아웃소스ID
	 */
    private String lytSourcId;
    
    /**
	 * 레이아웃템플릿ID
	 */
    private String lytTmplatId;
    
    /**
	 * 커뮤니티소스ID
	 */
    private String cmySourcId;
    
    /**
	 * 커뮤니티템플릿ID
	 */
    private String cmyTmplatId;
    
    /**
	 * 모바일사용여부
	 */
    private String mobileUseAt = "N";

    /**
	 * 활성여부
	 */
    private String actvtyAt = "Y";

    /**
	 * 사용여부
	 */
    private String useAt = "Y";
    
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
    
    /**
	 * 최종수정일
	 */
    private long lastModified = 0L;
    
    /**
	 * 메뉴리스트
	 */
    private List<Mpm> mpmList = null;
    
    /**
	 * 링크사이트리스트
	 */
    private List<LinkSiteManageVO> linkSiteList = null;
    
    /**
	 * 배너리스트
	 */
    private List<BannerVO> bannerList = null;
    
    /**
	 * 팝업리스트
	 */
    private List<PopupManageVO> popupList = null;
    
    /**
	 * 메뉴최종수정일
	 */
    private long mpmLastModified = 0L;
    
    /**
	 * 링크사이트 최종수정일
	 */
    private long linkSiteLastModified = 0L;
    
    /**
	 * 배너최종수정일
	 */
    private long bannerLastModified = 0L;
    
    /**
	 * 팝업최종수정일
	 */
    private long popupLastModified = 0L;
    
    /**
	 * 저작권신고서비스
	 */
    private String cpyrhtSttemntSvc;
    
    /**
	 * 브라우저타이틀
	 */
    private String brwsrSj;
    
    /**
	 * 전화번호
	 */
    private String tlphonNo;
    
    /**
	 * 팩스번호
	 */
    private String faxNo;
    
    /**
	 * 주소
	 */
    private String adres;
    
    /**
	 * 마우스보안적용여부
	 */
    private String mouseScrtyApplcAt = "N";
    
    /**
	 * 키보드보안적용여부
	 */
    private String kybrdScrtyApplcAt = "N";
    
    /**
	 * 중복로그인허용여부
	 */
    private String dplctLoginPermAt = "Y";
    
    /**
	 * 비밀번호최소길이
	 */
    private String passwordMummLt = "4";
    
    /**
	 * 비밀번호최대길이
	 */
    private String passwordMxmmLt = "20";
    
    /**
	 * 비밀번호숫자정책적용여부
	 */
    private String passwordNumberPolicyAt = "Y";
    
    /**
	 * 비밀번호문자정책적용여부
	 */
    private String passwordChrctrPolicyAt = "Y";
    
    /**
	 * 비밀번호특수문자정책적용여부
	 */
    private String passwordSpclchrctrPolicyAt = "N";
    
    /**
	 * 비밀번호변경주기
	 */
    private String passwordChangeCycle = "12";
    
    /**
	 * 기관코드
	 */
    private String insttCode;
    
    /**
	* 기본 자동생성 메뉴여부
	*/
    private String autoMakeMenuAt = "Y";
    
    /**
	* 위도
	*/
    private String la;
    
    /**
	* 경도
	*/
    private String lo;
    
    /** 메인컨텐츠리스트 */
    @SuppressWarnings("unchecked")
    private List<SiteMainContentsManageVO> mainContentsList = ListUtils.lazyList(new ArrayList<SiteMainContentsManageVO>(), new Factory() {
    	public SiteMainContentsManageVO create() {
    		return new SiteMainContentsManageVO();
    	}
    });

    /**
	 * 임시사이트아이디
	 */
    private String takeSiteId = "";
    
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

	public String getSiteUrl() {
		return siteUrl;
	}

	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}

	public String getSiteNm() {
		return siteNm;
	}

	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}

	
	public String getUpendLogoFileNm() {
		return upendLogoFileNm;
	}

	public void setUpendLogoFileNm(String upendLogoFileNm) {
		this.upendLogoFileNm = upendLogoFileNm;
	}

	public String getLptLogoFileNm() {
		return lptLogoFileNm;
	}

	public void setLptLogoFileNm(String lptLogoFileNm) {
		this.lptLogoFileNm = lptLogoFileNm;
	}

	public String getPeprsntImageFileNm() {
		return peprsntImageFileNm;
	}

	public void setPeprsntImageFileNm(String peprsntImageFileNm) {
		this.peprsntImageFileNm = peprsntImageFileNm;
	}

	public String getSloganFileNm() {
		return sloganFileNm;
	}

	public void setSloganFileNm(String sloganFileNm) {
		this.sloganFileNm = sloganFileNm;
	}

	public String getSloganReplcText() {
		return sloganReplcText;
	}

	public void setSloganReplcText(String sloganReplcText) {
		this.sloganReplcText = sloganReplcText;
	}

	public String getAdresFileNm() {
		return adresFileNm;
	}

	public void setAdresFileNm(String adresFileNm) {
		this.adresFileNm = adresFileNm;
	}

	public String getAdresReplcText() {
		return adresReplcText;
	}

	public void setAdresReplcText(String adresReplcText) {
		this.adresReplcText = adresReplcText;
	}

	public String getIndvdlInfoPolicy() {
		return indvdlInfoPolicy;
	}

	public void setIndvdlInfoPolicy(String indvdlInfoPolicy) {
		this.indvdlInfoPolicy = indvdlInfoPolicy;
	}

	public String getUseStplat() {
		return useStplat;
	}

	public void setUseStplat(String useStplat) {
		this.useStplat = useStplat;
	}

	public String getEmailColctPolicy() {
		return emailColctPolicy;
	}

	public void setEmailColctPolicy(String emailColctPolicy) {
		this.emailColctPolicy = emailColctPolicy;
	}

	public String getLytSourcId() {
		return lytSourcId;
	}

	public void setLytSourcId(String lytSourcId) {
		this.lytSourcId = lytSourcId;
	}

	public String getLytTmplatId() {
		return lytTmplatId;
	}

	public void setLytTmplatId(String lytTmplatId) {
		this.lytTmplatId = lytTmplatId;
	}

	public String getCmySourcId() {
		return cmySourcId;
	}

	public void setCmySourcId(String cmySourcId) {
		this.cmySourcId = cmySourcId;
	}

	public String getCmyTmplatId() {
		return cmyTmplatId;
	}

	public void setCmyTmplatId(String cmyTmplatId) {
		this.cmyTmplatId = cmyTmplatId;
	}

	public String getMobileUseAt() {
		return mobileUseAt;
	}

	public void setMobileUseAt(String mobileUseAt) {
		this.mobileUseAt = mobileUseAt;
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

	public long getLastModified() {
		return lastModified;
	}

	public void setLastModified(long lastModified) {
		this.lastModified = lastModified;
	}

	public List<Mpm> getMpmList() {
		return mpmList;
	}

	public void setMpmList(List<Mpm> mpmList) {
		this.mpmList = mpmList;
	}

	public List<LinkSiteManageVO> getLinkSiteList() {
		return linkSiteList;
	}

	public void setLinkSiteList(List<LinkSiteManageVO> linkSiteList) {
		this.linkSiteList = linkSiteList;
	}

	public List<BannerVO> getBannerList() {
		return bannerList;
	}

	public List<PopupManageVO> getPopupList() {
		return popupList;
	}

	public void setPopupList(List<PopupManageVO> popupList) {
		this.popupList = popupList;
	}

	public void setBannerList(List<BannerVO> bannerList) {
		this.bannerList = bannerList;
	}

	public long getMpmLastModified() {
		return mpmLastModified;
	}

	public void setMpmLastModified(long mpmLastModified) {
		this.mpmLastModified = mpmLastModified;
	}

	public long getLinkSiteLastModified() {
		return linkSiteLastModified;
	}

	public void setLinkSiteLastModified(long linkSiteLastModified) {
		this.linkSiteLastModified = linkSiteLastModified;
	}

	public long getBannerLastModified() {
		return bannerLastModified;
	}

	public void setBannerLastModified(long bannerLastModified) {
		this.bannerLastModified = bannerLastModified;
	}

	public long getPopupLastModified() {
		return popupLastModified;
	}

	public void setPopupLastModified(long popupLastModified) {
		this.popupLastModified = popupLastModified;
	}

	public List<SiteMainContentsManageVO> getMainContentsList() {
		return mainContentsList;
	}

	public void setMainContentsList(List<SiteMainContentsManageVO> mainContentsList) {
		this.mainContentsList = mainContentsList;
	}

	public String getTakeSiteId() {
		return takeSiteId;
	}

	public void setTakeSiteId(String takeSiteId) {
		this.takeSiteId = takeSiteId;
	}

	public String getCpyrhtSttemntSvc() {
		return cpyrhtSttemntSvc;
	}

	public void setCpyrhtSttemntSvc(String cpyrhtSttemntSvc) {
		this.cpyrhtSttemntSvc = cpyrhtSttemntSvc;
	}

	public String getBrwsrSj() {
		return brwsrSj;
	}

	public void setBrwsrSj(String brwsrSj) {
		this.brwsrSj = brwsrSj;
	}

	public String getTlphonNo() {
		return tlphonNo;
	}

	public void setTlphonNo(String tlphonNo) {
		this.tlphonNo = tlphonNo;
	}

	public String getFaxNo() {
		return faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getAdres() {
		return adres;
	}

	public void setAdres(String adres) {
		this.adres = adres;
	}

	public String getMouseScrtyApplcAt() {
		return mouseScrtyApplcAt;
	}

	public void setMouseScrtyApplcAt(String mouseScrtyApplcAt) {
		this.mouseScrtyApplcAt = mouseScrtyApplcAt;
	}

	public String getKybrdScrtyApplcAt() {
		return kybrdScrtyApplcAt;
	}

	public void setKybrdScrtyApplcAt(String kybrdScrtyApplcAt) {
		this.kybrdScrtyApplcAt = kybrdScrtyApplcAt;
	}

	public String getDplctLoginPermAt() {
		return dplctLoginPermAt;
	}

	public void setDplctLoginPermAt(String dplctLoginPermAt) {
		this.dplctLoginPermAt = dplctLoginPermAt;
	}

	public String getPasswordMummLt() {
		return passwordMummLt;
	}

	public void setPasswordMummLt(String passwordMummLt) {
		this.passwordMummLt = passwordMummLt;
	}

	public String getPasswordMxmmLt() {
		return passwordMxmmLt;
	}

	public void setPasswordMxmmLt(String passwordMxmmLt) {
		this.passwordMxmmLt = passwordMxmmLt;
	}

	public String getPasswordNumberPolicyAt() {
		return passwordNumberPolicyAt;
	}

	public void setPasswordNumberPolicyAt(String passwordNumberPolicyAt) {
		this.passwordNumberPolicyAt = passwordNumberPolicyAt;
	}

	public String getPasswordChrctrPolicyAt() {
		return passwordChrctrPolicyAt;
	}

	public void setPasswordChrctrPolicyAt(String passwordChrctrPolicyAt) {
		this.passwordChrctrPolicyAt = passwordChrctrPolicyAt;
	}

	public String getPasswordSpclchrctrPolicyAt() {
		return passwordSpclchrctrPolicyAt;
	}

	public void setPasswordSpclchrctrPolicyAt(String passwordSpclchrctrPolicyAt) {
		this.passwordSpclchrctrPolicyAt = passwordSpclchrctrPolicyAt;
	}

	public String getPasswordChangeCycle() {
		return passwordChangeCycle;
	}

	public void setPasswordChangeCycle(String passwordChangeCycle) {
		this.passwordChangeCycle = passwordChangeCycle;
	}

	public String getInsttCode() {
		return insttCode;
	}

	public void setInsttCode(String insttCode) {
		this.insttCode = insttCode;
	}

	public String getAutoMakeMenuAt() {
		return autoMakeMenuAt;
	}

	public void setAutoMakeMenuAt(String autoMakeMenuAt) {
		this.autoMakeMenuAt = autoMakeMenuAt;
	}

	public String getLa() {
		return la;
	}

	public void setLa(String la) {
		this.la = la;
	}

	public String getLo() {
		return lo;
	}

	public void setLo(String lo) {
		this.lo = lo;
	}   
	
}
