package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.Factory;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.com.sym.sit.service.SiteMainContentsManageVO;

/**
 *  게시판 속성정보를 담기위한 엔티티 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.12  이삼섭          최초 생성
 *   2009.06.26  한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class BoardMaster implements Serializable {
    
    /**
	 * 게시판 속성코드
	 */
    private String bbsAttrbCode = "BBSA03";
    
    /**
	 * 게시판 아이디
	 */
    private String bbsId = "";
        
    /**
	 * 게시판 명
	 */
    private String bbsNm = "";
    
    /**
	 * 게시판 서비스여부
	 */
    private String svcAt = "Y";
    
    /**
	 * 파일첨부가능여부
	 */
    private String fileAtchPosblAt = "Y";
    
    /**
	 * 최초등록자 아이디
	 */
    private String frstRegisterId = "";
    
    /**
	 * 최초등록시점
	 */
    private String frstRegisterPnttm = "";
    
    /**
	 * 최종수정자 아이디
	 */
    public String lastUpdusrId = "";
    
    /**
	 * 최종수정시점
	 */
    private String lastUpdusrPnttm = "";
    
    /**
	 * 첨부가능파일숫자
	 */
    private String posblAtchFileNumber = "5";
    
    /**
	 * 첨부가능파일사이즈
	 */
    private String posblAtchFileSize = "10";
    
    /**
	 * 답장가능여부
	 */
    private String replyPosblAt = "N";
    
    /**
	 * 소스 아이디
	 */
    private String sourcId = "BBSSRC_0000000000001";
    
    /**
	 * 템플릿 아이디
	 */
    private String tmplatId = "BBSTMP_0000000000001";
    
    /**
	 * 사용여부
	 */
    private String useAt = "Y";
    
    /**
	 * 사용플래그
	 */
    private String bbsUseFlag = "";
    
    /**
	 * 대상 아이디
	 */
    private String trgetId = "SYSTEM_DEFAULT_BOARD";
    
    /**
	 * 등록구분코드
	 */
    private String registSeCode = "REGC01";
    
    /**
	 * 유일 아이디
	 */
    private String uniqId = "";
    
    /**
	 * 댓글 여부
	 */
    private String commentUseAt = "N";
    
    /**
	 * 만족도조사
	 */
    private String stsfdgAt = "";
    
    /**
	 * 시스템구분
	 */ 
    private String sysTyCode = "";
    
    /**
	 * siteId
	 */
    private String siteId = "";
    
    /**
	 * 카테고리마스터 아이디
	 */
    private String ctgrymasterId = "";
    
    /**
	 * 삭제여부
	 */
    private String  deleteAt= "N";
    
    /**
	 * 공개/비공개 사용여부
	 */
    private String  othbcUseAt= "N";
    
    /**
	 * 보기권한
	 */
    private String  inqireAuthor = "01";
    
    /**
	 * 쓰기권한
	 */
    private String  registAuthor = "02";
    
    /**
	 * 답글권한
	 */
    private String  answerAuthor = "02";
    
    /**
	 * 메뉴 정보
	 */
    private String menuId = "";
    
    /** 카테고리리스트 */
    @SuppressWarnings("unchecked")
    private List<Ctgry> ctgryList = ListUtils.lazyList(new ArrayList<Ctgry>(), new Factory() {
    	public Ctgry create() {
    		return new Ctgry();
    	}
    });
            
    /**
	 * bbsAttrbCode attribute를 리턴한다.
	 * @return  the bbsAttrbCode
	 */
    public String getBbsAttrbCode() {
	return bbsAttrbCode;
    }

    /**
	 * bbsAttrbCode attribute 값을 설정한다.
	 * @param bbsAttrbCode  the bbsAttrbCode to set
	 */
    public void setBbsAttrbCode(String bbsAttrbCode) {
	this.bbsAttrbCode = bbsAttrbCode;
    }

    /**
	 * bbsId attribute를 리턴한다.
	 * @return  the bbsId
	 */
    public String getBbsId() {
	return bbsId;
    }

    /**
	 * bbsId attribute 값을 설정한다.
	 * @param bbsId  the bbsId to set
	 */
    public void setBbsId(String bbsId) {
	this.bbsId = bbsId;
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

    /**
	 * bbsNm attribute를 리턴한다.
	 * @return  the bbsNm
	 */
    public String getBbsNm() {
	return bbsNm;
    }

    /**
	 * bbsNm attribute 값을 설정한다.
	 * @param bbsNm  the bbsNm to set
	 */
    public void setBbsNm(String bbsNm) {
	this.bbsNm = bbsNm;
    }

    /**
	 * svcAt attribute를 리턴한다.
	 * @return  the svcAt
	 */
    public String getSvcAt() {
	return svcAt;
    }

    /**
	 * svcAt attribute 값을 설정한다.
	 * @param svcAt  the svcAt to set
	 */
    public void setSvcAt(String svcAt) {
	this.svcAt = svcAt;
    }
    
    /**
	 * fileAtchPosblAt attribute를 리턴한다.
	 * @return  the fileAtchPosblAt
	 */
    public String getFileAtchPosblAt() {
	return fileAtchPosblAt;
    }

    /**
	 * fileAtchPosblAt attribute 값을 설정한다.
	 * @param fileAtchPosblAt  the fileAtchPosblAt to set
	 */
    public void setFileAtchPosblAt(String fileAtchPosblAt) {
	this.fileAtchPosblAt = fileAtchPosblAt;
    }

    /**
	 * frstRegisterId attribute를 리턴한다.
	 * @return  the frstRegisterId
	 */
    public String getFrstRegisterId() {
	return frstRegisterId;
    }

    /**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId  the frstRegisterId to set
	 */
    public void setFrstRegisterId(String frstRegisterId) {
	this.frstRegisterId = frstRegisterId;
    }

    /**
	 * frstRegisterPnttm attribute를 리턴한다.
	 * @return  the frstRegisterPnttm
	 */
    public String getFrstRegisterPnttm() {
	return frstRegisterPnttm;
    }

    /**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm  the frstRegisterPnttm to set
	 */
    public void setFrstRegisterPnttm(String frstRegisterPnttm) {
	this.frstRegisterPnttm = frstRegisterPnttm;
    }

    /**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return  the lastUpdusrId
	 */
    public String getLastUpdusrId() {
	return lastUpdusrId;
    }

    /**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId  the lastUpdusrId to set
	 */
    public void setLastUpdusrId(String lastUpdusrId) {
	this.lastUpdusrId = lastUpdusrId;
    }

    /**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return  the lastUpdusrPnttm
	 */
    public String getLastUpdusrPnttm() {
	return lastUpdusrPnttm;
    }

    /**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm  the lastUpdusrPnttm to set
	 */
    public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
	this.lastUpdusrPnttm = lastUpdusrPnttm;
    }

    /**
	 * posblAtchFileNumber attribute를 리턴한다.
	 * @return  the posblAtchFileNumber
	 */
    public String getPosblAtchFileNumber() {
	return posblAtchFileNumber;
    }

    /**
	 * posblAtchFileNumber attribute 값을 설정한다.
	 * @param posblAtchFileNumber  the posblAtchFileNumber to set
	 */
    public void setPosblAtchFileNumber(String posblAtchFileNumber) {
	this.posblAtchFileNumber = posblAtchFileNumber;
    }

    /**
	 * posblAtchFileSize attribute를 리턴한다.
	 * @return  the posblAtchFileSize
	 */
    public String getPosblAtchFileSize() {
	return posblAtchFileSize;
    }

    /**
	 * posblAtchFileSize attribute 값을 설정한다.
	 * @param posblAtchFileSize  the posblAtchFileSize to set
	 */
    public void setPosblAtchFileSize(String posblAtchFileSize) {
	this.posblAtchFileSize = posblAtchFileSize;
    }

    /**
	 * replyPosblAt attribute를 리턴한다.
	 * @return  the replyPosblAt
	 */
    public String getReplyPosblAt() {
	return replyPosblAt;
    }

    /**
	 * replyPosblAt attribute 값을 설정한다.
	 * @param replyPosblAt  the replyPosblAt to set
	 */
    public void setReplyPosblAt(String replyPosblAt) {
	this.replyPosblAt = replyPosblAt;
    }

    public String getSourcId() {
		return sourcId;
	}

	public void setSourcId(String sourcId) {
		this.sourcId = sourcId;
	}

	/**
	 * tmplatId attribute를 리턴한다.
	 * @return  the tmplatId
	 */
    public String getTmplatId() {
	return tmplatId;
    }

    /**
	 * tmplatId attribute 값을 설정한다.
	 * @param tmplatId  the tmplatId to set
	 */
    public void setTmplatId(String tmplatId) {
	this.tmplatId = tmplatId;
    }


	/**
	 * useAt attribute를 리턴한다.
	 * @return  the useAt
	 */
    public String getUseAt() {
	return useAt;
    }

    /**
	 * useAt attribute 값을 설정한다.
	 * @param useAt  the useAt to set
	 */
    public void setUseAt(String useAt) {
	this.useAt = useAt;
    }

    /**
	 * bbsUseFlag attribute를 리턴한다.
	 * @return  the bbsUseFlag
	 */
    public String getBbsUseFlag() {
	return bbsUseFlag;
    }

    /**
	 * bbsUseFlag attribute 값을 설정한다.
	 * @param bbsUseFlag  the bbsUseFlag to set
	 */
    public void setBbsUseFlag(String bbsUseFlag) {
	this.bbsUseFlag = bbsUseFlag;
    }
    
    /**
	 * trgetId attribute를 리턴한다.
	 * @return  the trgetId
	 */
    public String getTrgetId() {
	return trgetId;
    }

    /**
	 * trgetId attribute 값을 설정한다.
	 * @param trgetId  the trgetId to set
	 */
    public void setTrgetId(String trgetId) {
	this.trgetId = trgetId;
    }

    /**
	 * registSeCode attribute를 리턴한다.
	 * @return  the registSeCode
	 */
    public String getRegistSeCode() {
	return registSeCode;
    }

    /**
	 * registSeCode attribute 값을 설정한다.
	 * @param registSeCode  the registSeCode to set
	 */
    public void setRegistSeCode(String registSeCode) {
	this.registSeCode = registSeCode;
    }

    /**
	 * uniqId attribute를 리턴한다.
	 * @return  the uniqId
	 */
    public String getUniqId() {
	return uniqId;
    }

    /**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId  the uniqId to set
	 */
    public void setUniqId(String uniqId) {
	this.uniqId = uniqId;
    }

    /**
	 * commentUseAt attribute를 리턴한다.
	 * @return  the commentUseAt
	 */
    public String getCommentUseAt() {
        return commentUseAt;
    }

    /**
	 * commentUseAt attribute 값을 설정한다.
	 * @param commentUseAt  the commentUseAt to set
	 */
    public void setCommentUseAt(String commentUseAt) {
        this.commentUseAt = commentUseAt;
    }

    /**
	 * stsfdgAt attribute를 리턴한다.
	 * @return  the stsfdgAt
	 */
    public String getStsfdgAt() {
        return stsfdgAt;
    }

    /**
	 * stsfdg attribute 값을 설정한다.
	 * @param stsfdgAt  the stsfdgAt to set
	 */
    public void setStsfdgAt(String stsfdgAt) {
        this.stsfdgAt = stsfdgAt;
    }

    /**
	 * 시스템구분코드를 리턴한다.
	 * @return  the sysTyCode
	 */
    public String getSysTyCode() {
        return sysTyCode;
    }

    /**
	 * 시스템구분코드 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 */
    public void setSysTyCode(String sysTyCode) {
        this.sysTyCode = sysTyCode;
    }
    
    /**
	 * 카테고리 마스터아이디를 리턴한다.
	 * @return  the ctgrymasterId
	 */
    public String getCtgrymasterId() {
        return ctgrymasterId;
    }

    /**
	 * 카테고리 마스터아이디를 설정한다.
	 * @param ctgrymasterId  the ctgrymasterId to set
	 */
    public void setCtgrymasterId(String ctgrymasterId) {
        this.ctgrymasterId = ctgrymasterId;
    }
    
    /**
	 * 삭제여부를 리턴한다.
	 * @return  the deleteAt
	 */
    public String getDeleteAt() {
        return deleteAt;
    }

    /**
	 * 삭제여부 값을 설정한다.
	 * @param deleteAt  the deleteAt to set
	 */
    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }
    
    /**
	 * 공개/비공개 사용여부를 리턴한다.
	 * @return  the othbcUseAt
	 */
    public String getOthbcUseAt() {
        return othbcUseAt;
    }

    /**
	 * 공개/비공개 사용여부를 설정한다.
	 * @param othbcUseAt  the othbcUseAt to set
	 */
    public void setOthbcUseAt(String othbcUseAt) {
        this.othbcUseAt = othbcUseAt;
    }
    
    
    public String getInqireAuthor() {
		return inqireAuthor;
	}

	public void setInqireAuthor(String inqireAuthor) {
		this.inqireAuthor = inqireAuthor;
	}

	public String getRegistAuthor() {
		return registAuthor;
	}

	public void setRegistAuthor(String registAuthor) {
		this.registAuthor = registAuthor;
	}

	public String getAnswerAuthor() {
		return answerAuthor;
	}

	public void setAnswerAuthor(String answerAuthor) {
		this.answerAuthor = answerAuthor;
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
    
	public List<Ctgry> getCtgryList() {
		return ctgryList;
	}

	public void setCtgryList(List<Ctgry> ctgryList) {
		this.ctgryList = ctgryList;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
