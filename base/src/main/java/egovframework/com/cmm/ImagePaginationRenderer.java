package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImagePaginationRenderer extends AbstractPaginationRenderer {
  
  public ImagePaginationRenderer() {
	/*
	firstPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"btn\"><img src=\"/template/common/images/bbs/btn_li_prevstart.gif\" alt=\"첫 페이지\"/></a></li>";
	previousPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"btn\"><img src=\"/template/common/images/bbs/btn_li_prev.gif\" alt=\"이전\"/></a></li>";
	currentPageLabel = "<li><span class=\"current\">{0}</span></li>";
	otherPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\">{2}</a></li>";
	nextPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"btn\"><img src=\"/template/common/images/bbs/btn_li_next.gif\" alt=\"다음\"/></a></li>";
	lastPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"btn\"><img src=\"/template/common/images/bbs/btn_li_nextend.gif\" alt=\"마지막 페이지\"/></a></li>";
	*/
	/*  
	firstPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\" title=\"{1}페이지\"><span>◀</span> First</a></li>";
	previousPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\" title=\"{1}페이지\"><span>◀</span></a></li>";
	currentPageLabel = "<li><em class=\"active\" title=\"현재페이지\">■</em></li>";
	otherPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" title=\"{1}페이지\">■</a></li>";
	nextPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\" title=\"{1}페이지\"> <span>▶</span></a></li>";
	lastPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\" title=\"{1}페이지\">Last <span>▶</span></a></li>";
	*/
	firstPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\"><img src=\"/template/manage/images/board/btn_first.gif\" alt=\"처음\"/></a></li>";
	previousPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\"><img src=\"/template/manage/images/board/btn_prew.gif\" alt=\"이전\"/></a></li>";
	currentPageLabel = "<li><a class=\"commthis\">{0}</a></li>";
	otherPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\">{2}</a></li>";
	nextPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\"><img src=\"/template/manage/images/board/btn_next.gif\" alt=\"다음\"/></a></li>";
	lastPageLabel = "<li><a href=\"{0}&amp;pageIndex={1}\" class=\"move\"><img src=\"/template/manage/images/board/btn_last.gif\" alt=\"마지막\"/></a></li>";
  }
  
}
