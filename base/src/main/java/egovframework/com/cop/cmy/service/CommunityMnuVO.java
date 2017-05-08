package egovframework.com.cop.cmy.service;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/******************************************************
 * @Class Name : ComtncmmntyMnu.java
 * @Program name : egovframework.com.cop.cmy.service
 * @Descriptopn : 커뮤니티 메뉴 검색 VO
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 1. 19.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 1. 19.        이호영             first generated
*********************************************************/

@SuppressWarnings("serial")
public class CommunityMnuVO extends CommunityMnu implements Serializable {
	
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
