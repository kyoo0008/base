package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImageSubPaginationRenderer extends AbstractPaginationRenderer {
	
	public ImageSubPaginationRenderer() {
		/*
		firstPageLabel = "<a href=\"{0}&amp;subPageIndex={1}\" title=\"처음페이지로이동\"><img src=\"/template/web/smart_001/image/sub/board/btn_first.gif\" alt=\"처음\"/></a>";
		previousPageLabel = "<a href=\"{0}&amp;subPageIndex={1}\" title=\"이전페이지로이동\"><img src=\"/template/web/smart_001/image/sub/board/btn_prew.gif\" alt=\"이전\"/></a>";
		currentPageLabel = "<a class=\"commthis\">{0}</a>";
		otherPageLabel = "<a href=\"{0}&amp;subPageIndex={1}\" title=\"{2}페이지로이동\">{2}</a>";
		nextPageLabel = "<a href=\"{0}&amp;subPageIndex={1}\" title=\"다음페이지로이동\"><img src=\"/template/web/smart_001/image/sub/board/btn_next.gif\" alt=\"다음\"/></a>";
		lastPageLabel = "<a href=\"{0}&amp;subPageIndex={1}\" title=\"마지막페이지로이동\"><img src=\"/template/web/smart_001/image/sub/board/btn_last.gif\" alt=\"마지막\"/></a>";
		*/
		firstPageLabel 		= "<a href=\"{0}&amp;subPageIndex={1}\" class=\"first\" title=\"처음페이지로 이동\"><span>처음</span></a>";
		previousPageLabel 	= "<a href=\"{0}&amp;subPageIndex={1}\" class=\"prev\" title=\"이전페이지로 이동\"><span>이전</span></a>";
		currentPageLabel 	= "<strong class=\"current\">{0}</strong>";
		otherPageLabel 		= "<a href=\"{0}&amp;subPageIndex={1}\" class=\"page\" title=\"{2}페이지로 이동\">{2}</a>";
		nextPageLabel 		= "<a href=\"{0}&amp;subPageIndex={1}\" class=\"next\" title=\"다음페이지로 이동\"><span>다음</span></a>";
		lastPageLabel 		= "<a href=\"{0}&amp;subPageIndex={1}\" class=\"last\" title=\"마지막페이지로 이동\"><span>마지막</span></a>";
	}
}
