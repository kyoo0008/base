package egovframework.com.msi.service;


public class ColumVO {

	/**
	 * 컬럼명
	 */
    public String colname = null;
    /**
	 * 길이 (전체 -1)
	 */
    public String length = null;
    /**
	 * 태그
	 */
    public String tag = null;
    /**
	 * 스타일 CSS
	 */
    public String cssClass = null;
    
    public String imgWidth = null;
    
    public String imgHeight = null;
    
    /**
	 * colname attribute를 리턴한다.
	 * @return  the colname
	 */
    public String getColname() {
	return colname;
    }
    
    /**
	 * colname attribute 값을 설정한다.
	 * @param colname  the colname to set
	 */
    public void setColname(String colname) {
	this.colname = colname;
    }

    /**
	 * length attribute를 리턴한다.
	 * @return  the length
	 */
    public String getLength() {
	return length;
    }

    /**
	 * length attribute 값을 설정한다.
	 * @param length  the length to set
	 */
    public void setLength(String length) {
	this.length = length;
    }

    /**
	 * tag attribute를 리턴한다.
	 * @return  the tag
	 */
    public String getTag() {
	return tag;
    }

    /**
	 * tag attribute 값을 설정한다.
	 * @param tag  the tag to set
	 */
    public void setTag(String tag) {
	this.tag = tag;
    }

    /**
	 * cssClass attribute를 리턴한다.
	 * @return  the cssClass
	 */
    public String getCssClass() {
	return cssClass;
    }

    /**
	 * cssClass attribute 값을 설정한다.
	 * @param cssClass  the cssClass to set
	 */
    public void setCssClass(String cssClass) {
	this.cssClass = cssClass;
    }
    
    public String getImgWidth() {
    	return imgWidth;
    }
    
    public void setImgWidth(String imgWidth) {
    	this.imgWidth = imgWidth;
    }
    
    public String getImgHeight() {
    	return imgHeight;
    }
    
    public void setImgHeight(String imgHeight) {
    	this.imgHeight = imgHeight;
    }
}
