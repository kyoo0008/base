package egovframework.com.utl.sim.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Hex;

import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

/*
 * AES, ARCFOUR, Blowfish, DES, DESede, HmacMD5, HmacSHA1..
//step 1. 암호화에 사용할 키를 생성한다.
String key=generateRandomSecretKey("AES");
System.out.println(key);
CipherSample cs=new CipherSample();

// step 2. 생성한 키를 저장
cs.setSecretKey(key);

// step 3. 암호화 알고리즘을 선택
cs.setAlgorithm("AES");

// step 4. 암호화
String encStr=cs.encrypt("My Nick's In Trutina");
System.out.println(encStr);

// step 5. 복호화
String decStr=cs.decrypt(encStr);
System.out.println(decStr);
*/

public class EgovCrypTo {
	private String keyAlgorithm = "AES";
	private String cipherAlgorithm = "AES/ECB/PKCS5Padding";
	private String key = "12345678";
	private SecretKeySpec keySpec;
	private Cipher cipher;

	public void setKeyAlgorithm(String algorithm){
		this.keyAlgorithm=algorithm;
	}
	
	public void setCipherAlgorithm(String cipherAlgorithm){
		this.cipherAlgorithm=cipherAlgorithm;
	}
	
	public void setSecretKey(String key){
		this.key=key;
	}

	private void setSecretKeySpec(){
		String rawkey = this.key;
		if("DES".equals(this.keyAlgorithm.toUpperCase())) {
			rawkey = EgovStringUtil.lpad(this.key, 8 * 2, "f");
		} else if("DESEDE".equals(this.keyAlgorithm.toUpperCase()) || "TRIPLEDES".equals(this.keyAlgorithm.toUpperCase())) {
			rawkey = EgovStringUtil.lpad(this.key, 8 * 3 * 2, "f");
		} else if("AES".equals(this.keyAlgorithm.toUpperCase())) {
			rawkey = EgovStringUtil.lpad(this.key, 16 * 2, "f");
		}
		
		byte[] raw=toBytes(rawkey, 16);//stringToBytes(key);
		keySpec=new SecretKeySpec(raw, this.keyAlgorithm);

		try {
			cipher=Cipher.getInstance(this.cipherAlgorithm);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		}

	}

	public String encrypt(String str){
		setSecretKeySpec();
		try{
			byte[] encrypted=null;
			synchronized(cipher){
				cipher.init(Cipher.ENCRYPT_MODE, keySpec);
				encrypted=cipher.doFinal(str.getBytes());
			}
			return new String(Hex.encodeHex(encrypted));       
		}catch(Exception e){
			throw new RuntimeException("encryption failure", e);
		}
	}

	public String decrypt(String str){
		setSecretKeySpec();
		try{
			byte[] encrypted=null;
			encrypted=Hex.decodeHex(str.toCharArray());
			byte[] decrypted=null;
			synchronized(cipher){
				cipher.init(Cipher.DECRYPT_MODE, keySpec);
				decrypted=cipher.doFinal(encrypted);
			}
			return new String(decrypted);
		}catch(Exception e){
			throw new RuntimeException("decryption failuer", e);
		}
	}

	/*
	public static String generateRandomSecretKey(String algorithm) throws Exception{
		KeyGenerator keyGen=KeyGenerator.getInstance(algorithm);
		keyGen.init(128);
		SecretKey key=keyGen.generateKey();
		byte[] raw=key.getEncoded();
		return bytesToString(raw);
	}
	 */
	
	public static String generateRandomSecretKey() {
		String key = "";
		for (int i = 1; i <= 8; i++) {
    		// 영자
    		if (i % 3 != 0) {
    			key += EgovStringUtil.getRandomStr('a', 'f');
    		// 숫자
    		} else {
    			key += EgovNumberUtil.getRandomNum(0, 9);
    		}
    	}
		return key;
	}
	
	private static String bytesToString(byte[] bytes){
		byte[] b2=new byte[bytes.length+1];
		b2[0]=1;
		System.arraycopy(bytes, 0, b2, 1, bytes.length);
		return new BigInteger(b2).toString(Character.MAX_RADIX);
	}

	
	private static byte[] stringToBytes(String str){
		byte[] bytes=new BigInteger(str, Character.MAX_RADIX).toByteArray();
		return Arrays.copyOfRange(bytes, 1, bytes.length);
	}
	
	
	/**
	 * <p>8, 10, 16진수 문자열을 바이트 배열로 변환한다.</p>
	 * <p>8, 10진수인 경우는 문자열의 3자리가, 16진수인 경우는 2자리가, 하나의 byte로 바뀐다.</p>
	 * 
	 * <pre>
	 * ByteUtils.toBytes(null)     = null
	 * ByteUtils.toBytes("0E1F4E", 16) = [0x0e, 0xf4, 0x4e]
	 * ByteUtils.toBytes("48414e", 16) = [0x48, 0x41, 0x4e]
	 * </pre>
	 * 
	 * @param digits 문자열
	 * @param radix 진수(8, 10, 16만 가능)
	 * @return
	 * @throws NumberFormatException
	 */
	public static byte[] toBytes(String digits, int radix) throws IllegalArgumentException, NumberFormatException {
		if (digits == null) {
			return null;
		}
		if (radix != 16 && radix != 10 && radix != 8) {
			throw new IllegalArgumentException("For input radix: \"" + radix + "\"");
		}
		int divLen = (radix == 16) ? 2 : 3;
    	int length = digits.length();
    	if (length % divLen == 1) {
    		throw new IllegalArgumentException("For input string: \"" + digits + "\"");
    	}
    	length = length / divLen;
    	byte[] bytes = new byte[length];
    	for (int i = 0; i < length; i++) {
    		int index = i * divLen;
    		bytes[i] = (byte)(Short.parseShort(digits.substring(index, index+divLen), radix));
    	}
    	return bytes;
	}
	
	 public static String encryptPassword(String str){
			String SHA = ""; 
			try{
				MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
				sh.update(str.getBytes("UTF-8")); 
				byte byteData[] = sh.digest();
				StringBuffer sb = new StringBuffer(); 
				for(int i = 0 ; i < byteData.length ; i++){
					sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
				}
				SHA = sb.toString();
				
			}catch(NoSuchAlgorithmException e){
				e.printStackTrace(); 
				SHA = null; 
			}catch(UnsupportedEncodingException e){
				e.printStackTrace(); 
				SHA = null; 
			}
			return SHA;
		}
}
