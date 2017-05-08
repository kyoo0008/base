package egovframework.com.uss.umt.service;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;


/******************************************************
 * @Class Name : UserDefaultVO.java
 * @Program name : egovframework.com.uss.umt.service
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 7. 25.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 7. 25.        이호영             first generated
*********************************************************/
@SuppressWarnings("serial")
public class UserDefaultVO implements Serializable {

	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 검색 권한조건 */
    private String searchSe = "";
    
    /** 연관,일치 검색조건 */
    private String searchCnd = "";
    
    /** 이동할페이지 */
    private String trgtPge = "";
    
    /** 수신여부 */
    private String recptnAt = "";
    
    /** 수신전화번호 */
    private String trnTel = "";
    
    /** 메세지 */
    private String trnMsg = "";
    
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
    
    /** targetId */
    private String targetId = "";
    
    
        
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
    
    public String getSearchSe() {
        return searchSe;
    }

    public void setSearchSe(String searchSe) {
        this.searchSe = searchSe;
    }

    public String getSearchCnd() {
        return searchCnd;
    }

    public void setSearchCnd(String searchCnd) {
        this.searchCnd = searchCnd;
    }
    
    public String getTrgtPge() {
        return trgtPge;
    }

    public void setTrgtPge(String trgtPge) {
        this.trgtPge = trgtPge;
    }
    
    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public String getRecptnAt() {
        return recptnAt;
    }

    public void setRecptnAt(String recptnAt) {
        this.recptnAt = recptnAt;
    }
    
    public String getTrnTel() {
        return trnTel;
    }

    public void setTrnTel(String trnTel) {
        this.trnTel = trnTel;
    }
    
    public String getTrnMsg() {
        return trnMsg;
    }

    public void setTrnMsg(String trnMsg) {
        this.trnMsg = trnMsg;
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

    public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
