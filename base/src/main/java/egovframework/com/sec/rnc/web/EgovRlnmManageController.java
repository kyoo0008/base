package egovframework.com.sec.rnc.web;

import java.text.*;
import java.util.*;

import java.net.URLDecoder;
import java.util.Map;

//import com.nice.OivsObject;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import egovframework.com.cmm.EgovMessageSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.fdl.property.EgovPropertyService;

import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.sec.rnc.service.EgovRlnmManageService;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;

import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.sec.rnc.service.RealhpVO;
import javax.servlet.http.HttpSession;

/**
 * 실명인증관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovRlnmManageController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
	@Resource(name = "propertiesService")
	  protected EgovPropertyService         propertiesService;
		
    /** Log Info */
    protected Log log = LogFactory.getLog(this.getClass());
    
    /**
     * 실명인증확인화면 호출(주민번호) 
     * @param model 모델
     * @return "/uss/umt/EgovStplatCnfirm"
     * @exception Exception
     */
	@RequestMapping("/sec/rnc/EgovRlnmCnfirm.do")
    public String rlnmCnfirm(@ModelAttribute("searchVO") UserManageVO userManageVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		//인증관련 세션
		EgovSessionCookieUtil.removeSessionAttribute(request, "dupInfo");
    	EgovSessionCookieUtil.removeSessionAttribute(request, "realName");
    	EgovSessionCookieUtil.removeSessionAttribute(request, "birthDate");
    	EgovSessionCookieUtil.removeSessionAttribute(request, "sex");
    	EgovSessionCookieUtil.removeSessionAttribute(request, "authInfo");
    	EgovSessionCookieUtil.removeSessionAttribute(request, "GPIN_AQ_SERVICE_SITE_USER_CONFIRM");

    	return "cmm/sec/rnc/EgovRlnmCnfirm";

    }
    
    /**
     * 실명인증확인처리(주민번호) 
     * @param model 모델
     * @return "cmm/sec/rnc/EgovRlnmCnfirm"
     * @exception Exception
     */
	/*
	@SuppressWarnings("unused")
    @RequestMapping("/sec/rnc/EgovRlnmCnfirmChk.do")
    public String rlnmCnfirmChk(@ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {

		OivsObject oivsObject = new OivsObject();
		String strRecvData 	= request.getParameter( "SendInfo" );
		boolean blProc = oivsObject.resolveClientData( strRecvData );
		
    	String niceID = oivsObject.niceId;
    	String ordNo = oivsObject.ordNo;
    	String trNo = oivsObject.trNo;
    	String retCd = oivsObject.retCd;
    	String RretDtlCd = oivsObject.retDtlCd;
    	String Message = oivsObject.message;
    	String paKey = oivsObject.paKey;
    	String dupInfo = oivsObject.dupeInfo;
    	String realName = oivsObject.niceNm;
    	String birthDate = oivsObject.birthday;
    	String sex = oivsObject.sex;
    	String foreigner = oivsObject.foreigner;

    	String result = null;
    	
    	if("1".equals(retCd)){		//인증 성공
    		//실명인증 처리 부분
        	model.addAttribute("niceID",     niceID);		//회원사ID
        	model.addAttribute("ordNo",     ordNo);			//내부번호
        	model.addAttribute("trNo",    trNo);			//한신정 내부번호
        	model.addAttribute("retCd",    retCd);			//결과코드
        	model.addAttribute("Message",    Message);		//결과상세코드
        	model.addAttribute("paKey",    paKey);			//주민번호 대체 13자리코드
        	model.addAttribute("dupInfo",    dupInfo);		//G-Pin 호환 키값
        	model.addAttribute("realName",    realName);	//반환하는 실명
        	model.addAttribute("sex",    sex);				//생년월일
        	model.addAttribute("foreigner",    foreigner);	//외국인여부

        	EgovSessionCookieUtil.setSessionAttribute(request, "dupInfo", dupInfo);
        	EgovSessionCookieUtil.setSessionAttribute(request, "realName", realName);
        	EgovSessionCookieUtil.setSessionAttribute(request, "birthDate", birthDate);
        	EgovSessionCookieUtil.setSessionAttribute(request, "sex", sex);
        	EgovSessionCookieUtil.setSessionAttribute(request, "foreigner", foreigner);
        	
    	}else{

    		if("A".equals(RretDtlCd)){
    			result = "sec.real.A";
    		}else if("B".equals(RretDtlCd)){
    			result = "sec.real.B";
    		}else if("C".equals(RretDtlCd)){
    			result = "sec.real.C";
    		}else if("D".equals(RretDtlCd)){
    			result = "sec.real.D";
    		}else if("E".equals(RretDtlCd)){
    			result = "sec.real.E";
    		}else if("F".equals(RretDtlCd)){
    			result = "sec.real.F";
    		}else if("Y".equals(RretDtlCd)){
    			result = "sec.real.Y";
    		}else if("G".equals(RretDtlCd)){
    			result = "sec.real.G";
    		}else if("H".equals(RretDtlCd)){
    			result = "sec.real.H";
    		}else if("Z".equals(RretDtlCd)){
    			result = "sec.real.Z";
    		}
    	}
    	if(result != null){
			model.addAttribute("message", egovMessageSource.getMessage(result));   //실명확인 결과
		}
        return "cmm/sec/rnc/EgovRlnmCnfirmChk";
    }
	*/
	/**
     * G-PIN 인증 실행 
     * @param model 모델
     * @return "cmm/sec/rnc/EgovRlnmCnfirm"
     * @exception Exception
     */
    @RequestMapping("/sec/rnc/EgovGpinCnfirm.do")
    public String gpinCnfirm(HttpServletRequest request) throws Exception {

    	return "cmm/sec/rnc/EgovGpinCnfirm";
	}
    
	/**
     * G-PIN 인증 처리결과 
     * @param model 모델
     * @return "cmm/sec/rnc/EgovRlnmCnfirm"
     * @exception Exception
     */
    @RequestMapping("/sec/rnc/EgovGpinCnfirmChk.do")
    public String gpinCnfirmChk(@ModelAttribute("searchVO") UserManageVO userManageVO, ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {

		String gpinUserIP = (String)EgovSessionCookieUtil.getSessionAttribute(request, "gpinUserIP");
		String dupInfo = (String)EgovSessionCookieUtil.getSessionAttribute(request, "dupInfo");
		String realName = (String)EgovSessionCookieUtil.getSessionAttribute(request, "realName");
		String nationalInfo = (String)EgovSessionCookieUtil.getSessionAttribute(request, "nationalInfo");
		if ("0".equals(nationalInfo)){
			EgovSessionCookieUtil.setSessionAttribute(request, "foreigner", "1");	//내국인
		}else{
			EgovSessionCookieUtil.setSessionAttribute(request, "foreigner", "2");	//외국인
		}
    	
    	
		//요청IP와 다를경우
		if (!gpinUserIP.equals(EgovClntInfo.getClntIP(request))){
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
			return "cmm/sec/rnc/EgovRlnmCnfirm";
		}

    	model.addAttribute("retCd",    '1');			//결과코드(1성공)
    	model.addAttribute("dupInfo",    dupInfo);	//G-Pin 호환 키값
    	model.addAttribute("niceNm",    realName);		//반환하는 실명
    	return "cmm/sec/rnc/EgovGpinCnfirmChk";
	}
	
	/**
     * 핸드폰 실명인증 처리실행
     * @param model 모델
     * @return "/uss/umt/RealhpCheck.do"
     * @exception Exception
     */
	@RequestMapping("/sec/rnc/RealhpCnfirm.do")
    public String realhpCnfirm(RealhpVO realhpVO, HttpServletRequest request, ModelMap model) throws Exception {
		
		EgovSessionCookieUtil.removeSessionAttribute(request, "childPhone");
		EgovSessionCookieUtil.removeSessionAttribute(request, "childIhidnum");
		
		boolean result = true;
		
		String message = "";
		
		String userIhidnum = realhpVO.getCp_client();
		String cpIhidnum = realhpVO.getCp_jumin();
		String cpPhone = realhpVO.getCp_phone();
		
		//14세 이상 인증
		if(getMyAge(userIhidnum) > 14){
			message = "14세 이상은 일반 회원가입으로 진행해 주십시오.";
			result = false;
		}
		
		//주민번호 유효성 체크
		if(!getCheck(userIhidnum)){
			message = "14세 미만 주민등록번호가 유효하지 않습니다";
			result = false;
		}
		
		//주민번호 유효성 체크
		if(!getCheck(cpIhidnum)){
			message = "보호자 주민등록번호가 유효하지 않습니다";
			result = false;
		}
		
		//14세 미만 회원가입 중복 체크
		/*
		if (userManageService.checkChildDplct(realhpVO) > 0) {
			message = "입력하신 정보는 이미 14세미만 어린이회원으로 가입된 정보입니다.";
			result = false;
    	}
    	*/
		
		if (result){
			EgovSessionCookieUtil.setSessionAttribute(request, "childPhone", cpPhone);
			EgovSessionCookieUtil.setSessionAttribute(request, "childIhidnum", userIhidnum);
		}
		
		model.addAttribute("message", message);
		model.addAttribute("result", result);
		
		return "cmm/sec/rnc/EgovRlhpCnfirm";
	}
	
	/**
     * 핸드폰 실명인증 처리결과
     * @param model 모델
     * @return "/uss/umt/RealhpCheck.do"
     * @exception Exception
     */
	@RequestMapping("/sec/rnc/RealhpCheck.do")
    public String realhpCheck(RealhpVO realhpVO, HttpServletRequest request, ModelMap model) throws Exception {

		return "cmm/sec/rnc/EgovRlhpCnfirmChk";
    }
	

	public boolean getCheck(String x)
	 {
	  int y[] = {2,3,4,5,6,7,8,9,2,3,4,5};
	  int sum = 0;
	  
	  for (int i = 0 ; i < x.length()-1 ; i++)
	  {
	   sum += (x.charAt(i) - 48) * y[i];
	  }
	  
	  int temp = 11 * (sum/11) + 11 - sum;
	  int re = temp - 10 * (temp/10);
	  
	  boolean check = false;
	  if(re == x.charAt(12)-48) // string (ASCII)값을  int로 바꿔주기위해서 -48을 실행
	   check = true;
	  return check;
	 }


	public static int getMyAge(String idNum){

		String today = ""; //시스템 날짜
		String birthday = ""; //생일
		int myAge = 0; //만 나이

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy", Locale.KOREA);

		today = formatter.format(new Date()); //시스템 날짜를 가져와서 yyyy 형태로 변환

		if(idNum.charAt(6) == '1' || idNum.charAt(6) == '2'){
			birthday = "19" + idNum.substring(0, 2); //주민번호 7번째 자리수가 1 또는 2이면 1900년대 출생
		}else{ 
			birthday = "20" + idNum.substring(0, 2); //주민번호 7번째 자리수가 1 또는 2가 아니면 2000년대 출생
		} 

		myAge = Integer.parseInt(today) - Integer.parseInt(birthday) + 1; //현재년도 - 생년 + 1

		return myAge;

		}


}