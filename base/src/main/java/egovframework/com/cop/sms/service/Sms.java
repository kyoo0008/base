package egovframework.com.cop.sms.service;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 문자메시지 서비스 데이터 처리 모델
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.18  한성곤          최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class Sms implements Serializable {
		
    /**
	 * 문자메시지 ID
	 */
    private String smsId = "";
    
    /**
	 * 전송 전화번호
	 */
    private String trnsmitTelno = "";
    
    /**
	 * 수신 전화번호
	 */
    private String recptnTelnoSingle = "";
    
    /**
	 * 전송 내용
	 */
    private String trnsmitCn = "";
    
    /**
	 * 수신 전화번호 개수
	 */
    private int recptnCnt = 0;
    
    /**
	 * 유일 아이디
	 */
    private String uniqId = "";
    
    /**
	 * 최초등록자 아이디
	 */
    private String frstRegisterId = "";
    
    /**
	 * 최초 등록자명
	 */
    private String frstRegisterNm = "";
    
    /**
	 * 최초등록시점
	 */
    private String frstRegisterPnttm = "";
    
    /**
	 * 수신 정보 List
	 */
    private List<SmsRecptn> recptn = null;
    
    /**
	 * 수전 전화번호 배열
	 */
    private List<String> recptnTelno = null;

    /**예약여부*/
    private String reservationAt = "N";
    
    /**MMS제목*/
    private String subject = null;
    
    /**
	 * 관리자여부
	 */
    private String adminAt = "N";
    
    public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public int getFileCnt() {
		return fileCnt;
	}

	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	/**첨부파일 갯수*/
    private int fileCnt = 1;
    
    /**첨부파일 경로*/
    private String filePath = null;
    
    
    /**
     * 예약일자
     * 포맷 : 2010-05-30 10:15:20
    */
    private String reservationDateString = null;
    
    public String getReservationDateString() {
		return reservationDateString;
	}

	public void setReservationDateString(String reservationDateString) {
		this.reservationDateString = reservationDateString;
	}

	public String getReservationAt() {
		return reservationAt;
	}

	public void setReservationAt(String reservationAt) {
		this.reservationAt = reservationAt;
	}

	/**
	 * smsId attribute를 리턴한다.
	 * @return  the smsId
	 */
    public String getSmsId() {
        return smsId;
    }

    /**
	 * smsId attribute 값을 설정한다.
	 * @param smsId  the smsId to set
	 */
    public void setSmsId(String smsId) {
        this.smsId = smsId;
    }

    /**
	 * trnsmitTelno attribute를 리턴한다.
	 * @return  the trnsmitTelno
	 */
    public String getTrnsmitTelno() {
        return trnsmitTelno;
    }

    /**
	 * trnsmitTelno attribute 값을 설정한다.
	 * @param trnsmitTelno  the trnsmitTelno to set
	 */
    public void setTrnsmitTelno(String trnsmitTelno) {
        this.trnsmitTelno = trnsmitTelno;
    }

    /**
	 * trnsmitCn attribute를 리턴한다.
	 * @return  the trnsmitCn
	 */
    public String getTrnsmitCn() {
        return trnsmitCn;
    }

    /**
	 * trnsmitCn attribute 값을 설정한다.
	 * @param trnsmitCn  the trnsmitCn to set
	 */
    public void setTrnsmitCn(String trnsmitCn) {
        this.trnsmitCn = trnsmitCn;
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
     * recptn attribute를 리턴한다.
     * @return the recptn
     */
    public List<SmsRecptn> getRecptn() {
        return recptn;
    }

    /**
     * recptn attribute 값을 설정한다.
     * @param recptn the recptn to set
     */
    public void setRecptn(List<SmsRecptn> recptn) {
        this.recptn = recptn;
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
	 * recptnCnt attribute를 리턴한다.
	 * @return  the recptnCnt
	 */
    public int getRecptnCnt() {
        return recptnCnt;
    }

    /**
	 * recptnCnt attribute 값을 설정한다.
	 * @param recptnCnt  the recptnCnt to set
	 */
    public void setRecptnCnt(int recptnCnt) {
        this.recptnCnt = recptnCnt;
    }

    /**
	 * recptnTelno attribute를 리턴한다.
	 * @return  the recptnTelno
	 */
    public List<String> getRecptnTelno() {
        return recptnTelno;
    }

    /**
	 * recptnTelno attribute 값을 설정한다.
	 * @param recptnTelno  the recptnTelno to set
	 */
    public void setRecptnTelno(List<String> recptnTelno) {
        this.recptnTelno = recptnTelno;
    }
    
    /**
	 * recptnTelnoSingle attribute를 리턴한다.
	 * @return  the recptnTelnoSingle
	 */
    public String getRecptnTelnoSingle() {
        return recptnTelnoSingle;
    }
    
    /**
	 * recptnTelnoSingle attribute 값을 설정한다.
	 * @param recptnTelnoSingle  the recptnTelnoSingle to set
	 */
    public void setRecptnTelnoSingle(String recptnTelnoSingle) {
        this.recptnTelnoSingle = recptnTelnoSingle;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
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
}
