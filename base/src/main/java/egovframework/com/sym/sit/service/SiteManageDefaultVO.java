package egovframework.com.sym.sit.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SiteManageDefaultVO extends SiteManageVO implements Serializable {
  
  /**
 * 검색조건
 */
  private String searchCate         = "";
  
  /**
 * 검색조건
 */
  private String searchCondition    = "";
  
  /**
 * 검색Keyword
 */
  private String searchKeyword      = "";
  
  /**
  * 보안설정 일괄적용여부
  */
  private String scrtySetupBtcbAt      = "";
    
  /**
  * 보안정책 일괄적용여부
  */
  private String scrtyPolicyBtcbAt      = "";
  
  /**
   * 활성화여부
   */
  private String searchActvtyAt 	= "";
  
  /**
   * 검색 Domain
   */
  private String searchDomain = "";
  
  /**
 * 검색사용여부
 */
  private String searchUseYn        = "";
  
  
  /** 검색 지역코드 */
  private String searchBlngEduInstCd = "";
	
  /** 검색 급코드 */
  private String searchSchlGrdCd = "";
  
  /**
 * 현재페이지
 */
  private int    pageIndex          = 1;
  
  /**
 * 페이지갯수
 */
  private int    pageUnit           = 10;
  
  /**
 * 페이지사이즈
 */
  private int    pageSize           = 10;
  
  /**
 * firstIndex
 */
  private int    firstIndex         = 1;
  
  /**
 * lastIndex
 */
  private int    lastIndex          = 1;
  
  /**
 * recordCountPerPage
 */
  private int    recordCountPerPage = 10;
    
  /**
 * searchCate attribute를 리턴한다.
 * @return  the searchCate
 */
  public String getSearchCate() {
    return searchCate;
  }
  
  /**
 * searchCate attribute 값을 설정한다.
 * @param searchCate  the searchCate to set
 */
  public void setSearchCate(String searchCate) {
    this.searchCate = searchCate;
  }
  
  /**
 * searchCondition attribute 를 리턴한다.
 * @return  the String
 */
  public String getSearchCondition() {
    return searchCondition;
  }
  
  /**
 * searchCondition attribute 값을 설정한다.
 * @return  searchCondition String
 */
  public void setSearchCondition(String searchCondition) {
    this.searchCondition = searchCondition;
  }
  
  /**
 * searchKeyword attribute 를 리턴한다.
 * @return  the String
 */
  public String getSearchKeyword() {
    return searchKeyword;
  }
  
  /**
 * searchKeyword attribute 값을 설정한다.
 * @return  searchKeyword String
 */
  public void setSearchKeyword(String searchKeyword) {
    this.searchKeyword = searchKeyword;
  }
  
  
  public String getSearchActvtyAt() {
	return searchActvtyAt;
  }

  public void setSearchActvtyAt(String searchActvtyAt) {
	this.searchActvtyAt = searchActvtyAt;
  }

  public String getSearchDomain() {
	return searchDomain;
  }

  public void setSearchDomain(String searchDomain) {
	this.searchDomain = searchDomain;
  }

/**
 * searchUseYn attribute 를 리턴한다.
 * @return  the String
 */
  public String getSearchUseYn() {
    return searchUseYn;
  }
  
  /**
 * searchUseYn attribute 값을 설정한다.
 * @return  searchUseYn String
 */
  public void setSearchUseYn(String searchUseYn) {
    this.searchUseYn = searchUseYn;
  }
  
  /**
 * pageIndex attribute 를 리턴한다.
 * @return  the int
 */
  public int getPageIndex() {
    return pageIndex;
  }
  
  /**
 * pageIndex attribute 값을 설정한다.
 * @return  pageIndex int
 */
  public void setPageIndex(int pageIndex) {
    this.pageIndex = pageIndex;
  }
  
  /**
 * pageUnit attribute 를 리턴한다.
 * @return  the int
 */
  public int getPageUnit() {
    return pageUnit;
  }
  
  /**
 * pageUnit attribute 값을 설정한다.
 * @return  pageUnit int
 */
  public void setPageUnit(int pageUnit) {
    this.pageUnit = pageUnit;
  }
  
  /**
 * pageSize attribute 를 리턴한다.
 * @return  the int
 */
  public int getPageSize() {
    return pageSize;
  }
  
  /**
 * pageSize attribute 값을 설정한다.
 * @return  pageSize int
 */
  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }
  
  /**
 * firstIndex attribute 를 리턴한다.
 * @return  the int
 */
  public int getFirstIndex() {
    return firstIndex;
  }
  
  /**
 * firstIndex attribute 값을 설정한다.
 * @return  firstIndex int
 */
  public void setFirstIndex(int firstIndex) {
    this.firstIndex = firstIndex;
  }
  
  /**
 * lastIndex attribute 를 리턴한다.
 * @return  the int
 */
  public int getLastIndex() {
    return lastIndex;
  }
  
  /**
 * lastIndex attribute 값을 설정한다.
 * @return  lastIndex int
 */
  public void setLastIndex(int lastIndex) {
    this.lastIndex = lastIndex;
  }
  
  /**
 * recordCountPerPage attribute 를 리턴한다.
 * @return  the int
 */
  public int getRecordCountPerPage() {
    return recordCountPerPage;
  }
  
  /**
 * recordCountPerPage attribute 값을 설정한다.
 * @return  recordCountPerPage int
 */
  public void setRecordCountPerPage(int recordCountPerPage) {
    this.recordCountPerPage = recordCountPerPage;
  }

public String getScrtySetupBtcbAt() {
	return scrtySetupBtcbAt;
}

public void setScrtySetupBtcbAt(String scrtySetupBtcbAt) {
	this.scrtySetupBtcbAt = scrtySetupBtcbAt;
}

public String getScrtyPolicyBtcbAt() {
	return scrtyPolicyBtcbAt;
}

public void setScrtyPolicyBtcbAt(String scrtyPolicyBtcbAt) {
	this.scrtyPolicyBtcbAt = scrtyPolicyBtcbAt;
}

public String getSearchBlngEduInstCd() {
	return searchBlngEduInstCd;
}

public void setSearchBlngEduInstCd(String searchBlngEduInstCd) {
	this.searchBlngEduInstCd = searchBlngEduInstCd;
}

public String getSearchSchlGrdCd() {
	return searchSchlGrdCd;
}

public void setSearchSchlGrdCd(String searchSchlGrdCd) {
	this.searchSchlGrdCd = searchSchlGrdCd;
}

  
}
