package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.string.EgovStringUtil;

/**
 * 게시물 관리를 위한 VO 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29  한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class BoardVO extends Board implements Serializable {
        
	/**
	 * 권한
	 */
    private String searchAuth = "";
    
	/**
	 * 검색 카테고리
	 */
    private String searchCate = "";
    
    /**
	 * 검색 카테고리리스트
	 */
    private List<String> searchCateList;
    
    /**
	 * 게시물번호리스트
	 */
    private List<String> nttNoArr;
    
    
    /**
	 * 검색시작일
	 */
    private String searchBgnDe = "";
    
    /**
	 * 검색조건
	 */
    private String searchCnd = "";
    
    /**
	 * 검색종료일
	 */
    private String searchEndDe = "";
    
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
	 * 첫페이지 인덱스
	 */
    private int firstIndex = 1;

    /**
	 * 마지막페이지 인덱스
	 */
    private int lastIndex = 1;

    /**
	 * 페이지당 레코드 개수
	 */
    private int recordCountPerPage = 10;

    /**
	 * 레코드 번호
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
	 * 조회 수 증가 여부
	 */
    private boolean plusCount = false;
    
    
    /**
	 * 메뉴 정보
	 */
    private String menuId = "";
    
    /**
	 * SITE ID
	 */
    private String siteId = "";
    
    /**
	 * SITE NM
	 */
    private String siteNm = "";
    
    /**
	 * SITE URL
	 */
    private String siteUrl = "";
    
    /**
	 * 커뮤니티 주소
	 */
    private String cmmntyAdres = "";
    
    /**
	 * 커뮤니티 명
	 */
    private String cmmntyNm = "";
    
    /**
	 * SYS_TY_CODE
	 */
    private String sysTyCode = "";
    
    /**
	 * 관리자여부
	 */
    private String adminAt = "N";
    
    /** 기간종료*/
    private String isExpired = "";
    
    /** 코멘트갯수*/
    private String commentCount = "";
    
    /** 첨부파일 리스트*/
    private List<FileVO> fileList = null;
    
    
    /** 코멘트사용여부*/
    private String commentUseAt = "";
    
    /** 게시판 템플릿 아이디*/
    private String tmplatId = "";
    
    /** 게시판속성코드*/
    private String bbsAttrbCode = "";
    
    /** 게시판 명 */
    private String bbsNm = "";
    
    /** 모바일검색여부*/
    private String isMobile = "";
    
    /** 공지여부*/
    private String searchNoticeAt = "N";
    
    /** 기존 첨부땜에 임시로 쓴다.**/
    private String storeImagePath = "";
    
    /**
	 * 카테고리마스터 아이디
	 */
    private String ctgrymasterId = "";
    
    /** 평가점수**/
    private int scoreSum = 0;
    
    /**
	 * 대상 아이디
	 */
    private String trgetId = "";
    
    /**
	 * 검색 처리상태
	 */
    private String searchSttus = "";
    
    /**
	 * 등록-액션
	 */
    private String registAction = "";
    
    /**
	 * 임시첨부파일 그룹아이디
	 */
    private String fileGroupId = "";
    
    /** 이전 게시물번호 */
    private java.math.BigDecimal oldNttNo;
    
    /**
	 * 템플릿 import여부
	 */
    private String tmplatImportAt = "";
    
    public String getSearchAuth() {
		return searchAuth;
	}

	public void setSearchAuth(String searchAuth) {
		this.searchAuth = searchAuth;
	}

	public int getScoreSum() {
		return scoreSum;
	}

	public void setScoreSum(int scoreSum) {
		this.scoreSum = scoreSum;
	}

	public String getStoreImagePath() {
		return storeImagePath;
	}

	public void setStoreImagePath(String storeImagePath) {
		this.storeImagePath = storeImagePath;
	}

	public String getSearchNoticeAt() {
		return searchNoticeAt;
	}

	public void setSearchNoticeAt(String searchNoticeAt) {
		this.searchNoticeAt = searchNoticeAt;
	}

	public String getFileGroupId() {
		return fileGroupId;
	}

	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}

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
    
    public List<String> getSearchCateList() {    	
		return searchCateList;
	}

	public void setSearchCateList(List<String> searchCateList) {
		if(searchCateList != null) {
			List<String> list = new ArrayList<String>();
    		for(int i=0; i < searchCateList.size(); i++) {    			
    			if(!EgovStringUtil.isEmpty(searchCateList.get(i))) {
    				list.add(searchCateList.get(i));
    			}
    		}    		
    		this.searchCateList = list;
    	}
	}

	
	public List<String> getNttNoArr() {
		return nttNoArr;
	}

	public void setNttNoArr(List<String> nttNoArr) {
		this.nttNoArr = nttNoArr;
	}

	/**
	 * searchBgnDe attribute를 리턴한다.
	 * @return  the searchBgnDe
	 */
    public String getSearchBgnDe() {
	return searchBgnDe;
    }

    /**
	 * searchBgnDe attribute 값을 설정한다.
	 * @param searchBgnDe  the searchBgnDe to set
	 */
    public void setSearchBgnDe(String searchBgnDe) {
	this.searchBgnDe = searchBgnDe;
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
	 * searchEndDe attribute를 리턴한다.
	 * @return  the searchEndDe
	 */
    public String getSearchEndDe() {
	return searchEndDe;
    }

    /**
	 * searchEndDe attribute 값을 설정한다.
	 * @param searchEndDe  the searchEndDe to set
	 */
    public void setSearchEndDe(String searchEndDe) {
	this.searchEndDe = searchEndDe;
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

    /**
	 * plusCount attribute를 리턴한다.
	 * @return  the plusCount
	 */
    public boolean isPlusCount() {
        return plusCount;
    }

    /**
	 * plusCount attribute 값을 설정한다.
	 * @param plusCount  the plusCount to set
	 */
    public void setPlusCount(boolean plusCount) {
        this.plusCount = plusCount;
    }
    
    /**
	 * menuId attribute를 리턴한다.
	 * @return  the menuId
	 */
    public String getMenuId() {
	return menuId;
    }

    /**
	 * menuId attribute 값을 설정한다.
	 * @param menuId  the menuId to set
	 */
    public void setMenuId(String menuId) {
	this.menuId = menuId;
    }
    
    /**
	 * siteId attribute를 리턴한다.
	 * @return  the siteId
	 */
    public String getSiteId() {
        return siteId;
    }
    
    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }
    
    public String getSysTyCode() {
		return sysTyCode;
	}

	public void setSysTyCode(String sysTyCode) {
		this.sysTyCode = sysTyCode;
	}

	public String getSiteNm() {
		return siteNm;
	}

	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}

	public String getSiteUrl() {
		return siteUrl;
	}

	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}

	public String getCmmntyAdres() {
		return cmmntyAdres;
	}

	public void setCmmntyAdres(String cmmntyAdres) {
		this.cmmntyAdres = cmmntyAdres;
	}

	public String getCmmntyNm() {
		return cmmntyNm;
	}

	public void setCmmntyNm(String cmmntyNm) {
		this.cmmntyNm = cmmntyNm;
	}

	/**
	 * adminAt attribute를 리턴한다.
	 * @return  the adminAt
	 */
    public String getAdminAt() {
        return adminAt;
    }
    
    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setAdminAt(String adminAt) {
        this.adminAt = adminAt;
    }
    
    public String getIsExpired() {
        return isExpired;
    }
    
    public void setIsExpired(String isExpired) {
        this.isExpired = isExpired;
    }
    
    public String getCommentCount() {
        return commentCount;
    }
    
    public void setCommentCount(String commentCount) {
        this.commentCount = commentCount;
    }
    
    /**
	 * fileList를 리턴한다.
	 * @return  the fileList
	 */
    public List<FileVO> getFileList() throws Exception {
    	return fileList;
    }
    
    /**
	 * fileList를 설정한다.
	 * @param fileList  the fileList to set
	 */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }
    
    
    public String getCommentUseAt() {
        return commentUseAt;
    }
    
    public void setCommentUseAt(String commentUseAt) {
        this.commentUseAt = commentUseAt;
    }
    
    public String getTmplatId() {
        return tmplatId;
    }
    
    public void setTmplatId(String tmplatId) {
        this.tmplatId = tmplatId;
    }
    
    public String getBbsAttrbCode() {
        return bbsAttrbCode;
    }
    
    public void setBbsAttrbCode(String bbsAttrbCode) {
        this.bbsAttrbCode = bbsAttrbCode;
    }
    
    /**
     * bbsNm attribute를 리턴한다.
     * 
     * @return the bbsNm
     */
    public String getBbsNm() {
	return bbsNm;
    }

    /**
     * bbsNm attribute 값을 설정한다.
     * 
     * @param bbsNm
     *            the bbsNm to set
     */
    public void setBbsNm(String bbsNm) {
	this.bbsNm = bbsNm;
    }
        
    public String getIsMobile() {
        return isMobile;
    }
    
    public void setIsMobile(String isMobile) {
        this.isMobile = isMobile;
    }
    
    public String getCtgrymasterId() {
		return ctgrymasterId;
	}

	public void setCtgrymasterId(String ctgrymasterId) {
		this.ctgrymasterId = ctgrymasterId;
	}

	
	public String getTrgetId() {
		return trgetId;
	}

	public void setTrgetId(String trgetId) {
		this.trgetId = trgetId;
	}


	public String getSearchSttus() {
		return searchSttus;
	}

	public void setSearchSttus(String searchSttus) {
		this.searchSttus = searchSttus;
	}

	public String getRegistAction() {
		return registAction;
	}

	public void setRegistAction(String registAction) {
		this.registAction = registAction;
	}

	public java.math.BigDecimal getOldNttNo() {
		return oldNttNo;
	}

	public void setOldNttNo(java.math.BigDecimal oldNttNo) {
		this.oldNttNo = oldNttNo;
	}

	public String getTmplatImportAt() {
		return tmplatImportAt;
	}

	public void setTmplatImportAt(String tmplatImportAt) {
		this.tmplatImportAt = tmplatImportAt;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
