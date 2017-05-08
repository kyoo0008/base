package egovframework.com.cop.sms.service.impl;

import java.sql.SQLException;
import java.util.List;


import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.com.cop.sms.service.Sms;
import egovframework.com.cop.sms.service.SmsRecptn;
import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 문자메시지를 위한 데이터 접근 클래스
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
@Repository("SmsDAO")
public class SmsDAO extends EgovAbstractDAO {
	
	    
    /**
     * 문자메시지 목록을 조회한다.
     * 
     * @param SmsVO
     */
    @SuppressWarnings("unchecked")
    public List<SmsVO> selectSmsInfs(SmsVO vo) throws Exception {
	return list("SmsDAO.selectSmsInfs", vo);
    }

    /**
     * 문자메시지 목록 숫자를 조회한다
     * 
     * @param SmsVO
     * @return
     * @throws Exception
     */
    public int selectSmsInfsCnt(SmsVO vo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("SmsDAO.selectSmsInfsCnt", vo);
    }
    
    /**
     * 문자메시지 정보를 등록한다.
     * 
     * @param notification
     * @return
     * @throws Exception
     */
    public Object insertSmsInf(final Sms sms) throws Exception {
    	
    	if(sms.getRecptnTelno() != null && sms.getRecptnTelno().size()> 0) {
	    	return getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              Sms sendSmsInfo = null;
		              String recptn = null;
		              List<String> list = sms.getRecptnTelno();
		              for(int i=0; i<list.size(); i++) {
		            	  recptn = list.get(i);
		            	  
		            	  sendSmsInfo = new Sms();
		            	  sendSmsInfo.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(sms.getTrnsmitTelno()));
		            	  sendSmsInfo.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(recptn));
		            	  sendSmsInfo.setTrnsmitCn(sms.getTrnsmitCn());
		            	  sendSmsInfo.setReservationAt(sms.getReservationAt());
		            	  sendSmsInfo.setReservationDateString(sms.getReservationDateString());
		            	  insert("SmsDAO.insertSmsInf", sendSmsInfo);
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		      });
    	} else {
    		sms.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(sms.getRecptnTelnoSingle()));
			sms.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(sms.getTrnsmitTelno()));
    		return insert("SmsDAO.insertSmsInf", sms);
    	}
    }
    
    /**
     * MMS메시지 정보를 등록한다.
     * 
     * @param notification
     * @return
     * @throws Exception
     */
    public Object insertMmsInf(final Sms sms) throws Exception {
    	
    	if(sms.getRecptn() != null && sms.getRecptn().size()> 0) {
	    	return getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
		          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
		              excutor.startBatch();
		              
		              Sms sendSmsInfo = null;
		              SmsRecptn recptn = null;
		              List<SmsRecptn> list = sms.getRecptn();
		              for(int i=0; i<list.size(); i++) {
		            	  recptn = (SmsRecptn)list.get(i);
		            	  
		            	  sendSmsInfo = new Sms();
		            	  sendSmsInfo.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(sms.getTrnsmitTelno()));
		            	  sendSmsInfo.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(recptn.getRecptnTelno()));
		            	  sendSmsInfo.setTrnsmitCn(sms.getTrnsmitCn());
		            	  sendSmsInfo.setReservationAt(sms.getReservationAt());
		            	  
		            	  sendSmsInfo.setSubject(sms.getSubject());
		            	  sendSmsInfo.setFileCnt(sms.getFileCnt());
		            	  sendSmsInfo.setFilePath(sms.getFilePath());
		            	  
		            	  insert("SmsDAO.insertMmsInf", sendSmsInfo);
		              }
	
		              excutor.executeBatch();
		              return null;
		          }
		      });
    	} else {
    		sms.setRecptnTelnoSingle(EgovStringUtil.getPhoneNumber(sms.getRecptnTelnoSingle()));
			sms.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(sms.getTrnsmitTelno()));
    		return insert("SmsDAO.insertMmsInf", sms);
    	}
    }
}
