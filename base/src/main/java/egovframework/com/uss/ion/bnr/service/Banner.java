/**
 * 개요
 * - 배너에 대한 model 클래스를 정의한다.
 * 
 * 상세내용
 * - 배너의 일련번호, 배너명, 링크URL, 배너설명, 반영여부 항목을 관리한다.
 * @author 이문준
 * @version 1.0
 * @created 03-8-2009 오후 2:07:10
 */

package egovframework.com.uss.ion.bnr.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;

@SuppressWarnings("serial")
public class Banner extends ComDefaultVO implements Serializable {

	/**
	 * 배너 ID
	 */
	private String bannerId;
	/**
	 * 배너 명
	 */
	private String bannerNm;
	/**
	 * 링크 URL
	 */
	private String linkUrl;
	/**
	 * 배너 이미지
	 */
	private String bannerImage;
	/**
	 * 배너 이미지 파일
	 */
	private String bannerImageFile;	
	/**
	 * 배너 설명
	 */
	private String bannerDc;
	/**
	 * 정렬 순서
	 */
	private String sortOrdr = "1";
	/**
	 * 반영여부
	 */
	private String reflctAt = "Y";
	
	/**
	 * 파일첨부여부
	 */
	private boolean isAtchFile;
	
	/**
	 * siteId
	 */
	private String siteId = "";

	 /**
	 * System Type 코드
	 */
	private String sysTyCode = "";

	/**
	 * 배너구분코드
	 */
	private String bannerTyCode;
	
	/**
	 * 배너주제분류코드
	 */
	private String bannerThemaClCode;
	
	/**
	 * 배너주제분류명
	 */
	private String bannerThemaClCodeNm;
	
	/**
	 * 게시시작일
	 */
	private String ntceBgnde = EgovDateUtil.getToday();
	/**
	 * 게시종료일
	 */
	private String ntceEndde = "901012010101";
        
	/**
	 * 게시시작일(시간)
	 */
    private String ntceBgndeHH;
    
    /**
	 * 게시시작일(분)
	 */
    private String ntceBgndeMM;
    
    /**
	 * 게시종료일(시간)
	 */
    private String ntceEnddeHH;
    
    /**
	 * 게시종료일(분)
	 */
    private String ntceEnddeMM;

    /**
	 * 새창보기여부
	 */
    private String popupTrgetAt = "Y";
    
    /** FRST_REGISTER_PNTTM */
    private java.util.Date frstRegisterPnttm;
    
    /** FRST_REGISTER_ID */
    private java.lang.String frstRegisterId = "";
    
    /** LAST_UPDUSR_PNTTM */
    private java.util.Date lastUpdusrPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId = "";
        
	
	public String getBannerId() {
		return bannerId;
	}

	public void setBannerId(String bannerId) {
		this.bannerId = bannerId;
	}

	public String getBannerNm() {
		return bannerNm;
	}

	public void setBannerNm(String bannerNm) {
		this.bannerNm = bannerNm;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public String getBannerImage() {
		return bannerImage;
	}

	public void setBannerImage(String bannerImage) {
		this.bannerImage = bannerImage;
	}

	public String getBannerImageFile() {
		return bannerImageFile;
	}

	public void setBannerImageFile(String bannerImageFile) {
		this.bannerImageFile = bannerImageFile;
	}

	public String getBannerDc() {
		return bannerDc;
	}

	public void setBannerDc(String bannerDc) {
		this.bannerDc = bannerDc;
	}

	public String getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(String sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public String getReflctAt() {
		return reflctAt;
	}

	public void setReflctAt(String reflctAt) {
		this.reflctAt = reflctAt;
	}

	public boolean isAtchFile() {
		return isAtchFile;
	}
	public void setAtchFile(boolean isAtchFile) {
		this.isAtchFile = isAtchFile;
	}

	/**
	 * siteId를 리턴한다.
	 * @return  the siteId
	 */
    public String getSiteId() {
        return siteId;
    }

    /**
	 * siteId 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }

    /**
	 * System Type 코드를 리턴한다.
	 * @return  the sysTyCode
	 */
    public String getSysTyCode() {
        return sysTyCode;
    }

    /**
	 * System Type 코드 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 */
    public void setSysTyCode(String sysTyCode) {
        this.sysTyCode = sysTyCode;
    }

    /**
	 * 배너구분코드를 리턴한다.
	 * @return  the bannerTyCode
	 */
    public String getBannerTyCode() {
        return bannerTyCode;
    }

    /**
	 * 배너구분코드 값을 설정한다.
	 * @param bannerTyCode  the bannerTyCode to set
	 */
    public void setBannerTyCode(String bannerTyCode) {
        this.bannerTyCode = bannerTyCode;
    }
    
    public String getBannerThemaClCode() {
		return bannerThemaClCode;
	}

	public void setBannerThemaClCode(String bannerThemaClCode) {
		this.bannerThemaClCode = bannerThemaClCode;
	}

	public String getBannerThemaClCodeNm() {
		return bannerThemaClCodeNm;
	}

	public void setBannerThemaClCodeNm(String bannerThemaClCodeNm) {
		this.bannerThemaClCodeNm = bannerThemaClCodeNm;
	}

	/**
	 * ntceBgnde 리턴
	 * @return  the ntceBgnde
	 */
    public String getNtceBgnde() {
        return ntceBgnde;
    }

    /**
	 * ntceBgnde 설정
	 * @param ntceBgnde  the ntceBgnde to set
	 */
    public void setNtceBgnde(String ntceBgnde) {
        this.ntceBgnde = ntceBgnde;
    }

    /**
	 * ntceEndde 리턴
	 * @return  the ntceEndde
	 */
    public String getNtceEndde() {
        return ntceEndde;
    }

    /**
	 * ntceEndde 설정
	 * @param ntceEndde  the ntceEndde to set
	 */
    public void setNtceEndde(String ntceEndde) {
        this.ntceEndde = ntceEndde;
    }

    /**
	 * ntceBgndeHH 리턴
	 * @return  the ntceBgndeHH
	 */
    public String getNtceBgndeHH() {
        return ntceBgndeHH;
    }

    /**
	 * ntceBgndeHH 설정
	 * @param ntceBgndeHH  the ntceBgndeHH to set
	 */
    public void setNtceBgndeHH(String ntceBgndeHH) {
        this.ntceBgndeHH = ntceBgndeHH;
    }

    /**
	 * ntceBgndeMM 리턴
	 * @return  the ntceBgndeMM
	 */
    public String getNtceBgndeMM() {
        return ntceBgndeMM;
    }

    /**
	 * ntceBgndeMM 설정
	 * @param ntceBgndeMM  the ntceBgndeMM to set
	 */
    public void setNtceBgndeMM(String ntceBgndeMM) {
        this.ntceBgndeMM = ntceBgndeMM;
    }

    /**
	 * ntceEnddeHH 리턴
	 * @return  the ntceEnddeHH
	 */
    public String getNtceEnddeHH() {
        return ntceEnddeHH;
    }

    /**
	 * ntceEnddeHH 설정
	 * @param ntceEnddeHH  the ntceEnddeHH to set
	 */
    public void setNtceEnddeHH(String ntceEnddeHH) {
        this.ntceEnddeHH = ntceEnddeHH;
    }

    /**
	 * ntceEnddeMM 리턴
	 * @return  the ntceEnddeMM
	 */
    public String getNtceEnddeMM() {
        return ntceEnddeMM;
    }

    /**
	 * ntceEnddeMM 설정
	 * @param ntceEnddeMM  the ntceEnddeMM to set
	 */
    public void setNtceEnddeMM(String ntceEnddeMM) {
        this.ntceEnddeMM = ntceEnddeMM;
    }
    
    /**
	 * popupTrgetAt 리턴
	 * @return  the popupTrgetAt
	 */
    public String getPopupTrgetAt() {
        return popupTrgetAt;
    }

    /**
	 * popupTrgetAt 설정
	 * @param popupTrgetAt  the popupTrgetAt to set
	 */
    public void setPopupTrgetAt(String popupTrgetAt) {
        this.popupTrgetAt = popupTrgetAt;
    }

	public java.util.Date getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	public java.lang.String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(java.lang.String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	public java.util.Date getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	public java.lang.String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(java.lang.String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}
    
}
