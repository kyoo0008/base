package egovframework.com.evt.service;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import egovframework.com.evt.service.ComtneventqesitmexVO;
import egovframework.com.evt.service.ComtneventcnsrVO;

import org.apache.commons.collections.Factory;
import org.apache.commons.collections.ListUtils;

/******************************************************
 * @Class Name : ComtneventqesitmVO.java
 * @Program name : egovframework.com.evt.service
 * @Descriptopn : 이벤트 문항VO
 * @version : 1.0.0
 * @author : 이호영
 * @created date : 2011. 8. 25.
 * Modification log
 * =====================================================
 * date                name             description
 * -----------------------------------------------------
 * 2011. 8. 25.        이호영             first generated
*********************************************************/
@SuppressWarnings("serial")
public class ComtneventqesitmVO implements Serializable {
    
    /** QESITM_ID */
    private java.lang.String qesitmId;
    
    /** QESITM_SN */
    private Integer qesitmSn;
    
    /** QESITM_TY_CODE */
    private java.lang.String qesitmTyCode;
    
    /** QESITM_SJ */
    private java.lang.String qesitmSj;
    
    /** QESITM_CN */
    private java.lang.String qesitmCn;
    
    /** MXMM_ANSWER_CO */
    private Integer mxmmAnswerCo;

    /** USER_CNSR */
    private java.lang.String userCnsr;
    
    /** USER_SCORE */
    private java.lang.String userScore;
    
    /** SCHDUL_ID */
    private java.lang.String schdulId;
    
    /** 보기 */
    private List exampleList = ListUtils.lazyList(new ArrayList(), new Factory() {
    	public Object create() {
    		return new ComtneventqesitmexVO();
    	}
    });

	public List getExampleList() {
		return exampleList;
	}

	public void setExampleList(List exampleList) {
		this.exampleList = exampleList;
	}

	public void addExample(ComtneventqesitmexVO example) {
		this.exampleList.add(example);
	}
    
    /** 정답 */
    private List answerList = ListUtils.lazyList(new ArrayList(), new Factory() {
	    public Object create() {
	      return new ComtneventcnsrVO();
	    }
	});
    
	public List getAnswerList() {
	return answerList;
	}
  
	public void setAnswerList(List answerList) {
		this.answerList = answerList;
	}
  
	public void addAnswer(ComtneventcnsrVO answer) {
		this.answerList.add(answer);
	}
    
    public java.lang.String getQesitmId() {
        return this.qesitmId;
    }
    
    public void setQesitmId(java.lang.String qesitmId) {
        this.qesitmId = qesitmId;
    }
    
    public Integer getQesitmSn() {
        return this.qesitmSn;
    }
    
    public void setQesitmSn(Integer qesitmSn) {
        this.qesitmSn = qesitmSn;
    }
    
    public java.lang.String getQesitmTyCode() {
        return this.qesitmTyCode;
    }
    
    public void setQesitmTyCode(java.lang.String qesitmTyCode) {
        this.qesitmTyCode = qesitmTyCode;
    }
    
    public java.lang.String getQesitmSj() {
        return this.qesitmSj;
    }
    
    public void setQesitmSj(java.lang.String qesitmSj) {
        this.qesitmSj = qesitmSj;
    }
    
    public java.lang.String getQesitmCn() {
        return this.qesitmCn;
    }
    
    public void setQesitmCn(java.lang.String qesitmCn) {
        this.qesitmCn = qesitmCn;
    }
    
    public Integer getMxmmAnswerCo() {
        return this.mxmmAnswerCo;
    }
    
    public void setMxmmAnswerCo(Integer mxmmAnswerCo) {
        this.mxmmAnswerCo = mxmmAnswerCo;
    }
    
    public java.lang.String getUserScore() {
        return this.userScore;
    }
    
    public void setCserScore(java.lang.String userScore) {
        this.userScore = userScore;
    }
    
    public java.lang.String getUserCnsr() {
        return this.userCnsr;
    }
    
    public void setCserCnsr(java.lang.String userCnsr) {
        this.userCnsr = userCnsr;
    }
    
    public java.lang.String getSchdulId() {
        return this.schdulId;
    }
    
    public void setSchdulId(java.lang.String schdulId) {
        this.schdulId = schdulId;
    }

}
