package egovframework.com.cmm;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : ComDefaultVO.java
 * @Description : ComDefaultVO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.02    조재영         최초 생성
 *
 *  @author 공통서비스 개발팀 조재영
 *  @since 2009.02.01
 *  @version 1.0
 *  @see 
 *  
 */
@SuppressWarnings("serial")
public class ComDefaultVO implements Serializable {
	
	/**
	 * 검색분류
	*/
	private String searchCate = "";
	
	/**
	 * 검색 카테고리리스트
	 */
    private List<String> searchCateList;
	
	/**
	 * 검색대상
	*/
	private String searchTarget = "";

	/**
	 * 검색레벨
	*/
	private String searchLevel = "";
	
	/**
	 * 검색모드
	 */
    private String searchMode = "";
    
    /** 선택모드여부 */
    private String selectMode = "N";
    
	/**
	 * 검색조건
	 */
    private String searchCondition = "";
    
    /**
	 * 검색Keyword
	 */
    private String searchKeyword = "";
    
    /**
	 * 검색사용여부
	 */
    private String searchUseYn = "";
    
    /**
	 * 현재페이지
	 */
    private int pageIndex = 1;
    
    /**
	 * 페이지갯수
	 */
    private int pageUnit = 10;
    
    /**
	 * 페이지사이즈
	 */
    private int pageSize = 10;

    /**
	 * firstIndex
	 */
    private int firstIndex = 1;

    /**
	 * lastIndex
	 */
    private int lastIndex = 1;

    /**
	 * recordCountPerPage
	 */
    private int recordCountPerPage = 10;
    
    /**
	 * 검색KeywordFrom
	 */
    private String searchKeywordFrom = "";    

	/**
	 * 검색KeywordTo
	 */
    private String searchKeywordTo = ""; 
    
    /**
	 * sortTyCode
	 */
    private String sortTyCode = "";    
    
    /**
	 * 관리자여부
	 */
    private String adminAt = "N";  
        
	public String getSearchCate() {
		return searchCate;
	}

	public void setSearchCate(String searchCate) {
		this.searchCate = searchCate;
	}

	public List<String> getSearchCateList() {
		return searchCateList;
	}

	public void setSearchCateList(List<String> searchCateList) {
		this.searchCateList = searchCateList;
	}

	public String getSearchTarget() {
		return searchTarget;
	}

	public void setSearchTarget(String searchTarget) {
		this.searchTarget = searchTarget;
	}

	public String getSearchLevel() {
		return searchLevel;
	}

	public void setSearchLevel(String searchLevel) {
		this.searchLevel = searchLevel;
	}

	/**
	 * @return
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * @param firstIndex
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * @return
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * @param lastIndex
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * @return
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * @param recordCountPerPage
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	/**
	 * @return
	 */
	public String getSearchMode() {
        return searchMode;
    }

    /**
	 * @param searchMode
	 */
    public void setSearchMode(String searchMode) {
        this.searchMode = searchMode;
    }
    
    
	/**
	 * @return
	 */
	public String getSearchCondition() {
        return searchCondition;
    }

    /**
	 * @param searchCondition
	 */
    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    /**
	 * @return
	 */
    public String getSearchKeyword() {
        return searchKeyword;
    }

    /**
	 * @param searchKeyword
	 */
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    /**
	 * @return
	 */
    public String getSearchUseYn() {
        return searchUseYn;
    }

    /**
	 * @param searchUseYn
	 */
    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    /**
	 * @return
	 */
    public int getPageIndex() {
        return pageIndex;
    }

    /**
	 * @param pageIndex
	 */
    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    /**
	 * @return
	 */
    public int getPageUnit() {
        return pageUnit;
    }

    /**
	 * @param pageUnit
	 */
    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    /**
	 * @return
	 */
    public int getPageSize() {
        return pageSize;
    }

    /**
	 * @param pageSize
	 */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    
    /**
	 * searchKeywordFrom attribute를 리턴한다.
	 * @return  String
	 */
	public String getSearchKeywordFrom() {
		return searchKeywordFrom;
	}

	/**
	 * searchKeywordFrom attribute 값을 설정한다.
	 * @param searchKeywordFrom  String
	 */
	public void setSearchKeywordFrom(String searchKeywordFrom) {
		this.searchKeywordFrom = searchKeywordFrom;
	}

	/**
	 * searchKeywordTo attribute를 리턴한다.
	 * @return  String
	 */
	public String getSearchKeywordTo() {
		return searchKeywordTo;
	}

	/**
	 * searchKeywordTo attribute 값을 설정한다.
	 * @param searchKeywordTo  String
	 */
	public void setSearchKeywordTo(String searchKeywordTo) {
		this.searchKeywordTo = searchKeywordTo;
	}

	public String getSelectMode() {
		return selectMode;
	}

	public void setSelectMode(String selectMode) {
		this.selectMode = selectMode;
	}

	public String getSortTyCode() {
		return sortTyCode;
	}

	public void setSortTyCode(String sortTyCode) {
		this.sortTyCode = sortTyCode;
	}

	public String getAdminAt() {
		return adminAt;
	}

	public void setAdminAt(String adminAt) {
		this.adminAt = adminAt;
	}
	
	
}
