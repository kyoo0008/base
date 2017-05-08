package egovframework.com.cop.cmy.service;

import java.util.List;
import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import egovframework.com.cmm.service.FileVO;

/**
 * 커뮤니티 관리를 위한 모델 클래스
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
 * 2009.4.2    이삼섭          최초 생성
 * 2012.1.18   이호영          충청남도교육연구정보원 스마트충남 기능 개선 구축
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class Community implements Serializable {

	/**
	 * 사이트ID
	 */
    private String siteId = "";
    
	/**
	 * 시스템구분 
	 */ 
    private String sysTyCode = "";
    
    /**
	 * 승인정책코드 
	 */ 
    private String confmPolicyCode = "Y";
    
    /**
	 * 재가입정책코드 
	 */ 
    private String resbscrbPolicyCode = "Y";
    
    /**
	 * 커뮤니티 아이디
	 */
    private String cmmntyId = "";

    /**
	 * 커뮤니티 소개
	 */
    private String cmmntyIntrcn = "";
    
    /**
	 * 커뮤니티 명
	 */
    private String cmmntyNm = "";
    
	/**
	 * 최초등록자 명
	 */
    private String frstRegisterNm = "";

    /**
	 * 최초등록자 아이디
	 */
    private String frstRegisterId = "";
    
    /**
	 * 최초등록시점
	 */
    private java.util.Date frstRegisterPnttm;
    
    /**
	 * 최종수정자 아이디
	 */
    private String lastUpdusrId = "";
    
    /**
	 * 최종수정시점
	 */
    private java.util.Date lastUpdusrPnttm;
    
    /**
	 * 등록구분코드
	 */
    private String registSeCode = "";
        
    /**
	 * 사용유무
	 */
    private String useAt = "";

    /**
	 * 사용자 아이디
	 */
    private String emplyrId = "";

    /**
	 * 사용자명
	 */
    private String userNm = "";
    
    /**
	 * 회원수
	 */
    private int userCo = 0;
    
    /**
	 * 새글수ARTICLE_NEW_CO
	 */
    private int articleNewCo = 0;

    /**
	 * 템플릿 명
	 */
    private String tmplatNm = "";

    /**
	 * 커뮤니티 주소
	 */
    private String cmmntyAdres = "";
    
    /**
	 * 커뮤니티 구분코드
	 */
    private String cmmntySeCode = "";
    
    /**
	 * 커뮤니티 구분코드명
	 */
    private String cmmntySeNm = "";
    
    /**
	 * 대표이미지
	 */
    private String atchFileNm = "";
    
    /**
	 * 대표아이콘
	 */
    private String atchFileIcon = "";
    
    /**
	 * 공개여부
	 */
    private String othbcAt = "Y";

    /**
	 * 마이메뉴추가여부
	 */
    private String indvdlAt = "N";
    
	
    public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getSysTyCode() {
		return sysTyCode;
	}

	public void setSysTyCode(String sysTyCode) {
		this.sysTyCode = sysTyCode;
	}

	/**
	 * cmmntyId attribute를 리턴한다.
	 * @return  the cmmntyId
	 */
    public String getCmmntyId() {
	return cmmntyId;
    }

    /**
	 * cmmntyId attribute 값을 설정한다.
	 * @param cmmntyId  the cmmntyId to set
	 */
    public void setCmmntyId(String cmmntyId) {
	this.cmmntyId = cmmntyId;
    }

    /**
	 * cmmntyIntrcn attribute를 리턴한다.
	 * @return  the cmmntyIntrcn
	 */
    public String getCmmntyIntrcn() {
	return cmmntyIntrcn;
    }

    /**
	 * cmmntyIntrcn attribute 값을 설정한다.
	 * @param cmmntyIntrcn  the cmmntyIntrcn to set
	 */
    public void setCmmntyIntrcn(String cmmntyIntrcn) {
	this.cmmntyIntrcn = cmmntyIntrcn;
    }

    /**
	 * cmmntyNm attribute를 리턴한다.
	 * @return  the cmmntyNm
	 */
    public String getCmmntyNm() {
	return cmmntyNm;
    }

    /**
	 * cmmntyNm attribute 값을 설정한다.
	 * @param cmmntyNm  the cmmntyNm to set
	 */
    public void setCmmntyNm(String cmmntyNm) {
	this.cmmntyNm = cmmntyNm;
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

    /**
	 * registSeCode attribute를 리턴한다.
	 * @return  the registSeCode
	 */
    public String getRegistSeCode() {
	return registSeCode;
    }

    /**
	 * registSeCode attribute 값을 설정한다.
	 * @param registSeCode  the registSeCode to set
	 */
    public void setRegistSeCode(String registSeCode) {
	this.registSeCode = registSeCode;
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
	 * emplyrId attribute를 리턴한다.
	 * @return  the emplyrId
	 */
    public String getEmplyrId() {
	return emplyrId;
    }

    /**
	 * emplyrId attribute 값을 설정한다.
	 * @param emplyrId  the emplyrId to set
	 */
    public void setEmplyrId(String emplyrId) {
	this.emplyrId = emplyrId;
    }

    /**
	 * userNm attribute를 리턴한다.
	 * @return  the userNm
	 */
    public String getUserNm() {
	return userNm;
    }

    /**
	 * userNm attribute 값을 설정한다.
	 * @param userNm  the userNm to set
	 */
    public void setUserNm(String userNm) {
	this.userNm = userNm;
    }

    /**
	 * tmplatNm attribute를 리턴한다.
	 * @return  the tmplatNm
	 */
    public String getTmplatNm() {
	return tmplatNm;
    }

    /**
	 * userCo attribute를 리턴한다.
	 * @return  the userCo
	 * @uml.property  name="userCo"
	 */
    public int getUserCo() {
	return userCo;
    }

    /**
	 * userCo attribute 값을 설정한다.
	 * @param userCo  the userCo to set
	 * @uml.property  name="userCo"
	 */
    public void setUserCo(int userCo) {
	this.userCo = userCo;
    }
    
    /**
	 * articleNewCo attribute를 리턴한다.
	 * @return  the articleNewCo
	 * @uml.property  name="articleNewCo"
	 */
    public int getArticleNewCo() {
	return articleNewCo;
    }

    /**
	 * articleNewCo attribute 값을 설정한다.
	 * @param articleNewCo  the articleNewCo to set
	 * @uml.property  name="articleNewCo"
	 */
    public void setArticleNewCo(int articleNewCo) {
	this.articleNewCo = articleNewCo;
    }
    /**
	 * tmplatNm attribute 값을 설정한다.
	 * @param tmplatNm  the tmplatNm to set
	 */
    public void setTmplatNm(String tmplatNm) {
	this.tmplatNm = tmplatNm;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
	
	
    public String getCmmntyAdres() {
		return cmmntyAdres;
	}

	public void setCmmntyAdres(String cmmntyAdres) {
		this.cmmntyAdres = cmmntyAdres;
	}
    
    public String getCmmntySeCode() {
		return cmmntySeCode;
	}

	public void setCmmntySeCode(String cmmntySeCode) {
		this.cmmntySeCode = cmmntySeCode;
	}
	
	public String getCmmntySeNm() {
		return cmmntySeNm;
	}

	public void setCmmntySeNm(String cmmntySeNm) {
		this.cmmntySeNm = cmmntySeNm;
	}
	
	public String getAtchFileNm() {
		return atchFileNm;
	}

	public void setAtchFileNm(String atchFileNm) {
		this.atchFileNm = atchFileNm;
	}
	
	public String getAtchFileIcon() {
		return atchFileIcon;
	}

	public void setAtchFileIcon(String atchFileIcon) {
		this.atchFileIcon = atchFileIcon;
	}
	
	public String getOthbcAt() {
		return othbcAt;
	}

	public void setOthbcAt(String othbcAt) {
		this.othbcAt = othbcAt;
	}
	
	public String getIndvdlAt() {
		return indvdlAt;
	}

	public void setIndvdlAt(String indvdlAt) {
		this.indvdlAt = indvdlAt;
	}

	public String getConfmPolicyCode() {
		return confmPolicyCode;
	}

	public void setConfmPolicyCode(String confmPolicyCode) {
		this.confmPolicyCode = confmPolicyCode;
	}

	public String getFrstRegisterNm() {
		return frstRegisterNm;
	}

	public void setFrstRegisterNm(String frstRegisterNm) {
		this.frstRegisterNm = frstRegisterNm;
	}
	
	public String getResbscrbPolicyCode() {
		return resbscrbPolicyCode;
	}

	public void setResbscrbPolicyCode(String resbscrbPolicyCode) {
		this.resbscrbPolicyCode = resbscrbPolicyCode;
	}
	
	public void setFileValue(List<FileVO> files) {
    	if(files != null) {
	    	for(int index=0; index < files.size(); index++) {
	    		FileVO file = files.get(index);
	    		if(file.getFormNm().startsWith("peprsnt")) {
	    			this.atchFileNm = file.getStreFileNm();
	    		} else if(file.getFormNm().startsWith("icon")) {
	    			this.atchFileIcon = file.getStreFileNm();
	    		}
	    	}
	    }
    }
}
