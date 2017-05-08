package egovframework.com.sym.log.service;

import java.io.Serializable;

/**
 * @Class Name : LoginLog.java
 * @Description : 접속 로그 관리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
public class DataUseLog implements Serializable {

	private String dtaUseId;
	private String siteId;	
	private String sysTyCode;	
	private String trgetId;
	private String bbsId;
	private String nttId;
	private String atchFileId;
	private String fileSn;
	private String rqesterIp;
	private String rqesterId;
	private java.util.Date occrrncPnttm;
	public String getDtaUseId() {
		return dtaUseId;
	}
	public void setDtaUseId(String dtaUseId) {
		this.dtaUseId = dtaUseId;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getSysTyCode() {
		return sysTyCode;
	}
	public void setSysTyCode(String sysTyCode) {
		this.sysTyCode = sysTyCode;
	}
	public String getTrgetId() {
		return trgetId;
	}
	public void setTrgetId(String trgetId) {
		this.trgetId = trgetId;
	}
	public String getBbsId() {
		return bbsId;
	}
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	public String getNttId() {
		return nttId;
	}
	public void setNttId(String nttId) {
		this.nttId = nttId;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getFileSn() {
		return fileSn;
	}
	public void setFileSn(String fileSn) {
		this.fileSn = fileSn;
	}
	public String getRqesterIp() {
		return rqesterIp;
	}
	public void setRqesterIp(String rqesterIp) {
		this.rqesterIp = rqesterIp;
	}
	public String getRqesterId() {
		return rqesterId;
	}
	public void setRqesterId(String rqesterId) {
		this.rqesterId = rqesterId;
	}
	public java.util.Date getOccrrncPnttm() {
		return occrrncPnttm;
	}
	public void setOccrrncPnttm(java.util.Date occrrncPnttm) {
		this.occrrncPnttm = occrrncPnttm;
	}
	
	
}
