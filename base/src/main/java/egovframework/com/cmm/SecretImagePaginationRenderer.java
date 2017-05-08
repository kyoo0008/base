package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class SecretImagePaginationRenderer extends AbstractPaginationRenderer {
	
	public SecretImagePaginationRenderer() {
		firstPageLabel = "<span><a href=\"{0}&amp;pageIndex={1}\" title=\"처음페이지로이동\"><img src=\"/template/web/secret_001/image/customer/btn_first.gif\" alt=\"처음\"/></a></span>";
		previousPageLabel = "<span><a href=\"{0}&amp;pageIndex={1}\" title=\"이전페이지로이동\"><img src=\"/template/web/secret_001/image/customer/btn_prew.gif\" alt=\"이전\"/></a></span>";
		currentPageLabel = "<span><strong>{0}</strong></span>";
		otherPageLabel = "<span><a href=\"{0}&amp;pageIndex={1}\" title=\"{2}페이지로이동\">{2}</a></span>";
		nextPageLabel = "<span><a href=\"{0}&amp;pageIndex={1}\" title=\"다음페이지로이동\"><img src=\"/template/web/secret_001/image/customer/btn_next.gif\" alt=\"다음\"/></a></span>";
		lastPageLabel = "<span><a href=\"{0}&amp;pageIndex={1}\" title=\"마지막페이지로이동\"><img src=\"/template/web/secret_001/image/customer/btn_last.gif\" alt=\"마지막\"/></a></span>";
	}
}
