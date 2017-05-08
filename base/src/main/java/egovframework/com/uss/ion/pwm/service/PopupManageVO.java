package egovframework.com.uss.ion.pwm.service;
/**
 * 개요
 * - 팝업창에 대한 Vo 클래스를 정의한다.
 * 
 * 상세내용
 * - 팝업창의 목록 항목을 관리한다.
 * @author 이창원
 * @version 1.0
 * @created 05-8-2009 오후 2:21:04
 */
@SuppressWarnings("serial")
public class PopupManageVO extends PopupManage {

	/**
	 * 임시첨부파일 그룹아이디
	 */
    private String fileGroupId = "";
    
	public PopupManageVO(){}

	public String getFileGroupId() {
		return fileGroupId;
	}

	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}

	
}