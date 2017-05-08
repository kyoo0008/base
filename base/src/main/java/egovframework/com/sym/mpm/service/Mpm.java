package egovframework.com.sym.mpm.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.rte.fdl.string.EgovStringUtil;

/**
 * 메뉴 데이터 처리 모델
 * @author 정정욱
 * @since 2010.12.27
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.12.27  정정욱          최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class Mpm implements Serializable {
	
	
    /**
	 * SITEID
	 */
    private String siteId = "";
    
    /**
	 * 시스템구분코드
	 */
    private String sysTyCode = "SYS01";
    
    
    /**
	 * 메뉴ID
	 */
    private String menuId;
    /**
	 * 상위메뉴ID
	 */
    private String upperMenuId;
    /**
	 * 메뉴명
	 */
    private String menuNm = "";
    /**
	 * 구성유형
	 */
    private String compositionTyCode = "CNTNTS";
    /**
	 * HTML 사용여부
	 */
    private String htmlUseAt = "Y";
    
    /**
	 * HTML소스 구분코드
	 */
    private String htmlsourcTyCode = "HTML";
    
    /**
	 * 스크립트 내용
	 */
    private String scriptCn = "";
    /**
	 * 스타일 내용
	 */
    private String styleCn = "";
    
    /**
	 * HTML 내용
	 */
    private String htmlCn = "";
    
    /**
	 * 모바일 HTML소스 구분코드
	 */
    private String mobileHtmlsourcTyCode = "HTML";
    
    /**
	 * 모바일 스크립트 내용
	 */
    private String mobileScriptCn = "";
    /**
	 * 모바일 스타일 내용
	 */
    private String mobileStyleCn = "";
    
    /**
	 * 모바일 HTML 내용
	 */
    private String mobileHtmlCn = "";
    /**
	 * 컨텐츠유형코드
	 */
    private String cntntsTyCode = "CTS01";
    /**
	 * 프로그램ID
	 */
    private String progrmId = "";
    
    /**
	 * 프로그램인자
	 */
    private String progrmFactr = "";
    
    /**
	 * URL
	 */
    private String url = "";
    
    /**
	 * 정렬번호깊이
	 */
    private int sortOrdr = 0;
    
    /**
	 * 노출여부
	 */
    private String expsrUseAt = "Y";
    
    

	/**
	 * 새창 여부
	 */
    private String nwdAt = "N";
    
    
    /**
	 * 모바일 사용 여부
	 */
    private String mobileUseAt = "N";
    
    /**
	 * 사용 여부
	 */
    private String useAt = "Y";

    /**
	 * 최초등록자 아이디
	 */
    private String frstRegisterId = "";
    
    /**
	 * 최초 등록자명
	 */
    private String frstRegisterNm = "";
    
    /**
	 * 최초등록시점
	 */
    private java.util.Date frstRegisterPnttm ;
    
    /**
	 * 최종수정자 아이디
	 */
    private String lastUpdusrId = "";
    
    /**
	 * 최종수정시점
	 */
    private java.util.Date lastUpdusrPnttm;
    
    /**
	 * 메뉴경로 - 메뉴명
	 */
    private String menuPathByName = "";
    
    /**
	 * 메뉴경로 - 메뉴ID
	 */
    private String menuPathById = "";
    
    /**
	 * 메뉴레벨
	 */
    private int menuLevel = 1;
    
    /**
	 * 메뉴경로- 마지막노드 여부
	 */
    private String menuLastNodeAt = "";    
    
    /**
	 * 이미지파일명
	 */
    private String imageFileNm = "";
        
    /**
	 * 사이트 URL
	 */
    private String siteUrl = "";
    
    /**
	 * 정렬순서코드
	 */
    private String sortTyCode = "";
    
    /**
	 * 학생메뉴사용여부
	 */
    private String stdntUseAt = "N";
    
    /**
	 * 학부모메뉴사용여부
	 */
    private String stdnprntUseAt = "N";
    
    /**
	 * 선생님메뉴사용여부
	 */
    private String profsrUseAt = "N";
    
    /**
	 * 일반인메뉴사용여부
	 */
    private String generalUseAt = "N";
    
    /**
	 * 메뉴이력ID
	 */
    private String menuHistId;
    
    /**
	 * 첨부파일ID
	 */
    private java.lang.String atchFileId = "";
    
    /**
	 * 모바일첨부파일ID
	 */
    private java.lang.String mobileAtchFileId = "";
        
    
    public Object clone() throws CloneNotSupportedException {
    	return super.clone();
    }
    
    /**
	 * nwdAt attribute를 리턴한다.
	 * @return  the nwdAt
	 */
    public String getNwdAt() {
        return nwdAt;
    }

    /**
	 * nwdAt attribute 값을 설정한다.
	 * @param nwdAt  the nwdAt to set
	 */
    public void setNwdAt(String nwdAt) {
        this.nwdAt = nwdAt;
    }
    
    
    /**
	 * sysTyCode attribute를 리턴한다.
	 * @return  the sysTyCode
	 */
    public String getSysTyCode() {
        return sysTyCode;
    }

    /**
	 * sysTyCode attribute 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 */
    public void setSysTyCode(String sysTyCode) {
        this.sysTyCode = sysTyCode;
    }
    
    /**
	 * siteId attribute를 리턴한다.
	 * @return  the siteId
	 */
    public String getSiteId() {
        return siteId;
    }

    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }
    
    
    
    /**
	 * menuId attribute를 리턴한다.
	 * @return  the menuId
	 */
    public String getMenuId() {
        return menuId;
    }

    /**
	 * menuId attribute 값을 설정한다.
	 * @param menuId  the menuId to set
	 */
    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
    
    /**
	 * upperMenuId attribute를 리턴한다.
	 * @return  the upperMenuId
	 */
    public String getUpperMenuId() {
        return upperMenuId;
    }

    /**
	 * upperMenuId attribute 값을 설정한다.
	 * @param upperMenuId  the upperMenuId to set
	 */
    public void setUpperMenuId(String upperMenuId) {
        this.upperMenuId = upperMenuId;
    }
    /**
	 * menuNm attribute를 리턴한다.
	 * @return  the menuNm
	 */
    public String getMenuNm() {
        return menuNm;
    }

    /**
	 * menuNm attribute 값을 설정한다.
	 * @param menuNm  the menuNm to set
	 */
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }
    /**
	 * compositionTyCode attribute를 리턴한다.
	 * @return  the compositionTyCode
	 */
    public String getCompositionTyCode() {
        return compositionTyCode;
    }

    /**
	 * compositionTyCode attribute 값을 설정한다.
	 * @param compositionTyCode  the compositionTyCode to set
	 */
    public void setCompositionTyCode(String compositionTyCode) {
        this.compositionTyCode = compositionTyCode;
    }
    /**
	 * htmlUseAt attribute를 리턴한다.
	 * @return  the htmlUseAt
	 */
    public String getHtmlUseAt() {
        return htmlUseAt;
    }

    /**
	 * htmlUseAt attribute 값을 설정한다.
	 * @param htmlUseAt  the htmlUseAt to set
	 */
    public void setHtmlUseAt(String htmlUseAt) {
        this.htmlUseAt = htmlUseAt;
    }
    /**
	 * htmlCn attribute를 리턴한다.
	 * @return  the htmlCn
	 */
    public String getHtmlCn() {
        return htmlCn;
    }

    /**
	 * htmlCn attribute 값을 설정한다.
	 * @param htmlCn  the htmlCn to set
	 */
    public void setHtmlCn(String htmlCn) {
        this.htmlCn = htmlCn;
    }
    /**
	 * cntntsTyCode attribute를 리턴한다.
	 * @return  the cntntsTyCode
	 */
    public String getCntntsTyCode() {
        return cntntsTyCode;
    }

    /**
	 * cntntsTyCode attribute 값을 설정한다.
	 * @param cntntsTyCode  the cntntsTyCode to set
	 */
    public void setCntntsTyCode(String cntntsTyCode) {
        this.cntntsTyCode = cntntsTyCode;
    }
    /**
	 * progrmId attribute를 리턴한다.
	 * @return  the progrmId
	 */
    public String getProgrmId() {
        return progrmId;
    }

    /**
	 * progrmId attribute 값을 설정한다.
	 * @param progrmId  the progrmId to set
	 */
    public void setProgrmId(String progrmId) {
        this.progrmId = progrmId;
    }
    
    /**
	 * progrmFactr attribute를 리턴한다.
	 * @return  the progrmFactr
	 */
    public String getProgrmFactr() {
        return progrmFactr;
    }

    /**
	 * progrmFactr attribute 값을 설정한다.
	 * @param progrmFactr  the progrmId to set
	 */
    public void setProgrmFactr(String progrmFactr) {
        this.progrmFactr = progrmFactr;
    }
    
    /**
	 * url attribute를 리턴한다.
	 * @return  the url
	 */
    public String getUrl() {
        return url;
    }

    /**
	 * url attribute 값을 설정한다.
	 * @param url  the url to set
	 */
    public void setUrl(String url) {
        this.url = url;
    }
    
    
    
	public int getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(int sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	/**
	 * expsrUseAt attribute를 리턴한다.
	 * @return  the expsrUseAt
	 */
    public String getExpsrUseAt() {
        return expsrUseAt;
    }

    /**
	 * expsrUseAt attribute 값을 설정한다.
	 * @param expsrUseAt  the expsrUseAt to set
	 */
    public void setExpsrUseAt(String expsrUseAt) {
        this.expsrUseAt = expsrUseAt;
    }
    
    /**
	 * scriptCn attribute를 리턴한다.
	 * @return  the scriptCn
	 */
    public String getScriptCn() {
        return scriptCn;
    }

    /**
	 * scriptCn attribute 값을 설정한다.
	 * @param scriptCn  the scriptCn to set
	 */
    public void setScriptCn(String scriptCn) {
        this.scriptCn = scriptCn;
    }
    /**
	 * styleCn attribute를 리턴한다.
	 * @return  the styleCn
	 */
    public String getStyleCn() {
        return styleCn;
    }

    /**
	 * styleCn attribute 값을 설정한다.
	 * @param styleCn  the styleCn to set
	 */
    public void setStyleCn(String styleCn) {
        this.styleCn = styleCn;
    }
   

    /**
	 * mobileUseAt attribute를 리턴한다.
	 * @return  the mobileUseAt
	 */
    public String getMobileUseAt() {
        return mobileUseAt;
    }

    /**
	 * mobileUseAt attribute 값을 설정한다.
	 * @param mobileUseAt  the mobileUseAt to set
	 */
    public void setMobileUseAt(String mobileUseAt) {
        this.mobileUseAt = mobileUseAt;
    }
    
	public String getHtmlsourcTyCode() {
		return htmlsourcTyCode;
	}

	public void setHtmlsourcTyCode(String htmlsourcTyCode) {
		this.htmlsourcTyCode = htmlsourcTyCode;
	}

	public String getMobileHtmlsourcTyCode() {
		return mobileHtmlsourcTyCode;
	}

	public void setMobileHtmlsourcTyCode(String mobileHtmlsourcTyCode) {
		this.mobileHtmlsourcTyCode = mobileHtmlsourcTyCode;
	}

	public String getMobileScriptCn() {
		return mobileScriptCn;
	}

	public void setMobileScriptCn(String mobileScriptCn) {
		this.mobileScriptCn = mobileScriptCn;
	}

	public String getMobileStyleCn() {
		return mobileStyleCn;
	}

	public void setMobileStyleCn(String mobileStyleCn) {
		this.mobileStyleCn = mobileStyleCn;
	}

	public String getMobileHtmlCn() {
		return mobileHtmlCn;
	}

	public void setMobileHtmlCn(String mobileHtmlCn) {
		this.mobileHtmlCn = mobileHtmlCn;
	}

	/**
	 * useAt attribute를 리턴한다.
	 * @return  the useAt
	 */
    public String getUseAt() {
        return useAt;
    }

    /**
	 * useAt attribute 값을 설정한다.
	 * @param useAt  the useAt to set
	 */
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }

    /**
	 * frstRegisterId attribute를 리턴한다.
	 * @return  the frstRegisterId
	 */
    public String getFrstRegisterId() {
        return frstRegisterId;
    }

    /**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId  the frstRegisterId to set
	 */
    public void setFrstRegisterId(String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }

    /**
	 * frstRegisterNm attribute를 리턴한다.
	 * @return  the frstRegisterNm
	 */
    public String getFrstRegisterNm() {
        return frstRegisterNm;
    }

    /**
	 * frstRegisterNm attribute 값을 설정한다.
	 * @param frstRegisterNm  the frstRegisterNm to set
	 */
    public void setFrstRegisterNm(String frstRegisterNm) {
        this.frstRegisterNm = frstRegisterNm;
    }

    /**
	 * frstRegisterPnttm attribute를 리턴한다.
	 * @return  the frstRegisterPnttm
	 */
    public java.util.Date getFrstRegisterPnttm() {
        return frstRegisterPnttm;
    }

    /**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm  the frstRegisterPnttm to set
	 */
    public void setFrstRegisterPnttm(java.util.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }

    /**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return  the lastUpdusrId
	 */
    public String getLastUpdusrId() {
        return lastUpdusrId;
    }

    /**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId  the lastUpdusrId to set
	 */
    public void setLastUpdusrId(String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    /**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return  the lastUpdusrPnttm
	 */
    public java.util.Date getLastUpdusrPnttm() {
        return lastUpdusrPnttm;
    }

    /**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm  the lastUpdusrPnttm to set
	 */
    public void setLastUpdusrPnttm(java.util.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public String getMenuPathByName() {
		return menuPathByName;
	}

	public void setMenuPathByName(String menuPathByName) {
		this.menuPathByName = menuPathByName;
	}

	public String getMenuPathById() {
		return menuPathById;
	}

	public void setMenuPathById(String menuPathById) {
		this.menuPathById = menuPathById;
	}

	public int getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getMenuLastNodeAt() {
		return menuLastNodeAt;
	}

	public void setMenuLastNodeAt(String menuLastNodeAt) {
		this.menuLastNodeAt = menuLastNodeAt;
	}

	public String getImageFileNm() {
		return imageFileNm;
	}

	public void setImageFileNm(String imageFileNm) {
		this.imageFileNm = imageFileNm;
	}

	public String getSiteUrl() {
		return siteUrl;
	}

	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}


	public String getSortTyCode() {
		return sortTyCode;
	}

	public void setSortTyCode(String sortTyCode) {
		this.sortTyCode = sortTyCode;
	}

	public String getStdntUseAt() {
		return stdntUseAt;
	}

	public void setStdntUseAt(String stdntUseAt) {
		this.stdntUseAt = stdntUseAt;
	}

	public String getStdnprntUseAt() {
		return stdnprntUseAt;
	}

	public void setStdnprntUseAt(String stdnprntUseAt) {
		this.stdnprntUseAt = stdnprntUseAt;
	}

	public String getProfsrUseAt() {
		return profsrUseAt;
	}

	public void setProfsrUseAt(String profsrUseAt) {
		this.profsrUseAt = profsrUseAt;
	}

	public String getGeneralUseAt() {
		return generalUseAt;
	}

	public void setGeneralUseAt(String generalUseAt) {
		this.generalUseAt = generalUseAt;
	}

	public String getMenuHistId() {
		return menuHistId;
	}

	public void setMenuHistId(String menuHistId) {
		this.menuHistId = menuHistId;
	}

	public java.lang.String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(java.lang.String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public java.lang.String getMobileAtchFileId() {
		return mobileAtchFileId;
	}

	public void setMobileAtchFileId(java.lang.String mobileAtchFileId) {
		this.mobileAtchFileId = mobileAtchFileId;
	}

	/**
     * URL을 리턴한다.
     */
    public String getMenuWebPath() {
    	return getMenuWebPath(true);
    }
    
    /**
     * URL을 리턴한다.
     */
    public String getMenuWebPathByUrlEncode() {
    	String path = getMenuWebPath(false);
    	try {
    		path = java.net.URLEncoder.encode(path, "UTF-8");
    	} catch(Exception ex) {}
    	return path;
    }
    
    /**
     * URL을 리턴한다.
     */
    public String getMenuWebPath(boolean domainWrited) {
    	String preFix = "";
    	
    	String path = "";
    	
    	if(EgovStringUtil.isEmpty(this.upperMenuId)) {
    		path = "/";
    	} else if("LINK".equals(this.compositionTyCode)) {
    		path = this.url;
    	} else if("CNTNTS".equals(this.compositionTyCode)) {//컨텐츠
    		if("CTS02".equals(this.cntntsTyCode)) {	//게시판
    			path = preFix + "/cop/bbs/selectBoardList.do?bbsId=" + this.progrmId;
        	} else if("CTS04".equals(this.cntntsTyCode)) {	//프로그램
        		if("PRGCAL".equals(this.progrmId)) {	//통합캘린더
    				path = preFix + "/evt/selectSchdulinfoCalendar.do";
    			} else if("PRGCMY".equals(this.progrmId)) {	//커뮤니티
    				path = preFix + "/cop/cmy/selectCmmntyInfs.do";
    				if(!EgovStringUtil.isEmpty(this.progrmFactr)) {
    					path = path + "?searchTy=" + this.progrmFactr;
    				}
    			}
        	} else if("CTS05".equals(this.cntntsTyCode)) {	//IFRAME
        		path = preFix + "/msi/cntntsService.do";
        	} else if("CTS06".equals(this.cntntsTyCode)) {	//포틀릿
        		path = preFix + "/msi/cntntsService.do";
        	} 
    	}
    	
    	if(EgovStringUtil.isEmpty(path)) {
    		path = preFix + "/msi/cntntsService.do";
    	}
    	
    	if(domainWrited) {
	    	if(!path.startsWith("http")) {
	    		path = "http://" + this.siteUrl + path;
	    	}
    	}
    	
    	if(path.indexOf("menuId") == -1) {// && "CNTNTS".equals(this.compositionTyCode) && ("CTS01".equals(this.cntntsTyCode) || "CTS02".equals(this.cntntsTyCode) || "CTS04".equals(this.cntntsTyCode) || "CTS05".equals(this.cntntsTyCode) || "CTS06".equals(this.cntntsTyCode))) {
    		if(path.indexOf("?") == -1) {
    			path = path + "?menuId=" + this.menuId;
    		} else {
    			path = path + "&menuId=" + this.menuId;
    		}
    	}
    	
    	return path;
    }
   
    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
