package egovframework.com.cop.sms.service.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.com.cop.sms.service.Sms;
import egovframework.com.cop.sms.service.SmsSenderService;
import egovframework.com.cop.sms.service.impl.SmsDAO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/******************************************************
 * @Class Name : SmsSenderServiceImpl.java
 * @Program name : egovframework.com.cop.sms.service.impl
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 9. 27.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 9. 27.        이호영             first generated
*********************************************************/

@Service("SmsSenderService")
public class SmsSenderServiceImpl extends AbstractServiceImpl implements SmsSenderService {

	/**
	 * SmsDAO
	 * @uml.property  name="SmsDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="SmsDAO")
	private SmsDAO SmsDAO;

	Logger log = Logger.getLogger(this.getClass());

	/**
     * 사용자 정보를 받아 sms 발송 처리 한다.
     * SMS수신여부 관계없이 무조건 전송한다
     * @param strMsg 메세지본문
     * @param userId 수신자ID
     */
	public boolean sendSmsSender(String userId, String moblphonNo, String strMsg) throws Exception {

		Sms sms = new Sms();
		sms.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(moblphonNo));
		sms.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(Globals.PHONE));
		sms.setTrnsmitCn(strMsg);
		
		SmsDAO.insertSmsInf(sms);

      return true;
	}
	
	/**
     * 사용자 정보를 받아 MMS정보를 처리 한다.
     * SMS수신여부 관계없이 무조건 전송한다
     * @param strMsg 메세지본문
     * @param userId 수신자ID
     */
	public boolean sendMmsSender(String userId, String moblphonNo, String strMsg, int fileCnt, String filePath) throws Exception {

		Sms sms = new Sms();
		sms.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(moblphonNo));
		sms.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(Globals.PHONE));
		sms.setTrnsmitCn(strMsg);
		sms.setFileCnt(fileCnt);
		sms.setFilePath(filePath);
		
		SmsDAO.insertMmsInf(sms);

      return true;
	}


}
