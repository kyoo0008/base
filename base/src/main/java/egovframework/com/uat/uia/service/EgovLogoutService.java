package egovframework.com.uat.uia.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class EgovLogoutService implements Runnable {

	List<String> urlList = null;
	public EgovLogoutService(List<String> urlList) {
		this.urlList = urlList;
	}
	
	public void run() {
		if(urlList != null) {
			for(int i = 0; i < urlList.size(); i++) {
				action(urlList.get(i));
			}
		}
	}
	
	private void action(String url) {
		HttpURLConnection con = null;
		BufferedReader br = null;
		String retValue = "";
		try {
			URL reqUrl = new URL(url);
			con = (HttpURLConnection)reqUrl.openConnection();
			con.setConnectTimeout(3000);
			if(con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStreamReader isr = new InputStreamReader(con.getInputStream(), "UTF-8");
				br = new BufferedReader(isr);
				String temp = null;
				while((temp = br.readLine()) != null) {
					retValue = retValue + temp;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(br != null) {
				try {
					br.close();
				} catch(Exception e1) {
					
				}
			}
			
			if(con != null) {
				try {
					con.disconnect();
				} catch(Exception e1) {
					
				}
			}
		}
		
	}
}
