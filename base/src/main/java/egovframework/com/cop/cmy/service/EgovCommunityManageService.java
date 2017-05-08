package egovframework.com.cop.cmy.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.com.service.BoardUseInf;
import egovframework.com.sec.ram.service.AuthorManageVO;
/**
 * 커뮤니티 정보를 관리하기 위한 서비스 인터페이스 클래스
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
 *
 * </pre>
 */
public interface EgovCommunityManageService {	
	
	/**
     * 커뮤니티 주소를 매칭하여 커뮤니티ID를 찾는다.
     * 
     * @param cmmnty
     */
    public String selectCmmntyFindId(String cmmntyAdres) throws Exception;
    
    /**
     * 커뮤니티에 대한 정보를 등록한다.
     * 
     * @param cmmnty
     * @throws Exception
     */
    public void insertCommunityInf(Community cmmnty) throws Exception;

    /**
     * 커뮤니티 정보를 수정한다.
     * 
     * @param cmmnty
     * @throws Exception
     */
    public void updateCommunityInf(Community cmmnty) throws Exception;

    /**
     * 커뮤니티에 대한 정보를 삭제한다.
     * 
     * @param cmmnty
     * @throws Exception
     */
    public void deleteCommunityInf(Community cmmnty) throws Exception;

    /**
     * 커뮤니티 정보 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommunityInfs(CommunityVO cmmntyVO) throws Exception;

    /**
     * 커뮤니티 사용자 정보를 등록한다.
     * 
     * @param cmmntyUser
     * @throws Exception
     */
    public String insertCommunityUserInf(CommunityUser cmmntyUser) throws Exception;

    /**
     * 커뮤니티 사용자 정보를 확인한다.
     * 
     * @param cmmntyUser
     * @throws Exception
     */
    public String checkCommunityUserInf(CommunityUser cmmntyUser) throws Exception;

    /**
     * 커뮤니티 사용자 정보를 수정한다.
     * 
     * @param cmmntyUser
     * @throws Exception
     */
    public void updateCommunityUserInf(CommunityUser cmmntyUser) throws Exception;

    /**
     * 커뮤니티 사용정보를 삭제한다.
     * 
     * @param cmmntyUser
     * @throws Exception
     */
    public void deleteCommunityUserInf(CommunityUser cmmntyUser) throws Exception;

    /**
     * 커뮤니티 사용자 정보에 대한 목록을 조회한다.
     * 
     * @param cmmntyUserVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommunityUserInfs(CommunityUserVO cmmntyUserVO) throws Exception;

    /**
     * 커뮤니티에 대한 게시판 사용정보를 등록한다.
     * 
     * @param bdUseInf
     * @throws Exception
     */
    public void insertCommunityBBSUseInf(BoardUseInf bdUseInf) throws Exception;

    /**
     * 커뮤니티 게시판 사용정보를 수정한다.
     * 
     * @param bdUseInf
     * @throws Exception
     */
    public void updateCommunityBBSUseInf(BoardUseInf bdUseInf) throws Exception;

    /**
     * 커뮤니티 게사판 사용정보 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public List<CommunityVO> selectCommunityBBSUseInf(CommunityVO cmmntyVO) throws Exception;
    
    /**
     * 커뮤니티 게사판 사용정보 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public List<CommunityVO> selectCommunityMenuList(CommunityVO cmmntyVO) throws Exception;

    /**
     * 커뮤니티에 대한 기본정보를 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public CommunityVO selectCommunityInfo(CommunityVO cmmntyVO) throws Exception;
    
    /**
     * 커뮤니티에 대한 특정 사용자 정보를 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public CommunityVO selectCommunityInf(CommunityVO cmmntyVO) throws Exception;

    /**
     * 커뮤니티 관리자 정보를 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public CommunityUser selectManager(CommunityVO cmmntyVO) throws Exception;

    /**
     * 포트릿을 위한 커뮤니티 정보 목록 정보를 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public List<CommunityVO> selectCmmntyListPortlet(CommunityVO cmmntyVO) throws Exception;

    /**
     * 모든 커뮤니티 목록을 조회한다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
    public List<CommunityVO> selectAllCmmnty(CommunityVO cmmntyVO) throws Exception;
    
    /**
     * 관리자 여부를 확인한다.
     * 
     * @param cmmntyUser
     * @return
     * @throws Exception
     */
    public boolean isManager(CommunityUser cmmntyUser) throws Exception;
    
    /**
	 * 모든 권한목록을 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
	public List<AuthorManageVO> selectAuthorAllList(AuthorManageVO authorManageVO) throws Exception;
	
	/**
     * 커뮤니티에 대한 특정 사용자 정보를 조회한다.
     * 
     * @param cmmntyUser
     * @return
     * @throws Exception
     */
    public CommunityUser selectSingleCommunityUserInf(CommunityUser cmmntyUser) throws Exception;
    
    /**
     * 커뮤니티 정보 목록을 조회한다.
     * 
     */
    public List<CommunityUser> selectMyCommunityList(CommunityUser cmmntyUser) throws Exception;
    
    /**
     * 커뮤니티명에 대한 중복확인 결과값을 얻어온다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
	public int checkCmmntyNmDplct(CommunityVO cmmntyVO) throws Exception;
	
	/**
     * 커뮤니티주소에 대한 중복확인 결과값을 얻어온다.
     * 
     * @param cmmntyVO
     * @return
     * @throws Exception
     */
	public int checkCmmntyAdresDplct(CommunityVO cmmntyVO) throws Exception;
	
	/**
     * 커뮤니티에 대한 메뉴를 등록한다.
     * 
     * @param cmmntyMnu
     * @throws Exception
     */
    public void insertCommunityMnu(CommunityMnu cmmntyMnu) throws Exception;
    
    /**
     * 커뮤니티에 메뉴를 수정한다.
     * 
     * @param cmmntyMnu
     */
     public void updateCommunityMnu(CommunityMnu cmmntyMnu) throws Exception;
     
    /**
     * 커뮤니티에 메뉴 정렬순서를 수정한다.
     * 
     * @param cmmntyMnu
     */
     public void updateCommunitySortOrdr(CommunityMnu cmmntyMnu) throws Exception;
     
     /**
      * 사용자별 커뮤니티 가입 목록을 조회한다.
      * 
      * @param cmmntyVO
      * @return
      * @throws Exception
      */
     public List<CommunityUser> selectMyCmmntyList(CommunityUser cmmntyUser) throws Exception;
     
     /**
      * 게시판 속성 정보의 목록을 조회 한다.
      * 
      * @param communityMnu
      */
     public Map<String, Object> selectCmmntyMasterInfs(CommunityMnu communityMnu) throws Exception;
     
     /**
      * 게시판 속성정보 한 건을 상세조회한다.
      * 
      * @param CommunityMnu
      */
     public CommunityMnu selectCmmntyMasterInf(CommunityMnu communityMnu) throws Exception;

     /**
      * 커뮤니티 메인노출유무를 설정한다.
      * 
      * @param cmmnty
      * @throws Exception
      */
     public void updateCommunityMnuMainAt(CommunityMnu communityMnu) throws Exception;
     
     /**
      * 커뮤니티 게시판 메인 목록을 조회한다.
      * 
      * @param cmmntyVO
      * @throws Exception
      */
     public List<CommunityMnu> selectCommunityBbsMaster(CommunityVO cmmntyVO) throws Exception;
     
     
     /**
      * 가입한 커뮤니티 게시판에 최신글을 조회한다.
      * 
      * @param cmmntyVO
      * @throws Exception
      */
     public List<BoardVO> selectCommunityBoardMyArticles(CommunityVO cmmntyVO) throws Exception;
     
     /**
      * 커뮤니티 게시판의 조건에 맞는 전체게시물을 조회한다.
      * 
      * @param cmmntyVO
      * @throws Exception
      */
     public List<BoardVO> selectCommunityBoardAllArticles(CommunityVO cmmntyVO) throws Exception;
     
     /**
      * 커뮤니티 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
      * 
      * @param cmmntyVO
      * @return
      * @throws Exception
      */
     public int selectCommunityBoardAllArticlesCnt(CommunityVO cmmntyVO) throws Exception;

     /**
      * 조건에 맞는 메뉴별 신규목록을 조회 한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public List<BoardVO> selectBoardNewArticles(BoardVO boardVO) throws Exception;
     
     /**
      * 커뮤니티 게시판 속성정보를 수정한다.
      * 
      * @param BoardMaster
      */
     public void updateCmmntyBBSMasterInf(BoardMaster boardMaster) throws Exception;
     
     /**
      * 조건에 맞는 게시물 목록을 조회 한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public List<BoardVO> selectCmmntyBoardArticles(BoardVO boardVO) throws Exception;
     
     /**
      * 커뮤니티 게시판을 등록한다.
      * 
      */
     public void insertBBSMasterInf(CommunityMnu cmmntyMnu) throws Exception;
     
     /**
      * 커뮤니티 게시판 수정 한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public void updateBBSMasterInf(CommunityMnu cmmntyMnu) throws Exception;
     
     /**
      * 모든 커뮤니티 게시판의 조건에 맞는 전체게시물을 조회한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public List<BoardVO> selectSearchCommunityBoardArticleList(BoardVO boardVO) throws Exception ;
     
     /**
      * 모든 커뮤니티 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public int selectSearchCommunityBoardArticleListCnt(BoardVO boardVO) throws Exception;
     
     /**
      * 모든 커뮤니티 알림장 게시판의 조건에 맞는 전체게시물을 조회한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public List<BoardVO> selectSearchCommunityNotifyArticleList(BoardVO boardVO) throws Exception;
     
     /**
      * 모든 커뮤니티 알림장 게시판의 조건에 맞는 전체게시물 건수를 조회한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public int selectSearchCommunityNotifyArticleListCnt(BoardVO boardVO) throws Exception;
     
     /**
      * 모든 커뮤니티 알림장 게시판을 조회한다.
      * 
      * @param boardVO
      * @return
      * @throws Exception
      */
     public List<BoardVO> selectSearchCommunityNotifyUrlList(BoardVO boardVO) throws Exception;
}

