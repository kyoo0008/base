package egovframework.com.uss.umt.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import egovframework.com.cmm.service.Globals;

import egovframework.com.cop.sms.service.SmsVO;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovCrypTo;
import egovframework.com.cop.sms.service.EgovSmsInfoService;

/**
 * 사용자관리에 관한 비지니스 클래스를 정의한다.
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
@Service("userManageService")
public class EgovUserManageServiceImpl extends AbstractServiceImpl implements EgovUserManageService {

	@Resource(name="userManageDAO")
	private UserManageDAO userManageDAO;
		
	@Resource(name = "EgovSmsInfoService")
    private EgovSmsInfoService egovSmsInfoService;
		
    /**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(실명인증키)
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public int checkDiDplct(String credtId) throws Exception {
		return userManageDAO.checkDiDplct(credtId);
	}
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
	 * @param checkId 중복여부 확인대상 실명인증키
	 * @return 사용가능여부
	 * @throws Exception
	 */
	public UserManageVO checkUserDplct(String credtId) throws Exception {
		return userManageDAO.checkUserDplct(credtId);
	}
	
	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인(아이디)
	 * @param checkId 중복여부 확인대상 아이디
	 * @return 사용가능여부(아이디 사용회수 int)
	 * @throws Exception
	 */
	public int checkIdDplct(String checkId) throws Exception {
		return userManageDAO.checkIdDplct(checkId);
	}
		
	/**
     * 화면탈퇴처리를 한다.
     * @param userManageVO
     */
    public int deleteUser(UserManageVO userManageVO) throws Exception {
    	return userManageDAO.deleteUser(userManageVO);
    }
	
	/**
	 * 사용자의 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param mberManageVO 일반회원 등록정보
	 * @return result 등록결과
	 * @throws Exception
	 */
	public void insertUser(UserManageVO userManageVO) throws Exception {
		
		userManageVO.setPassword(EgovCrypTo.encryptPassword(userManageVO.getPassword()));
		
		userManageVO.setEmailAdres(userManageVO.getEmail1()+"@"+userManageVO.getEmail2());
		userManageVO.setTlphonNo(userManageVO.getTel1()+"-"+userManageVO.getTel2()+"-"+userManageVO.getTel3());
		userManageVO.setMoblphonNo(userManageVO.getPhone1()+"-"+userManageVO.getPhone2()+"-"+userManageVO.getPhone3());
		
		userManageDAO.insertUser(userManageVO);
	}

	/**
	 * 기 등록된 사용자 중 검색조건에 맞는 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param uniqId 상세조회대상 업무사용자 아이디
	 * @return userManageVO 업무사용자 상세정보
	 * @throws Exception
	 */
	public UserManageVO selectUser(String userId) throws Exception {
		UserManageVO userManageVO = userManageDAO.selectUser(userId);		
		return userManageVO;
	}

	/**
	 * 기 등록된 특정 사용자의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	public List<?> selectUserList(UserManageVO userSearchVO) throws Exception {
		List<?> result = userManageDAO.selectUserList(userSearchVO);
		return result;
	}
	
	/**
	 * 20130225 이재현 회원가입시 학교목록을 조회한다
	 * @param userSearchVO 검색조건
	 * @return List<UserManageVO> 업무사용자 목록정보
	 * @throws Exception
	 */
	public List<?> selectSchool() throws Exception {
		List<?> result = userManageDAO.selectSchool();
		return result;
	}

	/**
	 * 학교소속 정보를 갖고온다.
	 */
	public List<?> selectUserSchoolList(UserManageVO userSearchVO) throws Exception {
		List<?> result = userManageDAO.selectUserSchoolList(userSearchVO);
		return result;
	}
	
	/**
	 * 기 등록된 특정 사용자목록의 전체수를 확인
	 * @param userSearchVO 검색조건
	 * @return 총사용자갯수(int)
	 * @throws Exception
	 */
	public int selectUserListTotCnt(UserManageVO userSearchVO) throws Exception {
		return userManageDAO.selectUserListTotCnt(userSearchVO);
	}
		
	/**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    public Map<String, Object> updateSendPassword(UserManageVO vo) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	//임시 비밀번호를 생성한다.
    	String newpassword = "";
    	for (int i = 1; i <= 10; i++) {
    		// 영자
    		if (i % 3 != 0) {
    			newpassword += EgovStringUtil.getRandomStr('a', 'z');
    		// 숫자
    		} else {
    			newpassword += EgovNumberUtil.getRandomNum(0, 9);
    		}
    	}
    	
    	vo.setPassword(newpassword);
    	this.updatePassword(vo);
    	
    	StringBuffer buff = new StringBuffer();
    	String strMsgSMS = buff.append(vo.getUserNm()).append("님의 임시비밀번호는 ").append(newpassword).append(" 입니다. ").toString();
		
		SmsVO smsVO = new SmsVO();
		
		List<String> phones = new ArrayList<String>();
		phones.add(vo.getMoblphonNo());
		smsVO.setAdminAt("Y");
		smsVO.setTrnsmitTelno(EgovStringUtil.getPhoneNumber(Globals.PHONE));
		smsVO.setRecptnTelno(phones);	//수신전화번호
		smsVO.setTrnsmitCn(strMsgSMS);	//내용

		int iRet = egovSmsInfoService.sendUserSms(vo.getUserId(), smsVO);

		//성공
		boolean result = false;
		if(smsVO.getRecptnTelno().size() == iRet) {
			result = true;
		}

		map.put("sendResult", result);
		
    	return map;
    }
    	
	/**
	 * 화면에 조회된 사용자의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param userManageVO 업무사용자 수정정보
	 * @throws Exception
	 */
	public int updateUser(UserManageVO userManageVO) throws Exception {
		userManageVO.setPassword(EgovCrypTo.encryptPassword(userManageVO.getPassword()));
		return userManageDAO.updateUser(userManageVO);
	}
	

    /**
     * 사용자 정보를 수정한다.
     * @param userManageVO 사용자 수정정보
     */
	public int updateManageUser(UserManageVO userManageVO) throws Exception {
		return userManageDAO.updateManageUser(userManageVO);
	}
	
	/**
	 * 사용자 암호 수정
	 * @param userManageVO 사용자 수정정보(비밀번호)
	 * @throws Exception
	 */
	public int updatePassword(UserManageVO userManageVO) throws Exception {
		userManageVO.setPassword(EgovCrypTo.encryptPassword(userManageVO.getPassword()));
		return userManageDAO.updatePassword(userManageVO);
	}
			
	public UserManageVO selectLoingUser(String userId) throws Exception {
    	return userManageDAO.selectLoingUser(userId);
    }
	
	/**
	 * 개인정보 보호를 위한 확인(아이디, 페스워드)
	 * @param passVO 회원의 암호 확인 조회조건정보
	 * @return userManageVO 회원의 암호 확인 조회조건정보
	 * @throws Exception
	 */
    public int selectCheckPassword(UserManageVO userManageVO) throws Exception {
    	userManageVO.setPassword(EgovCrypTo.encryptPassword(userManageVO.getPassword()));
    	return userManageDAO.selectCheckPassword(userManageVO);
    }
    
	/**
     * 권한 사용자 목록을 조회한다
     * @param userSearchVO 검색조건
     * @return List 업무사용자 목록정보
     */
    public List selectUserAuthList(UserManageVO userSearchVO) throws Exception {
        return userManageDAO.selectUserAuthList(userSearchVO);
    }
    
    /**
     * 권한 사용자 총 갯수를 조회한다
     * @param userSearchVO 검색조건
     * @return int 업무사용자 총갯수
     */
    public int selectUserAuthListTotCnt(UserManageVO userSearchVO) throws Exception {
        return userManageDAO.selectUserAuthListTotCnt(userSearchVO);
    }
    
    /**
     * 선택한 사용자 목록을 접속금지 처리 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRhibt(UserManageVO userManageVO) throws Exception {
    	userManageDAO.updateUserRhibt(userManageVO);
    }
    
    /**
     * 해당 사용자를 접속금지 해제 한다.
     * @param userManageVO 사용자수정정보
     */
    public void updateUserRelis(UserManageVO userManageVO) throws Exception {
    	userManageDAO.updateUserRelis(userManageVO);
    }

    /** 
	 * 사용자 엑셀파일을 일괄 업로드한다.
	 * @param  vo MenuManageVO  
	 * @param  inputStream InputStream  
	 * @exception Exception
	 */
	public Map<String, Object> insertUserExcelUpload(UserManageVO userManageVO, String fileExt, InputStream inputStream) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(EgovStringUtil.isEmpty(userManageVO.getSiteId())) {
			map.put("message", "학교(사이트)가 선택되지 않았습니다.");
			return map;
        }
		
		if(!("XLS".equals(fileExt) || "XLSX".equals(fileExt))) {
			map.put("message", "파일형식이 올바르지 않습니다('.xls','.xlsx')");
			return map;
        }
        
		String baseMessage = null;
		List<UserManageVO> memberList = new ArrayList<UserManageVO>();
	    try {
	    	Workbook wb = null;
	    	if("XLS".equals(fileExt)) {
	    		wb = new HSSFWorkbook(inputStream);
	    	} else if("XLSX".equals(fileExt)) {
	    		wb = new XSSFWorkbook(inputStream);
	    	}
	    	//int sheetNum = wb.getNumberOfSheets(); //시트갯수 가져오기
	    	if(wb != null) {
		    	Sheet sheet = wb.getSheetAt(0);
		    	int rows = sheet.getPhysicalNumberOfRows(); //행 갯수 가져오기
	
	            for(int r = 1; r < rows; r++){ //row 루프            	
	            	Row row = sheet.getRow(r); //row 가져오기
	                if(row != null) {
	                	UserManageVO userVO = new UserManageVO();
	                	int cells = row.getPhysicalNumberOfCells();
		                for(int c = 0; c < cells; c++) {	//cell 가져오기
		                	Cell cell = row.getCell(c);
		                	String value = "";
		                	switch(cell.getCellType()) {
			                	case Cell.CELL_TYPE_FORMULA:
			                		value = "" + cell.getCellFormula();
			                		break;
			                	case Cell.CELL_TYPE_NUMERIC:
			                		value = "" + (long)cell.getNumericCellValue();
			                		break;
			                	case Cell.CELL_TYPE_STRING:
			                		value = "" + cell.getRichStringCellValue();
			                		break;
			                	case Cell.CELL_TYPE_BLANK:
			                		value = "";
			                		break;
			                	case Cell.CELL_TYPE_ERROR:
			                		value = "" + cell.getErrorCellValue();
			                		break;
			                	case Cell.CELL_TYPE_BOOLEAN:
			                		value = "" + cell.getBooleanCellValue();
			                		break;
		                	}
		                	
		                	if(!EgovStringUtil.isEmpty(value)) {
		                		value = value.trim();
		                	}
		                	
		                	switch(c) {
		                		case 0 : userVO.setUserSeCode(value); 	break;	//사용자유형
				                case 1 : userVO.setUserId(value); 		break;	//아이디
				                case 2 : userVO.setPassword(value); 	break;	//비밀번호
				                case 3 : userVO.setUserNm(value); 		break;	//이름
				                case 7 : userVO.setEmailAdres(value);	break;	//이메일
				                case 8 : userVO.setTlphonNo(value);		break;	//전화
				                case 9 : userVO.setMoblphonNo(value);	break;	//휴대폰
				                case 10 : userVO.setZip(value);			break;	//우편번호
				                case 11 : userVO.setAdres(value);		break;	//주소
				                case 12 : userVO.setAdresDetail(value);	break;	//상세주소
			                }
		                }
		                userVO.setSiteId(userManageVO.getSiteId());				//사이트아이디
		                userVO.setNo(r);
		                
		                //Validation 1차
		                userVO.setMessage("");
		                boolean validateErrored = false;
		                if(EgovStringUtil.isEmpty(userVO.getUserSeCode())) {
		                	userVO.setMessage(userVO.getMessage() + "사용자구분,");validateErrored = true;
		                } else {
		                	if(!("S".equals(userVO.getUserSeCode()) || "T".equals(userVO.getUserSeCode()))) {userVO.setMessage(userVO.getMessage() + "사용자구분 오류,");validateErrored = true;}
		                }
		                
		                if(EgovStringUtil.isEmpty(userVO.getUserId())) {
		                	userVO.setMessage(userVO.getMessage() + "아이디없음,");validateErrored = true;
		                } else {
		                	if(userVO.getUserId().length() > 20) {userVO.setMessage(userVO.getMessage() + "아이디길이초과(20자),");validateErrored = true;}
		                }
		                
		                if(EgovStringUtil.isEmpty(userVO.getPassword())) {
		                	userVO.setMessage(userVO.getMessage() + "비밀번호없음,");validateErrored = true;
		                } else {
		                	if(userVO.getPassword().length() > 20) {userVO.setMessage(userVO.getMessage() + "비밀번호길이초과(20자),");validateErrored = true;}
		                }
		                
		                if(EgovStringUtil.isEmpty(userVO.getUserNm())) {
		                	userVO.setMessage(userVO.getMessage() + "이름없음,");validateErrored = true;
		                } else {
		                	if(userVO.getUserNm().length() > 30) {userVO.setMessage(userVO.getMessage() + "이름길이초과(30자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getEmailAdres())) {
		                	if(userVO.getEmailAdres().length() > 50) {userVO.setMessage(userVO.getMessage() + "이메일길이초과(50자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getTlphonNo())) {
		                	if(userVO.getTlphonNo().length() > 15) {userVO.setMessage(userVO.getMessage() + "전화길이초과(15자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getMoblphonNo())) {
		                	if(userVO.getMoblphonNo().length() > 15) {userVO.setMessage(userVO.getMessage() + "전화길이초과(15자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getZip())) {
		                	if(userVO.getZip().length() > 6) {userVO.setMessage(userVO.getMessage() + "우편번호길이초과(6자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getAdres())) {
		                	if(userVO.getAdres().length() > 100) {userVO.setMessage(userVO.getMessage() + "주소길이초과(100자),");validateErrored = true;}
		                }
		                
		                if(!EgovStringUtil.isEmpty(userVO.getAdresDetail())) {
		                	if(userVO.getAdresDetail().length() > 100) {userVO.setMessage(userVO.getMessage() + "상세주소길이초과(100자),");validateErrored = true;}
		                }
	 	                
		                
		                memberList.add(userVO);
		                
		                if(validateErrored) {
		                	map.put("message", "[포탈-문제가 발생하였습니다(00)]  데이터에 문제가 발견되었습니다. 데이터의 메세지를 확인해 주세요");
		            		map.put("dataList", memberList);
		            		return map;
		                }
	                }
	            }
	    	}
        } catch(Exception e){
        	baseMessage = e.getMessage();
        	e.printStackTrace(); 
        } finally {
        	if(inputStream != null) {
        		try {
        			inputStream.close();
        		} catch(Exception ex) {}
        	}
        }
        
        if(baseMessage!= null && memberList.size() == 0) {
        	map.put("message", "데이터가 0건 입니다. " + (baseMessage!= null ? "서버메세지 : " + baseMessage : ""));
        	return map;
        }
        
        //임시 사용자정보 일괄 입력
    	//Validation 2차
    	userManageDAO.deleteUserTmp(userManageVO);
    	
    	try {
			userManageDAO.insertUserTmpBatch(memberList);
    	} catch(Exception ex) {
    		map.put("message", "[포탈-문제가 발생하였습니다(01)] 서버메세지 : " + ex.getMessage());
    		map.put("dataList", memberList);
    		return map;
    	}
    	
    	List<UserManageVO> errorList = userManageDAO.selectUserTmpErrorList(userManageVO);
    	if(errorList != null && errorList.size() > 0) {
    		map.put("message", "[포탈-문제가 발생하였습니다(02)] 데이터에 문제가 발견되었습니다. 데이터의 메세지를 확인해 주세요");
    		map.put("dataList", errorList);
    		return map;
    	}
    	
		List<UserManageVO> dplctList = userManageDAO.selectUserTmpDplctList(userManageVO);
		if(dplctList != null && dplctList.size() > 0) {
    		map.put("message", "[포탈-문제가 발생하였습니다(03)] 중복된 아이디가 발견되었습니다. 다음은 중복된 아이디 목록입니다.");
    		map.put("dataList", dplctList);
    		return map;
    	}
		
		try {
    		userManageDAO.insertUserForTmp(userManageVO);
    	} catch(Exception ex) {
    		map.put("message", "[포탈-문제가 발생하였습니다(04)] 서버메세지 : " + ex.getMessage());
    		map.put("dataList", memberList);
    		return map;
    	}
    	
		//학사관리 데이터 입력처리
    	/*
		try {
			userManageDAO.insertUserTmpForSrm(userManageVO);
    	} catch(Exception ex) {
    		map.put("message", "[학사-문제가 발생하였습니다(05)] 서버메세지 : " + ex.getMessage());
    		map.put("dataList", memberList);
    		return map;
    	}
    	*/
    	map.put("message", "성공적으로 작업을 완료하였습니다. 처리된 데이터건수 :" + memberList.size());
        
		return map;
	}
}