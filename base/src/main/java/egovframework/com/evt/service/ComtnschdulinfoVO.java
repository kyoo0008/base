package egovframework.com.evt.service;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;

import javax.annotation.Resource;

import org.apache.commons.collections.Factory;
import org.apache.commons.collections.ListUtils;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.property.EgovPropertyService;


/******************************************************
 * @Class Name : ComtnschdulinfoVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 스케쥴 기본정보VO
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 17.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 17.        이호영             first generated
*********************************************************/

@SuppressWarnings("serial")
public class ComtnschdulinfoVO extends ComtnschdulinfoDefaultVO implements Serializable {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService         propertyService;
    
    /** 사이트ID */
    private String siteId = "";
    
	/** 시스템구분 */ 
    private String sysTyCode = "";

    /** 스케쥴 Web 파일경로 */
    private String storeWebPath = "/attachfiles/event/";
    
    /** SCHDUL_ID */
    private java.lang.String schdulId;

    /** SCHDUL_CL_CODE */
    private java.lang.String schdulClCode;
    
    /** SCHDUL_BGNDE */
    private java.lang.String schdulBgnde;
    
    /** SCHDUL_ENDDE */
    private java.lang.String schdulEndde;
    
    /** SCHDUL_NM */
    private java.lang.String schdulNm;
    
    /** SCHDUL_STRE_FILE_NM */
    private java.lang.String schdulStreFileNm;
    
    /** SCHDUL_CN */
    private java.lang.String schdulCn;
    
    /** SCHDUL_CHARGER_ID */
    private java.lang.String schdulChargerId;
    
    /** ATCH_FILE_ID */
    private java.lang.String atchFileId;
    
    /** FRST_REGISTER_PNTTM */
    private java.sql.Date frstRegisterPnttm;
    
    /** FRST_REGISTER_ID */
    private java.lang.String frstRegisterId;
    
    /** LAST_UPDUSR_PNTTM */
    private java.sql.Date lastUpdusrPnttm;
    
    /** LAST_UPDUSR_ID */
    private java.lang.String lastUpdusrId;
    
    /** REPTIT_AT */
    private java.lang.String reptitAt;
    
    /** INQIRE_CO */
    private java.math.BigDecimal inqireCo = BigDecimal.ZERO;
    
    /** TOTAL_CO */
    private double totalCo = 0;
    
    /** USE_AT */
    private java.lang.String useAt;
    
    /** PRESNATN_DE */
    private java.lang.String presnatnDe;
    
    /** UPEND_STRE_FILE_NM */
    private java.lang.String upendStreFileNm;
    
    /** MIDDLE_STRE_FILE_NM */
    private java.lang.String middleStreFileNm;
    
    /** LPT_STRE_FILE_NM */
    private java.lang.String lptStreFileNm;

    /** REQST_ID */
    private java.lang.String reqstId;
    
    /** REQST_FORM */
    private String reqstForm;
    
    /** PRZWNER_NMPR */
    private Integer przwnerNmpr;
    
    /** TRGT_URL */
    private String trgtUrl;

    
    private java.lang.String userId;
    private Boolean isError;
    private String errorMessage;
    private Boolean state;
    private String wner;
    
    private String fileGroupId;
    
    

    

	public String getFileGroupId() {
		return fileGroupId;
	}

	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}

	private java.lang.String popupAt = "N";
    
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
	
    public java.lang.String getStoreWebPath() {
        return propertyService.getString("Event.fileStoreWebPath");
    }
    
    public void setStoreWebPath(java.lang.String storeWebPath) {
        this.storeWebPath = storeWebPath;
    }
    
    public java.lang.String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(java.lang.String schdulId) {
        this.schdulId = schdulId;
    }
    
    public java.lang.String getSchdulClCode() {
        return this.schdulClCode;
    }
    
    public void setSchdulClCode(java.lang.String schdulClCode) {
        this.schdulClCode = schdulClCode;
    }
    
    public java.lang.String getSchdulBgnde() {
        return this.schdulBgnde;
    }
    
    public void setSchdulBgnde(java.lang.String schdulBgnde) {
        this.schdulBgnde = schdulBgnde;
    }
    
    public java.lang.String getSchdulEndde() {
        return this.schdulEndde;
    }
    
    public void setSchdulEndde(java.lang.String schdulEndde) {
        this.schdulEndde = schdulEndde;
    }
    
    public java.lang.String getSchdulNm() {
        return this.schdulNm;
    }
    
    public void setSchdulNm(java.lang.String schdulNm) {
        this.schdulNm = schdulNm;
    }
    
    public java.lang.String getSchdulCn() {
        return this.schdulCn;
    }
    
    public void setSchdulCn(java.lang.String schdulCn) {
        this.schdulCn = schdulCn;
    }
    
    public java.lang.String getSchdulChargerId() {
        return this.schdulChargerId;
    }
    
    public void setSchdulChargerId(java.lang.String schdulChargerId) {
        this.schdulChargerId = schdulChargerId;
    }
    
    public java.lang.String getAtchFileId() {
        return this.atchFileId;
    }
    
    public void setAtchFileId(java.lang.String atchFileId) {
        this.atchFileId = atchFileId;
    }
    
    public java.sql.Date getFrstRegisterPnttm() {
        return this.frstRegisterPnttm;
    }
    
    public void setFrstRegisterPnttm(java.sql.Date frstRegisterPnttm) {
        this.frstRegisterPnttm = frstRegisterPnttm;
    }
    
    public java.lang.String getFrstRegisterId() {
        return this.frstRegisterId;
    }
    
    public void setFrstRegisterId(java.lang.String frstRegisterId) {
        this.frstRegisterId = frstRegisterId;
    }
    
    public java.sql.Date getLastUpdusrPnttm() {
        return this.lastUpdusrPnttm;
    }
    
    public void setLastUpdusrPnttm(java.sql.Date lastUpdusrPnttm) {
        this.lastUpdusrPnttm = lastUpdusrPnttm;
    }
    
    public java.lang.String getLastUpdusrId() {
        return this.lastUpdusrId;
    }
    
    public void setLastUpdusrId(java.lang.String lastUpdusrId) {
        this.lastUpdusrId = lastUpdusrId;
    }
    
    public java.lang.String getReptitAt() {
        return this.reptitAt;
    }
    
    public void setReptitAt(java.lang.String reptitAt) {
        this.reptitAt = reptitAt;
    }
    
    public java.math.BigDecimal getInqireCo() {
        return this.inqireCo;
    }
    
    public void setInqireCo(java.math.BigDecimal inqireCo) {
        this.inqireCo = inqireCo;
    }
    
    public double getTotalCo() {
        return this.totalCo;
    }
    
    public void setTotalCo(double totalCo) {
        this.totalCo = totalCo;
    }
    
    public java.lang.String getUseAt() {
        return this.useAt;
    }
    
    public void setUseAt(java.lang.String useAt) {
        this.useAt = useAt;
    }
    
    public java.lang.String getPresnatnDe() {
        return this.presnatnDe;
    }
    
    public void setPresnatnDe(java.lang.String presnatnDe) {
        this.presnatnDe = presnatnDe;
    }
    
    public java.lang.String getUpendStreFileNm() {
        return this.upendStreFileNm;
    }
    
    public void setUpendStreFileNm(java.lang.String upendStreFileNm) {
        this.upendStreFileNm = upendStreFileNm;
    }
    
    public java.lang.String getSchdulStreFileNm() {
        return this.schdulStreFileNm;
    }
    
    public void setSchdulStreFileNm(java.lang.String schdulStreFileNm) {
        this.schdulStreFileNm = schdulStreFileNm;
    }
    
    public java.lang.String getMiddleStreFileNm() {
        return this.middleStreFileNm;
    }
    
    public void setMiddleStreFileNm(java.lang.String middleStreFileNm) {
        this.middleStreFileNm = middleStreFileNm;
    }
    
    public java.lang.String getLptStreFileNm() {
        return this.lptStreFileNm;
    }
    
    public void setLptStreFileNm(java.lang.String lptStreFileNm) {
        this.lptStreFileNm = lptStreFileNm;
    }
    
    public void setFileValue(List<FileVO> files) {
    	if(files != null) {
	    	for(int index=0; index < files.size(); index++) {
	    		FileVO file = files.get(index);
	    		if(file.getFormNm().startsWith("schdul")) {
	    			this.schdulStreFileNm = file.getStreFileNm();
	    		} else if(file.getFormNm().startsWith("upend")) {
	    			this.upendStreFileNm = file.getStreFileNm();
	    		} else if(file.getFormNm().startsWith("middle")) {
	    			this.middleStreFileNm = file.getStreFileNm();
	    		} else if(file.getFormNm().startsWith("lpt")) {
	    			this.lptStreFileNm = file.getStreFileNm();
		    	}
	    	}
	    }
    }
    
    public String getSchdulStreFileNmByWebPath() {
        return this.storeWebPath + this.schdulStreFileNm;
    }
    
    public String getUpendFileNmByWebPath() {
        return this.storeWebPath + this.upendStreFileNm;
    }
    
    public String getMiddleFileNmByWebPath() {
        return this.storeWebPath + this.middleStreFileNm;
    }
    
    public String getLptFileNmByWebPath() {
        return this.storeWebPath + this.lptStreFileNm;
    }

    private List questionTitleList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getQuestionTitleList() {
		return questionTitleList;
	}
	  
	public void setQuestionTitleList(List questionTitleList) {
		this.questionTitleList = questionTitleList;
	}
	
	private List typeList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getTypeList() {
		return typeList;
	}
	  
	public void setTypeList(List typeList) {
		this.typeList = typeList;
	}
	
	private List maximumList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getMaximumList() {
		return maximumList;
	}
	
	public void setMaximumList(List maximumList) {
		this.maximumList = maximumList;
	}
	
	private List exampleList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getExampleList() {
		return exampleList;
	}
	
	public void setExampleList(List exampleList) {
		this.exampleList = exampleList;
	}
	
	private List exampleIdList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getExampleIdList() {
		return exampleIdList;
	}
	
	public void setExampleIdList(List exampleIdList) {
		this.exampleIdList = exampleIdList;
	}
	
	private List questionIdList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getQuestionIdList() {
		return questionIdList;
	}
	
	public void setQuestionIdList(List questionIdList) {
		this.questionIdList = questionIdList;
	}
	
	private List questionContentsList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getQuestionContentsList() {
		return questionContentsList;
	}
	  
	public void setQuestionContentsList(List questionContentsList) {
		this.questionContentsList = questionContentsList;
	}
	
	private List answerIdList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getAnswerIdList() {
		return answerIdList;
	}
	
	public void setAnswerIdList(List answerIdList) {
		this.answerIdList = answerIdList;
	}
	
	private List answerList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getAnswerList() {
		return answerList;
	}
	
	public void setAnswerList(List answerList) {
		this.answerList = answerList;
	}
	
	private List questionList = ListUtils.lazyList(new ArrayList(), new Factory() {    
		public Object create() {
	      return new ComtneventqesitmVO();
	    }
	 });
	
	public List<ComtneventqesitmVO> getQuestionList() {
	    return questionList;
	}
	
	public void setQuestionList(List<ComtneventqesitmVO> questionList) {
	    this.questionList = questionList;
	}
	
	public String getUserId() {
		return userId;
	}
		  
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public Boolean getIsError() {
		return isError;
	}
		  
	public void setIsError(Boolean isError) {
		this.isError = isError;
	}
	
	public String getErrorMessage() {
		return errorMessage;
	}
		  
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	public Boolean getState() {
		return state;
	}
	
	public void setState(Boolean state) {
		this.state = state;
	}
	
	public String getWner() {
		return wner;
	}
	
	public void setWner(String wner) {
		this.wner = wner;
	}
	
	private List choiceAnswerList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	

	public List getChoiceAnswerList() {
		return choiceAnswerList;
	}
	
	public void setChoiceAnswerList(List choiceAnswerList) {
		this.choiceAnswerList = choiceAnswerList;
	}
	
	private List essayAnswerList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    
	    public Object create() {
	      return new String();
	    }
	});
	
	public List getEssayAnswerList() {
		return essayAnswerList;
	}
	
	public void setEssayAnswerList(List essayAnswerList) {
		this.essayAnswerList = essayAnswerList;
	}
	
	public java.lang.String getReqstId() {
        return this.reqstId;
    }
    
    public void setReqstId(java.lang.String reqstId) {
        this.reqstId = reqstId;
    }
    
    public String getReqstForm() {
        return this.reqstForm;
    }
    
    public void setReqstForm(String reqstForm) {
        this.reqstForm = reqstForm;
    }

    public void setPrzwnerNmpr(Integer przwnerNmpr) {
        this.przwnerNmpr = przwnerNmpr;
    }
    
    public Integer getPrzwnerNmpr() {
        return this.przwnerNmpr;
    }
    
    public void setTrgtUrl(String trgtUrl) {
        this.trgtUrl = trgtUrl;
    }
    
    public String getTrgtUrl() {
        return this.trgtUrl;
    }

	public java.lang.String getPopupAt() {
		return popupAt;
	}

	public void setPopupAt(java.lang.String popupAt) {
		this.popupAt = popupAt;
	}

}
