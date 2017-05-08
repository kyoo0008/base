package egovframework.com.cop.sms.service;

import java.util.Map;

/**
 * 문자메시지를 위한 서비스 인터페이스 클래스
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
public interface EgovSmsInfoService {
    /**
     * 문자메시지 목록을 조회 한다.
     * 
     * @param SmsVO
     */
    public Map<String, Object> selectSmsInfs(SmsVO searchVO) throws Exception;
    
    /**
     * 문자메시지를 전송(등록)한다.
     * 
     * @param sms
     * @throws Exception
     */
    public void insertSmsInf(Sms sms) throws Exception;
    
    /**
     * 사용자 sms발송서비스.. 사용자 정보를 받아 sms 발송 처리 한다.
     * @param userId 수신자ID
     * @param sms 발송정보VO
     */
	public int sendUserSms(String userId, Sms sms) throws Exception;
    
}
