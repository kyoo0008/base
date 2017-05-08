package egovframework.com.utl.fcc.service;

import egovframework.com.utl.sim.service.EgovCrypTo;
import egovframework.com.utl.sim.service.EgovFileScrty;

public class EgovSsoSecureEncryptUtil {

	public static String generateEncyptKey() {
		return EgovCrypTo.generateRandomSecretKey();
	}
	
	public static String generateEncyptToken(String encKey, String planToken) throws Exception {
		EgovCrypTo crypto = new EgovCrypTo();
		crypto.setSecretKey(encKey);
		
		return EgovFileScrty.encode(encKey + crypto.encrypt(planToken));
	}
	
	public static String generateDecryptToken(String encrypToken) throws Exception {
		String decodeToken = EgovFileScrty.decode(encrypToken);
		String key = decodeToken.substring(0, 8);
		String token = decodeToken.substring(8);
		EgovCrypTo crypto = new EgovCrypTo();
		crypto.setSecretKey(key);
		return crypto.decrypt(token);
	}
}
