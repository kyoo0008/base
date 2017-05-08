package egovframework.com.sym.mpm.service;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 메뉴 VO 클래스
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2010.12.27  정정욱          최초 생성 
 *  
 *  </pre>
 */
@SuppressWarnings("serial")
public class MpmVO extends Mpm {
	 
	/**
	 * 레이아웃구분
	 */
    private String layoutParam = "";

    /**
	 * 검색조건
	 */
    private String searchCnd = "";
    
    /**
	 * 검색단어
	 */
    private String searchWrd = "";
    
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
	 * rowNo
	 */
    private int rowNo = 0;

    /**
	 * 최초 등록자명
	 */
    private String frstRegisterNm = "";

    /**
	 * 최종 수정자명
	 */
    private String lastUpdusrNm = "";
    
    /**
	 * 미리보기 여부
	 */
    private String previewYn = "N";
    
    /**
	 * 임시메뉴아이디
	 */
    private String takeMenuId = "";
    
    /**
	 * 메인여부
	 */
    private String isMain = "N";

    /**
	 * 임시첨부파일 그룹아이디
	 */
    private String fileGroupId = "";
    
    /**
	 * 임시첨부파일 그룹아이디
	 */
    private String mobileFileGroupId = "";
    
    /**
	 * layoutParam attribute를 리턴한다.
	 * @return  the layoutParam
	 */
    public String getLayoutParam() {
	return layoutParam;
    }

    /**
	 * layoutParam attribute 값을 설정한다.
	 * @param layoutParam  the layoutParam to set
	 */
    public void setLayoutParam(String layoutParam) {
	this.layoutParam = layoutParam;
    }
    
    /**
	 * searchCnd attribute를 리턴한다.
	 * @return  the searchCnd
	 */
    public String getSearchCnd() {
	return searchCnd;
    }

    /**
	 * searchCnd attribute 값을 설정한다.
	 * @param searchCnd  the searchCnd to set
	 */
    public void setSearchCnd(String searchCnd) {
	this.searchCnd = searchCnd;
    }

    /**
	 * searchWrd attribute를 리턴한다.
	 * @return  the searchWrd
	 */
    public String getSearchWrd() {
	return searchWrd;
    }

    /**
	 * searchWrd attribute 값을 설정한다.
	 * @param searchWrd  the searchWrd to set
	 */
    public void setSearchWrd(String searchWrd) {
	this.searchWrd = searchWrd;
    }

    /**
	 * searchUseYn attribute를 리턴한다.
	 * @return  the searchUseYn
	 */
    public String getSearchUseYn() {
	return searchUseYn;
    }

    /**
	 * searchUseYn attribute 값을 설정한다.
	 * @param searchUseYn  the searchUseYn to set
	 */
    public void setSearchUseYn(String searchUseYn) {
	this.searchUseYn = searchUseYn;
    }

	/**
	 * pageIndex attribute를 리턴한다.
	 * @return  the pageIndex
	 */
    public int getPageIndex() {
	return pageIndex;
    }

    /**
	 * pageIndex attribute 값을 설정한다.
	 * @param pageIndex  the pageIndex to set
	 */
    public void setPageIndex(int pageIndex) {
	this.pageIndex = pageIndex;
    }

    /**
	 * pageUnit attribute를 리턴한다.
	 * @return  the pageUnit
	 */
    public int getPageUnit() {
	return pageUnit;
    }

    /**
	 * pageUnit attribute 값을 설정한다.
	 * @param pageUnit  the pageUnit to set
	 */
    public void setPageUnit(int pageUnit) {
	this.pageUnit = pageUnit;
    }

    /**
	 * pageSize attribute를 리턴한다.
	 * @return  the pageSize
	 */
    public int getPageSize() {
	return pageSize;
    }

    /**
	 * pageSize attribute 값을 설정한다.
	 * @param pageSize  the pageSize to set
	 */
    public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
    }

    /**
	 * firstIndex attribute를 리턴한다.
	 * @return  the firstIndex
	 */
    public int getFirstIndex() {
	return firstIndex;
    }

    /**
	 * firstIndex attribute 값을 설정한다.
	 * @param firstIndex  the firstIndex to set
	 */
    public void setFirstIndex(int firstIndex) {
	this.firstIndex = firstIndex;
    }

    /**
	 * lastIndex attribute를 리턴한다.
	 * @return  the lastIndex
	 */
    public int getLastIndex() {
	return lastIndex;
    }

    /**
	 * lastIndex attribute 값을 설정한다.
	 * @param lastIndex  the lastIndex to set
	 */
    public void setLastIndex(int lastIndex) {
	this.lastIndex = lastIndex;
    }

    /**
	 * recordCountPerPage attribute를 리턴한다.
	 * @return  the recordCountPerPage
	 */
    public int getRecordCountPerPage() {
	return recordCountPerPage;
    }

    /**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @param recordCountPerPage  the recordCountPerPage to set
	 */
    public void setRecordCountPerPage(int recordCountPerPage) {
	this.recordCountPerPage = recordCountPerPage;
    }

    /**
	 * rowNo attribute를 리턴한다.
	 * @return  the rowNo
	 */
    public int getRowNo() {
	return rowNo;
    }

    /**
	 * rowNo attribute 값을 설정한다.
	 * @param rowNo  the rowNo to set
	 */
    public void setRowNo(int rowNo) {
	this.rowNo = rowNo;
    }

    /**
	 * frstRegisterNm attribute를 리턴한다.
	 * @return  the frstRegisterNm
	 */
    public String getFrstRegisterNm() {
	return frstRegisterNm;
    }

    /**
	 * frstRegisterNm attribute 값을 설정한다.
	 * @param frstRegisterNm  the frstRegisterNm to set
	 */
    public void setFrstRegisterNm(String frstRegisterNm) {
	this.frstRegisterNm = frstRegisterNm;
    }


    /**
	 * lastUpdusrNm attribute를 리턴한다.
	 * @return  the lastUpdusrNm
	 */
    public String getLastUpdusrNm() {
	return lastUpdusrNm;
    }

    /**
	 * lastUpdusrNm attribute 값을 설정한다.
	 * @param lastUpdusrNm  the lastUpdusrNm to set
	 */
    public void setLastUpdusrNm(String lastUpdusrNm) {
	this.lastUpdusrNm = lastUpdusrNm;
    }
  
    
    public String getPreviewYn() {
		return previewYn;
	}

	public void setPreviewYn(String previewYn) {
		this.previewYn = previewYn;
	}

	public String getTakeMenuId() {
		return takeMenuId;
	}

	public void setTakeMenuId(String takeMenuId) {
		this.takeMenuId = takeMenuId;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	public String getFileGroupId() {
		return fileGroupId;
	}

	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}

	public String getMobileFileGroupId() {
		return mobileFileGroupId;
	}

	public void setMobileFileGroupId(String mobileFileGroupId) {
		this.mobileFileGroupId = mobileFileGroupId;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
}
