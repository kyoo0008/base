package egovframework.com.evt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.evt.service.ComtnschdulinfoService;
import egovframework.com.evt.service.ComtnschdulinfoDefaultVO;
import egovframework.com.evt.service.ComtnschdulinfoVO;
import egovframework.com.evt.service.impl.ComtnschdulinfoDAO;
import egovframework.com.evt.service.ComtneventadhrncVO;
import egovframework.com.evt.service.ComtneventaswperVO;
import egovframework.com.evt.service.ComtneventformaswperVO;
import egovframework.com.evt.service.ComtneventprzwnerVO;
import egovframework.com.evt.service.ComtneventprzwnerDefaultVO;


/******************************************************
 * @Class Name : ComtnschdulinfoServiceImpl.java
 * @Program name : egovframework.com.evt.service.impl
 * @Descriptopn : 충청남도교육연구정보원 스마트충남 기능 개선 구축
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2012. 2. 10.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2012. 2. 10.        이호영             first generated
*********************************************************/

@Service("comtnschdulinfoService")
public class ComtnschdulinfoServiceImpl extends AbstractServiceImpl implements ComtnschdulinfoService {

    @Resource(name="comtnschdulinfoDAO")
    private ComtnschdulinfoDAO comtnschdulinfoDAO;
    
    /** ID Generation */
    @Resource(name="egovEventInfoIdGnrService")   
    private EgovIdGnrService egovIdGnrService;
    
    /** ID Generation - cka */
    @Resource(name="egovEventFormAnwperIdGnrService")
    private EgovIdGnrService egovIdEventFormAnwperService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	/**
	 * COMTNSCHDULINFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnschdulinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
    	log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setSchdulId(id);
    	log.debug(vo.toString());
    	
    	vo.setAtchFileId(this.insertFileInfsByTemp(vo));
    	
    	this.comtnschdulinfoDAO.insertComtnschdulinfo(vo);
    }

    
    /**
     * 임시첨부파일을 정식으로 등록 한다.
     * 
     */
    public String insertFileInfsByTemp(ComtnschdulinfoVO vo) throws Exception {
  	  FileVO fvo = new FileVO();
  	  fvo.setAtchFileId(vo.getAtchFileId());
  	  fvo.setFileGroupId(vo.getFileGroupId());
  	  return fileMngService.insertFileInfsByTemp(fvo).getAtchFileId();
    }
    
    /**
	 * COMTNSCHDULINFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
    	
    	vo.setAtchFileId(this.insertFileInfsByTemp(vo));
        comtnschdulinfoDAO.updateComtnschdulinfo(vo);
    }

    /**
	 * COMTNSCHDULINFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
        comtnschdulinfoDAO.deleteComtnschdulinfo(vo);
    }
    
    /**
	 * COMTNEVENTADHRNC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComtneventadhrnc(ComtnschdulinfoVO vo) throws Exception {
        comtnschdulinfoDAO.deleteComtneventadhrnc(vo);
    }

    /**
	 * COMTNSCHDULINFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception {
    	if(!"Y".equals(vo.getMngrAt())) comtnschdulinfoDAO.updateComtnschdulinfoCo(vo);		//조회수 증가
    	return comtnschdulinfoDAO.selectComtnschdulinfo(vo);
    }

    /**
	 * 객관식 주관식 이벤트 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschduInfo(ComtnschdulinfoVO vo) throws Exception {
    	return comtnschdulinfoDAO.selectComtnschduInfo(vo);
    }
    
    /**
	 * 객관식 주관식 이벤트 결과 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschduInfoResult(ComtnschdulinfoVO vo) throws Exception {
    	return comtnschdulinfoDAO.selectComtnschduInfoResult(vo);
    }
    
    /**
	 * 신청이벤트 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    public ComtnschdulinfoVO selectComtnschdulForm(ComtnschdulinfoVO vo) throws Exception {
    	return this.comtnschdulinfoDAO.selectComtnschdulForm(vo);
   
    }

    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoList_S(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectComtnschdulinfoList_S(searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoList_D(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectComtnschdulinfoList_D(searchVO);
    }
    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    public int selectComtnschdulinfoListTotCnt(ComtnschdulinfoDefaultVO searchVO) {
		return comtnschdulinfoDAO.selectComtnschdulinfoListTotCnt(searchVO);
	}
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectUserEventList(ComtnschdulinfoDefaultVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectUserEventList(searchVO);
    }
    
    /**
	 * COMTNSCHDULINFO 마이페이지 메인목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectUserEventMain(ComtnschdulinfoVO comtnschdulinfoVO) throws Exception {
        return comtnschdulinfoDAO.selectUserEventMain(comtnschdulinfoVO);
    }
    
    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    public int selectUserEventListTotCnt(ComtnschdulinfoDefaultVO searchVO) {
		return comtnschdulinfoDAO.selectUserEventListTotCnt(searchVO);
	}
    
    /**
	 * 이벤트 중복 사용자 조회
	 * @exception
	 */
    public boolean isRegDuplicate(ComtneventadhrncVO user) {
		return this.comtnschdulinfoDAO.isRegDuplicate(user);
	}
    
    /**
	 * 이벤트 중복 참여자 조회
	 * @exception
	 */
    public boolean isAnswerDuplicate(ComtnschdulinfoVO user) {
		return this.comtnschdulinfoDAO.isAnswerDuplicate(user);
	}
    
    /**
	 * ComtneventadhrncVO 이벤트 사용자 등록
	 * @param comtneventadhrncVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public String insertEventUser(ComtneventadhrncVO comtneventadhrncVO) throws Exception {
		String result = comtnschdulinfoDAO.insertEventUser(comtneventadhrncVO);
		return result;
	}
	
	/**
	 * @param 이벤트 참여자 답안 ComtneventaswperVO
	 * @return void형 
	 * @exception Exception
	 */
	public void addUserAnswerByBatch(ComtneventadhrncVO comtneventadhrncVO, List<ComtneventaswperVO> ary) throws Exception {
		comtnschdulinfoDAO.insertEventUser(comtneventadhrncVO);		//이벤트 참여자 정보 입력
		comtnschdulinfoDAO.addUserAnswerByBatch(ary);
		/*
		//포인트지급(설문조사)
    	ComtnmlguserlogVO mlgVO = new ComtnmlguserlogVO();
    	mlgVO.setSiteId(comtneventadhrncVO.getSiteId());
	  	mlgVO.setUserId(comtneventadhrncVO.getUserId());
	  	mlgVO.setMlgCode("PTL_POLL_JOIN");
	  	mlgVO.setRefrnProgrmId(comtneventadhrncVO.getSchdulId());
	  	comtnmlguserlogDAO.insertComtnmlguserlog(mlgVO);
	  	*/
	  }

	/**
	 * ComtneventadhrncVO 신청 이벤트 사용자 답안 등록
	 * @param comtneventadhrncVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public String insertEventFormAswper(ComtneventformaswperVO vo) throws Exception {
		/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdEventFormAnwperService.getNextStringId();
    	vo.setAswperId(id);
    	log.debug(vo.toString());
    	
    	return comtnschdulinfoDAO.insertEventFormAswper(vo);
	}
	
	/**
	 * ComtneventadhrncVO 신청 이벤트 사용자 답안 수정
	 * @param comtneventadhrncVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public void updateEventFormAswper(ComtneventformaswperVO vo) throws Exception {
    	comtnschdulinfoDAO.updateEventFormAswper(vo);
	}
	
	/**
	 * COMTNEVENTADHRNC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 목록
	 * @exception Exception
	 */
    public List<ComtneventadhrncVO> selectComtneventadhrncList(ComtneventadhrncVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectComtneventadhrncList(searchVO);
    }

    /**
	 * COMTNEVENTADHRNC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    public int selectComtneventadhrncListTotCnt(ComtneventadhrncVO searchVO) {
		return comtnschdulinfoDAO.selectComtneventadhrncListTotCnt(searchVO);
	}
    
    /**
	 * COMTNEVENTPRZWNER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtneventprzwner(ComtneventprzwnerVO vo) throws Exception {
    	comtnschdulinfoDAO.insertComtneventprzwner(vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER을 수동 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComtneventprzwnerhopr(ComtneventprzwnerVO vo) throws Exception {
    	comtnschdulinfoDAO.insertComtneventprzwnerhopr(vo);
    }
    
    /**
	 * 이벤트 신청자를 취소시킨다
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void delComtneventprzwner(ComtneventprzwnerVO vo) throws Exception {
    	comtnschdulinfoDAO.delComtneventprzwner(vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    public List selectComtneventprzwnerList(ComtneventprzwnerDefaultVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectComtneventprzwnerList(searchVO);
    }
    
    /**
	 * COMTNEVENTADHRNC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerCnt(ComtneventprzwnerDefaultVO searchVO) {
		return comtnschdulinfoDAO.selectComtneventprzwnerCnt(searchVO);
	}

    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerListTotCnt(ComtneventprzwnerDefaultVO searchVO) {
		return comtnschdulinfoDAO.selectComtneventprzwnerListTotCnt(searchVO);
	}
    
    /**
	 * COMTNEVENTFORMASWPER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtneventformaswperVO
	 * @return 조회한 COMTNEVENTFORMASWPER
	 * @exception Exception
	 */
    public ComtneventformaswperVO selectComtneventformaswper(ComtneventformaswperVO vo) throws Exception {
        return comtnschdulinfoDAO.selectComtneventformaswper(vo);
    }
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    public List selectComtneventprzwnerUserList(ComtneventprzwnerDefaultVO searchVO) throws Exception {
        return comtnschdulinfoDAO.selectComtneventprzwnerUserList(searchVO);
    }

    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    public int selectComtneventprzwnerUserListCnt(ComtneventprzwnerDefaultVO searchVO) {
		return comtnschdulinfoDAO.selectComtneventprzwnerUserListCnt(searchVO);
	}
    
    /**
	 * 주관식 결과 화면목록을 조회한다.
	 * @param ComtneventaswperVO
	 */
    public Map<String, Object> selectCommunitySbjctList(ComtneventaswperVO comtneventaswperVO) throws Exception {
    	List<ComtneventaswperVO> resultList = comtnschdulinfoDAO.selectCommunitySbjctList(comtneventaswperVO);
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("resultList", resultList);
    	return map;
    }
    
    /**
	 * 이벤트 사용자별 참여내역을 조회한다
	 * @param ComtneventaswperVO
	 */
    public List selectCommunityAswper(ComtneventaswperVO comtneventaswperVO) throws Exception {
        return comtnschdulinfoDAO.selectCommunityAswper(comtneventaswperVO);
    }


    /**
	 * 이벤트 참여횟수를 조회한다.
	 * @exception
	 */
    public int selectComtneventadhrncCnt(ComtnschdulinfoVO vo) {
		return comtnschdulinfoDAO.selectComtneventadhrncCnt(vo);
	}
    
    /**
	 * COMTNSCHDULINFO 팝업목록을 조회한다.
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoByPopupList() throws Exception {
        return comtnschdulinfoDAO.selectComtnschdulinfoByPopupList();
    }
}
