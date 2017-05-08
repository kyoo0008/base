package egovframework.com.uat.uia.service;

import java.io.Serializable;

/**
 * @Class Name : LoginVO.java
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *  
 */
@SuppressWarnings("serial")
public class LoginVO implements Serializable {

	/** 아이디 */
	private String id;
	/** 이름 */
	private String name;
	/** 신용정보키 */
	private String ihidNum;
	/** 이메일주소 */
	private String email;
	/** 핸드폰번호 */
	private String mobileNo;
	/** 비밀번호 */
	private String password;
	/** 비밀번호 힌트 */
	private String passwordHint;
	/** 비밀번호 정답 */
	private String passwordCnsr;
	/** 사용자구분코드*/
	private String userSeCode;
	/** 사용자구분*/
	private String userSe;
	/** 사용자유형*/
	private String userTy;
	/** 로그인 후 이동할 페이지 */
	private String url;
	/** 사용자 IP정보 */
	private String ip;
	/** GPKI인증 DN */
	private String dn;
	/** 승인여부 */
	private String confmAt;
	/** 고유아이디 */
	private String uniqId;
	/** 사이트아이디 */
	private String siteId = "";
	/** 사이트명 */
	private String siteNm;
	
	private String findSe;
	
	/** 관리자여부 */
	private String adminAt;
	
	/** 요청도메인 */
	private String reqDomain;
	
	/** SSO토큰 */
	private String ssoToken;
	
	/**
	 * id attribute 를 리턴한다.
	 * @return String
	 */
	public String getId() {
		return id;
	}
	/**
	 * id attribute 값을 설정한다.
	 * @param id String
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * name attribute 를 리턴한다.
	 * @return String
	 */
	public String getName() {
		return name;
	}
	/**
	 * name attribute 값을 설정한다.
	 * @param name String
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * ihidNum attribute 를 리턴한다.
	 * @return String
	 */
	public String getIhidNum() {
		return ihidNum;
	}
	/**
	 * ihidNum attribute 값을 설정한다.
	 * @param ihidNum String
	 */
	public void setIhidNum(String ihidNum) {
		this.ihidNum = ihidNum;
	}
	/**
	 * email attribute 를 리턴한다.
	 * @return String
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * email attribute 값을 설정한다.
	 * @param email String
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * mobileNo attribute 를 리턴한다.
	 * @return String
	 */
	public String getMobileNo() {
		return mobileNo;
	}
	/**
	 * mobileNo attribute 값을 설정한다.
	 * @param mobileNo String
	 */
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	/**
	 * password attribute 를 리턴한다.
	 * @return String
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * password attribute 값을 설정한다.
	 * @param password String
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * passwordHint attribute 를 리턴한다.
	 * @return String
	 */
	public String getPasswordHint() {
		return passwordHint;
	}
	/**
	 * passwordHint attribute 값을 설정한다.
	 * @param passwordHint String
	 */
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	/**
	 * passwordCnsr attribute 를 리턴한다.
	 * @return String
	 */
	public String getPasswordCnsr() {
		return passwordCnsr;
	}
	/**
	 * passwordCnsr attribute 값을 설정한다.
	 * @param passwordCnsr String
	 */
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}
	
	public String getUserSeCode() {
		return userSeCode;
	}
	public void setUserSeCode(String userSeCode) {
		this.userSeCode = userSeCode;
	}
	/**
	 * userSe attribute 를 리턴한다.
	 * @return String
	 */
	public String getUserSe() {
		return userSe;
	}
	/**
	 * userSe attribute 값을 설정한다.
	 * @param userSe String
	 */
	public void setUserSe(String userSe) {
		this.userSe = userSe;
	}
	/**
	 * userTy attribute 를 리턴한다.
	 * @return String
	 */
	public String getUserTy() {
		return userTy;
	}
	/**
	 * userTy attribute 값을 설정한다.
	 * @param userTy String
	 */
	public void setUserTy(String userTy) {
		this.userTy = userTy;
	}
	/**
	 * url attribute 를 리턴한다.
	 * @return String
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * url attribute 값을 설정한다.
	 * @param url String
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * ip attribute 를 리턴한다.
	 * @return String
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * ip attribute 값을 설정한다.
	 * @param ip String
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	/**
	 * dn attribute 를 리턴한다.
	 * @return String
	 */
	public String getDn() {
		return dn;
	}
	/**
	 * dn attribute 값을 설정한다.
	 * @param dn String
	 */
	public void setDn(String dn) {
		this.dn = dn;
	}
	/**
	 * confmAt attribute 를 리턴한다.
	 * @return  String
	 */
	public String getConfmAt() {
		return confmAt;
	}
	/**
	 * confmAt attribute 값을 설정한다.
	 * @param confmAt  String
	 */
	public void setConfmAt(String confmAt) {
		this.confmAt = confmAt;
	}
	/**
	 * uniqId attribute 를 리턴한다.
	 * @return  String
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId  String
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	
	/**
	 * uniqId attribute 를 리턴한다.
	 * @return  String
	 */
	public String getSiteId() {
		return siteId;
	}
	/**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  String
	 */
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	/**
	 * findSe attribute 를 리턴한다.
	 * @return  String
	 */
	public String getFindSe() {
		return findSe;
	}
	/**
	 * findSe attribute 값을 설정한다.
	 * @param findSe  String
	 */
	public void setFindSe(String findSe) {
		this.findSe = findSe;
	}
	public String getAdminAt() {
		return adminAt;
	}
	public void setAdminAt(String adminAt) {
		this.adminAt = adminAt;
	}
	public String getReqDomain() {
		return reqDomain;
	}
	public void setReqDomain(String reqDomain) {
		this.reqDomain = reqDomain;
	}
	public String getSsoToken() {
		return ssoToken;
	}
	public void setSsoToken(String ssoToken) {
		this.ssoToken = ssoToken;
	}
}
