package egovframework.com.cop.com.service;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : LytTmplatVO
 * @Description : LytTmplatVO class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20120905
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@SuppressWarnings("serial")
public class LytTmplatVO extends LytTmplat implements Serializable {
	
	/** 대분류검색구분 */
    private String searchTmplatLcasCode;
    
    /** 중분류검색구분 */
    private String searchTmplatMlsfcCode;
    
    /** 선택모드여부 */
    private String selectMode = "N";
    
	/** 검색조건 */
    private String searchCnd = "";
    
    /** 검색Keyword */
    private String searchWrd = "";
    
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

	public String getSearchTmplatLcasCode() {
		return searchTmplatLcasCode;
	}

	public void setSearchTmplatLcasCode(String searchTmplatLcasCode) {
		this.searchTmplatLcasCode = searchTmplatLcasCode;
	}

	public String getSearchTmplatMlsfcCode() {
		return searchTmplatMlsfcCode;
	}

	public void setSearchTmplatMlsfcCode(String searchTmplatMlsfcCode) {
		this.searchTmplatMlsfcCode = searchTmplatMlsfcCode;
	}

	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    public String getSelectMode() {
		return selectMode;
	}

	public void setSelectMode(String selectMode) {
		this.selectMode = selectMode;
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

}
