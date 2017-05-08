package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.math.BigDecimal;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 댓글관리 서비스 데이터 처리 모델
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class Comment implements Serializable {
    /**
	 * 댓글번호
	 */
    private java.math.BigDecimal commentNo;
        
    /**
	 * 게시물 번호
	 */
    private BigDecimal nttNo = BigDecimal.ZERO;
        
    /**
	 * 작성자명
	 */
    private String wrterNm = "";
        
    /**
	 * 댓글 내용
	 */
    private String commentCn = "";
    
    /**
	 * 사용 여부
	 */
    private String useAt = "Y";

    /**
	 * 최초등록자 아이디
	 */
    private String frstRegisterId = "";
    
    /**
	 * 최초등록시점
	 */
    private java.util.Date frstRegisterPnttm;
    
    /**
	 * 최종수정자 아이디
	 */
    private String lastUpdusrId = "";
    
    /**
	 * 최종수정시점
	 */
    private java.util.Date lastUpdusrPnttm;
        
    private String ordrCode = "";
    
    private int ordrCodeDp = 0;
    
    private int score = 0;

    private java.lang.String genOrdrCode = "";
    
    
    public String getGenOrdrCode() {
		return genOrdrCode;
	}

	public void setGenOrdrCode(String genOrdrCode) {
		this.genOrdrCode = genOrdrCode;
	}
    /**
	 * commentNo attribute를 리턴한다.
	 * @return  the commentNo
	 */
    public java.math.BigDecimal getCommentNo() {
        return commentNo;
    }

    /**
	 * commentNo attribute 값을 설정한다.
	 * @param commentNo  the commentNo to set
	 */
    public void setCommentNo(java.math.BigDecimal commentNo) {
        this.commentNo = commentNo;
    }

    /**
	 * nttNo attribute를 리턴한다.
	 * @return  the nttNo
	 */
    public BigDecimal getNttNo() {
        return nttNo;
    }

    /**
	 * nttNo attribute 값을 설정한다.
	 * @param nttNo  the nttNo to set
	 */
    public void setNttNo(BigDecimal nttNo) {
        this.nttNo = nttNo;
    }

    /**
	 * wrterNm attribute를 리턴한다.
	 * @return  the wrterNm
	 */
    public String getWrterNm() {
        return wrterNm;
    }

    /**
	 * wrterNm attribute 값을 설정한다.
	 * @param wrterNm  the wrterNm to set
	 */
    public void setWrterNm(String wrterNm) {
        this.wrterNm = wrterNm;
    }

    /**
	 * commentCn attribute를 리턴한다.
	 * @return  the commentCn
	 */
    public String getCommentCn() {
        return commentCn;
    }

    /**
	 * commentCn attribute 값을 설정한다.
	 * @param commentCn  the commentCn to set
	 */
    public void setCommentCn(String commentCn) {
        this.commentCn = commentCn;
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
    public java.util.Date getFrstRegisterPnttm() {
        return frstRegisterPnttm;
    }

    /**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm  the frstRegisterPnttm to set
	 */
    public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
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
    public java.util.Date getLastUpdusrPnttm() {
        return lastUpdusrPnttm;
    }

    /**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm  the lastUpdusrPnttm to set
	 */
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

	public String getOrdrCode() {
		return ordrCode;
	}

	public void setOrdrCode(String ordrCode) {
		this.ordrCode = ordrCode;
	}

	public int getOrdrCodeDp() {
		return ordrCodeDp;
	}

	public void setOrdrCodeDp(int ordrCodeDp) {
		this.ordrCodeDp = ordrCodeDp;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
    
    
}
