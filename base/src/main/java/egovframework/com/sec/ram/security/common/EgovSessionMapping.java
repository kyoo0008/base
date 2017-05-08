package egovframework.com.sec.ram.security.common;

import egovframework.com.sec.ram.security.userdetails.EgovUserDetails;
import egovframework.com.sec.ram.security.userdetails.jdbc.EgovUsersByUsernameMapping;
import egovframework.com.uat.uia.service.LoginVO;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * mapRow 결과를 사용자 EgovUserDetails Object 에 정의한다.
 * 
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  ByungHun Woo    최초 생성
 *   2009.03.20  이문준          UPDATE
 *
 * </pre>
 */

public class EgovSessionMapping extends EgovUsersByUsernameMapping {
	
	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
    }

	/**
	 * mapRow Override
	 * @param rs ResultSet 결과
	 * @param rownum row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
    protected Object mapRow(ResultSet rs, int rownum) throws SQLException {
    	logger.debug("## EgovUsersByUsernameMapping mapRow ##");

        String strUserId    = rs.getString("USER_ID");
        String strPassWord  = rs.getString("PASSWORD");
        boolean strEnabled  = rs.getBoolean("ENABLED");        
        String strUserSe    = rs.getString("USER_SE_CODE");        
        String strUserNm    = rs.getString("USER_NM");
        String strUserEmail = rs.getString("EMAIL_ADRES");        
        String strUserPhone = rs.getString("MOBLPHON_NO");        
        String strSiteId 	= rs.getString("SITE_ID");
        String strSiteNm 	= rs.getString("SITE_NM");
        
        // 세션 항목 설정
        LoginVO loginVO = new LoginVO();
        loginVO.setId(strUserId);
        loginVO.setPassword(strPassWord);
        
        loginVO.setUserSeCode(strUserSe);
        loginVO.setUserSe(strUserSe);
        
        loginVO.setName(strUserNm);
        loginVO.setEmail(strUserEmail);
        loginVO.setMobileNo(strUserPhone);
        loginVO.setSiteId(strSiteId);
        loginVO.setSiteNm(strSiteNm);

        return new EgovUserDetails(strUserId, strPassWord, strEnabled, loginVO);
    }
}

	