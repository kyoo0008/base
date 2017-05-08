package egovframework.com.sym.mpm.service;

public class FileCompare {

	private String fileNm = "";
	
	private long lastModified = 0L;

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public long getLastModified() {
		return lastModified;
	}

	public void setLastModified(long lastModified) {
		this.lastModified = lastModified;
	}
	
	
}
