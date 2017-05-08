package egovframework.com.cop.bbs.service;

import java.io.Serializable;
import java.math.BigDecimal;

import net.sf.json.JSONObject;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : Board.java
 * @Description : 게시물에 대한 데이터 처리 모델
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 */
public class Board implements Serializable {

private static final long serialVersionUID = 1L;
    
    /** NTT_NO */
    private java.math.BigDecimal nttNo;
    
    /** BBS_ID */
    private java.lang.String bbsId;
    
    /** CTGRY_ID */
    private java.lang.String ctgryId;
    
    /** CTGRY_NM */
    private java.lang.String ctgryNm;
    
    /** ATCH_FILE_ID */
    private java.lang.String atchFileId;
    
    /** NTT_SJ */
    private java.lang.String nttSj;
    
    /** NTT_CN */
    private java.lang.String nttCn;
        
    /** NTCR_NM */
    private java.lang.String ntcrNm;
    
    /** INQIRE_CO */
    private java.math.BigDecimal inqireCo = BigDecimal.ZERO;
    
    /** RECOMEND_CO */
    private java.math.BigDecimal recomendCo = BigDecimal.ZERO;
    
    /** CREAT_IP */
    private java.lang.String creatIp;
    
    /** NOTICE_AT */
    private java.lang.String noticeAt = "N";
    
    /** OTHBC_AT */
    private java.lang.String othbcAt = "Y";
    
    /** USE_AT */
    private java.lang.String useAt = "Y";
    
    /** TMP_01 */
    private java.lang.String tmp01;
    
    /** TMP_02 */
    private java.lang.String tmp02;
    
    /** TMP_03 */
    private java.lang.String tmp03;
      
    /** 상위게시글번호 */
    private java.lang.Integer upperNttNo = 0;
    
    /** FRST_REGISTER_PNTTM */
    private java.util.Date frstRegisterPnttm;
    
    /** FRST_REGISTER_ID */
    private java.lang.String frstRegisterId;
    
    /** LAST_UPDUSR_PNTTM */
    private java.util.Date lastUpdusrPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId;
    
    private java.lang.String genOrdrCode;
    
    /** 카테고리경로 - ID */
    private java.lang.String ctgryPathById;
    
    /** 처리상태코드 */
    private java.lang.String processSttusCode;
    
    /** 처리상태명 */
    private java.lang.String processSttusNm;
    
    /** 확장첨부파일 - ID*/
    private java.lang.String estnAtchFileId;
    
    /** 확장데이터*/
    private java.lang.String estnData;
    
    /** 확장파싱데이터*/
    private JSONObject estnParseData;
    
    
    /** LAST_ANSWRR_PNTTM */
    private java.util.Date lastAnswrrPnttm;
    
    /** LAST_ANSWRR_ID */
    private java.lang.String lastAnswrrId;
    
    /** LAST_ANSWRR_NM */
    private java.lang.String lastAnswrrNm;
    
    /** 파일명*/
    private String atchFileNm;
    
    private int ordrCodeDp = 0;
    
    public java.lang.String getCtgryPathById() {
		return ctgryPathById;
	}

	public void setCtgryPathById(java.lang.String ctgryPathById) {
		this.ctgryPathById = ctgryPathById;
	}

	public java.lang.String getGenOrdrCode() {
		return genOrdrCode;
	}

	public void setGenOrdrCode(java.lang.String genOrdrCode) {
		this.genOrdrCode = genOrdrCode;
	}

	public java.math.BigDecimal getNttNo() {
        return this.nttNo;
    }
    
    public void setNttNo(java.math.BigDecimal nttNo) {
        this.nttNo = nttNo;
    }
    
    public java.lang.String getBbsId() {
        return this.bbsId;
    }
    
    public void setBbsId(java.lang.String bbsId) {
        this.bbsId = bbsId;
    }
    
    public java.lang.String getCtgryId() {
		return ctgryId;
	}

	public void setCtgryId(java.lang.String ctgryId) {
		this.ctgryId = ctgryId;
	}

	public java.lang.String getCtgryNm() {
        return this.ctgryNm;
    }
    
    public void setCtgryNm(java.lang.String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }
    
    public java.lang.String getAtchFileId() {
        return this.atchFileId;
    }
    
    public void setAtchFileId(java.lang.String atchFileId) {
        this.atchFileId = atchFileId;
    }
    
    public java.lang.String getNttSj() {
        return this.nttSj;
    }
    
    public void setNttSj(java.lang.String nttSj) {
        this.nttSj = nttSj;
    }
    
    public java.lang.String getNttCn() {
        return this.nttCn;
    }
    
    public void setNttCn(java.lang.String nttCn) {
        this.nttCn = nttCn;
    }
        
    public java.lang.String getNtcrNm() {
        return this.ntcrNm;
    }
    
    public void setNtcrNm(java.lang.String ntcrNm) {
        this.ntcrNm = ntcrNm;
    }
        
    public java.math.BigDecimal getInqireCo() {
        return this.inqireCo;
    }
    
    public void setInqireCo(java.math.BigDecimal inqireCo) {
        this.inqireCo = inqireCo;
    }
    
    public java.math.BigDecimal getRecomendCo() {
        return this.recomendCo;
    }
    
    public void setRecomendCo(java.math.BigDecimal recomendCo) {
        this.recomendCo = recomendCo;
    }
    
    public java.lang.String getCreatIp() {
        return this.creatIp;
    }
    
    public void setCreatIp(java.lang.String creatIp) {
        this.creatIp = creatIp;
    }
    
    public java.lang.String getNoticeAt() {
        return this.noticeAt;
    }
    
    public void setNoticeAt(java.lang.String noticeAt) {
        this.noticeAt = noticeAt;
    }
    
    public java.lang.String getOthbcAt() {
        return this.othbcAt;
    }
    
    public void setOthbcAt(java.lang.String othbcAt) {
        this.othbcAt = othbcAt;
    }
    
    public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }
    
    public java.lang.String getTmp01() {
		return tmp01;
	}

	public void setTmp01(java.lang.String tmp01) {
		this.tmp01 = tmp01;
	}

	public java.lang.String getTmp02() {
		return tmp02;
	}

	public void setTmp02(java.lang.String tmp02) {
		this.tmp02 = tmp02;
	}

	public java.lang.String getTmp03() {
		return tmp03;
	}

	public void setTmp03(java.lang.String tmp03) {
		this.tmp03 = tmp03;
	}

    public java.lang.Integer getUpperNttNo() {
		return upperNttNo;
	}

	public void setUpperNttNo(java.lang.Integer upperNttNo) {
		this.upperNttNo = upperNttNo;
	}

	public java.util.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.lang.String getFrstRegisterId() {
        return this.frstRegisterId;
    }
    
    public void setFrstRegisterId(java.lang.String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }
    
    public java.util.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }

    
	public java.lang.String getProcessSttusCode() {
		return processSttusCode;
	}

	public void setProcessSttusCode(java.lang.String processSttusCode) {
		this.processSttusCode = processSttusCode;
	}

	public java.lang.String getProcessSttusNm() {
		return processSttusNm;
	}

	public void setProcessSttusNm(java.lang.String processSttusNm) {
		this.processSttusNm = processSttusNm;
	}

	public java.lang.String getEstnAtchFileId() {
		return estnAtchFileId;
	}

	public void setEstnAtchFileId(java.lang.String estnAtchFileId) {
		this.estnAtchFileId = estnAtchFileId;
	}

	public java.lang.String getEstnData() {
		return estnData;
	}

	public void setEstnData(java.lang.String estnData) {
		this.estnData = estnData;
	}

	public java.util.Date getLastAnswrrPnttm() {
		return lastAnswrrPnttm;
	}

	public void setLastAnswrrPnttm(java.util.Date lastAnswrrPnttm) {
		this.lastAnswrrPnttm = lastAnswrrPnttm;
	}

	public java.lang.String getLastAnswrrId() {
		return lastAnswrrId;
	}

	public void setLastAnswrrId(java.lang.String lastAnswrrId) {
		this.lastAnswrrId = lastAnswrrId;
	}

	public java.lang.String getLastAnswrrNm() {
		return lastAnswrrNm;
	}

	public void setLastAnswrrNm(java.lang.String lastAnswrrNm) {
		this.lastAnswrrNm = lastAnswrrNm;
	}

	public String getAtchFileNm() {
		return atchFileNm;
	}

	public void setAtchFileNm(String atchFileNm) {
		this.atchFileNm = atchFileNm;
	}

	public int getOrdrCodeDp() {
		return ordrCodeDp;
	}

	public void setOrdrCodeDp(int ordrCodeDp) {
		this.ordrCodeDp = ordrCodeDp;
	}

	public JSONObject getEstnParseData() {
		if(estnParseData == null) {
			estnParseData = JSONObject.fromObject(this.estnData);
			if(estnParseData.isNullObject()) {
				estnParseData = new JSONObject();
				estnParseData.put("empty", "empty");
			}
		}
		return estnParseData;
	}

	public void setEstnParseData(JSONObject estnParseData) {
		this.estnParseData = estnParseData;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
