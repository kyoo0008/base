package egovframework.com.uss.umt.service;

import java.io.Serializable;
/******************************************************
 * @Class Name : UserManageVO.java
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
public class UserManageVO extends UserDefaultVO implements Serializable {
    
    /** USER_ID */
    private String userId;
    
    /** CREDT_ID */
    private String credtId;
    
    /** USER_SE_CODE */
    private String userSeCode;
    
    /** PASSWORD */
    private String password;
    
    /** PASSWORD RE */
    private String password2;
    
    /** USER_NM */
    private String userNm;
    
    /** EMAIL_ADRES */
    private String emailAdres;
    
    /** TLPHON_NO */
    private String tlphonNo;
    
    /** MOBLPHON_NO */
    private String moblphonNo;
    
    /** ZIP */
    private String zip;
    
    /** ADRES */
    private String adres;
    
    /** ADRES_DETAIL */
    private String adresDetail;
        
    /** DELETE_AT */
    private String deleteAt;
    
    /** DELETE_PNTTM */
    private java.util.Date deletePnttm;
    
    /** BRTHDY */
    private String brthdy;
    
    /** SLRCLD_LRR_CODE */
    private String slrcldLrrCode;
    
    /** SEXDSTN */
    private String sexdstn;
    
    /** EMAIL_RECPTN_AT */
    private String emailRecptnAt;
    
    /** MOBLPHON_RECPTN_AT */
    private String moblphonRecptnAt;
    
    /** PHOTO_ORIGINAL_FILE_NM */
    private String photoOriginalFileNm;
    
    /** PHOTO_STRE_FILE_NM */
    private String photoStreFileNm;
    
    /** FRST_REGIST_PNTTM */
    private java.util.Date frstRegistPnttm;
    
    /** LAST_UPDUSR_PNTTM */
    private java.util.Date lastUpdusrPnttm;
        
    /** LAST_UPDUSR_ID */
    private String lastUpdusrId;
    
    /** CONFM_PNTTM */
    private java.util.Date confmPnttm;
    
    /** CONFM_AT */
    private String confmAt;
    
    /** DELETE_RESN */
    private String deleteResn;
    
    /** USER_IHIDNUM */
    private String userIhidnum;
    
    /** SITE_ID */
    private String siteId;
    
    /** MESSAGE */
    private String message;
    
    /** 일련번호 */
    private int no;
        
    
    /** 집전화 앞번호 */
    private String tel1;
    
    /** 집전화 중간번호 */
    private String tel2;
    
    /** 집전화 끝번호 */
    private String tel3;
    
    /** 휴대전화 앞번호 */
    private String phone1;
    
    /** 휴대전화 중간번호 */
    private String phone2;
    
    /** 휴대전화 끝번호 */
    private String phone3;
    
    /** 이메일 계정 */
    private String email1;
    
    /** 이메일 도메인 */
    private String email2;
    
    /** 코드 이름 */
    private String codeNm;
    
    /** 코드 */
    private String code;

    /** 학년 */
    private String stGrade;
    
    /** 반 */
    private String stClass;
    
    /** 번호 */
    private String stNumber;
    
    /* 학교 코드*/
    private String stCode;
 
    /* 학교구분코드 (초,중,고) */
    private String stTyCodeStaff;
    
    /* 교직원 학교 코드*/
    private String stCodeStaff;
    
    /* 학교구분코드 (초,중,고) */
    private String stTyCode;
    
    /* 학교명 */
    private String stName;
    
    /** 강사 학력 */
    private String lecAcdmcr;
    
    /** 강의 경력 */
    private String lecCareer;
    
    /** 강사 소개 */
    private String lecInfo;
    
    /** 2013.03.11 이재현 
     *  회원권한
     */  
    private String grade;
    
	
    
	public String getLecAcdmcr() {
		return lecAcdmcr;
	}

	public void setLecAcdmcr(String lecAcdmcr) {
		this.lecAcdmcr = lecAcdmcr;
	}

	public String getLecInfo() {
		return lecInfo;
	}

	public void setLecInfo(String lecInfo) {
		this.lecInfo = lecInfo;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getLecCareer() {
		return lecCareer;
	}

	public void setLecCareer(String lecCareer) {
		this.lecCareer = lecCareer;
	}

	public String getStTyCodeStaff() {
		return stTyCodeStaff;
	}

	public void setStTyCodeStaff(String stTyCodeStaff) {
		this.stTyCodeStaff = stTyCodeStaff;
	}

	public String getStCodeStaff() {
		return stCodeStaff;
	}

	public void setStCodeStaff(String stCodeStaff) {
		this.stCodeStaff = stCodeStaff;
	}

	public String getCodeNm() {
		return codeNm;
	}

	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getCredtId() {
        return this.credtId;
    }
    
    public void setCredtId(String credtId) {
        this.credtId = credtId;
    }
        
    public String getUserSeCode() {
		return userSeCode;
	}

	public void setUserSeCode(String userSeCode) {
		this.userSeCode = userSeCode;
	}

	public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPassword2() {
        return this.password2;
    }
    
    public void setPassword2(String password2) {
        this.password2 = password2;
    }
    
    public String getUserNm() {
        return this.userNm;
    }
    
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }
    
    public String getEmailAdres() {
        return this.emailAdres;
    }
    
    public void setEmailAdres(String emailAdres) {
        this.emailAdres = emailAdres;
    }
    
    public String getTlphonNo() {
        return this.tlphonNo;
    }
    
    public void setTlphonNo(String tlphonNo) {
        this.tlphonNo = tlphonNo;
    }
    
    public String getMoblphonNo() {
        return this.moblphonNo;
    }
    
    public void setMoblphonNo(String moblphonNo) {
        this.moblphonNo = moblphonNo;
    }
    
    public String getZip() {
        return this.zip;
    }
    
    public void setZip(String zip) {
        this.zip = zip;
    }
    
    public String getAdres() {
        return this.adres;
    }
    
    public void setAdres(String adres) {
        this.adres = adres;
    }
    
    public String getAdresDetail() {
        return this.adresDetail;
    }
    
    public void setAdresDetail(String adresDetail) {
        this.adresDetail = adresDetail;
    }
    
    public String getDeleteAt() {
        return this.deleteAt;
    }
    
    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }
    
    public java.util.Date getDeletePnttm() {
        return this.deletePnttm;
    }
    
    public void setDeletePnttm(java.util.Date deletePnttm) {
        this.deletePnttm = deletePnttm;
    }
    
    public String getBrthdy() {
        return this.brthdy;
    }
    
    public void setBrthdy(String brthdy) {
        this.brthdy = brthdy;
    }
    
    public String getSlrcldLrrCode() {
		return slrcldLrrCode;
	}

	public void setSlrcldLrrCode(String slrcldLrrCode) {
		this.slrcldLrrCode = slrcldLrrCode;
	}

	public String getSexdstn() {
        return this.sexdstn;
    }
    
    public void setSexdstn(String sexdstn) {
        this.sexdstn = sexdstn;
    }
    
    public String getEmailRecptnAt() {
        return this.emailRecptnAt;
    }
    
    public void setEmailRecptnAt(String emailRecptnAt) {
        this.emailRecptnAt = emailRecptnAt;
    }
    
    public String getMoblphonRecptnAt() {
        return this.moblphonRecptnAt;
    }
    
    public void setMoblphonRecptnAt(String moblphonRecptnAt) {
        this.moblphonRecptnAt = moblphonRecptnAt;
    }
    
    public String getPhotoOriginalFileNm() {
        return this.photoOriginalFileNm;
    }
    
    public void setPhotoOriginalFileNm(String photoOriginalFileNm) {
        this.photoOriginalFileNm = photoOriginalFileNm;
    }
    
    public String getPhotoStreFileNm() {
        return this.photoStreFileNm;
    }
    
    public void setPhotoStreFileNm(String photoStreFileNm) {
        this.photoStreFileNm = photoStreFileNm;
    }
    
    public java.util.Date getFrstRegistPnttm() {
        return this.frstRegistPnttm;
    }
    
    public void setFrstRegistPnttm(java.util.Date frstRegistPnttm) {
        this.frstRegistPnttm = frstRegistPnttm;
    }
    
    public java.util.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
        
    public String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    public java.util.Date getConfmPnttm() {
        return this.confmPnttm;
    }
    
    public void setConfmPnttm(java.util.Date confmPnttm) {
        this.confmPnttm = confmPnttm;
    }
    
    public String getConfmAt() {
        return this.confmAt;
    }
    
    public void setConfmAt(String confmAt) {
        this.confmAt = confmAt;
    }
    
    public String getDeleteResn() {
        return this.deleteResn;
    }
    
    public void setDeleteResn(String deleteResn) {
        this.deleteResn = deleteResn;
    }    
    
    public String getPrtctorNm() {
        return this.userIhidnum;
    }
    
    public void setUserIhidnum(String userIhidnum) {
        this.userIhidnum = userIhidnum;
    }

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStGrade() {
		return stGrade;
	}

	public void setStGrade(String stGrade) {
		this.stGrade = stGrade;
	}

	public String getStClass() {
		return stClass;
	}

	public void setStClass(String stClass) {
		this.stClass = stClass;
	}

	public String getStNumber() {
		return stNumber;
	}

	public void setStNumber(String stNumber) {
		this.stNumber = stNumber;
	}
	
	public String getStCode() {
		return stCode;
	}
	
	public String getStName() {
		return stName;
	}

	public void setStName(String stName) {
		this.stName = stName;
	}

	public void setStCode(String stCode) {
		this.stCode = stCode;
	}

	public String getStTyCode() {
		return stTyCode;
	}

	public void setStTyCode(String stTyCode) {
		this.stTyCode = stTyCode;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}
    
}
