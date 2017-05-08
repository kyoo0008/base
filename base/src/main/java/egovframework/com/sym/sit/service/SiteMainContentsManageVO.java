package egovframework.com.sym.sit.service;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class SiteMainContentsManageVO implements Serializable {
  
	/**
	 * 사이트 ID
	 */
    private String siteId = "";
    
    /**
	 * 메뉴 ID
	 */
    private String menuId = "";
    
    /**
	 * 컨텐츠유형코드
	 */
    private String cntntsTyCode = "";
    
    /**
	 * 프로그램ID
	 */
    private String progrmId = "";
    
    /**
	 * 프로그램명
	 */
    private String progrmNm = "";
    
    /**
	 * 정렬번호깊이
	 */
    private int sortOrdr = 0;
    
    /**
	 * 프로그램ID 목록
	 */
    private List<String> bbsIdList;
    
    
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

	public String getCntntsTyCode() {
		return cntntsTyCode;
	}

	public void setCntntsTyCode(String cntntsTyCode) {
		this.cntntsTyCode = cntntsTyCode;
	}

	public String getProgrmId() {
		return progrmId;
	}

	public void setProgrmId(String progrmId) {
		this.progrmId = progrmId;
	}

	public String getProgrmNm() {
		return progrmNm;
	}

	public void setProgrmNm(String progrmNm) {
		this.progrmNm = progrmNm;
	}

	public int getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(int sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public List<String> getBbsIdList() {
		return bbsIdList;
	}

	public void setBbsIdList(List<String> bbsIdList) {
		this.bbsIdList = bbsIdList;
	}

}
