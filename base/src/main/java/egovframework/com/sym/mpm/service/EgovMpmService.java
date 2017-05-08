package egovframework.com.sym.mpm.service;

import java.util.List;

import egovframework.com.sym.sit.service.SiteManageVO;
import egovframework.com.uat.uia.service.LoginVO;

/**
 * 메뉴  인터페이스 클래스
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2010.12.27  정정욱          최초 생성 
 *  
 *  </pre>
 */
public interface EgovMpmService {
	
	/**
     * 상위메뉴에 대한 하위메뉴 건수를 조회 한다.
     * 
     * @param Mpm
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(Mpm mpm) throws Exception;
    
	/**
	 * 메뉴정보를 등록한다
	 * @param vo Mpm
	 */
	public String insertMpm(MpmVO mpm) throws Exception;
	
	/**
	 * 메뉴아이디를 생성한다.
	 */
	public String selectMenuIdGnr() throws Exception;
	
	/**
     * 전체메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectFullMpmList(MpmVO vo) throws Exception;
    
	/**
     * 메뉴 목록을 조회 한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectMpmList(MpmVO vo) throws Exception;
    
    /**
     * 메뉴상세 내용을 조회 한다.
     * 
     * @param MpmVO
     */
    public MpmVO selectMpm(MpmVO vo) throws Exception ;
    
    /**
     * 메뉴 속성정보를 수정한다.
     * 
     * @param Mpm
     */
    public void updateMpm(MpmVO mpm) throws Exception;
    
    /**
     * 메뉴 속성정보를 삭제한다.
     * 
     * @param Mpm
     */
    public void deleteMpm(MpmVO mpm) throws Exception;
    
    /**
    * 메뉴 정렬순서를 수정한다.
    * 
    * @param Mpm
    */
    public int updateMpmSortOrdr(MpmVO vo) throws Exception;
   
    /**
     * 메뉴정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmFind(List<Mpm> mpmList, String menuId) throws Exception ;
    
    /**
     * 현재메뉴정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmCurrent(List<Mpm> mpmList, MpmVO mnuVO) throws Exception ;
    
    /**
     * 현재메뉴의 최상위메뉴의 정보를 조회한다.
     * 
     * @param MpmVO
     */
    public Mpm selectMpmCurrentRoot(List<Mpm> mpmList, Mpm currMpm) throws Exception;
    
    /**
     * 프로그램으로 메뉴의 정보를 조회한다.
     * 
     * @param progrmId
     */
    public Mpm selectMpmProgram(List<Mpm> mpmList, String progrmId) throws Exception;
    
    /**
     * 메뉴를 일괄등록한다.
     * 
     * @param mpmList
     * @throws Exception
     */
    public void insertMpmBatch(List<Mpm> mpmList) throws Exception;
    
    /**
     * 서비스용대메뉴정보 목록을 조회한다.
     * 
     * @param MpmVO
     */
    public List<Mpm> selectMpmServiceList(MpmVO vo) throws Exception;
    
    /**
     * 서비스용 프로그램ID로 메뉴아이디를 조회한다.
     * 
     * @param MpmVO
     */
    public String selectMpmByProgrmId(MpmVO vo) throws Exception;
    
    /**
     * 사용자 유형에 맞는 메뉴리스트를 조회한다.
     */
	public List<Mpm> getCustomSiteMpmList(SiteManageVO siteVO, LoginVO user, String groupTy, String adminYn) throws Exception;
	
	/**
     * 메뉴를 미리보기형식으로 퍼블리싱한다.
     * 
     * @param Mpm
     */
    public void previewPublish(Mpm mpm) throws Exception;
    
    /**
     * 메뉴아이디를 재배치한다.
     * 
     * @param mpmList
     */
    public List<Mpm> updateNewMenuIdGen(List<Mpm> mpmList) throws Exception;
 
    /**
     * 메뉴명를 수정한다.
     * 
     * @param Mpm
     */
    public int updateMpmMenuNm(Mpm mpm) throws Exception;
}
