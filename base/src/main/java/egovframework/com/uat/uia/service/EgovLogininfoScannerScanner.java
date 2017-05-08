package egovframework.com.uat.uia.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.sym.log.service.LoginInfoVO;

/**
 * @Class Name : EgovLogManageScheduling.java
 * @Description : 로그아웃 스케쥴링 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭   최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Service("egovLogininfoScanner")
public class EgovLogininfoScannerScanner {
	
	@Resource(name = "loginService")
    private EgovLoginService loginService;

	/**
	 * 유효시간이 지난 로그인정보를 삭제한다. 
	 * 
	 * @param 
	 * @return
	 * @throws Exception 
	 */
	public void ssoLogininfoRemover() throws Exception {
		List<LoginInfoVO> resultList = loginService.selectRemoveTargetList();
		if(resultList != null) {
			for(int i = 0; i < resultList.size(); i++) {
				loginService.removeLogoutList(resultList.get(i));
			}			
			loginService.deleteLogininfoRemoveTarget();
		}
	}

}
