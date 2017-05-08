package egovframework.com.ems.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.Globals;
import egovframework.com.ems.service.DirectMailService;
import egovframework.com.ems.service.MailMessageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service("directMailService")
public class DirectMailServiceImpl extends AbstractServiceImpl implements DirectMailService {
    
	@Resource(name="directMailDAO")
	private DirectMailDAO directMailDAO;
	
	/**
	 * 					MailMessageVO mvo = new MailMessageVO();			//메일발송 VO생성
		    			mvo.setSenderEmail("a@a.com"); 						//보내는 사람 이메일	없을경우  Globals.EmailAdress 의 관리자 메일로 전송됨
		    			
		    			List<String> mails = new ArrayList<String>();		//받을메일주소 배열
		    			mails.add(mberManageVO.getMberEmailAdres());		//받을메일주소 추가
		    			
		    			mvo.setEmails(mails);								//받을 메일주소 배열 set
		    			mvo.setSubject(" 아이디를 알려드립니다.");				//메일제목
		    			mvo.setContent("홍길동님의 아이디는 \"" + mberManageVO.getMberId()  + "\"입니다.");	//메일 내용
		    			
		    			String strResult = messageService.sendMail(mvo);	//전송결과 리턴	- 리턴값이  공백 if(EgovStringUtil.isEmpty(strResult)) 이면 정상 발송 , 나머지는 에러발생)
		    			System.out.println("아이디 이메일발송결과 : [" + mberManageVO.getMberId() + "/" + mberManageVO.getMberEmailAdres() + "] " + strResult);
		    			
	 * 
	 */
	
	/**
	 * 메일발송 회원 목록을 가져온다.
	 * @param userSearchVO 검색조건
	 * @throws Exception
	 */
	public String sendManageMail(MailMessageVO mailMessageVO) {

		List<MailMessageVO> mailList = directMailDAO.selectEmsMberList(mailMessageVO);
		MailMessageVO mailVO = null;

		//메일이벤트 발송
		MailMessageVO mvo = new MailMessageVO();			//메일발송 VO생성
		List<String> mails = new ArrayList<String>();		//받을메일주소 배열

		for(int i=0; i < mailList.size(); i++) {
			mailVO = mailList.get(i);
			mails.add(mailVO.getReceptorEmail());
		}
		mvo.setEmails(mails);
		
		mvo.setSenderEmail(mailMessageVO.getSenderEmail());
		mvo.setSenderName(mailMessageVO.getSenderName());
		mvo.setSubject(mailMessageVO.getSubject());
		mvo.setContent(mailMessageVO.getContent());

		return sendMail(mvo);
	}
	
	public String sendMail(MailMessageVO vo) {
    	
    	String result = "";
    	
    	List<String> toList = EmailFilterAddress(vo.getEmails());
	    if(toList.size() > 0) {
	    	Properties props = new Properties();
	    	props.put("mail.smtp.host", Globals.EMAIL_HOST);
	    	Session sess = Session.getDefaultInstance(props, null);
	    	
	    	try {
	    		
	    		if(EgovStringUtil.isEmpty(vo.getSenderEmail())) {
	    			vo.setSenderEmail(Globals.EMAIL_ADDRESS);
	    			vo.setSenderName(Globals.EMAIL_NAME);
	    		}
	    		
	    		if(EgovStringUtil.isEmpty(vo.getSenderName())) {
	    			vo.setSenderEmail(vo.getSenderEmail());
	    		}

	    		Message msg = new MimeMessage(sess);
	    		InternetAddress from = new InternetAddress(vo.getSenderEmail(), vo.getSenderName(), "UTF-8");
	    		msg.setHeader("content-type", "text/html;charset=UTF-8");
	    		msg.setFrom(from);
	    		//InternetAddress[] address = {new InternetAddress("", "")};
	    		InternetAddress[] address = new InternetAddress[toList.size()];
	    		for(int i=0;i < toList.size();i++) {
	    			address[i] = new InternetAddress(toList.get(i));
	    		}
	    		msg.setRecipients(Message.RecipientType.TO, address);
	    		msg.setSubject(MimeUtility.encodeText(vo.getSubject(), "UTF-8", "B"));
	    		msg.setContent(vo.getContent(), "text/html;charset=UTF-8");
	    		msg.setSentDate(new java.util.Date());
	    		
	    		Transport.send(msg);
	    		
	    	} catch(Exception mex) {
	    		result = mex.getMessage();
	    	}
    	} else {
    		result = "받는 사람이 없습니다.";
    	}
    	
    	return result;
    }
    
    private List<String> EmailFilterAddress(List<String> to) {
    	List<String> newTo = new ArrayList<String>();
    	for(int i=0;i < to.size();i++) {
			if(!EgovStringUtil.isEmpty(to.get(i))) {
				newTo.add(to.get(i));
			}
		}
    	
    	return newTo;
    }

}
