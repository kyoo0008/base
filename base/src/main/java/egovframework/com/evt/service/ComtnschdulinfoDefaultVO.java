package egovframework.com.evt.service;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : ComtnschdulinfoDefaultVO.java
 * @Description : Comtnschdulinfo Default VO class
 * @Modification Information
 *
 * @author 이호영
 * @since 2011.08.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class ComtnschdulinfoDefaultVO implements Serializable {

	/** 사이트ID */
    private String siteId = "";
    
    /** 메뉴ID */
    private String menuId = "";
    
	/** 검색조건(년도) */
    private String searchDate;
    
	/** 검색조건(년도) */
    private int searchYear;
    
    /** 검색조건 (일정종류) */
    private String searchSe;
    
    /** 화면 모드(달력/목록) */
    private String mode;
    
	/** 검색조건(월) */
    private int searchMonth;
    
    /** 검색조건(일) */
    private int searchDay;
    
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** 검색시작일 */
    private String searchBeginDate = "";

	/** 검색종료일 */
    private String searchEndDate = "";
    
    /** 검색기간구분 */
    private String searchTermTy = "";
    
    /** 검색조건 (일정종류) */
    private String adminYn = "";
    
    /** 관리자 유무 */
    private String mngrAt = "";
    
	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
	public String getSearchSe() {
        return searchSe;
    }

    public void setSearchSe(String searchSe) {
        this.searchSe = searchSe;
    }
	
	public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }
    
	public String getSearchDate() {
        return searchDate;
    }

    public void setSearchDate(String searchDate) {
        this.searchDate = searchDate;
    }
    
	public int getSearchYear() {
        return searchYear;
    }

    public void setSearchYear(int searchYear) {
        this.searchYear = searchYear;
    }
	
	public int getSearchMonth() {
        return searchMonth;
    }

    public void setSearchMonth(int searchMonth) {
        this.searchMonth = searchMonth;
    }
    
    public int getSearchDay() {
        return searchDay;
    }

    public void setSearchDay(int searchDay) {
        this.searchDay = searchDay;
    }

	public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getSearchBeginDate() {
		return searchBeginDate;
	}

	public void setSearchBeginDate(String searchBeginDate) {
		this.searchBeginDate = searchBeginDate;
	}

	public String getSearchEndDate() {
		return searchEndDate;
	}

	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}

	public String getSearchTermTy() {
		return searchTermTy;
	}

	public void setSearchTermTy(String searchTermTy) {
		this.searchTermTy = searchTermTy;
	}
	
	public String getAdminYn() {
		return adminYn;
	}

	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	
    public String getMngrAt() {
        return mngrAt;
    }
    
    public void setMngrAt(String mngrAt) {
        this.mngrAt = mngrAt;
    }

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
    
    
}
