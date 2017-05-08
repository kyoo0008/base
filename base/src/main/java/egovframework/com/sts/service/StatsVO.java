package egovframework.com.sts.service;

/**
 * 통계 결과 VO 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  박지욱          최초 생성 
 *  
 *  </pre>
 */
public class StatsVO {

	/**
	 * 결과통계수
	 */
	private long statsCo;
	
	/**
	 * 모바일결과통계수
	 */
	private long mobileStatsCo;
	
	/**
	 * 결과일자
	 */
	private String statsDate;
	/**
	 * 최대통계수
	 */
	private long maxStatsCo;
	/**
	 * 최소통계수
	 */
	private long minStatsCo;
	/**
	 * 생성글수
	 */
	private long creatCo;
	/**
	 * 총조회수
	 */
	private long totInqireCo;
	/**
	 * 평균조회수
	 */
	private float avrgInqireCo;
	/**
	 * 최대조회게시물번호
	 */
	private String mxmmInqireNttNo;
	/**
	 * 최대조회게시물제목
	 */
	private String mxmmInqireBbsNm;
	/**
	 * 최소조회게시물번호
	 */
	private String mummInqireNttNo;
	/**
	 * 최소조회게시물제목
	 */
	private String mummInqireBbsNm;
	/**
	 * 최고게시자ID
	 */
	private String topNtcepersonId;
	/**
	 * 최고게시글수
	 */
	private long topNtcepersonCo;
	/**
	 * 접속프로그램메소드
	 */
	private String conectMethod;
	/**
	 * 수정글수
	 */
	private long updtCo;
	/**
	 * 조회글수
	 */
	private long inqireCo;
	/**
	 * 삭제글수
	 */
	private long deleteCo;
	/**
	 * 출력횟수
	 */
	private long outptCo;
	/**
	 * 에러횟수
	 */
	private long errorCo;
	/**
	 * 시작일자
	 */
	private String fromDate;
	/**
	 * 종료일자
	 */
	private String toDate;
	/**
	 * 기간구분
	 */
	private String pdKind;
	/**
	 * 통계구분
	 */
	private String statsKind;
	/**
	 * 세부통계구분
	 */
	private String detailStatsKind;
	/**
	 * 탭구분
	 */
	private String tabKind;
	/**
	 * 그래프길이
	 */
	private float maxUnit;
	
	/**
	 * 그래프길이2
	 */
	private float maxUnit2;
	
	/**
	 * 그래프길이3
	 */
	private float maxUnit3;
	
	//구분명
	private String mlgNm;
	
	//사이트명
	private String siteNm;
	
	//사이트ID
	private String siteId;
	
	//증감 마일리지
	private long irdsMlgScore;
	
	//가감 마일리지
	private long adsbtrMlgScore;
	
	//통계항목명
	private String statsNm;
	
	//통계항목명2
	private String statsNm2;
	
	//통계항목데이타
	private long statScore;
	
	//통계아이디
	private String statId;
	
	//사용여부
	private String statAt;

	//진행여부
	private String useAt;
	
	//대상ID
	private String trgetId;
	
	//게시판ID
	private String bbsId;
	
	//구분명
	private String gbNm;
	
	//게시판명
	private String bbsNm;
	
	//다운로드횟수
	private long dwldCo;
	
	private String userType;
	private String ownerType;
	private String lvl1ClasCd;
	private long tcnt;
	private long cnt1;
	private long cnt2;
	private long cnt3;
	private long cnt4;
	private long cnt5;
	private long cnt6;
	private long cnt7;
	private long cnt8;
	private long cnt9;
	

	public String getStatId() {
		return statId;
	}
	public void setStatId(String statId) {
		this.statId = statId;
	}
	
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	
	public String getStatAt() {
		return statAt;
	}
	public void setStatAt(String statAt) {
		this.statAt = statAt;
	}
	
	public String getMlgNm() {
		return mlgNm;
	}
	public void setMlgNm(String mlgNm) {
		this.mlgNm = mlgNm;
	}
	
	public long getIrdsMlgScore() {
		return irdsMlgScore;
	}
	public void setIrdsMlgScore(long irdsMlgScore) {
		this.irdsMlgScore = irdsMlgScore;
	}
	public long getAdsbtrMlgScore() {
		return adsbtrMlgScore;
	}
	public void setAdsbtrMlgScore(long adsbtrMlgScore) {
		this.adsbtrMlgScore = adsbtrMlgScore;
	}
	
	public String getStatsNm() {
		return statsNm;
	}
	public void setStatsNm(String statsNm) {
		this.statsNm = statsNm;
	}
	public String getStatsNm2() {
		return statsNm2;
	}
	public void setStatsNm2(String statsNm2) {
		this.statsNm2 = statsNm2;
	}
	
	public long getStatScore() {
		return statScore;
	}
	public void setStatScore(long statScore) {
		this.statScore = statScore;
	}
	/**
	 * statsCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getStatsCo() {
		return statsCo;
	}
	/**
	 * statsCo attribute 값을 설정한다.
	 * @param statsCo  long
	 */
	public void setStatsCo(long statsCo) {
		this.statsCo = statsCo;
	}
	
	public long getMobileStatsCo() {
		return mobileStatsCo;
	}
	public void setMobileStatsCo(long mobileStatsCo) {
		this.mobileStatsCo = mobileStatsCo;
	}
	
	/**
	 * statsDate attribute 를 리턴한다.
	 * @return  String
	 */
	public String getStatsDate() {
		return statsDate;
	}
	/**
	 * statsDate attribute 값을 설정한다.
	 * @param statsDate  String
	 */
	public void setStatsDate(String statsDate) {
		this.statsDate = statsDate;
	}
	/**
	 * maxStatsCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getMaxStatsCo() {
		return maxStatsCo;
	}
	/**
	 * maxStatsCo attribute 값을 설정한다.
	 * @param maxStatsCo  long
	 */
	public void setMaxStatsCo(long maxStatsCo) {
		this.maxStatsCo = maxStatsCo;
	}
	/**
	 * minStatsCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getMinStatsCo() {
		return minStatsCo;
	}
	/**
	 * minStatsCo attribute 값을 설정한다.
	 * @param minStatsCo  long
	 */
	public void setMinStatsCo(long minStatsCo) {
		this.minStatsCo = minStatsCo;
	}
	/**
	 * creatCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getCreatCo() {
		return creatCo;
	}
	/**
	 * creatCo attribute 값을 설정한다.
	 * @param creatCo  long
	 */
	public void setCreatCo(long creatCo) {
		this.creatCo = creatCo;
	}
	/**
	 * totInqireCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getTotInqireCo() {
		return totInqireCo;
	}
	/**
	 * totInqireCo attribute 값을 설정한다.
	 * @param totInqireCo  long
	 */
	public void setTotInqireCo(long totInqireCo) {
		this.totInqireCo = totInqireCo;
	}
	/**
	 * avrgInqireCo attribute 를 리턴한다.
	 * @return  float
	 */
	public float getAvrgInqireCo() {
		return avrgInqireCo;
	}
	/**
	 * avrgInqireCo attribute 값을 설정한다.
	 * @param avrgInqireCo  float
	 */
	public void setAvrgInqireCo(float avrgInqireCo) {
		this.avrgInqireCo = avrgInqireCo;
	}
	/**
	 * mxmmInqireNttNo attribute 를 리턴한다.
	 * @return  String
	 */
	public String getMxmmInqireNttNo() {
		return mxmmInqireNttNo;
	}
	/**
	 * mxmmInqireNttNo attribute 값을 설정한다.
	 * @param mxmmInqireNttNo  String
	 */
	public void setMxmmInqireNttNo(String mxmmInqireNttNo) {
		this.mxmmInqireNttNo = mxmmInqireNttNo;
	}
	/**
	 * mxmmInqireBbsNm attribute 를 리턴한다.
	 * @return  String
	 */
	public String getMxmmInqireBbsNm() {
		return mxmmInqireBbsNm;
	}
	/**
	 * mxmmInqireBbsNm attribute 값을 설정한다.
	 * @param mxmmInqireBbsNm  String
	 */
	public void setMxmmInqireBbsNm(String mxmmInqireBbsNm) {
		this.mxmmInqireBbsNm = mxmmInqireBbsNm;
	}
	/**
	 * mummInqireNttNo attribute 를 리턴한다.
	 * @return  String
	 */
	public String getMummInqireNttNo() {
		return mummInqireNttNo;
	}
	/**
	 * mummInqireNttNo attribute 값을 설정한다.
	 * @param mummInqireNttNo  String
	 */
	public void setMummInqireNttNo(String mummInqireNttNo) {
		this.mummInqireNttNo = mummInqireNttNo;
	}
	/**
	 * mummInqireBbsNm attribute 를 리턴한다.
	 * @return  String
	 */
	public String getMummInqireBbsNm() {
		return mummInqireBbsNm;
	}
	/**
	 * mummInqireBbsNm attribute 값을 설정한다.
	 * @param mummInqireBbsNm  String
	 */
	public void setMummInqireBbsNm(String mummInqireBbsNm) {
		this.mummInqireBbsNm = mummInqireBbsNm;
	}
	/**
	 * topNtcepersonId attribute 를 리턴한다.
	 * @return  String
	 */
	public String getTopNtcepersonId() {
		return topNtcepersonId;
	}
	/**
	 * topNtcepersonId attribute 값을 설정한다.
	 * @param topNtcepersonId  String
	 */
	public void setTopNtcepersonId(String topNtcepersonId) {
		this.topNtcepersonId = topNtcepersonId;
	}
	/**
	 * topNtcepersonCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getTopNtcepersonCo() {
		return topNtcepersonCo;
	}
	/**
	 * topNtcepersonCo attribute 값을 설정한다.
	 * @param topNtcepersonCo  long
	 */
	public void setTopNtcepersonCo(long topNtcepersonCo) {
		this.topNtcepersonCo = topNtcepersonCo;
	}
	/**
	 * conectMethod attribute 를 리턴한다.
	 * @return  String
	 */
	public String getConectMethod() {
		return conectMethod;
	}
	/**
	 * conectMethod attribute 값을 설정한다.
	 * @param conectMethod  String
	 */
	public void setConectMethod(String conectMethod) {
		this.conectMethod = conectMethod;
	}
	/**
	 * updtCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getUpdtCo() {
		return updtCo;
	}
	/**
	 * updtCo attribute 값을 설정한다.
	 * @param updtCo  long
	 */
	public void setUpdtCo(long updtCo) {
		this.updtCo = updtCo;
	}
	/**
	 * inqireCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getInqireCo() {
		return inqireCo;
	}
	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo  long
	 */
	public void setInqireCo(long inqireCo) {
		this.inqireCo = inqireCo;
	}
	/**
	 * deleteCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getDeleteCo() {
		return deleteCo;
	}
	/**
	 * deleteCo attribute 값을 설정한다.
	 * @param deleteCo  long
	 */
	public void setDeleteCo(long deleteCo) {
		this.deleteCo = deleteCo;
	}
	/**
	 * outptCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getOutptCo() {
		return outptCo;
	}
	/**
	 * outptCo attribute 값을 설정한다.
	 * @param outptCo  long
	 */
	public void setOutptCo(long outptCo) {
		this.outptCo = outptCo;
	}
	/**
	 * errorCo attribute 를 리턴한다.
	 * @return  long
	 */
	public long getErrorCo() {
		return errorCo;
	}
	/**
	 * errorCo attribute 값을 설정한다.
	 * @param errorCo  long
	 */
	public void setErrorCo(long errorCo) {
		this.errorCo = errorCo;
	}
	/**
	 * fromDate attribute 를 리턴한다.
	 * @return  String
	 */
	public String getFromDate() {
		return fromDate;
	}
	/**
	 * fromDate attribute 값을 설정한다.
	 * @param fromDate  String
	 */
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	/**
	 * toDate attribute 를 리턴한다.
	 * @return  String
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * toDate attribute 값을 설정한다.
	 * @param toDate  String
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * pdKind attribute 를 리턴한다.
	 * @return  String
	 */
	public String getPdKind() {
		return pdKind;
	}
	/**
	 * pdKind attribute 값을 설정한다.
	 * @param pdKind  String
	 */
	public void setPdKind(String pdKind) {
		this.pdKind = pdKind;
	}
	/**
	 * statsKind attribute 를 리턴한다.
	 * @return  String
	 */
	public String getStatsKind() {
		return statsKind;
	}
	/**
	 * statsKind attribute 값을 설정한다.
	 * @param statsKind  String
	 */
	public void setStatsKind(String statsKind) {
		this.statsKind = statsKind;
	}
	/**
	 * detailStatsKind attribute 를 리턴한다.
	 * @return  String
	 */
	public String getDetailStatsKind() {
		return detailStatsKind;
	}
	/**
	 * detailStatsKind attribute 값을 설정한다.
	 * @param detailStatsKind  String
	 */
	public void setDetailStatsKind(String detailStatsKind) {
		this.detailStatsKind = detailStatsKind;
	}
	/**
	 * tabKind attribute 를 리턴한다.
	 * @return  String
	 */
	public String getTabKind() {
		return tabKind;
	}
	/**
	 * tabKind attribute 값을 설정한다.
	 * @param tabKind  String
	 */
	public void setTabKind(String tabKind) {
		this.tabKind = tabKind;
	}
	/**
	 * maxUnit attribute 를 리턴한다.
	 * @return  float
	 */
	public float getMaxUnit() {
		return maxUnit;
	}
	/**
	 * maxUnit attribute 값을 설정한다.
	 * @param maxUnit  float
	 */
	public void setMaxUnit(float maxUnit) {
		this.maxUnit = maxUnit;
	}
	
	
	public float getMaxUnit2() {
		return maxUnit2;
	}
	public void setMaxUnit2(float maxUnit2) {
		this.maxUnit2 = maxUnit2;
	}
	
	public float getMaxUnit3() {
		return maxUnit3;
	}
	public void setMaxUnit3(float maxUnit3) {
		this.maxUnit3 = maxUnit3;
	}
	public String getSiteNm() {
		return siteNm;
	}
	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getTrgetId() {
		return trgetId;
	}
	public void setTrgetId(String trgetId) {
		this.trgetId = trgetId;
	}
	public String getBbsId() {
		return bbsId;
	}
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	public String getBbsNm() {
		return bbsNm;
	}
	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}
	public String getGbNm() {
		return gbNm;
	}
	public void setGbNm(String gbNm) {
		this.gbNm = gbNm;
	}
	public long getDwldCo() {
		return dwldCo;
	}
	public void setDwldCo(long dwldCo) {
		this.dwldCo = dwldCo;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getOwnerType() {
		return ownerType;
	}
	public void setOwnerType(String ownerType) {
		this.ownerType = ownerType;
	}
	public String getLvl1ClasCd() {
		return lvl1ClasCd;
	}
	public void setLvl1ClasCd(String lvl1ClasCd) {
		this.lvl1ClasCd = lvl1ClasCd;
	}
	public long getTcnt() {
		return tcnt;
	}
	public void setTcnt(long tcnt) {
		this.tcnt = tcnt;
	}
	public long getCnt1() {
		return cnt1;
	}
	public void setCnt1(long cnt1) {
		this.cnt1 = cnt1;
	}
	public long getCnt2() {
		return cnt2;
	}
	public void setCnt2(long cnt2) {
		this.cnt2 = cnt2;
	}
	public long getCnt3() {
		return cnt3;
	}
	public void setCnt3(long cnt3) {
		this.cnt3 = cnt3;
	}
	public long getCnt4() {
		return cnt4;
	}
	public void setCnt4(long cnt4) {
		this.cnt4 = cnt4;
	}
	public long getCnt5() {
		return cnt5;
	}
	public void setCnt5(long cnt5) {
		this.cnt5 = cnt5;
	}
	public long getCnt6() {
		return cnt6;
	}
	public void setCnt6(long cnt6) {
		this.cnt6 = cnt6;
	}
	public long getCnt7() {
		return cnt7;
	}
	public void setCnt7(long cnt7) {
		this.cnt7 = cnt7;
	}
	public long getCnt8() {
		return cnt8;
	}
	public void setCnt8(long cnt8) {
		this.cnt8 = cnt8;
	}
	public long getCnt9() {
		return cnt9;
	}
	public void setCnt9(long cnt9) {
		this.cnt9 = cnt9;
	}
	
}
