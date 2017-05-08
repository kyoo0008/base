package egovframework.com.cmm.service;

import javax.servlet.http.HttpServletRequest;
import egovframework.com.utl.fcc.service.EgovHttpUtil;
/**
 *  Class Name : Globals.java
 *  Description : 시스템 구동 시 프로퍼티를 통해 사용될 전역변수를 정의한다.
 *  Modification Information
 * 
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see 
 * 
 */

public class Globals {
	//OS 유형
    public static final String OS_TYPE = EgovProperties.getProperty("Globals.OsType");
    //DB 유형
    public static final String DB_TYPE = EgovProperties.getProperty("Globals.DbType");
    //메인 페이지
    public static final String MAIN_PAGE = EgovProperties.getProperty("Globals.MainPage");
    //ShellFile 경로
    public static final String SHELL_FILE_PATH = EgovProperties.getProperty("Globals.ShellFilePath");
    //퍼로퍼티 파일 위치
    public static final String CONF_PATH = EgovProperties.getProperty("Globals.ConfPath");
    //Server정보 프로퍼티 위치
    public static final String SERVER_CONF_PATH = EgovProperties.getProperty("Globals.ServerConfPath");
    //Client정보 프로퍼티 위치
    public static final String CLIENT_CONF_PATH = EgovProperties.getProperty("Globals.ClientConfPath");
    //파일포맷 정보 프로퍼티 위치
    public static final String FILE_FORMAT_PATH = EgovProperties.getProperty("Globals.FileFormatPath");
    
    //파일 업로드 원 파일명
	public static final String ORIGIN_FILE_NM = "originalFileName";
	//파일 확장자
	public static final String FILE_EXT = "fileExtension";
	//파일크기
	public static final String FILE_SIZE = "fileSize";
	//업로드된 파일명
	public static final String UPLOAD_FILE_NM = "uploadFileName";
	//파일경로
	public static final String FILE_PATH = "filePath";
	
	//메일발송요청 XML파일경로
	public static final String MAIL_REQUEST_PATH = EgovProperties.getProperty("Globals.MailRequestPath");
	//메일발송응답 XML파일경로
	public static final String MAIL_RESPONSE_PATH = EgovProperties.getProperty("Globals.MailRResponsePath");
	
	// 도메인 (localhost)
	public static final String DOMAIN = EgovProperties.getProperty("Globals.Domain");
	
	// G4C 연결용 IP (localhost)
	public static final String LOCAL_IP = EgovProperties.getProperty("Globals.LocalIp");
	
	//게시판 추가기능 활성화여부
	public static final String ADDED_OPTIONS = EgovProperties.getProperty("Globals.addedOptions");
	
	//sms설정정보
	public static final String SME_CONFIG_PATH = EgovProperties.getProperty("Globals.SMEConfigPath");
	
	//파일 저장 위치
	public static final String FILE_STORE_PATH = EgovProperties.getProperty("Globals.fileStorePath"); 
	
	// 전화번호
	public static final String PHONE = EgovProperties.getProperty("Globals.Phone");
	
	// 센드메일 호스트주소
	public static final String EMAIL_HOST = EgovProperties.getProperty("Globals.EmailHost");
	
	// 관리자 메일주소
	public static final String EMAIL_ADDRESS = EgovProperties.getProperty("Globals.EmailAdress");
	
	// 관리자 이메일명
	public static final String EMAIL_NAME = EgovProperties.getProperty("Globals.EmailName");
	
	//이니시스
	//public static final String INICIS_MID = EgovProperties.getProperty("INICIS_MID"); 
	//public static final String INICIS_ADMIN = EgovProperties.getProperty("INICIS_ADMIN"); 
	//public static final String INICIS_URL = EgovProperties.getProperty("INICIS_URL"); 
	//public static final String INICIS_HOME = EgovProperties.getProperty("INICIS_HOME"); 
	public static final String PUBLISH_HEADER = "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>\n";
	public static final String PUBLISH_MOBILE_APPEND_FREFIX = "_MBL";
	public static final String PUBLISH_PREVEIW_APPEND_FREFIX = "_PRE";
	public static String getPublishAppendPrefix(HttpServletRequest request) {		
		return (EgovHttpUtil.getIsMobile(request) ? PUBLISH_MOBILE_APPEND_FREFIX : "") + ("Y".equals(request.getParameter("previewYn")) ? PUBLISH_PREVEIW_APPEND_FREFIX : "");
	}
    
	public static final String MENU_AUTO_MAKE_SITE_ID = "ZZZZZZZZZZZZZZZZZZZZ";
}
