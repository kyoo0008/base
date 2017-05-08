package egovframework.com.sts.service;

/**
 * 웹로그집계정보에 대한 모델 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.04.15
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.04.15  박지욱          최초 생성 
 *  
 *  </pre>
 */
public class WebLogSummary {

	/**
	 * SITE 코드
	 * @uml.property  name="siteId"
	 */
    private String siteId = "";
    
	/**
	 * 시스템구분코드
	 * @uml.property  name="sysTyCode"
	 */
    private String sysTyCode = "";
    
    /**
	 * 메뉴ID
	 * @uml.property  name="menuId"
	 */
    private String menuId = "";
    
	/**
	 * 횟수
	 * @uml.property  name="inqireCo"
	 */
	private int inqireCo;
	/**
	 * 발생일자
	 * @uml.property  name="occrrncDe"
	 */
	private String occrrncDe;
	/**
	 * URL
	 * @uml.property  name="url"
	 */
	private String url;
	/**
	 * inqireCo attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="inqireCo"
	 */
	public int getInqireCo() {
		return inqireCo;
	}
	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo  int
	 * @uml.property  name="inqireCo"
	 */
	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}
	/**
	 * occrrncDe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="occrrncDe"
	 */
	public String getOccrrncDe() {
		return occrrncDe;
	}
	/**
	 * occrrncDe attribute 값을 설정한다.
	 * @param occrrncDe  String
	 * @uml.property  name="occrrncDe"
	 */
	public void setOccrrncDe(String occrrncDe) {
		this.occrrncDe = occrrncDe;
	}
	/**
	 * url attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="url"
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * url attribute 값을 설정한다.
	 * @param url  String
	 * @uml.property  name="url"
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * sysTyCode attribute를 리턴한다.
	 * @return  the sysTyCode
	 * @uml.property  name="sysTyCode"
	 */
    public String getSysTyCode() {
        return sysTyCode;
    }

    /**
	 * sysTyCode attribute 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 * @uml.property  name="sysTyCode"
	 */
    public void setSysTyCode(String sysTyCode) {
        this.sysTyCode = sysTyCode;
    }
    
    /**
	 * siteId attribute를 리턴한다.
	 * @return  the siteId
	 * @uml.property  name="siteId"
	 */
    public String getSiteId() {
        return siteId;
    }

    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 * @uml.property  name="siteId"
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }
    
    
    
    /**
	 * menuId attribute를 리턴한다.
	 * @return  the menuId
	 * @uml.property  name="menuId"
	 */
    public String getMenuId() {
        return menuId;
    }

    /**
	 * menuId attribute 값을 설정한다.
	 * @param menuId  the menuId to set
	 * @uml.property  name="menuId"
	 */
    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
}
