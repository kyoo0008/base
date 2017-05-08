package egovframework.com.sym.cal.service;

import java.io.Serializable;

/**
 * 휴일 모델 클래스
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
public class Restde implements Serializable {

	/*
	 * 휴일번호
	 */
    /**
	 * @uml.property  name="restdeNo"
	 */
    private int    restdeNo       = 0;
    
    /*
     * 휴일일자
     */
    /**
	 * @uml.property  name="restdeDe"
	 */
    private String restdeDe       = "";
    
    /*
     * 휴일명
     */
    /**
	 * @uml.property  name="restdeNm"
	 */
    private String restdeNm       = "";
    
    /*
     * 휴일설명
     */
    /**
	 * @uml.property  name="restdeDc"
	 */
    private String restdeDc       = "";
    
    /*
     * 휴일구분
     */
    /**
	 * @uml.property  name="restdeSe"
	 */
    private String restdeSe       = "";
    
    /*
     * 휴일구분코드
     */
    /**
	 * @uml.property  name="restdeSeCode"
	 */
    private String restdeSeCode   = "";
    
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

    /*
     * 년
     */
    /**
	 * @uml.property  name="year"
	 */
    private String year           = "";
    
    /*
     * 월
     */
    /**
	 * @uml.property  name="month"
	 */
    private String month          = "";
    
    /*
     * 일
     */
    /**
	 * @uml.property  name="day"
	 */
    private String day            = "";
    
    /*
     * 휴일여부
     */
    /**
	 * @uml.property  name="restdeAt"
	 */
    private String restdeAt       = "";

    /*
     * 달력셀
     */
	/**
	 * @uml.property  name="cellNum"
	 */
	private int    cellNum        = 0;
	
	/*
	 * 월별 주순위
	 */
    /**
	 * @uml.property  name="weeks"
	 */
    private int    weeks          = 0;
    
    /*
     * 월 주수
     */
    /**
	 * @uml.property  name="maxWeeks"
	 */
    private int maxWeeks = 0;
    
    /*
     * 요일
     */
    /**
	 * @uml.property  name="week"
	 */
    private int    week           = 0;
    
    /*
     * 시작요일 
     */
    /**
	 * @uml.property  name="startWeekMonth"
	 */
    private int    startWeekMonth = 0;
    
    /*
     * 마지막 일자
     */
    /**
	 * @uml.property  name="lastDayMonth"
	 */
    private int    lastDayMonth   = 0;

	/**
	 * restdeNo attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="restdeNo"
	 */
	public int getRestdeNo() {
		return restdeNo;
	}

	/**
	 * restdeNo attribute 값을 설정한다.
	 * @param restdeNo  int
	 * @uml.property  name="restdeNo"
	 */
	public void setRestdeNo(int restdeNo) {
		this.restdeNo = restdeNo;
	}

	/**
	 * restdeDe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeDe"
	 */
	public String getRestdeDe() {
		return restdeDe;
	}

	/**
	 * restdeDe attribute 값을 설정한다.
	 * @param restdeDe  String
	 * @uml.property  name="restdeDe"
	 */
	public void setRestdeDe(String restdeDe) {
		this.restdeDe = restdeDe;
	}

	/**
	 * restdeNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeNm"
	 */
	public String getRestdeNm() {
		return restdeNm;
	}

	/**
	 * restdeNm attribute 값을 설정한다.
	 * @param restdeNm  String
	 * @uml.property  name="restdeNm"
	 */
	public void setRestdeNm(String restdeNm) {
		this.restdeNm = restdeNm;
	}

	/**
	 * restdeDc attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeDc"
	 */
	public String getRestdeDc() {
		return restdeDc;
	}

	/**
	 * restdeDc attribute 값을 설정한다.
	 * @param restdeDc  String
	 * @uml.property  name="restdeDc"
	 */
	public void setRestdeDc(String restdeDc) {
		this.restdeDc = restdeDc;
	}

	/**
	 * restdeSe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeSe"
	 */
	public String getRestdeSe() {
		return restdeSe;
	}

	/**
	 * restdeSe attribute 값을 설정한다.
	 * @param restdeSe  String
	 * @uml.property  name="restdeSe"
	 */
	public void setRestdeSe(String restdeSe) {
		this.restdeSe = restdeSe;
	}

	/**
	 * restdeSeCode attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeSeCode"
	 */
	public String getRestdeSeCode() {
		return restdeSeCode;
	}

	/**
	 * restdeSeCode attribute 값을 설정한다.
	 * @param restdeSeCode  String
	 * @uml.property  name="restdeSeCode"
	 */
	public void setRestdeSeCode(String restdeSeCode) {
		this.restdeSeCode = restdeSeCode;
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

	/**
	 * year attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="year"
	 */
	public String getYear() {
		return year;
	}

	/**
	 * year attribute 값을 설정한다.
	 * @param year  String
	 * @uml.property  name="year"
	 */
	public void setYear(String year) {
		this.year = year;
	}

	/**
	 * month attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="month"
	 */
	public String getMonth() {
		return month;
	}

	/**
	 * month attribute 값을 설정한다.
	 * @param month  String
	 * @uml.property  name="month"
	 */
	public void setMonth(String month) {
		this.month = month;
	}

	/**
	 * day attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="day"
	 */
	public String getDay() {
		return day;
	}

	/**
	 * day attribute 값을 설정한다.
	 * @param day  String
	 * @uml.property  name="day"
	 */
	public void setDay(String day) {
		this.day = day;
	}

	/**
	 * restdeAt attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="restdeAt"
	 */
	public String getRestdeAt() {
		return restdeAt;
	}

	/**
	 * restdeAt attribute 값을 설정한다.
	 * @param restdeAt  String
	 * @uml.property  name="restdeAt"
	 */
	public void setRestdeAt(String restdeAt) {
		this.restdeAt = restdeAt;
	}

	/**
	 * cellNum attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="cellNum"
	 */
	public int getCellNum() {
		return cellNum;
	}

	/**
	 * cellNum attribute 값을 설정한다.
	 * @param cellNum  int
	 * @uml.property  name="cellNum"
	 */
	public void setCellNum(int cellNum) {
		this.cellNum = cellNum;
	}

	/**
	 * weeks attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="weeks"
	 */
	public int getWeeks() {
		return weeks;
	}

	/**
	 * weeks attribute 값을 설정한다.
	 * @param weeks  int
	 * @uml.property  name="weeks"
	 */
	public void setWeeks(int weeks) {
		this.weeks = weeks;
	}

	/**
	 * maxWeeks attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="maxWeeks"
	 */
	public int getMaxWeeks() {
		return maxWeeks;
	}

	/**
	 * maxWeeks attribute 값을 설정한다.
	 * @param maxWeeks  int
	 * @uml.property  name="maxWeeks"
	 */
	public void setMaxWeeks(int maxWeeks) {
		this.maxWeeks = maxWeeks;
	}

	/**
	 * week attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="week"
	 */
	public int getWeek() {
		return week;
	}

	/**
	 * week attribute 값을 설정한다.
	 * @param week  int
	 * @uml.property  name="week"
	 */
	public void setWeek(int week) {
		this.week = week;
	}

	/**
	 * startWeekMonth attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="startWeekMonth"
	 */
	public int getStartWeekMonth() {
		return startWeekMonth;
	}

	/**
	 * startWeekMonth attribute 값을 설정한다.
	 * @param startWeekMonth  int
	 * @uml.property  name="startWeekMonth"
	 */
	public void setStartWeekMonth(int startWeekMonth) {
		this.startWeekMonth = startWeekMonth;
	}

	/**
	 * lastDayMonth attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="lastDayMonth"
	 */
	public int getLastDayMonth() {
		return lastDayMonth;
	}

	/**
	 * lastDayMonth attribute 값을 설정한다.
	 * @param lastDayMonth  int
	 * @uml.property  name="lastDayMonth"
	 */
	public void setLastDayMonth(int lastDayMonth) {
		this.lastDayMonth = lastDayMonth;
	}

    
}
