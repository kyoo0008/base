package egovframework.com.cop.cmy.service;

import java.io.Serializable;
import java.util.List;

import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;

/******************************************************
 * @Class Name : CommunityMnu.java
 * @Program name : egovframework.com.cop.cmy.service
 * @Descriptopn : 커뮤니티 메뉴정보 VO
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
public class CommunityMnu extends BoardMasterVO implements Serializable {
    
    /** CMMNTY_ID */
    private java.lang.String cmmntyId;

    
    /** MAIN_OUTPT_AT */
    private java.lang.String mainOutptAt = "N";
    
    /** SORT_ORDR */
    private int sortOrdr = 1;
    
    /** NOTIFY_AT */
    private java.lang.String notifyAt = "N";    
    
    /** 정렬순서코드  - U:위로, D:아래로 */
    private String sortTyCode = "";

    /** 사용자 아이디 */
    private String emplyrId = "";

    /** 게시물 */
    private List<BoardVO> ariticleList;
	
    public java.lang.String getCmmntyId() {
        return this.cmmntyId;
    }
    
    public void setCmmntyId(java.lang.String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }

    
    public java.lang.String getMainOutptAt() {
        return this.mainOutptAt;
    }
    
    public void setMainOutptAt(java.lang.String mainOutptAt) {
        this.mainOutptAt = mainOutptAt;
    }
    
    public int getSortOrdr() {
        return this.sortOrdr;
    }
    
    public void setSortOrdr(int sortOrdr) {
        this.sortOrdr = sortOrdr;
    }

    public String getEmplyrId() {
	return emplyrId;
    }

    public java.lang.String getNotifyAt() {
		return notifyAt;
	}

	public void setNotifyAt(java.lang.String notifyAt) {
		this.notifyAt = notifyAt;
	}

	public void setEmplyrId(String emplyrId) {
	this.emplyrId = emplyrId;
    }
    
    public String getSortTyCode() {
		return sortTyCode;
	}

	public void setSortTyCode(String sortTyCode) {
		this.sortTyCode = sortTyCode;
	}

	public List<BoardVO> getAriticleList() {
		return ariticleList;
	}

	public void setAriticleList(List<BoardVO> ariticleList) {
		this.ariticleList = ariticleList;
	}
	
	
}
