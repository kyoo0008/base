package egovframework.com.cop.cmy.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.impl.BBSAttributeManageDAO;

import egovframework.com.cop.cmy.service.Community;
import egovframework.com.cop.cmy.service.CommunityUser;
import egovframework.com.cop.cmy.service.CommunityUserVO;
import egovframework.com.cop.cmy.service.CommunityVO;
import egovframework.com.cop.cmy.service.CommunityMnu;
import egovframework.com.cop.cmy.service.EgovCommunityManageService;
import egovframework.com.cop.com.service.BoardUseInf;
import egovframework.com.sec.ram.service.AuthorManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 커뮤니티 정보를 관리하기 위한 서비스 구현  클래스
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
 *   2009.4.2  이삼섭          최초 생성
 *   2012. 1. 26 이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
 *
 * </pre>
 */
@Service("EgovCommunityManageService")
public class EgovCommunityManageServiceImpl extends AbstractServiceImpl implements EgovCommunityManageService {

    /** EgovBBSAttributeManageService */
    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    /** CommunityManageDAO */
    @Resource(name = "CommunityManageDAO")
    private CommunityManageDAO cmmntyDAO;

    /** egovCmmntyIdGnrService */
    @Resource(name = "egovCmmntyIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "BBSAttributeManageDAO")
	private BBSAttributeManageDAO    attrbMngDAO;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    Logger log = Logger.getLogger(this.getClass());
	
    /**
     * 커뮤니티 주소를 매칭하여 커뮤니티ID를 찾는다.
     * 
     * @param cmmntyAdres 
     * @return
     * @throws Exception
     */
    public String selectCmmntyFindId(String cmmntyAdres) throws Exception {
    	return cmmntyDAO.selectCmmntyFindId(cmmntyAdres);
    }
    
    /**
     * 커뮤니티에 대한 정보를 삭제한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#deleteCommunityInf(egovframework.com.cop.cmy.service.Community)
     */
    public void deleteCommunityInf(Community cmmnty) throws Exception {
	cmmntyDAO.deleteCommunityInf(cmmnty);
	
	//커뮤니티에서 사용되는 게시판을 폐쇄시킨다.
	//BoardUseInfVO bdUseVO = new BoardUseInfVO();
	
	//bdUseVO.setLastUpdusrId(cmmnty.getLastUpdusrId());
	//bdUseVO.setCmmntyId(cmmnty.getCmmntyId());

	//bbsUseService.deleteAllBBSUseInfByCmmnty(bdUseVO);

	//커뮤니티 사용자도 삭제처리해야 한다.
	//CommunityUser cmmntyUser = new CommunityUser();
	//cmmntyUser.setSecsnDe(EgovDateUtil.getToday());
	//cmmntyUser.setCmmntyId(cmmnty.getCmmntyId());
	//cmmntyUser.setLastUpdusrId(cmmnty.getLastUpdusrId());
	
	//cmmntyDAO.deleteAllCommunityUserInf(cmmntyUser);
    }

    /**
     * 커뮤니티 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#deleteCommunityUserInf(egovframework.com.cop.cmy.service.CommunityUser)
     */
    public void deleteCommunityUserInf(CommunityUser cmmntyUser) throws Exception {
	cmmntyDAO.deleteCommunityUserInf(cmmntyUser);
    }

    /**
     * 커뮤니티에 대한 게시판 사용정보를 등록한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#insertCommunityBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInf)
     */
    public void insertCommunityBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	//cmmntyDAO.insertCommunityBBSUseInf(bdUseInf);
	//커뮤니티에 게시판을 하나 추가하게 되면 - _- 해당 게시판이 등록된 커뮤니티의
	//모든 소속사용자에게 사용 권한을 줘야하나 - _-? 일단 그렇게 진행
    }

    /**
     * 커뮤니티에 대한 정보를 등록한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#insertCommunityInf(egovframework.com.cop.cmy.service.Community)
     */
    public void insertCommunityInf(Community cmmnty) throws Exception {
    	
	    String cmmntyId = idgenService.getNextStringId();
	
		cmmnty.setCmmntyId(cmmntyId);
		cmmntyDAO.insertCommunityInf(cmmnty);

		CommunityUser cmmntyUser = new CommunityUser();
		cmmntyUser.setCmmntyId(cmmnty.getCmmntyId());
		cmmntyUser.setEmplyrId(cmmnty.getEmplyrId());
		cmmntyUser.setEmplyrNm(cmmnty.getFrstRegisterNm());
		cmmntyUser.setMngrAt("Y");
		cmmntyUser.setAuthorCode("10");
		cmmntyUser.setUseAt("Y");
		cmmntyUser.setFrstRegisterId(cmmnty.getFrstRegisterId());
		cmmntyDAO.insertCommunityUserInf(cmmntyUser);
		
		List<CommunityMnu> result = makeBdMstrListforCmmnty(cmmnty);
	
		Iterator<CommunityMnu> iter = result.iterator();
		while (iter.hasNext()) {
			insertBBSMasterInf(iter.next());
		}
    }

    /**
     * 커뮤니티용 게사판 정보를 생성한다.
     * 
     * @param cmmnty
     * @return
     */
    private List<CommunityMnu> makeBdMstrListforCmmnty(Community cmmnty) {
    CommunityMnu bdMstr;
	ArrayList<CommunityMnu> result = new ArrayList<CommunityMnu>();

	for (int i = 0; i < 4; i++) {
	    bdMstr = new CommunityMnu();
	    
	    bdMstr.setSiteId(cmmnty.getSiteId());
	    bdMstr.setSysTyCode(cmmnty.getSysTyCode());
	    bdMstr.setFrstRegisterId(cmmnty.getFrstRegisterId());
	    bdMstr.setUseAt("Y");								//사용여부
	    bdMstr.setTrgetId(cmmnty.getCmmntyId());			//커뮤니티 아이디
	    bdMstr.setRegistSeCode("REGC06");					//등록구분코드(REGC06:커뮤니티 게시판 등록)
	    //bdMstr.setTmplatId("TMPLAT_0000000000014");		//템플릿코드(기본커뮤니티)
	    bdMstr.setMainOutptAt("Y");
	    
	    if (i == 0) {
	    	if("CMY02".equals(cmmnty.getCmmntySeCode())) {
	    		bdMstr.setBbsNm("알림장");			//게시판명
	    		bdMstr.setNotifyAt("Y");
	    	} else {
				bdMstr.setBbsNm("공지게시판");		//게시판명
	    	}
	    	bdMstr.setReplyPosblAt("N");			//답장여부
			bdMstr.setFileAtchPosblAt("Y");			//파일첨부가능여부
			bdMstr.setCommentUseAt("N");			//뎃글사용우무
			//bdMstr.setPosblAtchFileNumber("5");	//파일첨부가능갯수
			bdMstr.setBbsAttrbCode("BBSA03");		//게시판 속성(BBSA02:겔러리 BBSA03:일반)
			bdMstr.setInqireAuthor("02");			//보기권한(01:손님 02:준회원 03:정회원 10:관리자)
		    bdMstr.setRegistAuthor("10");			//쓰기권한
		    bdMstr.setAnswerAuthor("10");			//답글권한
	    } else if (i == 1) {
	    	bdMstr.setReplyPosblAt("N");
			bdMstr.setFileAtchPosblAt("Y");
			bdMstr.setCommentUseAt("");
			//bdMstr.setPosblAtchFileNumber("5");
			bdMstr.setBbsAttrbCode("BBSA03");
			bdMstr.setBbsNm("자료실");
			bdMstr.setInqireAuthor("02");		//보기권한(01:손님 02:준회원 03:정회원 10:관리자)
		    bdMstr.setRegistAuthor("02");		//쓰기권한
		    bdMstr.setAnswerAuthor("02");		//답글권한
	    } else if (i == 2) {
	    	bdMstr.setReplyPosblAt("N");
			bdMstr.setFileAtchPosblAt("Y");
			bdMstr.setCommentUseAt("Y");
			//bdMstr.setPosblAtchFileNumber("5");
			bdMstr.setBbsAttrbCode("BBSA02");
			bdMstr.setBbsNm("사진게시판");
			bdMstr.setInqireAuthor("02");		//보기권한(01:손님 02:준회원 03:정회원 10:관리자)
		    bdMstr.setRegistAuthor("02");		//쓰기권한
		    bdMstr.setAnswerAuthor("02");		//답글권한
	    } else {
	    	bdMstr.setReplyPosblAt("Y");
			bdMstr.setFileAtchPosblAt("Y");
			bdMstr.setCommentUseAt("Y");
			//bdMstr.setPosblAtchFileNumber("5");
			bdMstr.setBbsAttrbCode("BBSA03");
			bdMstr.setBbsNm("자유게시판");
			bdMstr.setInqireAuthor("02");		//보기권한(01:손님 02:준회원 03:정회원 10:관리자)
		    bdMstr.setRegistAuthor("02");		//쓰기권한
		    bdMstr.setAnswerAuthor("02");		//답글권한
	    }
	    result.add(bdMstr);
	}
	
	return result;
    }

    /**
     * 커뮤니티 사용자 정보를 등록한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#insertCommunityUserInf(egovframework.com.cop.cmy.service.CommunityUser)
     */
    public String insertCommunityUserInf(CommunityUser cmmntyUser) throws Exception {
	//cmmntyId
	CommunityVO vo = new CommunityVO();
	
	vo.setCmmntyId(cmmntyUser.getCmmntyId());

	String retVal = "";
	int cnt = cmmntyDAO.checkExistUser(cmmntyUser);
	if (cnt == 0) {
	    cmmntyDAO.insertCommunityUserInf(cmmntyUser);
	} else {
	    retVal = "EXIST";
	}
	
	return retVal;
    }
	
	/**
     * 커뮤니티 사용자 정보를 확인한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#checkCommunityUserInf(egovframework.com.cop.cmy.service.CommunityUser)
     */
    public String checkCommunityUserInf(CommunityUser cmmntyUser) throws Exception {
	// 회원가입 승인처리 적용시 기존 insertCommunityUserInf 대신 사용자 확인만 확인

		//cmmntyId
		CommunityVO vo = new CommunityVO();
		vo.setCmmntyId(cmmntyUser.getCmmntyId());

		if (cmmntyDAO.checkExistUser(cmmntyUser) == 0) {
		    return "";
		} else {
		    return "EXIST";
		}
    }

    /**
     * 커뮤니티 게사판 사용정보 목록을 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCommunityBBSUseInf(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public List<CommunityVO> selectCommunityBBSUseInf(CommunityVO cmmntyVO) throws Exception {
	return cmmntyDAO.selectCommunityBBSUseInf(cmmntyVO);
    }
    
    /**
     * 커뮤니티 게사판 사용정보 목록을 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCommunityBBSUseInf(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public List<CommunityVO> selectCommunityMenuList(CommunityVO cmmntyVO) throws Exception {
	return cmmntyDAO.selectCommunityMenuList(cmmntyVO);
    }

    /**
     * 커뮤니티에 대한 기본정보를 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCmmntyTemplat(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public CommunityVO selectCommunityInfo(CommunityVO cmmntyVO) throws Exception {
	return cmmntyDAO.selectCommunityInfo(cmmntyVO);
    }
    
	/**
     * 커뮤니티에 대한 특정 사용자 정보를 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCommunityInf(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public CommunityVO selectCommunityInf(CommunityVO cmmntyVO) throws Exception {

	//CommunityVO vo = cmmntyDAO.selectCommunityInf(cmmntyVO);
	
	//List<CommunityVO> result = cmmntyDAO.selectCommunityBBSUseInf(cmmntyVO);

	//CommunityUser cmmntyUser = new CommunityUser();	
	//cmmntyUser.setEmplyrId(cmmntyVO.getEmplyrId());
	//cmmntyUser.setCmmntyId(cmmntyVO.getCmmntyId());
	//cmmntyUser = cmmntyDAO.selectSingleCommunityUserInf(cmmntyUser);

	//Map<String, Object> map = new HashMap<String, Object>();
	
	//map.put("cmmntyMnuList", result);
	//map.put("cmmntyVO", vo);
	//map.put("cmmntyUser", cmmntyUser);

	return cmmntyDAO.selectCommunityInf(cmmntyVO);
    }

    /**
     * 커뮤니티 관리자 정보를 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public CommunityUser selectManager(CommunityVO cmmntyVO) throws Exception {
	CommunityUser cmmntyUser = new CommunityUser();

	List<CommunityUser> managers = cmmntyDAO.selectCommunityManagerInfs(cmmntyVO);

	if (managers.size() == 1) {
	    cmmntyUser.setEmplyrId(managers.get(0).getEmplyrId());
	    cmmntyUser.setEmplyrNm(managers.get(0).getEmplyrNm());
	} else if (managers.size() > 1) {
	    cmmntyUser.setEmplyrId(managers.get(0).getEmplyrId());
	    cmmntyUser.setEmplyrNm(managers.get(0).getEmplyrNm() + "외 " + (managers.size() - 1) + "명");
	} else {
	    // no-op
	    log.debug("No managers...");
	}

	return cmmntyUser;
    }

    /**
     * 커뮤니티 정보 목록을 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCommunityInfs(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public Map<String, Object> selectCommunityInfs(CommunityVO cmmntyVO) throws Exception {

	List<CommunityVO> result = cmmntyDAO.selectCommunityInfs(cmmntyVO);
	int cnt = cmmntyDAO.selectCommunityInfsCnt(cmmntyVO);

	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 커뮤니티 사용자 정보에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCommunityUserInfs(egovframework.com.cop.cmy.service.CommunityUserVO)
     */
    public Map<String, Object> selectCommunityUserInfs(CommunityUserVO cmmntyUserVO) throws Exception {
	return null;
    }

    /**
     * 커뮤니티 게시판 사용정보를 수정한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#updateCommunityBBSUseInf(egovframework.com.cop.bbs.com.service.BoardUseInf)
     */
    public void updateCommunityBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	cmmntyDAO.updateCommunityBBSUseInf(bdUseInf);
    }

    /**
     * 커뮤니티 정보를 수정한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#updateCommunityInf(egovframework.com.cop.cmy.service.Community)
     */
    public void updateCommunityInf(Community cmmnty) throws Exception {
	//CommunityUser cmmntyUser = new CommunityUser();

	//cmmntyUser.setUseAt("Y");
	//cmmntyUser.setMngrAt("Y");
	//cmmntyUser.setAuthorCode("10");
	//cmmntyUser.setLastUpdusrId(cmmnty.getLastUpdusrId());
	///cmmntyUser.setCmmntyId(cmmnty.getCmmntyId());
	//cmmntyUser.setEmplyrId(cmmnty.getEmplyrId());

	cmmntyDAO.updateCommunityInf(cmmnty);
	//cmmntyDAO.updateCommunityUserInf(cmmntyUser);
    }

    /**
     * 커뮤니티 사용자 정보를 수정한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#updateCommunityUserInf(egovframework.com.cop.cmy.service.CommunityUser)
     */
    public void updateCommunityUserInf(CommunityUser cmmntyUser) throws Exception {
	cmmntyDAO.updateCommunityUserInf(cmmntyUser);
    }

    /**
     * 포트릿을 위한 커뮤니티 정보 목록 정보를 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectCmmntyListPortlet(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public List<CommunityVO> selectCmmntyListPortlet(CommunityVO cmmntyVO) throws Exception {
	return cmmntyDAO.selectCmmntyListPortlet(cmmntyVO);
    }

    /**
     * 모든 커뮤니티 목록을 조회한다.
     * 
     * @see egovframework.com.cop.cmy.service.EgovCommunityManageService#selectAllCmmnty(egovframework.com.cop.cmy.service.CommunityVO)
     */
    public List<CommunityVO> selectAllCmmnty(CommunityVO cmmntyVO) throws Exception {
	return cmmntyDAO.selectAllCmmnty(cmmntyVO);
    }
    
    /**
     * 관리자 여부를 확인한다.
     */
    public boolean isManager(CommunityUser cmmntyUser) throws Exception {
		CommunityUser result = cmmntyDAO.selectSingleCommunityUserInf(cmmntyUser);
		
		if(result == null) {
			return false;
		}
		
		if (("10".equals(result.getAuthorCode()) || "Y".equals(result.getMngrAt())) &&  "Y".equals(result.getUseAt())) {
		    return true;
		}
		
		return false;
    }
    
    /**
	 * 모든 권한목록을 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
	public List<AuthorManageVO> selectAuthorAllList(AuthorManageVO authorManageVO) throws Exception {
    	return cmmntyDAO.selectAuthorAllList(authorManageVO);
    }     
	
	/**
     * 커뮤니티에 대한 특정 사용자 정보를 조회한다.
     * 
     * @param cmmntyUser 
     * @return
     * @throws Exception
     */
    public CommunityUser selectSingleCommunityUserInf(CommunityUser cmmntyUser) throws Exception {
    	return cmmntyDAO.selectSingleCommunityUserInf(cmmntyUser);
    }
        
    /**
     * 커뮤니티 정보 목록을 조회한다.
     * 
     */
    public List<CommunityUser> selectMyCommunityList(CommunityUser cmmntyUser) throws Exception {
    	return cmmntyDAO.selectMyCmmntyList(cmmntyUser);
    }
    
    /**
	 * 커뮤니티명에 대한 중복확인 결과값을 얻어온다.
	 * @param cmmntyVO
	 * @return
	 * @throws Exception
	 */
	public int checkCmmntyNmDplct(CommunityVO cmmntyVO) {
		return cmmntyDAO.checkCmmntyNmDplct(cmmntyVO);
	}
	
	/**
	 * 커뮤니티주소에 대한 중복확인 결과값을 얻어온다.
	 * @param cmmntyVO
	 * @return
	 * @throws Exception
	 */
	public int checkCmmntyAdresDplct(CommunityVO cmmntyVO) {
		return cmmntyDAO.checkCmmntyAdresDplct(cmmntyVO);
	}
	
    /**
	 * 커뮤니티에 대한 메뉴를 등록한다.
	 * @param cmmntyVO
	 * @return
	 * @throws Exception
	 */
    public void insertCommunityMnu(CommunityMnu cmmntyMnu) throws Exception {
	cmmntyDAO.insertCommunityMnu(cmmntyMnu);
    }

    /**
     * 커뮤니티 대한 메뉴를 수정한다.
	 * @param cmmntyVO
	 * @return
	 * @throws Exception
     */
    public void updateCommunityMnu(CommunityMnu cmmntyMnu) throws Exception {
	cmmntyDAO.updateCommunityMnu(cmmntyMnu);
    }
    
    /**
     * 메뉴 정렬순서를 수정한다.
     * @param 
	 * @return
	 * @throws Exception
     */
    public void updateCommunitySortOrdr(CommunityMnu cmmntyMnu) throws Exception {
    	int sourceSortOrdr = cmmntyMnu.getSortOrdr();

    	CommunityMnu targetMenu = cmmntyDAO.selectCommunityMnuSortOrdr(cmmntyMnu);

    	if(targetMenu != null && targetMenu.getBbsId() != null && targetMenu.getBbsId() != "") {
    		cmmntyMnu.setSortOrdr(targetMenu.getSortOrdr());
    		cmmntyDAO.updateCommunityMnuSortOrdr(cmmntyMnu);

    		cmmntyMnu.setBbsId(targetMenu.getBbsId());
    		cmmntyMnu.setSortOrdr(sourceSortOrdr);
    		cmmntyDAO.updateCommunityMnuSortOrdr(cmmntyMnu);
    	}
    }	
    
    /**
     * 사용자별 커뮤니티 가입 목록을 조회한다.
     * @param CommunityVO
	 * @return
	 * @throws Exception
     */
    public List<CommunityUser> selectMyCmmntyList(CommunityUser cmmntyUser) throws Exception {
	return cmmntyDAO.selectMyCmmntyList(cmmntyUser);
    }
    
    /**
     *  커뮤니티 게시판 속성 정보의 목록을 조회 한다.
     * @param cmmntyMnu
	 * @return
	 * @throws Exception
     */
    public Map<String, Object> selectCmmntyMasterInfs(CommunityMnu cmmntyMnu) throws Exception {
      List<CommunityMnu> result = cmmntyDAO.selectCmmntyBBSMasterInfs(cmmntyMnu);
      int cnt = cmmntyDAO.selectCmmntyBBSMasterInfsCnt(cmmntyMnu);
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("resultList", result);
      map.put("resultCnt", Integer.toString(cnt));
      
      return map;
    }
    
    /**
     * 커뮤니티 게시판 속성정보 한 건을 상세조회한다.
     * @param cmmntyMnu
	 * @return
	 * @throws Exception
     */
    public CommunityMnu selectCmmntyMasterInf(CommunityMnu cmmntyMnu) throws Exception {
    	CommunityMnu result = cmmntyDAO.selectCmmntyBBSMasterInf(cmmntyMnu);   
      return result;
      // //-------------------------------
    }
    
    /**
     * 커뮤니티 게시판 속성정보 한 건을 상세조회한다.
     * @param cmmntyMnu
	 * @return
	 * @throws Exception
     */
    public void updateCommunityMnuMainAt(CommunityMnu cmmntyMnu) throws Exception {
    	cmmntyDAO.updateCommunityMnuMainAt(cmmntyMnu);
	}
    
    
    /**
     * 커뮤니티 게시판 메인 목록을 가져온다.
     */
    public List<CommunityMnu> selectCommunityBbsMaster(CommunityVO cmmntyVO) throws Exception {
      return cmmntyDAO.selectCommunityBbsMaster(cmmntyVO);
    }
    
    
    /**
     * 조건에 맞는 메뉴별 신규목록을 조회 한다.
     * 
     */
    public List<BoardVO> selectCommunityBoardMyArticles(CommunityVO cmmntyVO) throws Exception {
  	  return cmmntyDAO.selectCommunityBoardMyArticles(cmmntyVO);
    }
    
    /**
     * 커뮤니티 게시판의 조건에 맞는 전체게시물을 조회한다.
     * 
     */
    public List<BoardVO> selectCommunityBoardAllArticles(CommunityVO cmmntyVO) throws Exception {
  	  return cmmntyDAO.selectCommunityBoardAllArticles(cmmntyVO);
    }

    
    /**
     * 커뮤니티 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
     * 
     */
    public int selectCommunityBoardAllArticlesCnt(CommunityVO cmmntyVO) throws Exception {
  	  return cmmntyDAO.selectCommunityBoardAllArticlesCnt(cmmntyVO);
    }
    
    
    /**
     * 조건에 맞는 메뉴별 신규목록을 조회 한다.
     * 
     */
    public List<BoardVO> selectBoardNewArticles(BoardVO boardVO) throws Exception {
  	  return cmmntyDAO.selectBoardNewArticles(boardVO);
    }
    
    /**
     * 게시판 속성정보를 수정한다.
     * 
     */
    public void updateCmmntyBBSMasterInf(BoardMaster boardMaster) throws Exception {
      attrbMngDAO.updateBBSMasterInf(boardMaster);
    }
    
    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     */
    public List<BoardVO> selectCmmntyBoardArticles(BoardVO boardVO) throws Exception {
  	  return cmmntyDAO.selectCmmntyBoardArticles(boardVO);
    }
    
    /**
     * 커뮤니티 게시판을 등록한다.
     * 
     */
    public void insertBBSMasterInf(CommunityMnu cmmntyMnu) throws Exception {
    	bbsAttrbService.insertBBSMastetInf(cmmntyMnu);
    	insertCommunityMnu(cmmntyMnu);
    	
    }
    
    /**
     * 커뮤니티 게시판을 수정한다.
     * 
     */
    public void updateBBSMasterInf(CommunityMnu cmmntyMnu) throws Exception {
    	bbsAttrbService.updateBBSMasterInf(cmmntyMnu);
    	updateCommunityMnu(cmmntyMnu);    	
    }
    
    /**
     * 모든 커뮤니티 게시판의 조건에 맞는 전체게시물을 조회한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<BoardVO> selectSearchCommunityBoardArticleList(BoardVO boardVO) throws Exception {
    	return cmmntyDAO.selectSearchCommunityBoardArticleList(boardVO);
    }
    
    /**
     * 모든 커뮤니티 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectSearchCommunityBoardArticleListCnt(BoardVO boardVO) throws Exception {
    	return cmmntyDAO.selectSearchCommunityBoardArticleListCnt(boardVO);
    }
    
    /**
     * 모든 커뮤니티 알림장 게시판의 조건에 맞는 전체게시물을 조회한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<BoardVO> selectSearchCommunityNotifyArticleList(BoardVO boardVO) throws Exception {
    	return cmmntyDAO.selectSearchCommunityNotifyArticleList(boardVO);
    }
    
    /**
     * 모든 커뮤니티 알림장 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectSearchCommunityNotifyArticleListCnt(BoardVO boardVO) throws Exception {
    	return cmmntyDAO.selectSearchCommunityNotifyArticleListCnt(boardVO);
    }
    
    /**
     * 모든 커뮤니티 알림장 게시판을 조회한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<BoardVO> selectSearchCommunityNotifyUrlList(BoardVO boardVO) throws Exception {
    	return cmmntyDAO.selectSearchCommunityNotifyUrlList(boardVO);
    }
}

