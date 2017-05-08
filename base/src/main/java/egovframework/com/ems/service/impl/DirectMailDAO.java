package egovframework.com.ems.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

import egovframework.com.ems.service.MailMessageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/******************************************************
 * @Class Name : DirectMailDAO.java
 * @Program name : egovframework.com.ems.service.impl
 * @Descriptopn : 메일발송 DAO
 * @version : 1.0.0
 * @author : 비상을꿈꾸며
 * @created date : 2011. 12. 8.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 12. 8.        비상을꿈꾸며      first generated
*********************************************************/


@Repository("directMailDAO")
public class DirectMailDAO extends EgovAbstractDAO{
	
    protected Log log = LogFactory.getLog(this.getClass());

    /**
     * MMS발송 회원 목록
     * @param userSearchVO 검색조건
     * @return List 사용자 목록정보
     */
    @SuppressWarnings("unchecked")
	public List<MailMessageVO> selectEmsMberList(MailMessageVO mailMessageVO){
        return list("EmsDAO.selectEmsMberList", mailMessageVO);
    }

}