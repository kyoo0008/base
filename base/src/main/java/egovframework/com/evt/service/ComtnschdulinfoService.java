package egovframework.com.evt.service;

import java.util.List;
import java.util.Map;

import egovframework.com.evt.service.ComtnschdulinfoDefaultVO;
import egovframework.com.evt.service.ComtnschdulinfoVO;
import egovframework.com.evt.service.ComtneventadhrncVO;

/**
 * @Class Name : ComtnschdulinfoService.java
 * @Description : Comtnschdulinfo Business class
 * @Modification Information
 *
 * @author 이호영 
 * @since 2011.08.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ComtnschdulinfoService {
	
	/**
	 * COMTNSCHDULINFO을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtnschdulinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * COMTNSCHDULINFO을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형
	 * @exception Exception
	 */
    void updateComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * COMTNSCHDULINFO을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * COMTNEVENTADHRNC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComtnschdulinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComtneventadhrnc(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * COMTNSCHDULINFO을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 COMTNSCHDULINFO
	 * @exception Exception
	 */
    ComtnschdulinfoVO selectComtnschdulinfo(ComtnschdulinfoVO vo) throws Exception;

    /**
	 * 객관식 주관식 이벤트 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    ComtnschdulinfoVO selectComtnschduInfo(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * 객관식 주관식 이벤트 결과 조회.
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    ComtnschdulinfoVO selectComtnschduInfoResult(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * 참여 이벤트 조회
	 * @param vo - 조회할 정보가 담긴 ComtnschdulinfoVO
	 * @return 조회한 ComtnschdulinfoVO
	 * @exception Exception
	 */
    ComtnschdulinfoVO selectComtnschdulForm(ComtnschdulinfoVO vo) throws Exception;
    
    /**
	 * COMTNSCHDULINFO 목록을 월별로 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    List selectComtnschdulinfoList_S(ComtnschdulinfoDefaultVO searchVO) throws Exception;
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    List selectComtnschdulinfoList_D(ComtnschdulinfoDefaultVO searchVO) throws Exception;
    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    int selectComtnschdulinfoListTotCnt(ComtnschdulinfoDefaultVO searchVO);
    
    /**
	 * COMTNSCHDULINFO 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    List selectUserEventList(ComtnschdulinfoDefaultVO searchVO) throws Exception;
    
    /**
	 * COMTNSCHDULINFO 메인 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    List selectUserEventMain(ComtnschdulinfoVO comtnschdulinfoVO) throws Exception;
    
    /**
	 * COMTNSCHDULINFO 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNSCHDULINFO 총 갯수
	 * @exception
	 */
    int selectUserEventListTotCnt(ComtnschdulinfoDefaultVO searchVO);
    
    /**
	 * 이벤트 중복 사용자 조회
	 * @exception
	 */
    boolean isRegDuplicate(ComtneventadhrncVO comtneventadhrncVO);
    
    /**
	 * 이벤트 중복 참여자 조회
	 * @exception
	 */
    boolean isAnswerDuplicate(ComtnschdulinfoVO user);
    
    /**
	 * @param ComtneventadhrncVO 이벤트 사용자 등록
	 * @return result 등록결과
	 * @throws Exception
	 */
	public String insertEventUser(ComtneventadhrncVO comtneventadhrncVO) throws Exception;
	
	/**
	 * @param 이벤트 참여자 답안 ComtneventaswperVO
	 * @return void형 
	 * @exception Exception
	 */
    void addUserAnswerByBatch(ComtneventadhrncVO comtneventadhrncVO, List<ComtneventaswperVO> ary) throws Exception;
    
    /**
	 * @param 신청 이벤트 참여자 답안 ComtneventaswperVO
	 */
    public String insertEventFormAswper(ComtneventformaswperVO vo) throws Exception;
    
    /**
	 * @param 신청 이벤트 참여자 수정답안 ComtneventaswperVO
	 */
    public void updateEventFormAswper(ComtneventformaswperVO vo) throws Exception;
    
    /**
	 * COMTNEVENTADHRNC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 목록
	 * @exception Exception
	 */
    List<ComtneventadhrncVO> selectComtneventadhrncList(ComtneventadhrncVO searchVO) throws Exception;
    
    /**
	 * COMTNEVENTADHRNC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    int selectComtneventadhrncListTotCnt(ComtneventadhrncVO searchVO);

    /**
	 * COMTNEVENTPRZWNER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    void insertComtneventprzwner(ComtneventprzwnerVO vo) throws Exception;
    
    /**
	 * COMTNEVENTPRZWNER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComtneventprzwnerVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    void insertComtneventprzwnerhopr(ComtneventprzwnerVO vo) throws Exception;
    
    
    /**
	 * @param 이벤트 신청자를 취소시킨다 ComtneventprzwnerVO
	 */
    public void delComtneventprzwner(ComtneventprzwnerVO vo) throws Exception;
    
    /**
	 * COMTNEVENTPRZWNER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    List selectComtneventprzwnerList(ComtneventprzwnerDefaultVO searchVO) throws Exception;
    
    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTADHRNC 총 갯수
	 * @exception
	 */
    int selectComtneventprzwnerCnt(ComtneventprzwnerDefaultVO searchVO);
    
    /**
	 * COMTNEVENTPRZWNER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    int selectComtneventprzwnerListTotCnt(ComtneventprzwnerDefaultVO searchVO);
    
    /**
	 * COMTNEVENTFORMASWPER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComtneventformaswperVO
	 * @return 조회한 COMTNEVENTFORMASWPER
	 * @exception Exception
	 */
    ComtneventformaswperVO selectComtneventformaswper(ComtneventformaswperVO vo) throws Exception;
    
    /**
	 * 사용자별 당첨목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 목록
	 * @exception Exception
	 */
    List selectComtneventprzwnerUserList(ComtneventprzwnerDefaultVO searchVO) throws Exception;
    
    /**
	 * 사용자별 당첨자 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COMTNEVENTPRZWNER 총 갯수
	 * @exception
	 */
    int selectComtneventprzwnerUserListCnt(ComtneventprzwnerDefaultVO searchVO);

    /**
	 * 주관식 결과 화면목록을 조회한다.
	 * @exception
	 */
    public Map<String, Object> selectCommunitySbjctList(ComtneventaswperVO comtneventaswperVO) throws Exception;
    
    /**
	 * 이벤트 사용자별 참여내역을 조회한다
	 * @exception
	 */
    List selectCommunityAswper(ComtneventaswperVO comtneventaswperVO) throws Exception;
    
    /**
	 * 이벤트 참여횟수를 조회한다.
	 * @exception
	 */
	public int selectComtneventadhrncCnt(ComtnschdulinfoVO vo) throws Exception;
	
	/**
	 * COMTNSCHDULINFO 팝업목록을 조회한다.
	 * @return COMTNSCHDULINFO 목록
	 * @exception Exception
	 */
    public List selectComtnschdulinfoByPopupList() throws Exception;
}
