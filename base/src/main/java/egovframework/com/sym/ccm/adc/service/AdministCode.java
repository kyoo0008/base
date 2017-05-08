package egovframework.com.sym.ccm.adc.service;

import java.io.Serializable;

/**
 * 행정코드 모델 클래스
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
public class AdministCode implements Serializable {
	
	/*
	 * 행정구역구분
	 */
    /**
	 * @uml.property  name="administZoneSe"
	 */
    private String administZoneSe = "";

    /*
     * 행정구역코드 
     */
    /**
	 * @uml.property  name="administZoneCode"
	 */
    private String administZoneCode = "";
    
    /*
     * 행정구역명
     */
	/**
	 * @uml.property  name="administZoneNm"
	 */
	private String administZoneNm = "";
	
	/*
	 * 상위행정구역코드
	 */
    /**
	 * @uml.property  name="upperAdministZoneCode"
	 */
    private String upperAdministZoneCode = "";

	/*
	 * 상위행정구역명
	 */
    /**
	 * @uml.property  name="upperAdministZoneNm"
	 */
    private String upperAdministZoneNm = "";

    /*
	 * 생성일자
	 */
    /**
	 * @uml.property  name="creatDe"
	 */
    private String creatDe = "";

    /*
	 * 폐기일자
	 */
    /**
	 * @uml.property  name="ablDe"
	 */
    private String ablDe = "";

    /*
	 * 사용여부
	 */
    /**
	 * @uml.property  name="useAt"
	 */
    private String useAt = "";

    /*
     * 최초등록자ID
     */
    /**
	 * @uml.property  name="frstRegisterId"
	 */
    private String frstRegisterId = "";
    
    /*
     * 최종수정자ID
     */
    /**
	 * @uml.property  name="lastUpdusrId"
	 */
    private String lastUpdusrId   = "";

	/**
	 * administZoneSe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="administZoneSe"
	 */
	public String getAdministZoneSe() {
		return administZoneSe;
	}

	/**
	 * administZoneSe attribute 값을 설정한다.
	 * @param administZoneSe  String
	 * @uml.property  name="administZoneSe"
	 */
	public void setAdministZoneSe(String administZoneSe) {
		this.administZoneSe = administZoneSe;
	}

	/**
	 * administZoneCode attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="administZoneCode"
	 */
	public String getAdministZoneCode() {
		return administZoneCode;
	}

	/**
	 * administZoneCode attribute 값을 설정한다.
	 * @param administZoneCode  String
	 * @uml.property  name="administZoneCode"
	 */
	public void setAdministZoneCode(String administZoneCode) {
		this.administZoneCode = administZoneCode;
	}

	/**
	 * administZoneNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="administZoneNm"
	 */
	public String getAdministZoneNm() {
		return administZoneNm;
	}

	/**
	 * administZoneNm attribute 값을 설정한다.
	 * @param administZoneNm  String
	 * @uml.property  name="administZoneNm"
	 */
	public void setAdministZoneNm(String administZoneNm) {
		this.administZoneNm = administZoneNm;
	}

	/**
	 * upperAdministZoneCode attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="upperAdministZoneCode"
	 */
	public String getUpperAdministZoneCode() {
		return upperAdministZoneCode;
	}

	/**
	 * upperAdministZoneCode attribute 값을 설정한다.
	 * @param upperAdministZoneCode  String
	 * @uml.property  name="upperAdministZoneCode"
	 */
	public void setUpperAdministZoneCode(String upperAdministZoneCode) {
		this.upperAdministZoneCode = upperAdministZoneCode;
	}

	/**
	 * upperAdministZoneNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="upperAdministZoneNm"
	 */
	public String getUpperAdministZoneNm() {
		return upperAdministZoneNm;
	}

	/**
	 * upperAdministZoneNm attribute 값을 설정한다.
	 * @param upperAdministZoneNm  String
	 * @uml.property  name="upperAdministZoneNm"
	 */
	public void setUpperAdministZoneNm(String upperAdministZoneNm) {
		this.upperAdministZoneNm = upperAdministZoneNm;
	}
	
	/**
	 * creatDe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="creatDe"
	 */
	public String getCreatDe() {
		return creatDe;
	}

	/**
	 * creatDe attribute 값을 설정한다.
	 * @param creatDe  String
	 * @uml.property  name="creatDe"
	 */
	public void setCreatDe(String creatDe) {
		this.creatDe = creatDe;
	}

	/**
	 * ablDe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="ablDe"
	 */
	public String getAblDe() {
		return ablDe;
	}

	/**
	 * ablDe attribute 값을 설정한다.
	 * @param ablDe  String
	 * @uml.property  name="ablDe"
	 */
	public void setAblDe(String ablDe) {
		this.ablDe = ablDe;
	}

	/**
	 * useAt attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="useAt"
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt  String
	 * @uml.property  name="useAt"
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * frstRegisterId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="frstRegisterId"
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId  String
	 * @uml.property  name="frstRegisterId"
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * lastUpdusrId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="lastUpdusrId"
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId  String
	 * @uml.property  name="lastUpdusrId"
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	
}
