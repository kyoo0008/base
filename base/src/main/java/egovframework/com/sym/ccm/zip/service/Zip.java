package egovframework.com.sym.ccm.zip.service;

import java.io.Serializable;

/**
 * 우편번호 모델 클래스
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
public class Zip implements Serializable {

	/*
	 * 우편번호
	 */
    /**
	 * @uml.property  name="zip"
	 */
    private String zip            = "";
    
    /*
     * 일련번호
     */
    /**
	 * @uml.property  name="sn"
	 */
    private int    sn             = 0;
    
    /*
     * 시도명
     */
	/**
	 * @uml.property  name="ctprvnNm"
	 */
	private String ctprvnNm       = "";
	
	/*
	 * 시군구명
	 */
    /**
	 * @uml.property  name="signguNm"
	 */
    private String signguNm       = "";
    
    /*
     * 읍면동명
     */
    /**
	 * @uml.property  name="emdNm"
	 */
    private String emdNm          = "";
    
    /*
     * 리건물명
     */
    /**
	 * @uml.property  name="liBuldNm"
	 */
    private String liBuldNm      = "";
    
    /*
     * 번지동호
     */
    /**
	 * @uml.property  name="lnbrDongHo"
	 */
    private String lnbrDongHo     = "";

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
	 * zip attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="zip"
	 */
	public String getZip() {
		return zip;
	}

	/**
	 * zip attribute 값을 설정한다.
	 * @param zip  String
	 * @uml.property  name="zip"
	 */
	public void setZip(String zip) {
		this.zip = zip;
	}

	/**
	 * sn attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="sn"
	 */
	public int getSn() {
		return sn;
	}

	/**
	 * sn attribute 값을 설정한다.
	 * @param sn  int
	 * @uml.property  name="sn"
	 */
	public void setSn(int sn) {
		this.sn = sn;
	}

	/**
	 * ctprvnNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="ctprvnNm"
	 */
	public String getCtprvnNm() {
		return ctprvnNm;
	}

	/**
	 * ctprvnNm attribute 값을 설정한다.
	 * @param ctprvnNm  String
	 * @uml.property  name="ctprvnNm"
	 */
	public void setCtprvnNm(String ctprvnNm) {
		this.ctprvnNm = ctprvnNm;
	}

	/**
	 * signguNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="signguNm"
	 */
	public String getSignguNm() {
		return signguNm;
	}

	/**
	 * signguNm attribute 값을 설정한다.
	 * @param signguNm  String
	 * @uml.property  name="signguNm"
	 */
	public void setSignguNm(String signguNm) {
		this.signguNm = signguNm;
	}

	/**
	 * emdNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="emdNm"
	 */
	public String getEmdNm() {
		return emdNm;
	}

	/**
	 * emdNm attribute 값을 설정한다.
	 * @param emdNm  String
	 * @uml.property  name="emdNm"
	 */
	public void setEmdNm(String emdNm) {
		this.emdNm = emdNm;
	}

	/**
	 * liBuldNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="liBuldNm"
	 */
	public String getLiBuldNm() {
		return liBuldNm;
	}

	/**
	 * liBuldNm attribute 값을 설정한다.
	 * @param liBuldNm  String
	 * @uml.property  name="liBuldNm"
	 */
	public void setLiBuldNm(String liBuldNm) {
		this.liBuldNm = liBuldNm;
	}

	/**
	 * lnbrDongHo attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="lnbrDongHo"
	 */
	public String getLnbrDongHo() {
		return lnbrDongHo;
	}

	/**
	 * lnbrDongHo attribute 값을 설정한다.
	 * @param lnbrDongHo  String
	 * @uml.property  name="lnbrDongHo"
	 */
	public void setLnbrDongHo(String lnbrDongHo) {
		this.lnbrDongHo = lnbrDongHo;
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
