package egovframework.com.sym.ccm.cde.service;

import java.io.Serializable;

/**
 * 공통상세코드 모델 클래스
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
public class CmmnDetailCode implements Serializable {
	
	/*
	 * 코드ID
	 */
    /**
	 * @uml.property  name="codeId"
	 */
    private String codeId = "";
    
    /*
     * 코드ID명
     */
    /**
	 * @uml.property  name="codeIdNm"
	 */
    private String codeIdNm = "";
    
    /*
     * 코드
     */
	/**
	 * @uml.property  name="code"
	 */
	private String code = "";
	
	/*
	 * 코드명
	 */
    /**
	 * @uml.property  name="codeNm"
	 */
    private String codeNm = "";
    
    /*
     * 코드설명
     */
    /**
	 * @uml.property  name="codeDc"
	 */
    private String codeDc = "";
    
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
	 * codeId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeId"
	 */
	public String getCodeId() {
		return codeId;
	}

	/**
	 * codeId attribute 값을 설정한다.
	 * @param codeId  String
	 * @uml.property  name="codeId"
	 */
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	/**
	 * codeIdNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeIdNm"
	 */
	public String getCodeIdNm() {
		return codeIdNm;
	}

	/**
	 * codeIdNm attribute 값을 설정한다.
	 * @param codeIdNm  String
	 * @uml.property  name="codeIdNm"
	 */
	public void setCodeIdNm(String codeIdNm) {
		this.codeIdNm = codeIdNm;
	}

	/**
	 * code attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="code"
	 */
	public String getCode() {
		return code;
	}

	/**
	 * code attribute 값을 설정한다.
	 * @param code  String
	 * @uml.property  name="code"
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * codeNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeNm"
	 */
	public String getCodeNm() {
		return codeNm;
	}

	/**
	 * codeNm attribute 값을 설정한다.
	 * @param codeNm  String
	 * @uml.property  name="codeNm"
	 */
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	/**
	 * codeDc attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeDc"
	 */
	public String getCodeDc() {
		return codeDc;
	}

	/**
	 * codeDc attribute 값을 설정한다.
	 * @param codeDc  String
	 * @uml.property  name="codeDc"
	 */
	public void setCodeDc(String codeDc) {
		this.codeDc = codeDc;
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
