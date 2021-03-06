<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="_WEB_FULL_PATH" value="http://${siteInfo.siteUrl}"/>
<c:set var="_IMG" value="${pageContext.request.contextPath}${LytFileStoreWebPathByWebFile}cmy/${siteInfo.cmyTmplatId}/images"/>
<c:set var="_PREFIX" value="/cop/cmy"/>

<c:import url="/cop/cmy/tmplatHead.do" charEncoding="utf-8">
	<c:param name="defaultHeader">Y</c:param>
</c:import>

<script language="javascript" type="text/javascript">
	function fnAgreeCheck(){
		var stpAgree = document.community.agree;
		if(!stpAgree.checked){
            alert('약관에 동의 하셔야 합니다');
            stpAgree.focus();
            return false; 
		}
		return true;
	}
</script>

       <div class="cm_caluse">
        <form name="community" method="post" action="${_PREFIX}/addCmmntyInf.do">
        <input type="hidden" name="menuId" value="<c:out value='${searchVO.menuId}'/>"/>
		<input type="hidden" name="searchTy" value="<c:out value='${searchVO.searchTy}'/>"/>
		<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
		<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
          <p class="txt_caluse">커뮤니티 개설을 위해 아래의 약관을 꼭 읽어보세요.</p>

							<div class="clause">
								<h2>『U-스쿨포털 통합로그인』 서비스 이용 약관 </h2>

								<h3>제1장 총 칙 </h3>

								<h4>제1조 (목적)</h4>
								<ul>
									<li>이 약관은 U-스쿨포털 『통합로그인(http://www.)』(이하 "U-스쿨포털 통합로그인"이라 합니다)이 제공하는 각종 서비스를 이용함에 있어 회원과 U-스쿨포털의 권리 및 의무와 책임 사항을 정하는데 목적으로 합니다. </li>
								</ul>
								
								<h4>제2조 (이용약관의 효력 및 변경)</h4>
								<ul>
									<li>① 이 약관은 U-스쿨포털 통합로그인에 게시하여 공시함으로써 효력을 발생합니다. </li>
									<li>② U-스쿨포털 통합로그인은 합리적인 사유가 발생될 경우에는 이 약관을 변경할 수 있으며, 약관이 변경된 경우에는 지체 없이 이를 공시합니다. </li>
									<li>③ 회원제 혹은 무료서비스 이용고객은 변경된 약관 사항에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주됩니다. </li>
								</ul>

								<h4>제3조 (약관의 적용) </h4>
								<ul>
									<li>① 이 약관은 U-스쿨포털이 제공하는 개별서비스에 관한 이용안내 (이하 "서비스별 안내"라 합니다)와 함께 적용합니다. </li>
									<li>② 이 약관에 명시되지 아니한 사항에 대해서는 관계법령 및 서비스별 안내의 취지에 따라 적용할 수 있습니다. </li>
								</ul>
							
								<h4>제4조 (용어의 정의) </h4>
									<ul>
										<li>① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다. 
											<ul>
												<li>1. "이용고객" 이라 함은 서비스를 이용하는 이용자를 말합니다.</li>
												<li>2. "이용계약" 이라 함은 서비스 이용과 관련하여 U-스쿨포털과 이용고객 간에 체결하는 계약을 말합니다.</li>
												<li>3. "이용자번호(ID)"라 함은 이용고객의 식별과 이용고객의 서비스 이용을 위하여 이용고객이 선정하고 U-스쿨포털 통합로그인이 부여하는 문자와 숫자의 조합을 말합니다.</li>
												<li>4. "비밀번호"라 함은 이용고객이 부여받은 이용자번호와 일치된 이용고객 임을 확인하고 이용고객의 권익보호를 위하여 이용고객이 선정한 문자와 숫자의 조합을 말합니다.</li>
												<li>5. "단말기"라 함은 U-스쿨포털이 제공하는 서비스를 이용하기 위해 이용고객이 설치한 개인용 컴퓨터 및 모뎀 등을 말합니다.</li>
											</ul>
										</li>
										<li>② 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스별 안내에서 정하는 바에 의합니다. </li>
									</ul>
								
								<h3>제2장 서비스 이용 계약 </h3>

								<h4>제5조 (이용계약의 성립)</h4>
									<ul>
										<li>① 이용계약은 이용자의 이용신청에 대한 U-스쿨포털의 이용 승낙에 의하여 성립됩니다.</li>
										<li>② 제 1항의 규정에 의해 이용자가 이용 신청을 할 때에는  U-스쿨포털이 이용자 관리 시 필요로 하는 사항을 전자적 방식( U-스쿨포털의 컴퓨터 등 정보처리 장치에 접속하여 데이터를 입력하는 것을 말합니다)이나 서면으로 하여야 합니다. </li>
										<li>③ 이용계약은 이용자번호 단위로 체결합니다. </li>
										<li>④ 서비스의 대량이용 등 특별한 서비스 이용에 관한 계약은 별도의 계약으로 합니다. </li>
									</ul>

								<h4>제6조 (이용신청) </h4>
									<ul>
										<li>서비스를 이용하고자 하는 자(개인 또는 단체)는  U-스쿨포털 이 지정한 양식에 따라 온라인 신청을 이용하여 가입 신청을 해야 합니다. </li>
									</ul>

								<h4>제7조 (이용계약 승낙의 유보)</h4>
									<ul>
										<li>① U-스쿨포털 통합로그인은 다음 각 호에 해당하는 경우에는 이용계약의 승낙을 유보할 수 있습니다. 
											<ul>
												<li>1. 설비에 여유가 없는 경우</li>
												<li>2. 기술상에 지장이 있는 경우 </li>
												<li>3. 기타  U-스쿨포털 이 서비스의 효율적인 운영 등을 위하여 필요하다고 인정되는 경우 </li>
											</ul>
										</li>
										<li>② U-스쿨포털 통합로그인은 다음 각 호에 해당하는 이용계약 신청에 대하여는 이를 거절할 수 있습니다. 
											<ul>
												<li>1. 다른 사람의 명의를 사용하여 이용신청을 하였을 때 </li>
												<li>2. 이용계약 신청서의 내용을 허위로 기재하였을 때 </li>
												<li>3. 사회의 안녕, 질서 혹은 미풍양속을 저해할 목적으로 이용신청을 하였을 때 </li>
											</ul>
										</li>
									</ul>

								<h4>제8조 (계약사항의 변경) </h4>
									<ul>
										<li>이용자는 다음 사항을 변경하고자 하는 경우 서비스에 접속하여 서비스 내의 기능을 이용하여 변경할 수 있습니다 
											<ul>
												<li>1. 주소 및 전화번호 </li>
												<li>2. 비밀번호  </li>
												<li>3. 기타  U-스쿨포털 이 인정하는 경미한 사항 </li>
											</ul>
										</li>
									</ul>

						
								<h3>제3장 서비스의 이용 </h3>

								<h4>제9조 (서비스 이용시간) </h4>
								<ul>
									<li>서비스의 이용 시간은 U-스쿨포털의 업무 및 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간(00:00-24:00)을 원칙으로 합니다. 다만, 정기점검 등의 필요로 U-스쿨포털이 정한 날이나 시간은 그러하지 아니합니다. </li>
								</ul>

								<h4>제10조 (이용자번호 등)</h4>
								<ul>
									<li>① 이용자번호 및 비밀번호에 대한 모든 관리책임은 이용자에게 있습니다.</li>
									<li>② 명백한 사유가 있는 경우를 제외하고는 이용자가 이용자번호를 공유, 양도 또는 변경할 수 없습니다.</li>
									<li>③ 이용자에게 부여된 이용자번호에 의하여 발생되는 서비스 이용상의 과실 또는 제3자에 의한 부정사용 등에 대한 모든 책임은 이용자에게 있습니다. </li>
								</ul>

								<h4>제11조 (서비스 이용의 제한 및 이용계약의 해지) </h4>
								<ul>
									<li>① U-스쿨포털 통합로그인은 서비스용 설비의 용량에 여유가 없다고 판단되는 경우 필요에 따라 이용자가 게재 또는 등록한 내용물을 삭제할 수 있습니다.</li>
									<li>② U-스쿨포털 통합로그인은 서비스용 설비의 용량에 여유가 없다고 판단되는 경우 이용자의 서비스 이용을 부분적으로 제한할 수 있습니다..</li>
									<li>③ 제 1 항 및 제 2 항의 경우에는 당해 사항을 사전에 온라인을 통해서 공지합니다. </li>
									<li>④ U-스쿨포털 통합로그인은 이용자가 게재 또는 등록하는 서비스내의 내용물이 다음 각 호에 해당한다고 판단되는 경우에 이용자에게 사전 통지없이 삭제할 수 있습니다. 
										<ul>
											<li>1. 다른 이용자 또는 제 3자를 비방하거나 중상모략으로 명예를 손상시키는 경우</li>
											<li>2. 공공질서 및 미풍양속에 위반되는 내용의 정보, 문장, 도형 등을 유포하는 경우</li>
											<li>3. 반국가적, 반사회적, 범죄적 행위와 결부된다고 판단되는 경우 </li>
											<li>4. 다른 이용자 또는 제 3자의 저작권 등, 기타 권리를 침해하는 경우 </li>
											<li>5. 게시 기간이 규정된 기간을 초과한 경우 </li>
											<li>6. 기타 관계 법령에 위배된다고 판단되는 경우</li>
										</ul>
									</li>
								</ul>

								<h4>제12조 (이용자 게시물의 삭제 및 서비스 이용 제한) </h4>
								<ul>
									<li>①U-스쿨포털 통합로그인은 서비스용 설비의 용량에 여유가 없다고 판단되는 경우 필요에 따라 이용자가 게재 또는 등록한 내용물을 삭제할 수 있습니다.</li>
									<li>②U-스쿨포털 통합로그인은 서비스용 설비의 용량에 여유가 없다고 판단되는 경우 이용자의 서비스 이용을 부분적으로 제한할 수 있습니다.</li>
									<li>③제 1 항 및 제 2 항의 경우에는 당해 사항을 사전에 온라인을 통해서 공지합니다.</li>
									<li>④U-스쿨포털 통합로그인은 이용자가 게재 또는 등록하는 서비스내의 내용물이 다음 각 호에 해당한다고 판단되는 경우에 이용자에게 사전 통지없이 삭제할 수 있습니다 
										<ul>
											<li>1. 다른 이용자 또는 제 3자를 비방하거나 중상모략으로 명예를 손상시키는 경우</li>
											<li>2. 공공질서 및 미풍양속에 위반되는 내용의 정보, 문장, 도형 등을 유포하는 경우</li>
											<li>3. 반국가적, 반사회적, 범죄적 행위와 결부된다고 판단되는 경우 </li>
											<li>4. 다른 이용자 또는 제 3자의 저작권 등, 기타 권리를 침해하는 경우 </li>
											<li>5. 게시 기간이 규정된 기간을 초과한 경우 </li>
											<li>6. 기타 관계 법령에 위배된다고 판단되는 경우 </li>
										</ul>
									</li>
								</ul>

								<h4>제13조 (서비스 제공의 중지 및 제한) </h4>
								<ul>
									<li>① U-스쿨포털 통합로그인은 다음 각 호에 해당하는 경우 서비스 제공을 중지할 수 있습니다. 
										<ul>
											<li>1. 서비스용 설비의 보수 또는 공사로 인한 부득이한 경우 </li>
											<li>2. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 때 </li>
										</ul>
									</li>
									<li>② U-스쿨포털 통합로그인은 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주등으로 서비스 이용에 지장이 있는 때에는 서비스 제공을 중지하거나 제한할 수 있습니다 </li>
								</ul>
								

								<h4>제14조 (U-스쿨포털의 의무) </h4>
								<ul>
									<li>① U-스쿨포털 통합로그인은 U-스쿨포털에 설치된 서비스용 설비를 지속적이고 안정적인 서비스 제공에 적합하도록 유지하여야 하며 서비스용 설비에 장애가 발생하거나 또는 그 설비가 못쓰게 된 경우 그 설비를 수리하거나 복구하여야 합니다. </li>
									<li>② U-스쿨포털 통합로그인은 서비스 내용의 변경 또는 추가사항이 있는 경우 그 사항을 온라인을 통해 서비스 화면에 공지합니다. </li>
								</ul>

								<h4>제15조 (개인정보보호) </h4>
								<ul>
									<li>① U-스쿨포털은 정보통신망이용촉진 등에 관한 법률 등 관계법령에 따라 이용신청 시 제공받는 이용자의 개인정보, 이후에 추가로 제공받는 개인정보 및 서비스 이용 중 생성되는 개인정보를 보호하여야 합니다.</li>
									<li>② U-스쿨포털의 관리책임자의 주소 및 연락처는 대전시 중구 문화동 279-8, 전화번호 042-582-3245번이며 개인정보 관리책임자의 성명은 별도로 공지하거나 서비스 안내에 게시합니다. </li>
									<li>③ 이용자가 자신의 개인정보를 전송 등의 방법으로 U-스쿨포털에 제공하는 행위는 U-스쿨포털의 개인정보 수집 및 이용 등에 동의하는 것으로 간주됩니다. U-스쿨포털의 이용자 개인정보의 수집 및 이용 목적은 다음 각 호와 같습니다. 
										<ul>
											<li>1. 서비스 제공 등 이용계약의 이행 </li>
											<li>2. 서비스 기능 향상을 위한 정보 생성 및 이용자별 안내 </li>
										</ul>
									</li>
									<li>④ 센터는 개인정보를 이용고객의 별도의 동의 없이 제3자에게 제공하지 않습니다. 다만, 다음 각 호의 경우는 이용고객의 별도 동의 없이 제3자에게 이용고객의 개인 정보를 제공할 수 있습니다. 
										<ul>
											<li>1. 수사상 목적에 따른 수사기관의 서면 요구가 있는 경우에 수사협조의 목적으로 국가 수사 기관에 성명, 주소등 신상정보를 제공하는 경우 </li>
											<li>2. 신용정보의 이용 및 보호에 관한 법률, 전기통신관련법률 등 법률에 특별한 규정이 있는 경우 </li>
											<li>3. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우</li>
										</ul>
									</li>
									<li>⑤ 이용자는 언제나 자신의 개인정보를 열람할 수 있으며, 스스로 오류를 수정 할 수 있습니다. 열람 및 수정은 원칙적으로 이용 신청과 동일한 방법으로 하며, 자세한 방법은 공지, 이용안내에서 정한 바에 따릅니다. </li>
									<li>⑥ 이용자는 언제나 이용계약을 해지함으로써 개인정보의 수집 및 이용에 대한 동의, 목적 외 사용에 대한 별도동의, 제3자 제공에 대한 별도동의를 철회 할 수 있습니다. 해지의 방법은 이 약관에서 별도로 규정한 바에 따릅니다. </li>
								</ul>

								<h4>제16조 (이용자의 의무)</h4>
								<ul>
									<li>1. 다른 회원의 비밀번호와 ID를 도용하여 부정 사용하는 행위</li>
									<li>2. 저속, 음란, 모욕적, 위협적이거나 타인의 Privacy를 침해할 수 있는 내용을 전송, 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
									<li>3. 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</li>
									<li>4 법률, 계약에 의해 이용할 수 없는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
									<li>5 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
									<li>6 당 사이트의 승인을 받지 아니한 광고, 판촉물, 스팸메일, 행운의 편지, 피라미드 조직 기타 다른 형태의 권유를 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
									<li>7 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
									<li>8 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위 </li>
									<li>9 선량한 풍속, 기타 사회질서를 해하는 행위 </li>
									<li>10 타인의 명예를 훼손하거나 모욕하는 행위 </li>
									<li>11 타인의 지적재산권 등의 권리를 침해하는 행위 </li>
									<li>12 해킹행위 또는 컴퓨터바이러스의 유포행위 </li>
									<li>13 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위 </li>
									<li>14 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위 </li>
									<li>15 당 사이트에 게시된 정보의 변경. </li>
									<li>16 기타 전기통신사업법 제53조 제1항과 전기통신사업법 시행령 16조(불온통신)에 위배되는 행위 </li>
								</ul>

								<h3>제4장 저작권</h3> 

								<h4>제17조 (게재된 자료에 대한 권리) </h4>
								<ul>
									<li>서비스에 게재된 자료에 대한 권리는 다음 각 호와 같습니다. <br />
									1. 게시물에 대한 권리와 책임은 게시자에게 있으며, U-스쿨포털은 게시자의 동의 없이는 이를 영리적 목적으로 사용할 수 없습니다. 단, 비영리적 목적인 경우 U-스쿨포털은 게시자의 동의 없이도 이를 사용할 수 있으며 서비스내의 게재권을 갖습니다. </li>
									<li>2.게재된 자료에 대하여 U-스쿨포털 통합로그인 본 서비스 내에서 게재자를 저작자 또는 저작재산권자로 추정할 수 있으며, 해당 게시물에 대한 게재자와 저작자 또는 저작재산권자가 다른 경우 게재자는 이를 반드시 표기할 의무를 가집니다. 
										<ul>
											<li>① 이용자가 게재한 내용이 타인의 저작권 또는 저작인접권을 침해한다고 판단될 경우 U-스쿨포털 통합로그인은 게재자에게 이를 통지한 후 해당 저작물의 복제 및 전송을 중단시킬 수 있습니다. </li>
											<li>② 게재한 내용이 자신의 저작권 또는 저작인접권을 침해한다고 판단되는 자는 U-스쿨포털 통합로그인에게 이에 대한 자신의 권리를 소명하고 복제 및 전송을 중단시킬 수 있습니다. </li>
											<li>③ U-스쿨포털 통합로그인 은 게재물에 대한 정당한 권리 있음을 주장하는 자가 다음 각호의 양식과 증명 자료를 갖추어 소명하면 게재자와 권리주장자 양자에게 이를 통지한 후 해당 게시물의 복제 및 전송을 중단하여야 합니다. 
												<ul>
													<li>1. 복제 및 전송 재개 요청서( 메인화면 하단 참조) </li>
													<li>2. 재개 요청에 따른 증명자료(아래 중 하나) 
														<ul>
															<li>가. 저작권 등록증 </li>
															<li>나. 널리 알려진 것이 표시된 저작물 사본 또는 관련자료 </li>
															<li>다. 이용허락 또는 저작재산권 양도 계약서 사본 </li>
															<li>라. 보호기간이 끝난 경우 그에 따른 증빙서류 </li>
														</ul>
													</li>
												</ul>
											</li>
											<li>④ U-스쿨포털 통합로그인은 게재자가 해당 게재물에 대하여 자신의 권리 있음을 소명한 경우 해당 게시물의 게재를 즉시 재개할 수 있습니다. </li>
										</ul>
									</li>
								</ul>
				


								<h4>제18조 (당 사이트의 소유권)</h4>
								<ul>
									<li>1.U-스쿨포털 통합로그인이 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 U-스쿨포털 통합로그인에 소유권이 있습니다. </li>
									<li>2. U-스쿨포털 통합로그인이 명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정 행위, 상업적 이용 행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</li>
								</ul>

				

								<h3>제5장 이의 신청 및 손해배상 청구 금지 </h3>

								<h4>제19조 (이의신청금지)</h4>
								<ul>
									<li>이용자는 U-스쿨포털에서 제공하는 서비스 이용 시 발생되는 어떠한 문제에 대해서도 이의 신청 및 민원을 제기할 수 없습니다. </li>
								</ul>

								<h4>제20조 (손해배상청구금지)</h4>

								<ul>
									<li>이용자는 U-스쿨포털 통합로그인에서 제공하는 서비스 이용 시 발생되는 어떠한 문제에 대해서도 이용기간 동안은 U-스쿨포털 통합로그인및 관계 기관에 손해배상 청구를 할 수 없으며 U-스쿨포털은 이에 대해 책임을 지지 아니합니다.</li>
								</ul>
								
								<h3>부 칙</h3> 
								<ul>
									<li>1. (시행일) 이 약관은 2006년 3월 15일부터 시행합니다.</li>
								</ul>

							</div>

							<div class="chk_agree">
								<input type="checkbox" id="agree" />
								<label for="agree">위 내용에 동의합니다.</label>
							</div>
							
							<div class="btn_c">
								<span  class="btn"><button type="submit" onclick="return fnAgreeCheck();">확인</button></span>
								<c:url var="listUrl" value="${_PREFIX}/selectCmmntyInfs.do">
									<c:if test="${not empty searchVO.searchCnd}"><c:param name="searchCnd" value="${searchVO.searchCnd}"/></c:if>
									<c:if test="${not empty searchVO.searchWrd}"><c:param name="searchWrd" value="${searchVO.searchWrd}"/></c:if>
									<c:if test="${not empty searchVO.pageIndex}"><c:param name="pageIndex" value="${searchVO.pageIndex}"/></c:if>
								</c:url>
								<span  class="btn2"><button type="button" onclick="location.href='<c:out value="${listUrl}"/>'">취소</button></span>
							</div>
        </form>
        </div>

<c:import url="/cop/cmy/tmplatBottom.do" charEncoding="utf-8"/>