package egovframework.com.cop.com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.cmy.service.Community;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.cop.com.service.ConfirmHistory;
import egovframework.com.cop.com.service.ConfirmHistoryVO;
import egovframework.com.cop.com.service.EgovConfirmManageService;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 승인정보를 관리하기 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.4.7  이삼섭          최초 생성
 *   2012. 1. 26 이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
 *
 * </pre>
 */
@Service("EgovConfirmManageService")
public class EgovConfirmManageServiceImpl extends AbstractServiceImpl implements EgovConfirmManageService {

    /**
	 * @uml.property  name="confmDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "ConfirmManageDAO")
    private ConfirmManageDAO confmDAO;

    /**
	 * @uml.property  name="cmmntyService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "EgovCommunityManageService")
    private EgovCommunityManageService cmmntyService;

    /**
     * 승인(탈퇴)요청에 대한 등록을 처리한다.
     * 
     * @see egovframework.com.cop.com.service.EgovConfirmManageService#insertConfirmRequest(egovframework.com.cop.com.service.ConfirmHistory)
     */
    public void insertConfirmRequest(ConfirmHistory history) throws Exception {
    	if("Y".equals(history.getAutoAt())){	//자동 승인경우
    		CommunityUser cmmntyUser = new CommunityUser();
    		
    		cmmntyUser.setCmmntyId(history.getTrgetJobId());
    		cmmntyUser.setEmplyrId(history.getConfmRqesterId());
    		cmmntyUser.setEmplyrNm(history.getConfmRqesterNm());

    		String retVal = cmmntyService.checkCommunityUserInf(cmmntyUser);
    		if(retVal.equals("EXIST")){		//이전 탈퇴자라면 재가입 시켜준다.
    			cmmntyUser.setUseAt("Y");
				cmmntyService.updateCommunityUserInf(cmmntyUser);
			}else{
				cmmntyUser.setUseAt("Y");
	    		cmmntyUser.setMngrAt("N");
	    		cmmntyUser.setAuthorCode("02");
	    		cmmntyUser.setFrstRegisterId(history.getConfmRqesterId());
				cmmntyService.insertCommunityUserInf(cmmntyUser);
			}
    		history.setConfmSttusCode("AP02"); 				// 승인완료처리
    		history.setConfmDe(EgovDateUtil.getToday());	// 승인완료처리일
    	}
    	confmDAO.insertConfirmRequest(history);
    }

    /**
     * 승인(탈퇴)요청에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cop.com.service.EgovConfirmManageService#selectConfirmRequest(egovframework.com.cop.com.service.ConfirmHistoryVO)
     */
    public Map<String, Object> selectConfirmRequest(ConfirmHistoryVO historyVO) throws Exception {
	List<ConfirmHistoryVO> result = confmDAO.selectConfirmRequestList(historyVO);
	int cnt = confmDAO.selectConfirmRequestListCnt(historyVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 승인(탈퇴)요청에 대한 확인을 처리한다.
     * 
     * @see egovframework.com.cop.com.service.EgovConfirmManageService#updateConfirmRequest(egovframework.com.cop.com.service.ConfirmHistory)
     */
    public void updateConfirmRequest(ConfirmHistory history) throws Exception {
	String sttus = history.getConfmSttusCode();

	// 승인요청이면 아무것도 처리하지 않음
	if ("AP01".equals(sttus)) {
	    return;
	}

	/* sttus 가 승인완료 AP02일때만 로직처리/ 승인반려시에는 승인정보만 변경처리 */
	if ("AP02".equals(sttus)) {
	    if ("CF12".equals(history.getConfmTyCode())) {
		// 커뮤니티 사용자 탈퇴처리
		CommunityUser cmmntyUser = new CommunityUser();
		
		cmmntyUser.setLastUpdusrId(history.getConfmerId());
		cmmntyUser.setCmmntyId(history.getTrgetJobId());
		cmmntyUser.setEmplyrId(history.getConfmRqesterId());
		cmmntyUser.setSecsnDe(EgovDateUtil.getToday());
		
		cmmntyService.deleteCommunityUserInf(cmmntyUser);
		
	    } else if ("CF02".equals(history.getConfmTyCode())) {
		// 커뮤니티 삭제
		Community cmmnty = new Community();

		cmmnty.setLastUpdusrId(history.getConfmerId());
		cmmnty.setCmmntyId(history.getTrgetJobId());
		
		cmmntyService.deleteCommunityInf(cmmnty);
		
	    } else if ("CF11".equals(history.getConfmTyCode())) {
		// 커뮤니티 가입
		CommunityUser cmmntyUser = new CommunityUser();

		cmmntyUser.setCmmntyId(history.getTrgetJobId());
		cmmntyUser.setEmplyrId(history.getConfmRqesterId());
		cmmntyUser.setEmplyrNm(history.getConfmRqesterNm());
		cmmntyUser.setFrstRegisterId(history.getConfmRqesterId());

		String retVal = cmmntyService.checkCommunityUserInf(cmmntyUser);
		if(retVal.equals("EXIST")){		//이전 탈퇴자라면 재가입 시켜준다.
			cmmntyUser.setUseAt("Y");
			cmmntyService.updateCommunityUserInf(cmmntyUser);
		}else{
			cmmntyUser.setUseAt("Y");
    		cmmntyUser.setMngrAt("N");
    		cmmntyUser.setAuthorCode("02");
    		cmmntyUser.setFrstRegisterId(history.getConfmRqesterId());
    		cmmntyService.insertCommunityUserInf(cmmntyUser);
		}

	    }
	}
	
	history.setConfmDe(EgovDateUtil.getToday());
	
	confmDAO.updateConfirmRequest(history);
    }

    /**
     * 승인(탈퇴)요청에 대한 상세내용을 조회한다.
     * 
     * @see egovframework.com.cop.com.service.EgovConfirmManageService#selectSingleConfirmRequest(egovframework.com.cop.com.service.ConfirmHistoryVO)
     */
    public ConfirmHistoryVO selectSingleConfirmRequest(ConfirmHistoryVO historyVO) throws Exception {
	return confmDAO.selectSingleConfirmRequest(historyVO);
    }

    /**
     * 현재 승인 요청된 건수를 조회한다.
     * 
     * @see egovframework.com.cop.com.service.EgovConfirmManageService#countConfirmRequest(egovframework.com.cop.com.service.ConfirmHistoryVO)
     */
    public int countConfirmRequest(ConfirmHistory history) throws Exception {
	return confmDAO.countConfirmRequest(history);
    }
}
