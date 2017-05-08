package egovframework.com.cop.sms.service;

public interface SmsSenderService {

	/**
     * 사용자 정보를 받아 sms 발송 처리 한다.
     * SMS수신여부 관계없이 무조건 전송한다
     * @param strMsg 메세지본문
     * @param userId 수신자ID
     */
    public boolean sendSmsSender(String userId, String moblphonNo, String strMsg) throws Exception;
    
    /**
     * 사용자 정보를 받아 MMS정보를 처리 한다.
     * SMS수신여부 관계없이 무조건 전송한다
     * @param strMsg 메세지본문
     * @param userId 수신자ID
     */
    public boolean sendMmsSender(String userId, String moblphonNo, String strMsg, int fileCnt, String filePath) throws Exception;
}
