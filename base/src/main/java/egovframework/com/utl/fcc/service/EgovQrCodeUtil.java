package egovframework.com.utl.fcc.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class EgovQrCodeUtil {

	public static void CreateQrCode(String text, File file, int width, int height) {
		FileOutputStream stream = null;
		try {
			stream = new FileOutputStream(file);
			CreateQrCode(text, stream, width, height);
		} catch(FileNotFoundException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(stream != null) {
				try {
					stream.close();
				} catch(Exception e1) {
					
				}
			}
		}
	}
	
	public static void CreateQrCode(String text, HttpServletResponse res, int width, int height) {
		ServletOutputStream stream  = null;
		try {
			stream  = res.getOutputStream();
			CreateQrCode(text, stream, width, height);
		} catch(FileNotFoundException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(stream != null) {
				try {
					stream.close();
				} catch(Exception e1) {
					
				}
			}
		}
	}
	
	public static void CreateQrCode(String text, OutputStream stream, int width, int height) {
		
		QRCodeWriter qw = new QRCodeWriter();
		BitMatrix bitMatrix = null;
		try {
			text = new String(text.getBytes("UTF-8"), "ISO-8859-1");
			bitMatrix = qw.encode(text, BarcodeFormat.QR_CODE, width, height);
			MatrixToImageWriter.writeToStream(bitMatrix, "png", stream);
		} catch(FileNotFoundException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(bitMatrix != null) {
				bitMatrix.clear();
			}
		}
	}
}
