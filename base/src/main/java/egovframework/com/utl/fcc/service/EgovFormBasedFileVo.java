package egovframework.com.utl.fcc.service;

import java.io.Serializable;

/**
 * @Class Name  : EgovFormBasedFileVo.java
 * @Description : Form-based File Upload VO
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.08.26       한성곤                  최초 생성
 *
 * @author 공통컴포넌트 개발팀 한성곤
 * @since 2009.08.26
 * @version 1.0
 * @see 
 * 
 *  Copyright (C) 2008 by MOPAS  All right reserved.
 */
@SuppressWarnings("serial")
public class EgovFormBasedFileVo implements Serializable {
    /**
	 * 파일명
	 * @uml.property  name="fileName"
	 */
    private String fileName = "";
    /**
	 * ContextType
	 * @uml.property  name="contentType"
	 */
    private String contentType = "";
    /**
	 * 하위 디렉토리 지정
	 * @uml.property  name="serverSubPath"
	 */
    private String serverSubPath = "";
    /**
	 * 물리적 파일명
	 * @uml.property  name="physicalName"
	 */
    private String physicalName = "";
    /**
	 * 파일 사이즈
	 * @uml.property  name="size"
	 */
    private long size = 0L;
    
    /**
	 * fileName attribute를 리턴한다.
	 * @return  the fileName
	 * @uml.property  name="fileName"
	 */
    public String getFileName() {
        return fileName;
    }
    /**
	 * fileName attribute 값을 설정한다.
	 * @param fileName  the fileName to set
	 * @uml.property  name="fileName"
	 */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    /**
	 * contentType attribute를 리턴한다.
	 * @return  the contentType
	 * @uml.property  name="contentType"
	 */
    public String getContentType() {
        return contentType;
    }
    /**
	 * contentType attribute 값을 설정한다.
	 * @param contentType  the contentType to set
	 * @uml.property  name="contentType"
	 */
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    /**
	 * serverSubPath attribute를 리턴한다.
	 * @return  the serverSubPath
	 * @uml.property  name="serverSubPath"
	 */
    public String getServerSubPath() {
        return serverSubPath;
    }
    /**
	 * serverSubPath attribute 값을 설정한다.
	 * @param serverSubPath  the serverSubPath to set
	 * @uml.property  name="serverSubPath"
	 */
    public void setServerSubPath(String serverSubPath) {
        this.serverSubPath = serverSubPath;
    }
    /**
	 * physicalName attribute를 리턴한다.
	 * @return  the physicalName
	 * @uml.property  name="physicalName"
	 */
    public String getPhysicalName() {
        return physicalName;
    }
    /**
	 * physicalName attribute 값을 설정한다.
	 * @param physicalName  the physicalName to set
	 * @uml.property  name="physicalName"
	 */
    public void setPhysicalName(String physicalName) {
        this.physicalName = physicalName;
    }
    /**
	 * size attribute를 리턴한다.
	 * @return  the size
	 * @uml.property  name="size"
	 */
    public long getSize() {
        return size;
    }
    /**
	 * size attribute 값을 설정한다.
	 * @param size  the size to set
	 * @uml.property  name="size"
	 */
    public void setSize(long size) {
        this.size = size;
    }
}
