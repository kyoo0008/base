package egovframework.com.sec.ram.security.userdetails.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;

import egovframework.com.cmm.service.Globals;
import egovframework.com.sec.ram.security.userdetails.EgovUserDetails;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.string.EgovObjectUtil;

/**
 * EgovUserDetails Helper 클래스
 * 
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon    최초 생성
 *
 * </pre>
 */

public class EgovUserDetailsHelper {
	
		/**
		 * 인증된 사용자객체를 VO형식으로 가져온다.
		 * @return Object - 사용자 ValueObject
		 */
		public static LoginVO getAuthenticatedUser(HttpServletRequest request, HttpServletResponse response) {
			
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				return null;
			}
			
			String username = authentication.getName();
			if (username.equals("roleAnonymous")) {
				return null;
			}
			
			Object principal = authentication.getPrincipal();
			if(EgovObjectUtil.isNull(principal)) {
				return null;
			}
			
			EgovUserDetails details = (EgovUserDetails) principal;			
			
			return (LoginVO)details.getEgovUserVO();
			
		}
		
		/**
		 * 인증된 사용자의 권한 정보를 가져온다.
		 * 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
		 * @return List - 사용자 권한정보 목록
		 */
		public static List<String> getAuthorities() {
			List<String> listAuth = new ArrayList<String>();
			
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				return null;
			}
			
			GrantedAuthority[] authorities = authentication.getAuthorities();

			for (int i = 0; i < authorities.length; i++) {
				listAuth.add(authorities[i].getAuthority());
			}

			return listAuth;
		}
		
		/**
		 * 인증된 사용자 여부를 체크한다.
		 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
		 */
		
		public static Boolean isAuthenticated(HttpServletRequest request, HttpServletResponse response) {
			
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (EgovObjectUtil.isNull(authentication)) {
				// log.debug("## authentication object is null!!");
				return Boolean.FALSE;
			}
			
			String username = authentication.getName();
			if (username.equals("roleAnonymous")) {
				// log.debug("## username is " + username);
				return Boolean.FALSE;
			}

			Object principal = authentication.getPrincipal();
			
			return Boolean.valueOf(!EgovObjectUtil.isNull(principal));
		}
				
		//로그인 URL
		public static String getRedirectLoginUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uat/uia/egovLoginUsr.do";
			return "/uat/uia/egovLoginUsr.do";
		}

		//로그아웃 URL
		public static String getRedirectLogoutUrl() throws Exception {
			
			return "/uat/uia/actionLogout.do";
		}
		
		//회원가입 URL
		public static String getRedirectRegistUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uss/umt/cmm/EgovSelectMber.do";
			return "/uss/umt/cmm/EgovSelectMber.do";
		}
		
		//아이디찾기 URL
		public static String getRedirectFindIdUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uat/uia/egovIdSearchView.do";
			return "/uat/uia/egovIdSearchView.do";
		}
		
		//비밀번호재발급 URL
		public static String getRedirectFindPasswordUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uat/uia/egovPasswordSearchView.do";
			return "/uat/uia/egovPasswordSearchView.do";
		}
		
		//정보수정 URL
		public static String getRedirectUserUpdateUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=update";
			return "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=update";
		}
		
		//비밀번호변경 URL
		public static String getRedirectUserPasswordUpdateUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=password";
			return "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=password";
		}
		
		//회원탈퇴 URL
		public static String getRedirectUserDeleteUrl() throws Exception {
			
			//return Globals.DOMAIN  + "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=secsn";
			return "/uss/umt/cmm/EgovUserConfirmView.do?trgtPge=secsn";
		}

}
