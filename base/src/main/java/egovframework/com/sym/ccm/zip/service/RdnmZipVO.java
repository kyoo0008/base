package egovframework.com.sym.ccm.zip.service;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : RdnmZipVO.java
 * @Description : RdnmZipVO Default VO class
 * @Modification Information
 *
 * @author 정정욱
 * @since 20121130
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class RdnmZipVO extends RdnmZip implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/** 검색 시도명 */
    private String searchCtprvnNm = "";
    
    /** 검색 시군구명 */
    private String searchSignguNm = "";
        
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
    
	public String getSearchCtprvnNm() {
		return searchCtprvnNm;
	}

	public void setSearchCtprvnNm(String searchCtprvnNm) {
		this.searchCtprvnNm = searchCtprvnNm;
	}

	public String getSearchSignguNm() {
		return searchSignguNm;
	}

	public void setSearchSignguNm(String searchSignguNm) {
		this.searchSignguNm = searchSignguNm;
	}

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

}
