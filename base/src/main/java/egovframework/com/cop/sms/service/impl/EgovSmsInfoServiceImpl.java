package egovframework.com.cop.sms.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.sms.service.EgovSmsInfoService;
import egovframework.com.cop.sms.service.Sms;
import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 문자메시지를 위한 서비스 구현 클래스
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
@Service("EgovSmsInfoService")
public class EgovSmsInfoServiceImpl extends AbstractServiceImpl implements EgovSmsInfoService {
   
    @Resource(name="SmsDAO")
    private SmsDAO smsDao;
    
    /**
     * 문자메시지 목록을 조회 한다.
     */
    public Map<String, Object> selectSmsInfs(SmsVO searchVO) throws Exception {
		List<SmsVO> result = smsDao.selectSmsInfs(searchVO);
		int cnt = smsDao.selectSmsInfsCnt(searchVO);
		
		// 전화번호 포맷 처리
		for (int i = 0; i < result.size(); i++) {
		    String phone = result.get(i).getTrnsmitTelno();
		    result.get(i).setTrnsmitTelno(EgovStringUtil.formatPhoneNumber(phone));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }
    
    /**
     * 문자메시지를 전송(등록)한다.
     */
    public void insertSmsInf(Sms sms) throws Exception {
		
		smsDao.insertSmsInf(sms);
    }
    
    /**
     * MMS 메시지를 전송(등록)한다.
     */
    public void insertMmsInf(Sms sms) throws Exception {
		
		smsDao.insertMmsInf(sms);
    }
    
    /**
     * 사용자 sms발송서비스.. 사용자 정보를 받아 sms 발송 처리 한다.
     * @param userId 수신자ID
     * @param sms 발송정보VO
     */
	public int sendUserSms(String userId, Sms sms) throws Exception {

		int sendCount = 0;
		if(sms.getRecptnTelno() != null && sms.getRecptnTelno().size()> 0) {
			List<String> list = sms.getRecptnTelno();
			if(list != null && list.size() > 0) {
				
				Sms smsVO = null;
				String recptnTelnoSingle = null;
	            for(int i=0; i<list.size(); i++) {
	            	recptnTelnoSingle = list.get(i);
	            	
	    			smsVO = new Sms();
		    		smsVO.setRecptnTelnoSingle(recptnTelnoSingle);
		    		smsVO.setTrnsmitTelno(sms.getTrnsmitTelno());
		    		smsVO.setTrnsmitCn(sms.getTrnsmitCn());
		    		smsVO.setReservationAt(sms.getReservationAt());
		    		smsVO.setReservationDateString(sms.getReservationDateString());
		    		this.insertSmsInf(smsVO);
		    		
		    		sendCount++;
	            }
			}
		}

      return sendCount;
	}
}
