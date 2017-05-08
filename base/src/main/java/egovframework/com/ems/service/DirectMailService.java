package egovframework.com.ems.service;

public interface DirectMailService {
	
	public String sendMail(MailMessageVO vo) throws Exception;

	/**
	 * 메일발송 목록을 가져온다.
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public String sendManageMail(MailMessageVO vo) throws Exception;
}
