package egovframework.com.msi.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class ContentsServiceVO implements Serializable {
	
	private String siteId = "";
	
    /**
	 * 시스템구분코드
	 */
    private String sysTyCode = "";
    
    /**
	 * 메뉴아이디
	 */
    private String linkMenuId = "";
    
    /**
	 * 테이블아이디
	 */
    private String tableId = "";
    /**
	 * 리스트항목 태그
	 */
    private String listTag = "";
    /**
	 * 출력갯수
	 */
    private String itemCount = "";
    
    /**
	 * 뷰타입(data, gallry)
	 */
    private String viewType = "";
    
	private String randomAt = "N";
    
    
    
    /**
	 * 컬럼명
	 */
    public List<String> colname = null;
    /**
	 * 길이 (전체 -1)
	 */
    public List<String> length = null;
    /**
	 * 태그
	 */
    public List<String> tag = null;
    /**
	 * 스타일 CSS
	 */
    public List<String> cssClass = null;
    
    public List<String> imgWidth = null;
    
    public List<String> imgHeight = null;
        

    private List<ColumVO> columInfo = null;
    
    /**
	 * siteId attribute를 리턴한다.
	 * @return  the siteId
	 */
    public String getSiteId() {
        return siteId;
    }

    /**
	 * siteId attribute 값을 설정한다.
	 * @param siteId  the siteId to set
	 */
    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }
    
    /**
	 * linkMenuId attribute를 리턴한다.
	 * @return  the linkMenuId
	 */
    public String getLinkMenuId() {
        return linkMenuId;
    }

    /**
	 * linkMenuId attribute 값을 설정한다.
	 * @param linkMenuId  the linkMenuId to set
	 */
    public void setLinkMenuId(String linkMenuId) {
        this.linkMenuId = linkMenuId;
    }
    
    /**
	 * sysTyCode attribute를 리턴한다.
	 * @return  the sysTyCode
	 */
    public String getSysTyCode() {
	return sysTyCode;
    }

    /**
	 * sysTyCode attribute 값을 설정한다.
	 * @param sysTyCode  the sysTyCode to set
	 */
    public void setSysTyCode(String sysTyCode) {
	this.sysTyCode = sysTyCode;
    }

    /**
	 * tableId attribute를 리턴한다.
	 * @return  the tableId
	 */
    public String getTableId() {
	return tableId;
    }

    /**
	 * tableId attribute 값을 설정한다.
	 * @param tableId  the tableId to set
	 */
    public void setTableId(String tableId) {
	this.tableId = tableId;
    }

    /**
	 * listTag attribute를 리턴한다.
	 * @return  the listTag
	 */
    public String getListTag() {
	return listTag;
    }

    /**
	 * listTag attribute 값을 설정한다.
	 * @param listTag  the listTag to set
	 */
    public void setListTag(String listTag) {
	this.listTag = listTag;
    }

    /**
	 * itemCount attribute를 리턴한다.
	 * @return  the itemCount
	 */
    public String getItemCount() {
	return itemCount;
    }

    /**
	 * itemCount attribute 값을 설정한다.
	 * @param itemCount  the itemCount to set
	 */
    public void setItemCount(String itemCount) {
	this.itemCount = itemCount;
    }

    /**
	 * viewType attribute를 리턴한다.
	 * @return  the viewType
	 */
    public String getViewType() {
	return viewType;
    }

    /**
	 * viewType attribute 값을 설정한다.
	 * @param viewType  the viewType to set
	 */
    public void setViewType(String viewType) {
	this.viewType = viewType;
    }

    
    /**
	 * colname attribute를 리턴한다.
	 * @return  the colname
	 */
    public List<String> getColname() {
	return colname;
    }
    
    /**
	 * colname attribute 값을 설정한다.
	 * @param colname  the colname to set
	 */
    public void setColname(List<String> colname) {
	this.colname = colname;
    }

    /**
	 * length attribute를 리턴한다.
	 * @return  the length
	 */
    public List<String> getLength() {
	return length;
    }

    /**
	 * length attribute 값을 설정한다.
	 * @param length  the length to set
	 */
    public void setLength(List<String> length) {
	this.length = length;
    }

    /**
	 * tag attribute를 리턴한다.
	 * @return  the tag
	 */
    public List<String> getTag() {
	return tag;
    }

    /**
	 * tag attribute 값을 설정한다.
	 * @param tag  the tag to set
	 */
    public void setTag(List<String> tag) {
	this.tag = tag;
    }

    /**
	 * cssClass attribute를 리턴한다.
	 * @return  the cssClass
	 */
    public List<String> getCssClass() {
	return cssClass;
    }

    /**
	 * cssClass attribute 값을 설정한다.
	 * @param cssClass  the cssClass to set
	 */
    public void setCssClass(List<String> cssClass) {
	this.cssClass = cssClass;
    }
    
    public List<String> getImgWidth() {
    	return imgWidth;
    }
    
    public void setImgWidth(List<String> imgWidth) {
    	this.imgWidth = imgWidth;
    }
    
    public List<String> getImgHeight() {
    	return imgHeight;
    }
    
    public void setImgHeight(List<String> imgHeight) {
    	this.imgHeight = imgHeight;
    }
        
    public String getRandomAt() {
		return randomAt;
	}

	public void setRandomAt(String randomAt) {
		this.randomAt = randomAt;
	}

	/**
	 * cssClass attribute를 리턴한다.
	 * @return  the cssClass
	 */
    public List<ColumVO> getColumInfo() {
    	
    	if(columInfo == null && colname != null) {
    		columInfo = new ArrayList<ColumVO>();
    		ColumVO vo = null;
    		for(int i=0; i < colname.size(); i++) {
    			vo = new ColumVO();
    			vo.setColname(colname.get(i));
    			vo.setCssClass(cssClass.get(i));
    			vo.setLength(length.get(i));
    			vo.setTag(tag.get(i));
    			if(imgWidth != null && imgWidth.size() >= i)
    				vo.setImgWidth(imgWidth.get(i));
    			if(imgHeight != null && imgHeight.size() >= i)
    				vo.setImgHeight(imgHeight.get(i));
    			columInfo.add(vo);
    		}
    	}
    	
	return columInfo;
    }
    
    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
	
}
