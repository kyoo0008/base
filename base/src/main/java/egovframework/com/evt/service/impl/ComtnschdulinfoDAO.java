package egovframework.com.evt.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import java.sql.SQLException;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientCallback;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.com.evt.service.ComtnschdulinfoVO;
import egovframework.com.evt.service.ComtnschdulinfoDefaultVO;

import egovframework.com.evt.service.ComtneventqesitmexVO;
import egovframework.com.evt.service.ComtneventqesitmVO;
import egovframework.com.evt.service.ComtneventcnsrVO;
import egovframework.com.evt.service.ComtneventadhrncVO;
import egovframework.com.evt.service.ComtneventaswperVO;
import egovframework.com.evt.service.ComtneventformaswperVO;
import egovframework.com.evt.service.ComtneventprzwnerVO;
import egovframework.com.evt.service.ComtneventprzwnerDefaultVO;

import org.apache.commons.lang.StringUtils;

/******************************************************
 * @Class Name : ComtnschdulinfoDAO.java
 * @Program name : egovframework.com.evt.service.impl
 * @Descriptopn : 
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 25.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 25.        이호영             first generated
*********************************************************/

@Repository("comtnschdulinfoDAO")
public class ComtnschdulinfoDAO extends EgovAbstractDAO {

	/** ID Generation - 문항ID */
    @Resource(name="egovEventItemIdGnrService")
    private EgovIdGnrService egovIdGnrService;
    
    /** ID Generation - 문항보기ID */
    @Resource(name="egovEventItemExIdGnrService")
    private EgovIdGnrService egovIdExService;
    
    /** ID Generation - 정답ID */
    @Resource(name="egovEventCnsrIdGnrService")
    private EgovIdGnrService egovIdCnsrService;
    
    /** ID Generation - 참여자ID */
    @Resource(name="egovEventAnwperIdGnrService")
    private EgovIdGnrService egovIdAnwperService;

	/**
	 * COMTNSCHDULINFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnschdulinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
    	
    	getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtnschdulinfo_S", vo);

		for(int index = 0; index < vo.getQuestionList().size(); index++) {
			ComtneventqesitmVO question = (ComtneventqesitmVO)vo.getQuestionList().get(index);
			question.setSchdulId(vo.getSchdulId());
			question.setQesitmId(egovIdGnrService.getNextStringId());
			getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventqesitm_S", question);
			
			for(int index1 = 0; index1 < question.getExampleList().size(); index1++) {
				ComtneventqesitmexVO example = (ComtneventqesitmexVO)question.getExampleList().get(index1);
				example.setQesitmId(question.getQesitmId());
				example.setExId(egovIdExService.getNextStringId());
				getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventqesitmex_S", example);
			}
			
			for(int index2 = 0; index2 < question.getAnswerList().size(); index2++) {
				ComtneventcnsrVO answer = (ComtneventcnsrVO)question.getAnswerList().get(index2);
				answer.setCnsrId(egovIdCnsrService.getNextStringId());
				answer.setQesitmId(question.getQesitmId());
				getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventcnsr_S", answer);
			}
		}
    }

    /**
	 * COMTNSCHDULINFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
    	getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateComtnschdulinfo_S", vo);

    	List<String> hasQuestionIdList = new ArrayList<String>();

    	for(int index = 0; index < vo.getQuestionList().size(); index++) {
    		ComtneventqesitmVO question = (ComtneventqesitmVO)vo.getQuestionList().get(index);
    		if(StringUtils.isEmpty(question.getQesitmId())) {
    			question.setSchdulId(vo.getSchdulId());
    			question.setQesitmId(egovIdGnrService.getNextStringId());
    			getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventqesitm_S", question);
    			hasQuestionIdList.add(question.getQesitmId());
    		}else if(getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateComtneventqesitm", question) > 0){
    			hasQuestionIdList.add(question.getQesitmId());
    		}

    		List<String> hasExampleIdList = new ArrayList<String>();
    		for(int index2 = 0; index2 < question.getExampleList().size(); index2++) {
    			ComtneventqesitmexVO example = (ComtneventqesitmexVO)question.getExampleList().get(index2);
    			if(StringUtils.isEmpty(example.getQesitmId())) example.setQesitmId(question.getQesitmId());
    			if(StringUtils.isEmpty(example.getExId())) {
    				example.setExId(egovIdExService.getNextStringId());
    				getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventqesitmex_S", example);
    				hasExampleIdList.add(example.getExId());
    			} else if(getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateComtneventqesitmex", example) > 0) {
    				hasExampleIdList.add(example.getExId());
    			}
    		}

    		List<String> hasAnswerIdList = new ArrayList<String>();
    		for(int index2 = 0; index2 < question.getAnswerList().size(); index2++) {
    			ComtneventcnsrVO answer = (ComtneventcnsrVO)question.getAnswerList().get(index2);
    			
    			if(StringUtils.isEmpty(answer.getQesitmId())) answer.setQesitmId(question.getQesitmId());
    			if(StringUtils.isEmpty(answer.getCnsrId())) {
    				answer.setCnsrId(egovIdCnsrService.getNextStringId());
    				getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventcnsr_S", answer);
    				hasAnswerIdList.add(answer.getCnsrId());
    			} else if(getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateComtneventcnsr", answer) > 0) {
		        	  hasAnswerIdList.add(answer.getCnsrId());
    			}
    		}

    		Map<String, Object> paramMap = new HashMap<String, Object>();
			  paramMap.put("questionId", question.getQesitmId());
			  paramMap.put("exampleIdList", hasExampleIdList);
			  paramMap.put("answerIdList", hasAnswerIdList);
			  getSqlMapClientTemplate().delete("comtnschdulinfoDAO.delExampleNotInExampleIdList", paramMap);
			  getSqlMapClientTemplate().delete("comtnschdulinfoDAO.delAnswerNotInAnswerIdList", paramMap);
			  paramMap.clear();
			  paramMap = null;
    	}
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("onlineEventId", vo.getSchdulId());
	    paramMap.put("questionIdList", hasQuestionIdList);
	    getSqlMapClientTemplate().delete("comtnschdulinfoDAO.delAnswerNotInQuestionIdList", paramMap);
	    getSqlMapClientTemplate().delete("comtnschdulinfoDAO.delExampleNotInQuestionIdList", paramMap);
	    getSqlMapClientTemplate().delete("comtnschdulinfoDAO.delQuestionNotInQuestionIdList", paramMap);
	    
	    paramMap.clear();
	    paramMap = null;
    }

    /**
	 * COMTNSCHDULINFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
        delete("comtnschdulinfoDAO.deleteComtnschdulinfo_S", vo);
    }
    
    /**
	 * COMTNEVENTADHRNC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtneventadhrnc(ComtnschdulinfoVO vo) throws Exception {
    	delete("comtnschdulinfoDAO.deleteComtneventprzwner_S", vo);
    	delete("comtnschdulinfoDAO.deleteComtneventaswper_S", vo);
    	delete("comtnschdulinfoDAO.deleteComtneventadhrnc_S", vo);
    }

    /**
	 * COMTNSCHDULINFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
        return (ComtnschdulinfoVO) selectByPk("comtnschdulinfoDAO.selectComtnschdulinfo_S", vo);
    }
    
    /**
	 * 이벤트의 조회 횟수를 증가시킨다.
	 * @param ComtneventformaswperVO 신청형 이벤트 답안정보
	 * @return result 등록결과
	 * @throws Exception
	 */
    public void updateComtnschdulinfoCo(ComtnschdulinfoVO vo){
    	getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateComtnschdulinfoCo", vo);
    }
    
    /**
	 * 객관식 주관식 이벤트 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschduInfo(ComtnschdulinfoVO vo) throws Exception {
        return (ComtnschdulinfoVO) selectByPk("comtnschdulinfoDAO.selectComtnschduInfo_S", vo);
    }
    
    /**
	 * 객관식 주관식 이벤트 결과 조회
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschduResult(ComtnschdulinfoVO vo) throws Exception {
        return (ComtnschdulinfoVO) selectByPk("comtnschdulinfoDAO.selectComtnschduInfoResult_S", vo);
    }
    
    /**
	 * 객관식 주관식 이벤트 결과 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschduInfoResult(ComtnschdulinfoVO vo) throws Exception {
        return (ComtnschdulinfoVO) selectByPk("comtnschdulinfoDAO.selectComtnschduInfoResult_S", vo);
    }
    
    /**
	 * COMTNSCHDULINFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschdulForm(ComtnschdulinfoVO vo) throws Exception {
        return (ComtnschdulinfoVO) selectByPk("comtnschdulinfoDAO.selectComtneventform_S", vo);
    }

    /**
	 * COMTNSCHDULINFO 목록을 월별로 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoList_S(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return list("comtnschdulinfoDAO.selectComtnschdulinfoList_S", searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoList_D(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return list("comtnschdulinfoDAO.selectComtnschdulinfoList_D", searchVO);
    }

    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    public int selectComtnschdulinfoListTotCnt(ComtnschdulinfoDefaultVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtnschdulinfoListTotCnt_S", searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectUserEventList(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return list("comtnschdulinfoDAO.selectUserEventList", searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectUserEventMain(ComtnschdulinfoVO comtnschdulinfoVO) throws Exception {
        return list("comtnschdulinfoDAO.selectUserEventMain", comtnschdulinfoVO);
    }

    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    public int selectUserEventListTotCnt(ComtnschdulinfoDefaultVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectUserEventListTotCnt", searchVO);
    }
    
    /**
	 * 이벤트 중복 사용자 조회
	 * @exception
	 */
    public boolean isRegDuplicate(ComtneventadhrncVO user) {
		return (Boolean)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.isRegDuplicate", user);
	}
    
    /**
	 * 이벤트 중복 참여자 조회
	 * @exception
	 */
    public boolean isAnswerDuplicate(ComtnschdulinfoVO user) {
		return (Boolean)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.isAnswerDuplicate", user);
	}
    
    /**
	 * ComtneventadhrncVO 이벤트 사용자 등록
	 * @param comtneventadhrncVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
    public String insertEventUser(ComtneventadhrncVO comtneventadhrncVO){
        return (String)insert("comtnschdulinfoDAO.insertEventUser", comtneventadhrncVO);
    }
    
    /**
	 * ComtneventformaswperVO 신청형 이벤트 답안
	 * @param ComtneventformaswperVO 신청형 이벤트 답안정보
	 * @return result 등록결과
	 * @throws Exception
	 */
    public String insertEventFormAswper(ComtneventformaswperVO vo){
        return (String)insert("comtnschdulinfoDAO.insertEventFormAswper", vo);
    }
    
    /**
	 * ComtneventformaswperVO 신청형 이벤트 수정답안
	 * @param ComtneventformaswperVO 신청형 이벤트 답안정보
	 * @return result 등록결과
	 * @throws Exception
	 */
    public void updateEventFormAswper(ComtneventformaswperVO vo){
    	getSqlMapClientTemplate().update("comtnschdulinfoDAO.updateEventFormAswper", vo);
    }

    /**
	 * @param 주관식 개관식 이벤트 참여자 답안 ComtneventaswperVO
	 * @return void형 
	 * @exception Exception
	 */
    public void addUserAnswerByBatch( final List<ComtneventaswperVO> ary)  throws DataAccessException {
	      getSqlMapClientTemplate().execute( new SqlMapClientCallback() {
	          public Object doInSqlMapClient( SqlMapExecutor excutor ) throws SQLException {
	              excutor.startBatch();
	             
	              for ( int i = 0 ; i < ary.size() ; i++ ) {
	            	  ComtneventaswperVO answer = ary.get(i);
	            	  	try {
	            		  answer.setAswperId(egovIdAnwperService.getNextStringId());
	            	  	} catch (FdlException e) {
							e.printStackTrace();
	            	  	}                 
	            	  excutor.insert("comtnschdulinfoDAO.addUserAnswer", answer);
	              }

	              excutor.executeBatch();
	              return null;
	          }
	      });
	 }
    
    /**
	 * COMTNEVENTADHRNC 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTADHRNC 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<ComtneventadhrncVO> selectComtneventadhrncList(ComtneventadhrncVO comtneventadhrncVO) throws Exception {
    	
    	List<ComtneventadhrncVO> selectComtneventadhrncList = getSqlMapClientTemplate().queryForList("comtnschdulinfoDAO.selectComtneventadhrncList_D", comtneventadhrncVO);
    	
    	int i = 0;
    	for (i=0; i < selectComtneventadhrncList.size(); i++){
    		ComtneventadhrncVO result = selectComtneventadhrncList.get(i);
    		comtneventadhrncVO.setUserId(result.getUserId());
    		result.setUserAnswerList(getSqlMapClientTemplate().queryForList("comtnschdulinfoDAO.getUserAnswerList", comtneventadhrncVO));
    	}
        return selectComtneventadhrncList;
    }

    /**
	 * COMTNEVENTADHRNC 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    public int selectComtneventadhrncListTotCnt(ComtneventadhrncVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtneventadhrncListTotCnt_S", searchVO);
    }
    
    /**
	 * COMTNEVENTADHRNC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtneventadhrncVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtneventadhrnc(ComtneventadhrncVO vo) throws Exception {
        delete("comtnschdulinfoDAO.deleteComtneventadhrnc_S", vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtneventprzwner(ComtneventprzwnerVO vo) throws Exception {
    	getSqlMapClientTemplate().delete("comtnschdulinfoDAO.deleteComtneventprzwner_D", vo);
		getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventprzwner_S", vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER을 수동 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtneventprzwnerhopr(ComtneventprzwnerVO vo) throws Exception {
		getSqlMapClientTemplate().insert("comtnschdulinfoDAO.insertComtneventprzwnerhopr_S", vo);
    }
    
    /**
	 * 이벤트 신청자를 취소시킨다
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void delComtneventprzwner(ComtneventprzwnerVO vo){
    	getSqlMapClientTemplate().delete("comtnschdulinfoDAO.updateComtneventprzwner", vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    public List selectComtneventprzwnerList(ComtneventprzwnerDefaultVO searchVO) throws Exception {
        return list("comtnschdulinfoDAO.selectComtneventprzwnerList_D", searchVO);
    }

    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerCnt(ComtneventprzwnerDefaultVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtneventprzwnerCnt", searchVO);
    }
    
    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerListTotCnt(ComtneventprzwnerDefaultVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtneventprzwnerListTotCnt_S", searchVO);
    }
    
    /**
	 * COMTNEVENTFORMASWPER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtneventformaswperVO
	 * @return 조회한 COMTNEVENTFORMASWPER
	 * @exception Exception
	 */
    public ComtneventformaswperVO selectComtneventformaswper(ComtneventformaswperVO vo) throws Exception {
        return (ComtneventformaswperVO) selectByPk("comtnschdulinfoDAO.selectComtneventformaswper_S", vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    public List selectComtneventprzwnerUserList(ComtneventprzwnerDefaultVO searchVO) throws Exception {
        return list("comtnschdulinfoDAO.selectComtneventprzwneUserList", searchVO);
    }

    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerUserListCnt(ComtneventprzwnerDefaultVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtneventprzwnerUserListCnt", searchVO);
    }
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<ComtneventaswperVO> selectCommunitySbjctList(ComtneventaswperVO comtneventaswperVO) throws Exception {
        return list("comtnschdulinfoDAO.selectCommunitySbjctList", comtneventaswperVO);
    }
    
    /**
	 * 이벤트 사용자별 참여내역을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    public List selectCommunityAswper(ComtneventaswperVO comtneventaswperVO) throws Exception {
        return list("comtnschdulinfoDAO.selectCommunityAswper", comtneventaswperVO);
    }
    
    /**
	 * 이벤트 참여횟수를 조회한다.
	 * @exception
	 */
    public int selectComtneventadhrncCnt(ComtnschdulinfoVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("comtnschdulinfoDAO.selectComtneventadhrncCnt", searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 팝업목록을 조회한다.
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoByPopupList() throws Exception {
        return list("comtnschdulinfoDAO.selectComtnschdulinfoByPopupList", null);
    }
}
